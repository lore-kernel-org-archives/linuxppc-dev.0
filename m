Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F2A57DDE9E
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jun 2008 08:04:03 +1000 (EST)
Message-Id: <A09E5DF4-4844-41E6-B30A-C3E08BE342EB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: John Rigby <jrigby@freescale.com>
In-Reply-To: <1213981119-1979-6-git-send-email-jrigby@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 5/6] MPC5121 Add PCI support
Date: Fri, 20 Jun 2008 17:03:52 -0500
References: <1213981119-1979-1-git-send-email-jrigby@freescale.com>
	<1213981119-1979-2-git-send-email-jrigby@freescale.com>
	<1213981119-1979-3-git-send-email-jrigby@freescale.com>
	<1213981119-1979-4-git-send-email-jrigby@freescale.com>
	<1213981119-1979-5-git-send-email-jrigby@freescale.com>
	<1213981119-1979-6-git-send-email-jrigby@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 20, 2008, at 11:58 AM, John Rigby wrote:

> Copied from 83xx minus support for two busses.
>
> Signed-off-by: John Rigby <jrigby@freescale.com>
> ---
> arch/powerpc/Kconfig                      |    2 +-
> arch/powerpc/platforms/512x/Kconfig       |    1 +
> arch/powerpc/platforms/512x/Makefile      |    1 +
> arch/powerpc/platforms/512x/mpc5121_ads.c |   10 ++++
> arch/powerpc/platforms/512x/mpc512x.h     |    1 +
> arch/powerpc/platforms/512x/pci.c         |   84 ++++++++++++++++++++ 
> +++++++++
> 6 files changed, 98 insertions(+), 1 deletions(-)
> create mode 100644 arch/powerpc/platforms/512x/pci.c
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 3934e26..5a467a1 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -545,7 +545,7 @@ config MCA
> config PCI
> 	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx ||  
> PPC_86xx \
> 		|| PPC_MPC52xx || (EMBEDDED && (PPC_PSERIES || PPC_ISERIES)) \
> -		|| PPC_PS3 || 44x
> +		|| PPC_PS3 || 44x || PPC_MPC512x

is it possible to select PCI rather than adding to the madness here?

>
> 	default y if !40x && !CPM2 && !8xx && !PPC_MPC512x && !PPC_83xx \
> 		&& !PPC_85xx && !PPC_86xx
> 	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx


> diff --git a/arch/powerpc/platforms/512x/pci.c b/arch/powerpc/ 
> platforms/512x/pci.c
> new file mode 100644
> index 0000000..7ed9b34
> --- /dev/null
> +++ b/arch/powerpc/platforms/512x/pci.c
> @@ -0,0 +1,84 @@
> +/*
> + * Copyright (C) 2008 Freescale Semiconductor, Inc. All rights  
> reserved.
> + *
> + * Original copied from 83xx/pci.c:

Can we not reuse the same code for 83xx/pci.c and 5121/pci?  and move  
it into sysdev/fsl_pci.c?  (we'd add some ifdefs for 83xx & 5121)

- k
