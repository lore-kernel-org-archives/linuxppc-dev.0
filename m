Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTR7d0tgyzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 18:43:56 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1N7hid4095746
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 02:43:54 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28shbjd4m8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 02:43:54 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 23 Feb 2017 17:43:50 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9E58F2CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 18:43:48 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1N7hepZ45154380
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 18:43:48 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1N7hG7P012523
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 18:43:16 +1100
Subject: Re: [PATCH] powerpc/powernv: add hdat attribute to sysfs
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20170223022954.14676-1-matthew.brown.dev@gmail.com>
Cc: Matt Brown <brownmatt1997@gmail.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 23 Feb 2017 18:42:51 +1100
MIME-Version: 1.0
In-Reply-To: <20170223022954.14676-1-matthew.brown.dev@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <9d2269d4-0e90-6e08-94d8-a5f49ebbd6c2@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23/02/17 13:29, Matt Brown wrote:
> From: Matt Brown <brownmatt1997@gmail.com>

Did you intend for this to be different from the email you're using to 
send + sign-off?

>
> The HDAT data area is consumed by skiboot and turned into a device-tree.
> In some cases we would like to look directly at the HDAT, so this patch
> adds a sysfs node to allow it to be viewed.  This is not possible through
> /dev/mem as it is reserved memory which is stopped by the /dev/mem filter.
>
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>

Oliver obviously knows more about how HDAT actually works, I won't 
repeat his comments.

I haven't checked the actual important bit of how HDAT is exposed in 
device tree but other than that things look fairly good. Boring 
stylistic comments below!

> ---
>  arch/powerpc/include/asm/opal.h              |  1 +
>  arch/powerpc/platforms/powernv/opal-msglog.c | 49 ++++++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/opal.c        |  2 ++
>  3 files changed, 52 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 5c7db0f..b26944e 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -277,6 +277,7 @@ extern int opal_async_comp_init(void);
>  extern int opal_sensor_init(void);
>  extern int opal_hmi_handler_init(void);
>  extern int opal_event_init(void);
> +extern void opal_hdat_sysfs_init(void);
>
>  extern int opal_machine_check(struct pt_regs *regs);
>  extern bool opal_mce_check_early_recovery(struct pt_regs *regs);
> diff --git a/arch/powerpc/platforms/powernv/opal-msglog.c b/arch/powerpc/platforms/powernv/opal-msglog.c
> index 39d6ff9..a637055 100644
> --- a/arch/powerpc/platforms/powernv/opal-msglog.c
> +++ b/arch/powerpc/platforms/powernv/opal-msglog.c

I think I know why you've put it in opal-msglog.c - the existing code in 
there does similar things in exposing a chunk of skiboot stuff via a 
sysfs file - but it's not immediately obvious given that HDAT and msglog 
are quite different things. Perhaps add a new file, opal-hdat.c?

> @@ -31,7 +31,13 @@ struct memcons {
>  	__be32 in_cons;
>  };
>
> +struct hdatInfo {

Kernel coding style tends to avoid using camelCase naming, instead 
preferring all-lowercase separated by underscores. (same applies to a 
couple of other places)

> +	char *base;
> +	u64 size;
> +};
> +
>  static struct memcons *opal_memcons = NULL;
> +static struct hdatInfo hdat_inf;
>
>  ssize_t opal_msglog_copy(char *to, loff_t pos, size_t count)
>  {
> @@ -136,3 +142,46 @@ void __init opal_msglog_sysfs_init(void)
>  	if (sysfs_create_bin_file(opal_kobj, &opal_msglog_attr) != 0)
>  		pr_warn("OPAL: sysfs file creation failed\n");
>  }
> +
> +
> +
> +/* Read function for HDAT attribute in sysfs */
> +static ssize_t hdat_read(struct file *file, struct kobject *kobj,
> +			 struct bin_attribute *bin_attr, char *to,
> +			 loff_t pos, size_t count)
> +{
> +	if (!hdat_inf.base)
> +		return -ENODEV;
> +
> +	return memory_read_from_buffer(to, count, &pos, hdat_inf.base,
> +					hdat_inf.size);
> +}
> +
> +
> +/* HDAT attribute for sysfs */
> +static struct bin_attribute hdat_attr = {
> +	.attr = {.name = "hdat", .mode = 0444},
> +	.read = hdat_read
> +};
> +
> +void __init opal_hdat_sysfs_init(void)
> +{
> +	u64 hdatAddr[2];
> +
> +	/* Check for the hdat-map prop in device-tree */
> +	if (of_property_read_u64_array(opal_node, "hdat-map", hdatAddr, 2)) {
> +		pr_debug("OPAL: Property hdat-map not found.\n");
> +		return;
> +	}
> +
> +	/* Print out hdat-map values. [0]: base, [1]: size */
> +	pr_debug("HDAT Base address: %#llx\n", hdatAddr[0]);
> +	pr_debug("HDAT Size: %#llx\n", hdatAddr[1]);

Prefix these with "OPAL: " like the other messages?

> +
> +	hdat_inf.base = phys_to_virt(hdatAddr[0]);
> +	hdat_inf.size = hdatAddr[1];
> +
> +	if (sysfs_create_bin_file(opal_kobj, &hdat_attr) != 0)
> +		pr_debug("OPAL: sysfs file creation for HDAT failed");
> +
> +}
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 2822935..cae3745 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -740,6 +740,8 @@ static int __init opal_init(void)
>  		opal_sys_param_init();
>  		/* Setup message log sysfs interface. */
>  		opal_msglog_sysfs_init();
> +		/* Create hdat object under sys/firmware/opal */
> +		opal_hdat_sysfs_init();
>  	}
>
>  	/* Initialize platform devices: IPMI backend, PRD & flash interface */
>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
