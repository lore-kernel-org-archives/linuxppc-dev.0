Return-Path: <geoff@infradead.org>
Message-ID: <4E5425B7.6060205@infradead.org>
Date: Tue, 23 Aug 2011 15:12:07 -0700
From: Geoff Levand <geoff@infradead.org>
MIME-Version: 1.0
To: Andre Heider <a.heider@gmail.com>
Subject: Re: [PATCH part1 v2 8/9] ps3flash: Refuse to work in lpars other
	than OtherOS
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1313091073-4572-1-git-send-email-a.heider@gmail.com>
	<1313091073-4572-9-git-send-email-a.heider@gmail.com>
In-Reply-To: <1313091073-4572-9-git-send-email-a.heider@gmail.com>
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

On 08/11/2011 12:31 PM, Andre Heider wrote:
> The driver implements a character and misc device, meant for the
> axed OtherOS to exchange various settings with GameOS.
> Since Firmware 3.21 there is no support anymore to write these
> settings, so test if we're running in OtherOS, and refuse to load
> if that is not the case.

Please see my comments to the v1 patch regarding this text.

> Signed-off-by: Andre Heider <a.heider@gmail.com>
> ---
>  arch/powerpc/platforms/ps3/Kconfig |    2 +-
>  drivers/char/ps3flash.c            |    7 +++++++
>  2 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/ps3/Kconfig b/arch/powerpc/platforms/ps3/Kconfig
> index 84df5c8..72fdecd 100644
> --- a/arch/powerpc/platforms/ps3/Kconfig
> +++ b/arch/powerpc/platforms/ps3/Kconfig
> @@ -121,7 +121,7 @@ config PS3_FLASH
>  
>  	  This support is required to access the PS3 FLASH ROM, which
>  	  contains the boot loader and some boot options.
> -	  In general, all users will say Y or M.
> +	  In general, all PS3 OtherOS users will say Y or M.
>  
>  	  As this driver needs a fixed buffer of 256 KiB of memory, it can
>  	  be disabled on the kernel command line using "ps3flash=off", to
> diff --git a/drivers/char/ps3flash.c b/drivers/char/ps3flash.c
> index d0c57c2..fc6d867 100644
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
> @@ -464,6 +465,12 @@ static struct ps3_system_bus_driver ps3flash = {
>  
>  static int __init ps3flash_init(void)
>  {
> +	if (!firmware_has_feature(FW_FEATURE_PS3_LV1))
> +		return -ENODEV;
> +
> +	if (ps3_get_ss_laid() != PS3_SS_LAID_OTHEROS)
> +		return -ENODEV;
> +
>  	return ps3_system_bus_driver_register(&ps3flash);
>  }
>  
