Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id D9789DDDCA
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 03:47:36 +1100 (EST)
Date: Thu, 15 Mar 2007 11:47:28 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH][POWERPC] QE: Make QUICC Engine support a
	configurableoption
Message-ID: <20070315164728.GA20524@ld0162-tx32.am.freescale.net>
References: <989B956029373F45A0B8AF02970818902DB124@zch01exm26.fsl.freescale.net>
	<45F94472.6010803@freescale.com>
	<Pine.LNX.4.64.0703151006110.28961@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0703151006110.28961@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 15, 2007 at 10:07:31AM -0500, Kumar Gala wrote:
>  config MPC836x_MDS
>  	bool "Freescale MPC836x MDS"
>  	select DEFAULT_UIMAGE
> -	select QUICC_ENGINE
>  	help
>  	  This option enables support for the MPC836x MDS Processor Board.
> 
>  endchoice
> 
> +config QUICC_ENGINE_83xx
> +	bool "QUICC Engine Support"
> +	select QUICC_ENGINE
> +	depends on PPC_MPC836x || PPC_MPC832x
> +	default y
> +	---help---
> +	  The QUICC Engine (QE) is a new generation of communications
> +	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
> +	  Selecting this option means that you wish to build a kernel
> +	  for a machine with a QE coprocessor.
> +

Instead of doing it like this, what about having each QE-enabled SOC
select HAS_QUICC_ENGINE, and then have the user-configurable
QUICC_ENGINE option depend on HAS_QUICC_ENGINE?

That way, there's no need for separate 83xx and 85xx defines, and the
knowledge of which SOCs have QE is maintaned with the SOC entry, rather
than in a separate list.

-Scott
