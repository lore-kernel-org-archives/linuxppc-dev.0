Return-Path: <kumar.gala@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id E290567A7D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 03:33:25 +1100 (EST)
In-Reply-To: <Pine.LNX.4.61.0503181818330.26408@blarg.somerset.sps.mot.com>
References: <Pine.LNX.4.61.0503181818330.26408@blarg.somerset.sps.mot.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <121cf78b6c13c2cc867f66464e2ac444@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 21 Mar 2005 10:33:19 -0600
To: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Cc: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [RFC] ppc32: Report chip version in common /proc/cpuinfo
	handling
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ok, in a possible solution we could call it 'chip(set)' this dealing=20
with either chips (85??, 82??, 52??, ....) or chipsets (MV64x60,=20
TSI10x, MPC10x, etc..)

- kumar

On Mar 18, 2005, at 6:26 PM, Kumar Gala wrote:

> Tom,
>
> You asked me to look at doing the following.=A0 I just want to make =
sure
> this is what we want to do (and call it).=A0 I'm a little concerned =
that
> 'chip' is not necessary the right name in light of TSI10x and MV64x60
> being described by ppc_sys in the future.
>
> - kumar
>
> --=20
>
> Moved reporting of chip revision from board specific to common handing=20=

> of
> /proc/cpuinfo.=A0 In light of numerous PPC system-on-chip devices, we=20=

> report
> both the cpu version (reflects the core version) and the chip version
> (reflects the system-on-chip version).
>
> Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
>
> ---
>  diff -Nru a/arch/ppc/kernel/setup.c b/arch/ppc/kernel/setup.c
> --- a/arch/ppc/kernel/setup.c=A0=A0 2005-03-18 18:17:16 -06:00
>  +++ b/arch/ppc/kernel/setup.c=A0=A0 2005-03-18 18:17:16 -06:00
>  @@ -40,6 +40,7 @@
>  =A0#include <asm/nvram.h>
> =A0#include <asm/xmon.h>
> =A0#include <asm/ocp.h>
>  +#include <asm/ppc_sys.h>
> =A0
>  =A0#if defined CONFIG_KGDB
> =A0#include <asm/kgdb.h>
>  @@ -245,6 +246,11 @@
>  =A0
>  =A0=A0=A0=A0=A0=A0=A0 seq_printf(m, "bogomips\t: %lu.%02lu\n",
>  =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 =A0=A0 lpj / (500000/HZ), =
(lpj / (5000/HZ)) % 100);
>  +
>  +#if defined (CONFIG_85xx) || defined (CONFIG_83xx)
> +=A0=A0=A0=A0=A0=A0 if (cur_ppc_sys_spec->ppc_sys_name)
> +=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 seq_printf(m, "chip\t\t: =
%s\n",=20
> cur_ppc_sys_spec->ppc_sys_name);
> +#endif
>  =A0
>  =A0#ifdef CONFIG_SMP
> =A0=A0=A0=A0=A0=A0=A0 seq_printf(m, "\n");
>  diff -Nru a/arch/ppc/platforms/83xx/mpc834x_sys.c=20
> b/arch/ppc/platforms/83xx/mpc834x_sys.c
> --- a/arch/ppc/platforms/83xx/mpc834x_sys.c=A0=A0=A0=A0 2005-03-18 =
18:17:16=20
> -06:00
>  +++ b/arch/ppc/platforms/83xx/mpc834x_sys.c=A0=A0=A0=A0 2005-03-18 =
18:17:16=20
> -06:00
>  @@ -143,7 +143,6 @@
>  =A0=A0=A0=A0=A0=A0=A0 pvid =3D mfspr(SPRN_PVR);
> =A0=A0=A0=A0=A0=A0=A0 svid =3D mfspr(SPRN_SVR);
> =A0
>  -=A0=A0=A0=A0=A0=A0 seq_printf(m, "chip\t\t: MPC%s\n",=20
> cur_ppc_sys_spec->ppc_sys_name);
> =A0=A0=A0=A0=A0=A0=A0 seq_printf(m, "Vendor\t\t: Freescale Inc.\n");
>  =A0=A0=A0=A0=A0=A0=A0 seq_printf(m, "Machine\t\t: mpc%s sys\n",=20
> cur_ppc_sys_spec->ppc_sys_name);
> =A0=A0=A0=A0=A0=A0=A0 seq_printf(m, "core clock\t: %d MHz\n"
>  diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_ads_common.c=20
> b/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
> --- a/arch/ppc/platforms/85xx/mpc85xx_ads_common.c=A0=A0=A0=A0=A0 =
2005-03-18=20
> 18:17:16 -06:00
>  +++ b/arch/ppc/platforms/85xx/mpc85xx_ads_common.c=A0=A0=A0=A0=A0 =
2005-03-18=20
> 18:17:16 -06:00
>  @@ -129,7 +129,6 @@
>  =A0=A0=A0=A0=A0=A0=A0 pvid =3D mfspr(SPRN_PVR);
> =A0=A0=A0=A0=A0=A0=A0 svid =3D mfspr(SPRN_SVR);
> =A0
>  -=A0=A0=A0=A0=A0=A0 seq_printf(m, "chip\t\t: MPC%s\n",=20
> cur_ppc_sys_spec->ppc_sys_name);
> =A0=A0=A0=A0=A0=A0=A0 seq_printf(m, "Vendor\t\t: Freescale =
Semiconductor\n");
> =A0=A0=A0=A0=A0=A0=A0 seq_printf(m, "Machine\t\t: mpc%sads\n",=20
> cur_ppc_sys_spec->ppc_sys_name);
> =A0=A0=A0=A0=A0=A0=A0 seq_printf(m, "clock\t\t: %dMHz\n", freq / =
1000000);
>  diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c=20
> b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
> --- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c=A0=A0=A0=A0=A0 =
2005-03-18=20
> 18:17:16 -06:00
>  +++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c=A0=A0=A0=A0=A0 =
2005-03-18=20
> 18:17:16 -06:00
>  @@ -146,7 +146,6 @@
>  =A0=A0=A0=A0=A0=A0=A0 pvid =3D mfspr(SPRN_PVR);
> =A0=A0=A0=A0=A0=A0=A0 svid =3D mfspr(SPRN_SVR);
> =A0
>  -=A0=A0=A0=A0=A0=A0 seq_printf(m, "chip\t\t: MPC%s\n",=20
> cur_ppc_sys_spec->ppc_sys_name);
> =A0=A0=A0=A0=A0=A0=A0 seq_printf(m, "Vendor\t\t: Freescale =
Semiconductor\n");
> =A0=A0=A0=A0=A0=A0=A0 seq_printf(m, "Machine\t\t: CDS - MPC%s (%x)\n",=20=

> cur_ppc_sys_spec->ppc_sys_name, cadmus[CM_VER]);
> =A0=A0=A0=A0=A0=A0=A0 seq_printf(m, "clock\t\t: %dMHz\n", freq / =
1000000);
>  diff -Nru a/arch/ppc/platforms/85xx/sbc85xx.c=20
> b/arch/ppc/platforms/85xx/sbc85xx.c
> --- a/arch/ppc/platforms/85xx/sbc85xx.c 2005-03-18 18:17:16 -06:00
>  +++ b/arch/ppc/platforms/85xx/sbc85xx.c 2005-03-18 18:17:16 -06:00
>  @@ -129,7 +129,6 @@
>  =A0=A0=A0=A0=A0=A0=A0 pvid =3D mfspr(SPRN_PVR);
> =A0=A0=A0=A0=A0=A0=A0 svid =3D mfspr(SPRN_SVR);
> =A0
>  -=A0=A0=A0=A0=A0=A0 seq_printf(m, "chip\t\t: MPC%s\n",=20
> cur_ppc_sys_spec->ppc_sys_name);
> =A0=A0=A0=A0=A0=A0=A0 seq_printf(m, "Vendor\t\t: Wind River\n");
> =A0=A0=A0=A0=A0=A0=A0 seq_printf(m, "Machine\t\t: SBC%s\n",=20
> cur_ppc_sys_spec->ppc_sys_name);
> =A0=A0=A0=A0=A0=A0=A0 seq_printf(m, "clock\t\t: %dMHz\n", freq / =
1000000);
>  diff -Nru a/arch/ppc/platforms/85xx/stx_gp3.c=20
> b/arch/ppc/platforms/85xx/stx_gp3.c
> --- a/arch/ppc/platforms/85xx/stx_gp3.c 2005-03-18 18:17:16 -06:00
>  +++ b/arch/ppc/platforms/85xx/stx_gp3.c 2005-03-18 18:17:16 -06:00
>  @@ -268,7 +268,6 @@
>  =A0
>  =A0=A0=A0=A0=A0=A0=A0 memsize =3D total_memory;
>  =A0
>  -=A0=A0=A0=A0=A0=A0 seq_printf(m, "chip\t\t: MPC%s\n",=20
> cur_ppc_sys_spec->ppc_sys_name);
> =A0=A0=A0=A0=A0=A0=A0 seq_printf(m, "Vendor\t\t: RPC Electronics STx =
\n");
>  =A0=A0=A0=A0=A0=A0=A0 seq_printf(m, "Machine\t\t: GP3 - MPC%s\n",=20
> cur_ppc_sys_spec->ppc_sys_name);
> =A0=A0=A0=A0=A0=A0=A0 seq_printf(m, "bus freq\t: %u.%.6u MHz\n", freq =
/ 1000000,
>
> _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
