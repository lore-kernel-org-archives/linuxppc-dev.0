Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [150.101.137.129])
 by lists.ozlabs.org (Postfix) with ESMTP id 75FE71A070E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 14:12:45 +1000 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: Pranith Kumar <bobby.prani@gmail.com>
Subject: Re: [PATCH] powerpc: Fix build failure when CONFIG_USB=y
Date: Tue, 16 Sep 2014 14:12:44 +1000
Message-ID: <5910448.DIq02Mfy77@mexican>
In-Reply-To: <1408626964-31554-1-git-send-email-bobby.prani@gmail.com>
References: <1408626964-31554-1-git-send-email-bobby.prani@gmail.com>
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

On Thu, 21 Aug 2014 09:16:04 Pranith Kumar wrote:
> We are enabling USB unconditionally which results in following build failure
> 
> drivers/built-in.o: In function `tb_drom_read':
> (.text+0x1b62b70): undefined reference to `usb_speed_string'
> make: *** [vmlinux] Error
> 
> Enable USB only if USB_SUPPORT is set to avoid such failures
> 
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  arch/powerpc/platforms/44x/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/44x/Kconfig
> b/arch/powerpc/platforms/44x/Kconfig index 3e7deb2..82f2da2 100644
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -215,7 +215,7 @@ config AKEBONO
>  	select NET_VENDOR_IBM
>  	select IBM_EMAC_EMAC4
>  	select IBM_EMAC_RGMII_WOL
> -	select USB
> +	select USB if USB_SUPPORT
>  	select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
>  	select USB_EHCI_HCD_PLATFORM if USB_EHCI_HCD
>  	select MMC_SDHCI
