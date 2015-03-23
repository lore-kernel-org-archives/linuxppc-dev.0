Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BBB961A2AC0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 07:21:58 +1100 (AEDT)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Mon, 23 Mar 2015 14:21:55 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id DB94E1FF0027
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 14:13:04 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2NKKAXn32833770
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 13:20:10 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2NKLpSk018315
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 14:21:53 -0600
Message-ID: <551075DC.4050909@linux.vnet.ibm.com>
Date: Mon, 23 Mar 2015 13:21:48 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pseries: Introduce api_version to migration sysfs
 interface
References: <1425522338-14271-1-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1425522338-14271-1-git-send-email-tyreld@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Cc: Cyril Bur <cyrilbur@gmail.com>, Nathan Fontenot <nfont@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/04/2015 06:25 PM, Tyrel Datwyler wrote:
> The /sys/kernel/mobility/migration interface was added all the way back
> in 2.6.37. However, the drmgr userspace tool was never augmented to use
> this interface to perfrom migrations. Instead it has continued using a
> faux rtas call coupled with performing the device tree update processing
> in userspace and communicating it back to the kernel via the ugly
> /proc/ppc64/ofdt interface.
> 
> Up until 3.12 the device tree update code in the kernel was badly broken
> and bit rotting. This code was fixed in 3.12 and is now utilized by the
> kernel suspend code as of 3.15. The kernel is now better suited to
> handle the post-mobility fixup of the device tree and drmgr should be
> transitioned to using the sysfs migration interface.
> 
> This patch introduces the api_version sysfs file to /sys/kernel/mobility
> as a means for drmgr to query the current implementation level of the
> kernel migration code. This initial versioning indicates it is capable
> of perfroming all current PAPR requirements for migration including the
> post-mobility firmware activation and device tree update.
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Cc: Cyril Bur <cyrilbur@gmail.com>
> ---

Ping. Does this look acceptable for -next?

-Tyrel

>  arch/powerpc/platforms/pseries/mobility.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
> index bdf62c1..ceb18d3 100644
> --- a/arch/powerpc/platforms/pseries/mobility.c
> +++ b/arch/powerpc/platforms/pseries/mobility.c
> @@ -338,7 +338,16 @@ static ssize_t migrate_store(struct class *class, struct class_attribute *attr,
>  	return count;
>  }
> 
> +/*
> + * Used by drmgr to determine the kernel behavior of the migration interface.
> + *
> + * Version 1: Performs all PAPR requirements for migration including
> + *	firmware activation and device tree update.
> + */
> +#define MIGRATION_API_VERSION	1
> +
>  static CLASS_ATTR(migration, S_IWUSR, NULL, migrate_store);
> +static CLASS_ATTR_STRING(api_version, S_IRUGO, __stringify(MIGRATION_API_VERSION));
> 
>  static int __init mobility_sysfs_init(void)
>  {
> @@ -349,7 +358,13 @@ static int __init mobility_sysfs_init(void)
>  		return -ENOMEM;
> 
>  	rc = sysfs_create_file(mobility_kobj, &class_attr_migration.attr);
> +	if (rc)
> +		pr_err("mobility: unable to create migration sysfs file (%d)\n", rc);
> 
> -	return rc;
> +	rc = sysfs_create_file(mobility_kobj, &class_attr_api_version.attr.attr);
> +	if (rc)
> +		pr_err("mobility: unable to create api_version sysfs file (%d)\n", rc);
> +
> +	return 0;
>  }
>  machine_device_initcall(pseries, mobility_sysfs_init);
> 
