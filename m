Return-Path: <avorontsov@ru.mvista.com>
Date: Fri, 30 May 2008 16:50:57 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] [NAND] driver extension to support NAND on TQM85xx modules
Message-ID: <20080530125057.GB13407@polina.dev.rtsoft.ru>
References: <1212129392-27589-1-git-send-email-wg@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <1212129392-27589-1-git-send-email-wg@grandegger.com>
Cc: Linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 30, 2008 at 08:36:32AM +0200, Wolfgang Grandegger wrote:
> This patch extends the FSL UPM NAND driver from Anton Vorontsov to
> support for the TQM85xx modules. Unfortunately, the hardware does
> not support the R/B pins of the NAND chip and therefore the specified
> maximum delay time must used. It therefore re-introduces the chip-delay
> property.
> 
> Note: this patch is based on a patch Anton Vorontsov posted to this list:
>       See http://ozlabs.org/pipermail/linuxppc-dev/2008-April/055587.html.
>       It should show up mainstream soon. 

Personally, I like this patch. But OF people should approve "chip-delay"
property. Though, the whole UPM NAND bindings are in the air still.

> --- a/include/linux/of_gpio.h
> +++ b/include/linux/of_gpio.h
> @@ -15,7 +15,7 @@
>  #define __LINUX_OF_GPIO_H
>  
>  #include <linux/errno.h>
> -#include <asm/gpio.h>
> +#include <linux/gpio.h>

This should be done separately.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
