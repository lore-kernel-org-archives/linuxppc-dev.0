Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0106.outbound.protection.outlook.com [157.56.111.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9F3C51A0326
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 08:56:27 +1000 (AEST)
Date: Mon, 21 Sep 2015 17:56:11 -0500
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <qiang.zhao@freescale.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <lauraa@codeaurora.org>, <X.xie@freescale.com>, <benh@kernel.crashing.org>,
 <leoli@freescale.com>, <paulus@samba.org>
Subject: Re: [PATCH v10 5/5] QE: Move QE from arch/powerpc to drivers/soc
Message-ID: <20150921225611.GC12709@home.buserror.net>
References: <1442560521-19354-1-git-send-email-qiang.zhao@freescale.com>
 <1442560521-19354-5-git-send-email-qiang.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1442560521-19354-5-git-send-email-qiang.zhao@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 18, 2015 at 03:15:21PM +0800, Zhao Qiang wrote:
> diff --git a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
> new file mode 100644
> index 0000000..3012571
> --- /dev/null
> +++ b/drivers/soc/fsl/qe/Kconfig
> @@ -0,0 +1,33 @@
> +#
> +# QE Communication options
> +#
> +
> +config QUICC_ENGINE
> +	bool "Freescale QUICC Engine (QE) Support"
> +	depends on FSL_SOC && PPC32
> +	select PPC_LIB_RHEAP
> +	select GENERIC_ALLOCATOR
> +	select CRC32

Why is "select PPC_LIB_RHEAP" still here?

> +	help
> +	  The QUICC Engine (QE) is a new generation of communications
> +	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
> +	  Selecting this option means that you wish to build a kernel
> +	  for a machine with a QE coprocessor.
> +
> +config UCC_SLOW
> +	bool
> +	default y if SERIAL_QE
> +	help
> +	  This option provides qe_lib support to UCC slow
> +	  protocols: UART, BISYNC, QMC
> +
> +config UCC_FAST
> +	bool
> +	default y if UCC_GETH
> +	help
> +	  This option provides qe_lib support to UCC fast
> +	  protocols: HDLC, Ethernet, ATM, transparent

What does "qe_lib" mean to the end user, or to anyone after the code is
moved to drivers/soc/fsl/qe?

-Scott
