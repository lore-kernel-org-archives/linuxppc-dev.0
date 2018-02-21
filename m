Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmWKr4lc2zDrJ0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 19:46:08 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1L8jCCv078058
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 03:46:06 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g94ywhaq1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 03:45:53 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 21 Feb 2018 08:45:51 -0000
Subject: Re: [PATCH V6] cxl: Fix timebase synchronization status on P9
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, vaibhav@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com
References: <1519134536-16485-1-git-send-email-clombard@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 21 Feb 2018 09:45:47 +0100
MIME-Version: 1.0
In-Reply-To: <1519134536-16485-1-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <fb7b0d41-e5e7-d674-c962-efff6691953a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 20/02/2018 à 14:48, Christophe Lombard a écrit :
> The PSL Timebase register is updated by the PSL to maintain the
> timebase.
> On P9, the Timebase value is only provided by the CAPP as received
> the last time a timebase request was performed.
> The timebase requests are initiated through the adapter configuration or
> application registers.
> The specific sysfs entry "/sys/class/cxl/cardxx/psl_timebase_synced" is
> now dynamically updated according the content of the PSL Timebase
> register.
> 
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> Reviewed-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> 
> ---


Thanks!
Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>


> This patch applies on top of this patch:
>   http://patchwork.ozlabs.org/patch/873663/
> 
> Changelog[v6]
>   - Rebased to latest upstream.
>   - Recompute the status only in native mode.
> 
> Changelog[v5]
>   - Rebased to latest upstream.
>   - Changed the type of 'delta'
> 
> Changelog[v4]
>   - Rebased to latest upstream.
>   - Added log message.
> 
> Changelog[v3]
>   - Rebased to latest upstream.
>   - Dynamic update is now applied to P8.
> 
> Changelog[v2]
>   - Missing Signed-off-by.
>   - Spaces required around the ':'.
> ---
>   drivers/misc/cxl/pci.c   | 17 -----------------
>   drivers/misc/cxl/sysfs.c | 12 ++++++++++++
>   2 files changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 66eed6a..3247eaf 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -606,9 +606,6 @@ static u64 timebase_read_xsl(struct cxl *adapter)
> 
>   static void cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev *dev)
>   {
> -	u64 psl_tb;
> -	int delta;
> -	unsigned int retry = 0;
>   	struct device_node *np;
> 
>   	adapter->psl_timebase_synced = false;
> @@ -636,20 +633,6 @@ static void cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev *dev)
>   	cxl_p1_write(adapter, CXL_PSL_Control, 0x0000000000000000);
>   	cxl_p1_write(adapter, CXL_PSL_Control, CXL_PSL_Control_tb);
> 
> -	/* Wait until CORE TB and PSL TB difference <= 16usecs */
> -	do {
> -		msleep(1);
> -		if (retry++ > 5) {
> -			dev_info(&dev->dev, "PSL timebase can't synchronize\n");
> -			return;
> -		}
> -		psl_tb = adapter->native->sl_ops->timebase_read(adapter);
> -		delta = mftb() - psl_tb;
> -		if (delta < 0)
> -			delta = -delta;
> -	} while (tb_to_ns(delta) > 16000);
> -
> -	adapter->psl_timebase_synced = true;
>   	return;
>   }
> 
> diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
> index a8b6d6a..95285b7 100644
> --- a/drivers/misc/cxl/sysfs.c
> +++ b/drivers/misc/cxl/sysfs.c
> @@ -62,7 +62,19 @@ static ssize_t psl_timebase_synced_show(struct device *device,
>   					char *buf)
>   {
>   	struct cxl *adapter = to_cxl_adapter(device);
> +	u64 psl_tb, delta;
> 
> +	/* Recompute the status only in native mode */
> +	if (cpu_has_feature(CPU_FTR_HVMODE)) {
> +		psl_tb = adapter->native->sl_ops->timebase_read(adapter);
> +		delta = abs(mftb() - psl_tb);
> +
> +		/* CORE TB and PSL TB difference <= 16usecs ? */
> +		adapter->psl_timebase_synced = (tb_to_ns(delta) < 16000) ? true : false;
> +		pr_devel("PSL timebase %s - delta: 0x%016llx\n",
> +			 (tb_to_ns(delta) < 16000) ? "synchronized" :
> +			 "not synchronized", tb_to_ns(delta));
> +	}
>   	return scnprintf(buf, PAGE_SIZE, "%i\n", adapter->psl_timebase_synced);
>   }
> 
