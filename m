Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AA8EAB6FBB
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2012 23:37:36 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: Add back condition for smp
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1334698746-11529-1-git-send-email-yorksun@freescale.com>
Date: Wed, 18 Apr 2012 08:37:21 -0500
Message-Id: <6DA2F6F1-7F77-4E30-86E8-14DCD58D5C28@kernel.crashing.org>
References: <1334698746-11529-1-git-send-email-yorksun@freescale.com>
To: York Sun <yorksun@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 17, 2012, at 4:39 PM, York Sun wrote:

> The timebase synchronization is only necessary if we need to reset a
> separate core.  Currently only KEXEC and CPU hotplug require resetting
> a single core. The following code should be in the condition of
> CONFIG_KEXEC or CONFIG_HOTPLUG_CPU
>=20
>        .give_timebase  =3D smp_generic_give_timebase,
>        .take_timebase  =3D smp_generic_take_timebase,

This doesn't explain why you are putting the #ifdef back, only under =
what conditions it applies.

>=20
> Signed-off-by: York Sun <yorksun@freescale.com>
> Acked-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/platforms/85xx/smp.c |    2 ++
> 1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/85xx/smp.c =
b/arch/powerpc/platforms/85xx/smp.c
> index 56942af..868c6d7 100644
> --- a/arch/powerpc/platforms/85xx/smp.c
> +++ b/arch/powerpc/platforms/85xx/smp.c
> @@ -192,8 +192,10 @@ struct smp_ops_t smp_85xx_ops =3D {
> 	.cpu_disable	=3D generic_cpu_disable,
> 	.cpu_die	=3D generic_cpu_die,
> #endif
> +#if defined(CONFIG_KEXEC) || defined(CONFIG_HOTPLUG_CPU)
> 	.give_timebase	=3D smp_generic_give_timebase,
> 	.take_timebase	=3D smp_generic_take_timebase,
> +#endif
> };
>=20
> #ifdef CONFIG_KEXEC
> --=20
> 1.7.0.4
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
