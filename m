Return-Path: <arndbergmann@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zbftL3q3MzF11v
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Feb 2018 09:55:05 +1100 (AEDT)
Received: by mail-oi0-x244.google.com with SMTP id j15so2621888oii.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Feb 2018 14:55:05 -0800 (PST)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180206220534.9929-1-alexandre.belloni@bootlin.com>
References: <20180206220534.9929-1-alexandre.belloni@bootlin.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Feb 2018 23:55:02 +0100
Message-ID: <CAK8P3a0Wmh6acO7W=weX37B2GNbecJQzPhZdVZcXXAwfT6jZ5A@mail.gmail.com>
Subject: Re: [PATCH] char: nvram: disable on ARM
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 6, 2018 at 11:05 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> /dev/nvram was never meant to be used alongside the RTC CMOS driver from
> drivers/rtc as it already expose the NVRAM through another interface..
> Anyway, the last defconfig to enable it properly was removed in 2010 so
> prevent ARM users from selecting it.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/char/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index c28dca0c613d..9bcac927cfd0 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -264,7 +264,7 @@ source "drivers/char/hw_random/Kconfig"
>
>  config NVRAM
>         tristate "/dev/nvram support"
> -       depends on ATARI || X86 || (ARM && RTC_DRV_CMOS) || GENERIC_NVRAM
> +       depends on ATARI || X86 || GENERIC_NVRAM
>         ---help---
>           If you say Y here and create a character special file /dev/nvram
>           with major number 10 and minor number 144 using mknod ("man mknod"),

The change looks good:

Acked-by: Arnd Bergmann <arnd@arndb.de>

but taking a closer look raises a few other points:

* arch/arm/kernel/time.c has this code

#if defined(CONFIG_RTC_DRV_CMOS) || defined(CONFIG_RTC_DRV_CMOS_MODULE) || \
    defined(CONFIG_NVRAM) || defined(CONFIG_NVRAM_MODULE)
/* this needs a better home */
DEFINE_SPINLOCK(rtc_lock);
EXPORT_SYMBOL(rtc_lock);
#endif  /* pc-style 'CMOS' RTC support */

That can be adapted now, or maybe we could move all definitions into
a common place (that needs some more planning).

* similarly, this line in nvram.c can be simplified:
#if defined(CONFIG_ATARI)
#  define MACH ATARI
#elif defined(__i386__) || defined(__x86_64__) || defined(__arm__)  /* and ?? */
#  define MACH PC
#else
#  error Cannot build nvram driver for this machine configuration.
#endif

* GENERIC_NVRAM is not really generic, instead this seems to be the
  chardev that is used for 32-bit powerpc (powermac, 85xx, 86xx), while
  64-bit powerpc (cell, maple, opal, pseries) use code from
  arch/powerpc/kernel/nvram_64.c, with the same underlying arch hooks.
  The nvram_64 code appears to be mostly a superset of the 32-bit
  generic_nvram one.

* The code in drivers/char/nvram is not used at all when
   GENERIC_NVRAM is set, and half the code in there is different
   between x86 and atari.

* most of the external interface in include/linux/nvram.h is
  unused, the rest tends to be architecture specific

* The procfs file appears to be completely useless on any 64-bit
   x86 machine, this is what I see:

$ cat /proc/driver/nvram
Checksum status: valid
# floppies     : 0
Floppy 0 type  : none
Floppy 1 type  : none
HD 0 type      : none
HD 1 type      : none
HD type 48 data: 0/0/0 C/H/S, precomp 0, lz 0
HD type 49 data: 156/0/0 C/H/S, precomp 0, lz 0
DOS base memory: 635 kB
Extended memory: 65535 kB (configured), 65535 kB (tested)
Gfx adapter    : EGA, VGA, ... (with BIOS)
FPU            : not installed

      Arnd
