Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [150.101.137.129])
 by lists.ozlabs.org (Postfix) with ESMTP id AF9D41A0138
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 14:12:39 +1000 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: Pranith Kumar <bobby.prani@gmail.com>
Subject: Re: [PATCH] powerpc: Fix build failure
Date: Tue, 16 Sep 2014 14:12:37 +1000
Message-ID: <1480446.gFeczbkrbH@mexican>
In-Reply-To: <1408626271-13519-1-git-send-email-bobby.prani@gmail.com>
References: <1408626271-13519-1-git-send-email-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: open list <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for fixing these!

Acked-by: Alistair Popple <alistair@popple.id.au>

On Thu, 21 Aug 2014 09:04:31 Pranith Kumar wrote:
> Fix the following build failure
> 
> drivers/built-in.o: In function `nhi_init':
> nhi.c:(.init.text+0x63390): undefined reference to `ehci_init_driver'
> 
> by adding a dependency on USB_EHCI_HCD which supplies the
> ehci_init_driver().
> 
> Also we need to depend on USB_OHCI_HCD similarly
> 
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  arch/powerpc/platforms/44x/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/44x/Kconfig
> b/arch/powerpc/platforms/44x/Kconfig index 4d88f6a..3e7deb2 100644
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -216,8 +216,8 @@ config AKEBONO
>  	select IBM_EMAC_EMAC4
>  	select IBM_EMAC_RGMII_WOL
>  	select USB
> -	select USB_OHCI_HCD_PLATFORM
> -	select USB_EHCI_HCD_PLATFORM
> +	select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
> +	select USB_EHCI_HCD_PLATFORM if USB_EHCI_HCD
>  	select MMC_SDHCI
>  	select MMC_SDHCI_PLTFM
>  	select MMC_SDHCI_OF_476GTR
