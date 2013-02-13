Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CFFA12C008C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2013 01:02:08 +1100 (EST)
Subject: Re: [PATCH 15/17] powerpc: Add config option for transactional memory
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1360729895-304-16-git-send-email-mikey@neuling.org>
Date: Wed, 13 Feb 2013 08:02:04 -0600
Message-Id: <2AEBB52F-9DB5-4211-9DA7-B1D271F1D6E8@kernel.crashing.org>
References: <1360729895-304-1-git-send-email-mikey@neuling.org>
 <1360729895-304-16-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 12, 2013, at 10:31 PM, Michael Neuling wrote:

> Kconfig option for transactional memory on powerpc.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> arch/powerpc/Kconfig |    8 ++++++++
> 1 file changed, 8 insertions(+)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 4b27edb..fbeb6d2 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -313,6 +313,14 @@ config MATH_EMULATION
> 	  unit, which will allow programs that use floating-point
> 	  instructions to run.
> 
> +config PPC_TRANSACTIONAL_MEM
> +       bool "Transactional Memory support for POWERPC"
> +       depends on PPC64

Should this really depend on PPC_BOOK3S_64 ?

> +       depends on SMP
> +       default n
> +       ---help---
> +         Support user-mode Transactional Memory on POWERPC.
> +
> config 8XX_MINIMAL_FPEMU
> 	bool "Minimal math emulation for 8xx"
> 	depends on 8xx && !MATH_EMULATION
> -- 
> 1.7.10.4
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
