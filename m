Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
 by ozlabs.org (Postfix) with ESMTP id 1C0822C008E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2012 00:17:00 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Teodori Serge <teodori.serge@gmail.com>
Subject: Re: [PATCH 1/1] drivers/char/mem.c
Date: Sun, 23 Sep 2012 14:16:51 +0000
References: <Teodori Serge <teodori.serge@hotmail.com>
 <teodori.serge@hotmail.com>
 <1348348812-17201-1-git-send-email-teodori.serge@hotmail.com>
In-Reply-To: <1348348812-17201-1-git-send-email-teodori.serge@hotmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201209231416.52067.arnd@arndb.de>
Cc: Teodori Serge <teodori.serge@hotmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Saturday 22 September 2012, Teodori Serge wrote:
> replace 'arch_has_dev_port()' to 'CONFIG_DEVPORT'
> 
> modified:   arch/powerpc/include/asm/io.h
> modified:   drivers/char/mem.c
> modified:   include/linux/io.h
> 
> why do we need 'arch_has_dev_port()' if we have a 'CONFIG_DEVPORT'?
> 
> Signed-off-by: Teodori Serge <teodori.serge@hotmail.com>
> ---
>  arch/powerpc/include/asm/io.h |    2 +-
>  drivers/char/mem.c            |    6 ------
>  include/linux/io.h            |    9 ---------
>  3 files changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
> index f94ef42..cb8b663 100644
> --- a/arch/powerpc/include/asm/io.h
> +++ b/arch/powerpc/include/asm/io.h
> @@ -25,7 +25,7 @@ extern struct pci_dev *isa_bridge_pcidev;
>  /*
>   * has legacy ISA devices ?
>   */
> -#define arch_has_dev_port()	(isa_bridge_pcidev != NULL)
> +#define CONFIG_DEVPORT	(isa_bridge_pcidev != NULL)
>  #endif
>  
>  #include <linux/device.h>

By convention, CONFIG_* symbols should only be set by Kconfig and not used
for runtime checks.

Also, the existing checks for those symbols check for whether it is
defined, not for the actual value. With what you have there,
the driver will always enable /dev/ports because CONFIG_DEVPORT
is defined.

What are you actually trying to achieve?

	Arnd
