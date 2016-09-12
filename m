Return-Path: <tcminyard@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXtmX36QBzDsX1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 02:38:52 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id p2so1775943pap.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 09:38:52 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
Subject: Re: [Openipmi-developer] [PATCH 3/4] ipmi: allow dynamic BMC version
 information
References: <1473670537-26428-1-git-send-email-jk@ozlabs.org>
 <1473670537-26428-4-git-send-email-jk@ozlabs.org>
To: Jeremy Kerr <jk@ozlabs.org>, openipmi-developer@lists.sourceforge.net
Cc: linuxppc-dev@lists.ozlabs.org
From: Corey Minyard <minyard@acm.org>
Message-ID: <7732b504-a9f1-b8f6-fb7a-ead34719d862@acm.org>
Date: Mon, 12 Sep 2016 11:38:44 -0500
MIME-Version: 1.0
In-Reply-To: <1473670537-26428-4-git-send-email-jk@ozlabs.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/12/2016 03:55 AM, Jeremy Kerr wrote:
> Currently, it's up to the IPMI SMIs to provide the product & version
> details of BMCs behind registered IPMI SMI interfaces. This device ID is
> provided on SMI regsitration, and kept around for all future queries.
>
> However, this version information isn't always static. For example, a
> BMC may be upgraded at runtime, making the old version information
> stale.
>
> This change allows querying the BMC device ID & version information
> dynamically. If no static device_id argument is provided to
> ipmi_register_smi, then the IPMI core code will perform a Get Device ID
> IPMI command to query the version information when needed. We keep a
> short-term cache of this information so we don't need to re-query
> for every attribute access.

In all, this looks good.  I have two minor nits inline below, and
two more major comments here:

I would prefer if it always queried the data, even if the device id
information is provided by the lower level driver.  The other
two interfaces query the device id for blacklisting and interface
detection, so they already have it available.  If the dev_id is
provided, you can just set the information valid and set the last
query time.  Then the disabled state is no longer necessary.

Since the values can change while you are querying them, do
we need some sort of mutex on them?  I know the chances are
pretty remote that you would ever hit an issue, but it's at least
theoretically possible.

Thanks,

-corey

> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> ---
>   drivers/char/ipmi/ipmi_msghandler.c | 158 ++++++++++++++++++++++++++++++++++--
>   1 file changed, 153 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 41990bb..55feba0 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -90,6 +90,9 @@ static struct proc_dir_entry *proc_ipmi_root;
>    */
>   #define IPMI_REQUEST_EV_TIME	(1000 / (IPMI_TIMEOUT_TIME))
>   
> +/* How long should we cache dynamic device IDs? */
> +#define IPMI_DYN_DEV_ID_EXPIRY	(10 * HZ)
> +
>   /*
>    * The main "user" data structure.
>    */
> @@ -192,10 +195,19 @@ struct ipmi_proc_entry {
>   };
>   #endif
>   
> +enum bmc_dyn_device_id_state {
> +	BMC_DEVICE_DYN_ID_STATE_DISABLED,
> +	BMC_DEVICE_DYN_ID_STATE_QUERYING,
> +	BMC_DEVICE_DYN_ID_STATE_VALID,
> +	BMC_DEVICE_DYN_ID_STATE_INVALID,
> +};
> +
>   struct bmc_device {
>   	struct platform_device pdev;
>   	struct ipmi_device_id  id;
>   	ipmi_smi_t             intf;
> +	int                    dyn_id;
> +	unsigned long          dyn_id_expiry;
>   	unsigned char          guid[16];
>   	int                    guid_set;
>   	char                   name[16];
> @@ -1997,6 +2009,108 @@ int ipmi_request_supply_msgs(ipmi_user_t          user,
>   }
>   EXPORT_SYMBOL(ipmi_request_supply_msgs);
>   
> +static void bmc_device_id_handler(ipmi_smi_t intf, struct ipmi_recv_msg *msg)
> +{
> +	int rc;
> +
> +	if ((msg->addr.addr_type != IPMI_SYSTEM_INTERFACE_ADDR_TYPE)
> +			|| (msg->msg.netfn != IPMI_NETFN_APP_RESPONSE)
> +			|| (msg->msg.cmd != IPMI_GET_DEVICE_ID_CMD))
> +		return;
> +
> +	/* Do we have a success completion code? */
> +	if (msg->msg.data[0] != 0) {
> +		intf->bmc->dyn_id = BMC_DEVICE_DYN_ID_STATE_INVALID;
> +		goto out;
> +	}
> +
> +	/* Do we have enough data to parse the device ID details? This doesn't
> +	 * inclde the optional auxilliary version data. */

Minor nit: include is misspelled.

> +	if (msg->msg.data_len < 12) {
> +		intf->bmc->dyn_id = BMC_DEVICE_DYN_ID_STATE_INVALID;
> +		goto out;
> +	}
> +
> +	rc = ipmi_demangle_device_id(msg->msg.netfn, msg->msg.cmd,
> +			msg->msg.data, msg->msg.data_len, &intf->bmc->id);
> +	if (rc) {
> +		intf->bmc->dyn_id = BMC_DEVICE_DYN_ID_STATE_INVALID;
> +		goto out;
> +	}
> +
> +	intf->ipmi_version_major = ipmi_version_major(&intf->bmc->id);
> +	intf->ipmi_version_minor = ipmi_version_minor(&intf->bmc->id);
> +
> +	/* All good! mark the dynamic ID as valid, and set its expiration
> +	 * time */
> +	intf->bmc->dyn_id = BMC_DEVICE_DYN_ID_STATE_VALID;
> +	intf->bmc->dyn_id_expiry = jiffies + IPMI_DYN_DEV_ID_EXPIRY;
> +out:
> +	wake_up(&intf->waitq);
> +}
> +
> +
> +static int bmc_update_device_id(struct bmc_device *bmc)
> +{
> +	struct ipmi_system_interface_addr si;
> +	ipmi_smi_t intf = bmc->intf;
> +	struct kernel_ipmi_msg msg;
> +	int rc;
> +
> +	if (bmc->dyn_id == BMC_DEVICE_DYN_ID_STATE_DISABLED)
> +		return 0;
> +
> +	if (bmc->dyn_id == BMC_DEVICE_DYN_ID_STATE_VALID &&
> +			time_is_after_jiffies(bmc->dyn_id_expiry))
> +		return 0;
> +
> +	/* do we have a request in progress? Just wait for that. */
> +	if (bmc->dyn_id == BMC_DEVICE_DYN_ID_STATE_QUERYING)
> +		return wait_event_timeout(intf->waitq,
> +				bmc->dyn_id != BMC_DEVICE_DYN_ID_STATE_QUERYING,
> +				IPMI_DYN_DEV_ID_EXPIRY);
> +
> +	/* send Get Device ID request */
> +	si.addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
> +	si.channel = IPMI_BMC_CHANNEL;
> +	si.lun = 0;
> +
> +	msg.netfn = IPMI_NETFN_APP_REQUEST;
> +	msg.cmd = IPMI_GET_DEVICE_ID_CMD;
> +	msg.data = NULL;
> +	msg.data_len = 0;
> +
> +	intf->null_user_handler = bmc_device_id_handler;
> +
> +	bmc->dyn_id = BMC_DEVICE_DYN_ID_STATE_QUERYING;
> +
> +	rc = i_ipmi_request(NULL,
> +			      intf,
> +			      (struct ipmi_addr *) &si,
> +			      0,
> +			      &msg,
> +			      intf,
> +			      NULL,
> +			      NULL,
> +			      0,
> +			      intf->channels[0].address,
> +			      intf->channels[0].lun,
> +			      -1, 0);
> +
> +	if (rc) {
> +		bmc->dyn_id = BMC_DEVICE_DYN_ID_STATE_INVALID;
> +		return rc;
> +	}
> +
> +	wait_event_timeout(intf->waitq,
> +			bmc->dyn_id != BMC_DEVICE_DYN_ID_STATE_QUERYING,
> +			IPMI_DYN_DEV_ID_EXPIRY);
> +
> +	intf->null_user_handler = NULL;
> +
> +	return bmc->dyn_id == BMC_DEVICE_DYN_ID_STATE_VALID ? 0 : 1;
> +}
> +
>   #ifdef CONFIG_PROC_FS
>   static int smi_ipmb_proc_show(struct seq_file *m, void *v)
>   {
> @@ -2273,6 +2387,9 @@ static ssize_t provides_device_sdrs_show(struct device *dev,
>   {
>   	struct bmc_device *bmc = to_bmc_device(dev);
>   
> +	if (bmc_update_device_id(bmc))
> +		return -EIO;
> +
>   	return snprintf(buf, 10, "%u\n",
>   			(bmc->id.device_revision & 0x80) >> 7);
>   }
> @@ -2284,6 +2401,9 @@ static ssize_t revision_show(struct device *dev, struct device_attribute *attr,
>   {
>   	struct bmc_device *bmc = to_bmc_device(dev);
>   
> +	if (bmc_update_device_id(bmc))
> +		return -EIO;
> +
>   	return snprintf(buf, 20, "%u\n",
>   			bmc->id.device_revision & 0x0F);
>   }
> @@ -2295,6 +2415,9 @@ static ssize_t firmware_revision_show(struct device *dev,
>   {
>   	struct bmc_device *bmc = to_bmc_device(dev);
>   
> +	if (bmc_update_device_id(bmc))
> +		return -EIO;
> +
>   	return snprintf(buf, 20, "%u.%x\n", bmc->id.firmware_revision_1,
>   			bmc->id.firmware_revision_2);
>   }
> @@ -2306,6 +2429,9 @@ static ssize_t ipmi_version_show(struct device *dev,
>   {
>   	struct bmc_device *bmc = to_bmc_device(dev);
>   
> +	if (bmc_update_device_id(bmc))
> +		return -EIO;
> +
>   	return snprintf(buf, 20, "%u.%u\n",
>   			ipmi_version_major(&bmc->id),
>   			ipmi_version_minor(&bmc->id));
> @@ -2318,6 +2444,9 @@ static ssize_t add_dev_support_show(struct device *dev,
>   {
>   	struct bmc_device *bmc = to_bmc_device(dev);
>   
> +	if (bmc_update_device_id(bmc))
> +		return -EIO;
> +
>   	return snprintf(buf, 10, "0x%02x\n",
>   			bmc->id.additional_device_support);
>   }
> @@ -2330,6 +2459,9 @@ static ssize_t manufacturer_id_show(struct device *dev,
>   {
>   	struct bmc_device *bmc = to_bmc_device(dev);
>   
> +	if (bmc_update_device_id(bmc))
> +		return -EIO;
> +
>   	return snprintf(buf, 20, "0x%6.6x\n", bmc->id.manufacturer_id);
>   }
>   static DEVICE_ATTR(manufacturer_id, S_IRUGO, manufacturer_id_show, NULL);
> @@ -2340,6 +2472,9 @@ static ssize_t product_id_show(struct device *dev,
>   {
>   	struct bmc_device *bmc = to_bmc_device(dev);
>   
> +	if (bmc_update_device_id(bmc))
> +		return -EIO;
> +
>   	return snprintf(buf, 10, "0x%4.4x\n", bmc->id.product_id);
>   }
>   static DEVICE_ATTR(product_id, S_IRUGO, product_id_show, NULL);
> @@ -2350,6 +2485,9 @@ static ssize_t aux_firmware_rev_show(struct device *dev,
>   {
>   	struct bmc_device *bmc = to_bmc_device(dev);
>   
> +	if (bmc_update_device_id(bmc))
> +		return -EIO;
> +
>   	return snprintf(buf, 21, "0x%02x 0x%02x 0x%02x 0x%02x\n",
>   			bmc->id.aux_firmware_revision[3],
>   			bmc->id.aux_firmware_revision[2],
> @@ -2390,8 +2528,10 @@ static umode_t bmc_dev_attr_is_visible(struct kobject *kobj,
>   	struct bmc_device *bmc = to_bmc_device(dev);
>   	umode_t mode = attr->mode;
>   
> -	if (attr == &dev_attr_aux_firmware_revision.attr)
> +	if (attr == &dev_attr_aux_firmware_revision.attr) {
> +		bmc_update_device_id(bmc);
>   		return bmc->id.aux_firmware_revision_set ? mode : 0;
> +	}
>   	if (attr == &dev_attr_guid.attr)
>   		return bmc->guid_set ? mode : 0;
>   	return mode;
> @@ -2450,6 +2590,8 @@ static int ipmi_bmc_register(ipmi_smi_t intf, int ifnum)
>   
>   	mutex_lock(&ipmidriver_mutex);
>   
> +	bmc_update_device_id(bmc);
> +

What happens if this fails?  You can return an error from this function.
It's also probably not necessary to have this inside the mutex.

>   	/*
>   	 * Try to find if there is an bmc_device struct
>   	 * representing the interfaced BMC already
> @@ -2787,9 +2929,6 @@ int ipmi_register_smi(const struct ipmi_smi_handlers *handlers,
>   	if (!intf)
>   		return -ENOMEM;
>   
> -	intf->ipmi_version_major = ipmi_version_major(device_id);
> -	intf->ipmi_version_minor = ipmi_version_minor(device_id);
> -
>   	intf->bmc = kzalloc(sizeof(*intf->bmc), GFP_KERNEL);
>   	if (!intf->bmc) {
>   		kfree(intf);
> @@ -2798,7 +2937,16 @@ int ipmi_register_smi(const struct ipmi_smi_handlers *handlers,
>   	intf->intf_num = -1; /* Mark it invalid for now. */
>   	kref_init(&intf->refcount);
>   	intf->bmc->intf = intf;
> -	intf->bmc->id = *device_id;
> +	if (device_id) {
> +		intf->bmc->id = *device_id;
> +		intf->ipmi_version_major = ipmi_version_major(device_id);
> +		intf->ipmi_version_minor = ipmi_version_minor(device_id);
> +		intf->bmc->dyn_id = BMC_DEVICE_DYN_ID_STATE_DISABLED;
> +	} else {
> +		memset(&intf->bmc->id, 0, sizeof(intf->bmc->id));
> +		intf->bmc->dyn_id = BMC_DEVICE_DYN_ID_STATE_INVALID;
> +	}
> +
>   	intf->si_dev = si_dev;
>   	for (j = 0; j < IPMI_MAX_CHANNELS; j++) {
>   		intf->channels[j].address = IPMI_BMC_SLAVE_ADDR;
