Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E4398B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Dec 2010 03:40:58 +1100 (EST)
Subject: Re: [PATCH 1/7] powerpc/85xx: re-enable timebase sync disabled by
	KEXEC patch
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1291379651-8822-1-git-send-email-leoli@freescale.com>
Date: Fri, 3 Dec 2010 10:40:52 -0600
Message-Id: <9127D47D-F146-4387-AF36-3193CF47389A@kernel.crashing.org>
References: <1291379651-8822-1-git-send-email-leoli@freescale.com>
To: Li Yang <leoli@freescale.com>
Cc: Matthew McClintock <msm@freescale.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 3, 2010, at 6:34 AM, Li Yang wrote:

> The timebase sync is not only necessary when using KEXEC.  It should =
also
> be used by normal boot up and cpu hotplug.  Remove the ifdef added by
> the KEXEC patch.  Fix a problem that cpu hotplugging freezes the whole =
system.
>=20
> Signed-off-by: Jin Qing <b24347@freescale.com>
> Singed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/platforms/85xx/smp.c |    4 +---
> 1 files changed, 1 insertions(+), 3 deletions(-)

But we have problems with KEXEC w/o this?  What is the issue with =
hotplugging and the generic timebase code?  When do we freeze?

>=20
> diff --git a/arch/powerpc/platforms/85xx/smp.c =
b/arch/powerpc/platforms/85xx/smp.c
> index 5c91a99..1e8aec8 100644
> --- a/arch/powerpc/platforms/85xx/smp.c
> +++ b/arch/powerpc/platforms/85xx/smp.c
> @@ -2,7 +2,7 @@
>  * Author: Andy Fleming <afleming@freescale.com>
>  * 	   Kumar Gala <galak@kernel.crashing.org>
>  *
> - * Copyright 2006-2008 Freescale Semiconductor Inc.
> + * Copyright 2006-2010 Freescale Semiconductor Inc.
>  *
>  * This program is free software; you can redistribute  it and/or =
modify it
>  * under  the terms of  the GNU General  Public License as published =
by the
> @@ -115,10 +115,8 @@ smp_85xx_setup_cpu(int cpu_nr)
>=20
> struct smp_ops_t smp_85xx_ops =3D {
> 	.kick_cpu =3D smp_85xx_kick_cpu,
> -#ifdef CONFIG_KEXEC
> 	.give_timebase	=3D smp_generic_give_timebase,
> 	.take_timebase	=3D smp_generic_take_timebase,
> -#endif
> };
>=20
> #ifdef CONFIG_KEXEC
> --=20
> 1.6.6-rc1.GIT
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
