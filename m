Return-Path: <chuckmeade@mindspring.com>
Received: from txslsmtp2.vzwmail.net (txslsmtp2.vzwmail.net [66.174.85.156])
	by ozlabs.org (Postfix) with ESMTP id 3168567B89
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 23:51:42 +1000 (EST)
From: "Chuck Meade" <chuckmeade@mindspring.com>
To: "Li Yang" <leoli@freescale.com>, <paulus@samba.org>,
	<galak@kernel.crashing.org>,
	"Chuck Meade \(mindspring\)" <chuckmeade@mindspring.com>
Subject: RE: [PATCH 1/12] qe_lib: Add QE Kconfig
Date: Thu, 28 Sep 2006 09:38:08 -0400
Message-ID: <IIEEICKJLNEPBBDJICNGKEAEMEAA.chuckmeade@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <451B8562.4040904@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> 
> ---
>  arch/powerpc/Kconfig |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 694b0c6..c907792 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -355,6 +355,16 @@ config APUS
>  	  <http://linux-apus.sourceforge.net/>.
>  endchoice
>  
> +config QUICC_ENGINE
> +	bool
> +	depends on MPC836x

The QUICC Engine is on chips other than MPC836x, such as the MPC832x:
http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=MPC8323E

Why do you want it to depend on MPC836x?
Or do you just plan to change this dependency once 832x support is in
the source tree?

Chuck

> +	default y
> +	help
> +	  The QE(QUICC Engine) is a new generation of coprocessor on 
> +	  Freescale embedded CPUs(like CPM  in older chips).  Selecting
> +	  this option means that you wish to build a kernel for a machine
> +	  with QE coprocessor on it.
> +
>  config PPC_PSERIES
>  	depends on PPC_MULTIPLATFORM && PPC64
>  	bool "IBM pSeries & new (POWER5-based) iSeries"
> @@ -1047,6 +1057,8 @@ # XXX source "arch/ppc/8xx_io/Kconfig"
>  
>  # XXX source "arch/ppc/8260_io/Kconfig"
>  
> +source "arch/powerpc/sysdev/qe_lib/Kconfig"
> +
>  source "arch/powerpc/platforms/iseries/Kconfig"
>  
>  source "lib/Kconfig"
