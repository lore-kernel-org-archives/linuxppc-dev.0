Return-Path: <R65777@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E9BC72C01F1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 21:25:03 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Xie Shaohui-B21989 <B21989@freescale.com>,
 "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH][v2] powerpc/watchdog: move booke watchdog param related
 code to setup-common.c
Date: Wed, 11 Jul 2012 11:24:54 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D03DC300B@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1342000568-5605-1-git-send-email-Shaohui.Xie@freescale.com>
In-Reply-To: <1342000568-5605-1-git-send-email-Shaohui.Xie@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Xie Shaohui-B21989 <B21989@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ACK:

> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-
> bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Sha=
ohui Xie
> Sent: Wednesday, July 11, 2012 3:26 PM
> To: linux-watchdog@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Cc: Xie Shaohui-B21989
> Subject: [PATCH][v2] powerpc/watchdog: move booke watchdog param related =
code to
> setup-common.c
>=20
> Currently, BOOKE watchdog code for checking "wdt" and "wdt_period" is in
> setup_32.c, it cannot be used in 64-bit, so move it to a common place set=
up-
> common.c, which will be shared by 32-bit and 64-bit.
>=20
> Also, replace the simple_strtoul with kstrtol.
>=20
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> ---
> changes for v2:
> use setup-common.c instead of prom.c
>=20
>  arch/powerpc/kernel/setup-common.c |   27 +++++++++++++++++++++++++++
>  arch/powerpc/kernel/setup_32.c     |   24 ------------------------
>  2 files changed, 27 insertions(+), 24 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/set=
up-
> common.c
> index afd4f05..bdc499c 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -720,6 +720,33 @@ static int powerpc_debugfs_init(void)
> arch_initcall(powerpc_debugfs_init);
>  #endif
>=20
> +#ifdef CONFIG_BOOKE_WDT
> +extern u32 booke_wdt_enabled;
> +extern u32 booke_wdt_period;
> +
> +/* Checks wdt=3Dx and wdt_period=3Dxx command-line option */ notrace int
> +__init early_parse_wdt(char *p) {
> +	if (p && strncmp(p, "0", 1) !=3D 0)
> +		booke_wdt_enabled =3D 1;
> +
> +	return 0;
> +}
> +early_param("wdt", early_parse_wdt);
> +
> +int __init early_parse_wdt_period(char *p) {
> +	unsigned long ret;
> +	if (p) {
> +		if (!kstrtol(p, 0, &ret))
> +			booke_wdt_period =3D ret;
> +	}
> +
> +	return 0;
> +}
> +early_param("wdt_period", early_parse_wdt_period);
> +#endif	/* CONFIG_BOOKE_WDT */
> +
>  void ppc_printk_progress(char *s, unsigned short hex)  {
>  	pr_info("%s\n", s);
> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_3=
2.c
> index ec8a53f..a8f54ec 100644
> --- a/arch/powerpc/kernel/setup_32.c
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -149,30 +149,6 @@ notrace void __init machine_init(u64 dt_ptr)
>  		ppc_md.progress("id mach(): done", 0x200);  }
>=20
> -#ifdef CONFIG_BOOKE_WDT
> -extern u32 booke_wdt_enabled;
> -extern u32 booke_wdt_period;
> -
> -/* Checks wdt=3Dx and wdt_period=3Dxx command-line option */ -notrace in=
t __init
> early_parse_wdt(char *p) -{
> -	if (p && strncmp(p, "0", 1) !=3D 0)
> -	       booke_wdt_enabled =3D 1;
> -
> -	return 0;
> -}
> -early_param("wdt", early_parse_wdt);
> -
> -int __init early_parse_wdt_period (char *p) -{
> -	if (p)
> -		booke_wdt_period =3D simple_strtoul(p, NULL, 0);
> -
> -	return 0;
> -}
> -early_param("wdt_period", early_parse_wdt_period);
> -#endif	/* CONFIG_BOOKE_WDT */
> -
>  /* Checks "l2cr=3Dxxxx" command-line option */  int __init ppc_setup_l2c=
r(char
> *str)  {
> --
> 1.6.4
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
