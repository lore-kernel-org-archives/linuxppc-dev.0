Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AF44CDDE04
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 14:00:48 +1000 (EST)
Message-Id: <9E78A635-CB7B-4A51-9FD5-2922747D4847@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080429190017.GA21203@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 1/6] [POWERPC] sysdev: implement FSL GTM support
Date: Wed, 30 Apr 2008 23:00:42 -0500
References: <20080429185920.GA19735@polina.dev.rtsoft.ru>
	<20080429190017.GA21203@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 29, 2008, at 2:00 PM, Anton Vorontsov wrote:
> GTM stands for General-purpose Timers Module and able to generate
> timer{1,2,3,4} interrupts. These timers are used by the drivers that
> need time precise interrupts (like for USB transactions scheduling for
> the Freescale USB Host controller as found in some QE and CPM chips),
> or these timers could be used as wakeup events from the CPU deep-sleep
> mode.
>
> Things unimplemented:
> 1. Cascaded (32 bit) timers (1-2, 3-4).
>   This is straightforward to implement when needed, two timers should
>   be marked as "requested" and configured as appropriate.
> 2. Super-cascaded (64 bit) timers (1-2-3-4).
>   This is also straightforward to implement when needed, all timers
>   should be marked as "requested" and configured as appropriate.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> Documentation/powerpc/booting-without-of.txt |   37 +++-
> arch/powerpc/Kconfig                         |    5 +
> arch/powerpc/sysdev/Makefile                 |    1 +
> arch/powerpc/sysdev/fsl_gtm.c                |  424 +++++++++++++++++ 
> +++++++++
> include/asm-powerpc/fsl_gtm.h                |   47 +++
> 5 files changed, 513 insertions(+), 1 deletions(-)
> create mode 100644 arch/powerpc/sysdev/fsl_gtm.c
> create mode 100644 include/asm-powerpc/fsl_gtm.h
>
>

>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 4e40c12..4070a78 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -538,6 +538,11 @@ config FSL_LBC
> 	help
> 	  Freescale Localbus support
>
> +config FSL_GTM
> +	bool
> +	help
> +	  Freescale General-purpose Timers support
> +

what chips actually use this?  just QE or 83xx?

- k
