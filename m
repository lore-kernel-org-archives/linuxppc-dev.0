Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D5DCEB6F74
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jul 2011 00:12:17 +1000 (EST)
Subject: Re: [PATCH 09/14] 85xx/sbc8548: read hardware revision when it's
	required for first time
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1311065631-3429-10-git-send-email-dbaryshkov@gmail.com>
Date: Tue, 19 Jul 2011 09:12:08 -0500
Message-Id: <EBAEF199-2D62-477F-BD40-861149AB1CFA@kernel.crashing.org>
References: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
	<1311065631-3429-10-git-send-email-dbaryshkov@gmail.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Linux PPC Development <linuxppc-dev@lists.ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 19, 2011, at 3:53 AM, Dmitry Eremin-Solenikov wrote:

> Currently sbc8548 reads hardware revision during bootup. To simplify
> things read it when it's first required when the kernel is up and
> running.
>=20
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
> arch/powerpc/platforms/85xx/sbc8548.c |    8 +++++---
> 1 files changed, 5 insertions(+), 3 deletions(-)

How is this simplifying things, seems more complicated to add an =
additional if() check.

- k

>=20
> diff --git a/arch/powerpc/platforms/85xx/sbc8548.c =
b/arch/powerpc/platforms/85xx/sbc8548.c
> index ecdd8c0..2eeb376 100644
> --- a/arch/powerpc/platforms/85xx/sbc8548.c
> +++ b/arch/powerpc/platforms/85xx/sbc8548.c
> @@ -49,7 +49,7 @@
> #include <sysdev/fsl_soc.h>
> #include <sysdev/fsl_pci.h>
>=20
> -static int sbc_rev;
> +static int sbc_rev =3D -EINVAL;
>=20
> static void __init sbc8548_pic_init(void)
> {
> @@ -82,7 +82,7 @@ static void __init sbc8548_pic_init(void)
> }
>=20
> /* Extract the HW Rev from the EPLD on the board */
> -static int __init sbc8548_hw_rev(void)
> +static int sbc8548_hw_rev(void)
> {
> 	struct device_node *np;
> 	struct resource res;
> @@ -130,7 +130,6 @@ static void __init sbc8548_setup_arch(void)
> 		}
> 	}
> #endif
> -	sbc_rev =3D sbc8548_hw_rev();
> }
>=20
> static void sbc8548_show_cpuinfo(struct seq_file *m)
> @@ -140,6 +139,9 @@ static void sbc8548_show_cpuinfo(struct seq_file =
*m)
> 	pvid =3D mfspr(SPRN_PVR);
> 	svid =3D mfspr(SPRN_SVR);
>=20
> +	if (sbc_rev =3D=3D -EINVAL)
> +		sbc_rev =3D sbc8548_hw_rev();
> +
> 	seq_printf(m, "Vendor\t\t: Wind River\n");
> 	seq_printf(m, "Machine\t\t: SBC8548 v%d\n", sbc_rev);
> 	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
> --=20
> 1.7.2.5
