Return-Path: <nfont@austin.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 607F8102546
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Mar 2010 06:59:26 +1100 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2BJpDUl023180
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Mar 2010 14:51:13 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2BJxKbO1659074
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Mar 2010 14:59:20 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2BJxKXZ015675
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Mar 2010 14:59:20 -0500
Message-ID: <4B994B97.70702@austin.ibm.com>
Date: Thu, 11 Mar 2010 13:59:19 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc: Partition hibernation support
References: <201002240002.o1O02OBe031005@d03av05.boulder.ibm.com>
In-Reply-To: <201002240002.o1O02OBe031005@d03av05.boulder.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Brian King wrote:
> Enables support for HMC initiated partition hibernation. This is
> a firmware assisted hibernation, since the firmware handles writing
> the memory out to disk, along with other partition information,
> so we just mimic suspend to ram.
> 
> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
> ---
> 
>  arch/powerpc/Kconfig                         |    2 
>  arch/powerpc/include/asm/hvcall.h            |    1 
>  arch/powerpc/include/asm/machdep.h           |    1 
>  arch/powerpc/include/asm/rtas.h              |   10 +
>  arch/powerpc/kernel/rtas.c                   |  118 ++++++++++-----
>  arch/powerpc/platforms/pseries/Makefile      |    1 
>  arch/powerpc/platforms/pseries/hotplug-cpu.c |    6 
>  arch/powerpc/platforms/pseries/suspend.c     |  209 +++++++++++++++++++++++++++
>  8 files changed, 312 insertions(+), 36 deletions(-)
> 
> diff -puN /dev/null arch/powerpc/platforms/pseries/suspend.c
> --- /dev/null	2009-12-15 17:58:07.000000000 -0600
> +++ linux-2.6-bjking1/arch/powerpc/platforms/pseries/suspend.c	2010-02-23 16:29:25.000000000 -0600
> @@ -0,0 +1,209 @@

-- snip --

> +
> +static SYSDEV_ATTR(hibernate, S_IWUSR, NULL, store_hibernate);
> +
> +static struct sysdev_class suspend_sysdev_class = {
> +	.name = "power",
> +};
> +
> +static struct platform_suspend_ops pseries_suspend_ops = {
> +	.valid		= suspend_valid_only_mem,
> +	.begin		= pseries_suspend_begin,
> +	.prepare_late	= pseries_prepare_late,
> +	.enter		= pseries_suspend_enter,
> +};
> +
> +/**
> + * pseries_suspend_sysfs_register - Register with sysfs
> + *
> + * Return value:
> + * 	0 on success / other on failure
> + **/
> +static int pseries_suspend_sysfs_register(struct sys_device *sysdev)
> +{
> +	int rc;
> +
> +	if ((rc = sysdev_class_register(&suspend_sysdev_class)))
> +		return rc;
> +
> +	sysdev->id = 0;
> +	sysdev->cls = &suspend_sysdev_class;
> +
> +	if ((rc = sysdev_register(sysdev)))
> +		goto class_unregister;
> +	if ((rc = sysdev_create_file(sysdev, &attr_hibernate)))
> +		goto fail;
> +

Could you just do a sysdev_class_create_file(&suspend_sysdev_class, &attr_hibernate)
call to create the hibernate file instead of the sysdev_register() and
sysdev_create_file()?  I think this may make it a bit nicer since the file created
will be /sys/devices/system/power/hibernate instead of 
/sys/devices/system/power/power0/hibernate.

-Nathan

> +	return 0;
> +
> +fail:
> +	sysdev_unregister(sysdev);
> +class_unregister:
> +	sysdev_class_unregister(&suspend_sysdev_class);
> +	return rc;
> +}
> +
