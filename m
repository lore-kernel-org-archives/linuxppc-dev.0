Return-Path: <pebolle@tiscali.nl>
Received: from lb1-smtp-cloud6.xs4all.net (lb1-smtp-cloud6.xs4all.net
 [194.109.24.24])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 489001A0DCE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 18:38:36 +1000 (AEST)
Message-ID: <1436517510.20619.123.camel@tiscali.nl>
Subject: Re: [PATCH 02/11] soc/fsl: Introduce DPAA BMan device management
 driver
From: Paul Bolle <pebolle@tiscali.nl>
To: Roy Pledge <Roy.Pledge@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, scottwood@freescale.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 10 Jul 2015 10:38:30 +0200
In-Reply-To: <1436473322-21247-3-git-send-email-Roy.Pledge@freescale.com>
References: <1436473322-21247-1-git-send-email-Roy.Pledge@freescale.com>
 <1436473322-21247-3-git-send-email-Roy.Pledge@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On do, 2015-07-09 at 16:21 -0400, Roy Pledge wrote:
> --- /dev/null
> +++ b/drivers/soc/fsl/qbman/Kconfig
> @@ -0,0 +1,33 @@
> +menuconfig FSL_DPA
> +	bool "Freescale DPAA support"
> +	depends on FSL_SOC || COMPILE_TEST

Are you sure about COMPILE_TEST?

> +	default n
> +	help
> +		FSL Data-Path Acceleration Architecture drivers
> +
> +		These are not the actual Ethernet driver(s)
> +
> +if FSL_DPA

[...]

> +config FSL_BMAN
> +	tristate "BMan device management"
> +	default n
> +	help
> +		FSL DPAA BMan driver
> +
> +endif # FSL_DPA

Because with FSL_BMAN set to 'm' testing things with
    make -C ../../../.. M=$PWD bman.ko    

will not actually compile on x86_64:

make: Entering directory '[...]'
  CC [M]  [...]/drivers/soc/fsl/qbman/bman.o
In file included from [...]/drivers/soc/fsl/qbman/bman_priv.h:33:0,
                 from [...]/drivers/soc/fsl/qbman/bman.c:31:
[...]/drivers/soc/fsl/qbman/dpaa_sys.h: In function ‘mfatb’:
[...]/drivers/soc/fsl/qbman/dpaa_sys.h:134:8: error: implicit declaration of function ‘mfspr’ [-Werror=implicit-function-declaration]
   hi = mfspr(SPRN_ATBU);
        ^
[...]/drivers/soc/fsl/qbman/dpaa_sys.h:134:14: error: ‘SPRN_ATBU’ undeclared (first use in this function)
   hi = mfspr(SPRN_ATBU);
              ^
[...]/drivers/soc/fsl/qbman/dpaa_sys.h:134:14: note: each undeclared identifier is reported only once for each function it appears in
[...]/drivers/soc/fsl/qbman/dpaa_sys.h:135:14: error: ‘SPRN_ATBL’ undeclared (first use in this function)
   lo = mfspr(SPRN_ATBL);
              ^
[...]/drivers/soc/fsl/qbman/bman.c: In function ‘__bm_in’:
[...]/drivers/soc/fsl/qbman/bman.c:168:9: error: implicit declaration of function ‘in_be32’ [-Werror=implicit-function-declaration]
  return in_be32((void *)bm + offset);
         ^
[...]/drivers/soc/fsl/qbman/bman.c: In function ‘__bm_out’:
[...]/drivers/soc/fsl/qbman/bman.c:172:2: error: implicit declaration of function ‘out_be32’ [-Werror=implicit-function-declaration]
  out_be32((void *)bm + offset, val);
  ^
[...]/drivers/soc/fsl/qbman/bman.c: In function ‘of_fsl_bman_probe’:
[...]/drivers/soc/fsl/qbman/bman.c:463:17: error: ‘NO_IRQ’ undeclared (first use in this function)
  if (err_irq == NO_IRQ) {
                 ^
cc1: some warnings being treated as errors
scripts/Makefile.build:264: recipe for target '[...]/drivers/soc/fsl/qbman/bman.o' failed
make[1]: *** [[...]/drivers/soc/fsl/qbman/bman.o] Error 1
Makefile:1568: recipe for target 'bman.ko' failed
make: *** [bman.ko] Error 2
make: Leaving directory '[...]'

Thanks,


Paul Bolle
