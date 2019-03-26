Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6142CC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 20:57:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C89EF20700
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 20:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="up4eFBIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89EF20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TNjh6vr1zDqP3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 07:57:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="up4eFBIS"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TNgs6pT3zDqMt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 07:55:37 +1100 (AEDT)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A7DDD20700;
 Tue, 26 Mar 2019 20:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1553633735;
 bh=tA+yhLyPz3pS7/zaWIUUT5xew+vLqD4acHfJaRD1P4E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=up4eFBISWZopYl29DTampIL5GX6OR90ICwYe3llJ9TGTv4JnIB6KuruJB46dIpVDa
 PNm+dEIOSCozbESZfUrzkdjLRAJ63SIYF8E+8qdYccBk7btsA+IlgCSq8oQ32XdsCx
 QwJzAPg/XsuHw/BTaOIK4Ln6z/eWCbg/wAFgID/A=
Date: Tue, 26 Mar 2019 15:55:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH RFC v4 12/21] PCI: Don't allow hotplugged devices to
 steal resources
Message-ID: <20190326205533.GT24180@google.com>
References: <20190311133122.11417-1-s.miroshnichenko@yadro.com>
 <20190311133122.11417-13-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311133122.11417-13-s.miroshnichenko@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux@yadro.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 11, 2019 at 04:31:13PM +0300, Sergey Miroshnichenko wrote:
> When movable BARs are enabled, the PCI subsystem at first releases
> all the bridge windows and then performs an attempt to assign new
> requested resources and re-assign the existing ones.

s/performs an attempt/attempts/

I guess "new requested resources" means "resources to newly hotplugged
devices"?

> If a hotplugged device gets its resources first, there could be no
> space left to re-assign resources of already working devices, which
> is unacceptable. If this happens, this patch marks one of the new
> devices with the new introduced flag PCI_DEV_IGNORE and retries the
> resource assignment.
> 
> This patch adds a new res_mask bitmask to the struct pci_dev for
> storing the indices of assigned resources.
> 
> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  drivers/pci/bus.c       |   5 ++
>  drivers/pci/pci.h       |  11 +++++
>  drivers/pci/probe.c     | 100 +++++++++++++++++++++++++++++++++++++++-
>  drivers/pci/setup-bus.c |  15 ++++++
>  include/linux/pci.h     |   1 +
>  5 files changed, 130 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 5cb40b2518f9..a9784144d6f2 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -311,6 +311,11 @@ void pci_bus_add_device(struct pci_dev *dev)
>  {
>  	int retval;
>  
> +	if (pci_dev_is_ignored(dev)) {
> +		pci_warn(dev, "%s: don't enable the ignored device\n", __func__);
> +		return;

I'm not sure about this.  Even if we're unable to assign space for all
the device's BARs, it still should respond to config accesses, and I
think it should show up in sysfs and lspci.

> +	}
> +
>  	/*
>  	 * Can not put in pci_device_add yet because resources
>  	 * are not assigned yet for some devices.
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index e06e8692a7b1..56b905068ac5 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -366,6 +366,7 @@ static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
>  
>  /* pci_dev priv_flags */
>  #define PCI_DEV_ADDED 0
> +#define PCI_DEV_IGNORE 1
>  
>  static inline void pci_dev_assign_added(struct pci_dev *dev, bool added)
>  {
> @@ -377,6 +378,16 @@ static inline bool pci_dev_is_added(const struct pci_dev *dev)
>  	return test_bit(PCI_DEV_ADDED, &dev->priv_flags);
>  }
>  
> +static inline void pci_dev_ignore(struct pci_dev *dev, bool ignore)
> +{
> +	assign_bit(PCI_DEV_IGNORE, &dev->priv_flags, ignore);
> +}
> +
> +static inline bool pci_dev_is_ignored(const struct pci_dev *dev)
> +{
> +	return test_bit(PCI_DEV_IGNORE, &dev->priv_flags);
> +}
> +
>  #ifdef CONFIG_PCIEAER
>  #include <linux/aer.h>
>  
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 692752c71f71..62f4058a001f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3248,6 +3248,23 @@ unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge)
>  	return max;
>  }
>  
> +static unsigned int pci_dev_res_mask(struct pci_dev *dev)
> +{
> +	unsigned int res_mask = 0;
> +	int i;
> +
> +	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
> +		struct resource *r = &dev->resource[i];
> +
> +		if (!r->flags || (r->flags & IORESOURCE_UNSET) || !r->parent)
> +			continue;
> +
> +		res_mask |= (1 << i);
> +	}
> +
> +	return res_mask;
> +}
> +
>  static void pci_bus_rescan_prepare(struct pci_bus *bus)
>  {
>  	struct pci_dev *dev;
> @@ -3257,6 +3274,8 @@ static void pci_bus_rescan_prepare(struct pci_bus *bus)
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		struct pci_bus *child = dev->subordinate;
>  
> +		dev->res_mask = pci_dev_res_mask(dev);
> +
>  		if (child) {
>  			pci_bus_rescan_prepare(child);
>  		} else if (dev->driver &&
> @@ -3318,6 +3337,84 @@ static void pci_setup_bridges(struct pci_bus *bus)
>  		pci_setup_bridge(bus);
>  }
>  
> +static struct pci_dev *pci_find_next_new_device(struct pci_bus *bus)
> +{
> +	struct pci_dev *dev;
> +
> +	if (!bus)
> +		return NULL;
> +
> +	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		struct pci_bus *child_bus = dev->subordinate;
> +
> +		if (!pci_dev_is_added(dev) && !pci_dev_is_ignored(dev))
> +			return dev;
> +
> +		if (child_bus) {
> +			struct pci_dev *next_new_dev;
> +
> +			next_new_dev = pci_find_next_new_device(child_bus);
> +			if (next_new_dev)
> +				return next_new_dev;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static bool pci_bus_validate_resources(struct pci_bus *bus)

The name of this function should tell us what the return value means.
Just from the name "pci_bus_validate_resources", I can't tell whether we
call it for side-effects, or whether true or false indicates success.

> +{
> +	struct pci_dev *dev;
> +	bool ret = true;
> +
> +	if (!bus)
> +		return false;
> +
> +	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		struct pci_bus *child = dev->subordinate;
> +		unsigned int res_mask = pci_dev_res_mask(dev);
> +
> +		if (pci_dev_is_ignored(dev))
> +			continue;
> +
> +		if (dev->res_mask & ~res_mask) {
> +			pci_err(dev, "%s: Non-re-enabled resources found: 0x%x -> 0x%x\n",
> +				__func__, dev->res_mask, res_mask);

I don't think __func__ really tells users anything useful, so I would
just omit them.  Searching for the text of the message is almost as
good.

> +			ret = false;
> +		}
> +
> +		if (child && !pci_bus_validate_resources(child))
> +			ret = false;
> +	}
> +
> +	return ret;
> +}
> +
> +static void pci_reassign_root_bus_resources(struct pci_bus *root)
> +{
> +	do {
> +		struct pci_dev *next_new_dev;
> +
> +		pci_bus_release_root_bridge_resources(root);
> +		pci_assign_unassigned_root_bus_resources(root);
> +
> +		if (pci_bus_validate_resources(root))
> +			break;
> +
> +		next_new_dev = pci_find_next_new_device(root);
> +		if (!next_new_dev) {
> +			dev_err(&root->dev, "%s: failed to re-assign resources even after ignoring all the hotplugged devices\n",
> +				__func__);
> +			break;
> +		}
> +
> +		dev_warn(&root->dev, "%s: failed to re-assign resources, disable the next hotplugged device %s and retry\n",
> +			 __func__, dev_name(&next_new_dev->dev));
> +
> +		pci_dev_ignore(next_new_dev, true);
> +	} while (true);
> +}
> +
>  /**
>   * pci_rescan_bus - Scan a PCI bus for devices
>   * @bus: PCI bus to scan
> @@ -3341,8 +3438,7 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
>  
>  		max = pci_scan_child_bus(root);
>  
> -		pci_bus_release_root_bridge_resources(root);
> -		pci_assign_unassigned_root_bus_resources(root);
> +		pci_reassign_root_bus_resources(root);
>  
>  		pci_setup_bridges(root);
>  		pci_bus_rescan_done(root);
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 36a1907d9509..551108f48df7 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -131,6 +131,9 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
>  {
>  	int i;
>  
> +	if (pci_dev_is_ignored(dev))
> +		return;
> +
>  	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
>  		struct resource *r;
>  		struct pci_dev_resource *dev_res, *tmp;
> @@ -181,6 +184,9 @@ static void __dev_sort_resources(struct pci_dev *dev,
>  {
>  	u16 class = dev->class >> 8;
>  
> +	if (pci_dev_is_ignored(dev))
> +		return;
> +
>  	/* Don't touch classless devices or host bridges or ioapics.  */
>  	if (class == PCI_CLASS_NOT_DEFINED || class == PCI_CLASS_BRIDGE_HOST)
>  		return;
> @@ -284,6 +290,9 @@ static void assign_requested_resources_sorted(struct list_head *head,
>  	int idx;
>  
>  	list_for_each_entry(dev_res, head, list) {
> +		if (pci_dev_is_ignored(dev_res->dev))
> +			continue;
> +
>  		res = dev_res->res;
>  		idx = res - &dev_res->dev->resource[0];
>  		if (resource_size(res) &&
> @@ -991,6 +1000,9 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		int i;
>  
> +		if (pci_dev_is_ignored(dev))
> +			continue;
> +
>  		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
>  			struct resource *r = &dev->resource[i];
>  			resource_size_t r_size;
> @@ -1353,6 +1365,9 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
>  	pbus_assign_resources_sorted(bus, realloc_head, fail_head);
>  
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		if (pci_dev_is_ignored(dev))
> +			continue;
> +
>  		pdev_assign_fixed_resources(dev);
>  
>  		b = dev->subordinate;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 3d52f5538282..26aa59cb6220 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -369,6 +369,7 @@ struct pci_dev {
>  	 */
>  	unsigned int	irq;
>  	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
> +	unsigned int	res_mask;		/* Bitmask of assigned resources */
>  
>  	bool		match_driver;		/* Skip attaching driver */
>  
> -- 
> 2.20.1
> 
