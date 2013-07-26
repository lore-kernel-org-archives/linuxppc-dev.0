Return-Path: <jdelvare@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id DC7C12C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 21:01:24 +1000 (EST)
Subject: Re: [PATCH 5/7] rapidio: add modular build option for the
 subsystem core
From: Jean Delvare <jdelvare@suse.de>
To: Alexandre Bounine <alexandre.bounine@idt.com>
In-Reply-To: <1372447136-5751-6-git-send-email-alexandre.bounine@idt.com>
References: <1372447136-5751-1-git-send-email-alexandre.bounine@idt.com>
 <1372447136-5751-6-git-send-email-alexandre.bounine@idt.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 26 Jul 2013 13:00:54 +0200
Message-ID: <1374836454.4361.2.camel@chaos.site>
Mime-Version: 1.0
Cc: Stef van Os <stef.van.os@Prodrive.nl>,
 Micha Nelissen <micha.nelissen@Prodrive.nl>, linux-kernel@vger.kernel.org,
 Andre van Herk <andre.van.herk@Prodrive.nl>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Alexandre,

Le Friday 28 June 2013 à 15:18 -0400, Alexandre Bounine a écrit :
> Add a configuration option to build RapidIO subsystem core code as a loadable
> kernel module. Currently this option is available only for x86-based platforms,
> with the additional patch for PowerPC planned to be provided later.
> 
> This patch replaces kernel command line parameter "riohdid=" with its
> module-specific analog "rapidio.hdid=".  
> 
> Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
> Cc: Matt Porter <mporter@kernel.crashing.org>
> Cc: Li Yang <leoli@freescale.com>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: Andre van Herk <andre.van.herk@Prodrive.nl>
> Cc: Micha Nelissen <micha.nelissen@Prodrive.nl>
> Cc: Stef van Os <stef.van.os@Prodrive.nl>
> Cc: Jean Delvare <jdelvare@suse.de>
> ---
>  arch/x86/Kconfig         |    4 ++--
>  drivers/rapidio/Makefile |    4 +++-
>  drivers/rapidio/rio.c    |   27 ++++++++++++++-------------
>  3 files changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index fe120da..583ac42 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2246,11 +2246,11 @@ source "drivers/pcmcia/Kconfig"
>  source "drivers/pci/hotplug/Kconfig"
>  
>  config RAPIDIO
> -	bool "RapidIO support"
> +	tristate "RapidIO support"

Is there a reason why this was only done for x86 and not for mips and
powerpc?

>  	depends on PCI
>  	default n
>  	help
> -	  If you say Y here, the kernel will include drivers and
> +	  If enabled this option will include drivers and the core
>  	  infrastructure code to support RapidIO interconnect devices.
>  

-- 
Jean Delvare
Suse L3
