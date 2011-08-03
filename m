Return-Path: <geoff@infradead.org>
Message-ID: <4E39CCF3.7000406@infradead.org>
Date: Wed, 3 Aug 2011 15:34:27 -0700
From: Geoff Levand <geoff@infradead.org>
MIME-Version: 1.0
To: Andre Heider <a.heider@gmail.com>
Subject: Re: [PATCH 07/15] ps3flash: Refuse to work in lpars other than OtherOS
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1312228986-32307-8-git-send-email-a.heider@gmail.com>
In-Reply-To: <1312228986-32307-8-git-send-email-a.heider@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: cbe-oss-dev@lists.ozlabs.org, Hector Martin <hector@marcansoft.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/01/2011 01:02 PM, Andre Heider wrote:
> The driver implements a character and misc device, meant for the
> axed OtherOS to exchange various settings with GameOS.
> Since Firmware 3.21 there is no GameOS support anymore to write these
> settings, so limit the driver to the OtherOS environment.

This is really a test if running on the PS3 OtherOS, so this
comment should state that.

> 
> Signed-off-by: Andre Heider <a.heider@gmail.com>
> ---
>  arch/powerpc/platforms/ps3/Kconfig |    1 +
>  drivers/char/ps3flash.c            |    7 +++++++
>  2 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/ps3/Kconfig b/arch/powerpc/platforms/ps3/Kconfig
> index 84df5c8..5eb956a 100644
> --- a/arch/powerpc/platforms/ps3/Kconfig
> +++ b/arch/powerpc/platforms/ps3/Kconfig
> @@ -121,6 +121,7 @@ config PS3_FLASH
>  
>  	  This support is required to access the PS3 FLASH ROM, which
>  	  contains the boot loader and some boot options.
> +	  This driver only supports the deprecated OtherOS LPAR.

This will be confusing for OtherOS users, so should be removed.

>  	  In general, all users will say Y or M.


This could be changed to: 'In general, all PS3 OtherOS users will say Y or M.'

>  
>  	  As this driver needs a fixed buffer of 256 KiB of memory, it can
> diff --git a/drivers/char/ps3flash.c b/drivers/char/ps3flash.c
> index 69c734a..b1e8659 100644
> --- a/drivers/char/ps3flash.c
> +++ b/drivers/char/ps3flash.c
> @@ -25,6 +25,7 @@
>  
>  #include <asm/lv1call.h>
>  #include <asm/ps3stor.h>
> +#include <asm/firmware.h>
>  
>  
>  #define DEVICE_NAME		"ps3flash"
> @@ -455,6 +456,12 @@ static struct ps3_system_bus_driver ps3flash = {
>  
>  static int __init ps3flash_init(void)
>  {
> +	if (!firmware_has_feature(FW_FEATURE_PS3_LV1))
> +		return -ENODEV;

Is this needed?  Won't this driver only be loaded on PS3 hardware?

> +
> +	if (ps3_get_ss_laid() != PS3_SS_LAID_OTHEROS)
> +		return -ENODEV;
> +
>  	return ps3_system_bus_driver_register(&ps3flash);
>  }
>  

-Geoff
