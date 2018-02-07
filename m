Return-Path: <alexandre.belloni@free-electrons.com>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zbktD5XY6zF0yN
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Feb 2018 12:55:15 +1100 (AEDT)
Date: Wed, 7 Feb 2018 02:55:09 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] char: nvram: disable on ARM
Message-ID: <20180207015509.GV3404@piout.net>
References: <20180206220534.9929-1-alexandre.belloni@bootlin.com>
 <CAK8P3a0Wmh6acO7W=weX37B2GNbecJQzPhZdVZcXXAwfT6jZ5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAK8P3a0Wmh6acO7W=weX37B2GNbecJQzPhZdVZcXXAwfT6jZ5A@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/02/2018 at 23:55:02 +0100, Arnd Bergmann wrote:
> * arch/arm/kernel/time.c has this code
> 
> #if defined(CONFIG_RTC_DRV_CMOS) || defined(CONFIG_RTC_DRV_CMOS_MODULE) || \
>     defined(CONFIG_NVRAM) || defined(CONFIG_NVRAM_MODULE)
> /* this needs a better home */
> DEFINE_SPINLOCK(rtc_lock);
> EXPORT_SYMBOL(rtc_lock);
> #endif  /* pc-style 'CMOS' RTC support */
> 
> That can be adapted now, or maybe we could move all definitions into
> a common place (that needs some more planning).
> 

Yes, on arm, the rtc_lock is mostly there to please
drivers/rtc/rtc-cmos.c. Maybe we could make the locking in this driver
x86 and PPC specific.

If we can get rid of arch/powerpc/platforms/chrp/time.c and
arch/powerpc/platforms/maple/time.c (so much duplicated code), then it
is x86 only.

> * similarly, this line in nvram.c can be simplified:
> #if defined(CONFIG_ATARI)
> #  define MACH ATARI
> #elif defined(__i386__) || defined(__x86_64__) || defined(__arm__)  /* and ?? */
> #  define MACH PC
> #else
> #  error Cannot build nvram driver for this machine configuration.
> #endif
> 
> * GENERIC_NVRAM is not really generic, instead this seems to be the
>   chardev that is used for 32-bit powerpc (powermac, 85xx, 86xx), while
>   64-bit powerpc (cell, maple, opal, pseries) use code from
>   arch/powerpc/kernel/nvram_64.c, with the same underlying arch hooks.
>   The nvram_64 code appears to be mostly a superset of the 32-bit
>   generic_nvram one.
> 
> * The code in drivers/char/nvram is not used at all when
>    GENERIC_NVRAM is set, and half the code in there is different
>    between x86 and atari.
> 
> * most of the external interface in include/linux/nvram.h is
>   unused, the rest tends to be architecture specific
> 
> * The procfs file appears to be completely useless on any 64-bit
>    x86 machine, this is what I see:
> 
> $ cat /proc/driver/nvram
> Checksum status: valid
> # floppies     : 0
> Floppy 0 type  : none
> Floppy 1 type  : none
> HD 0 type      : none
> HD 1 type      : none
> HD type 48 data: 0/0/0 C/H/S, precomp 0, lz 0
> HD type 49 data: 156/0/0 C/H/S, precomp 0, lz 0
> DOS base memory: 635 kB
> Extended memory: 65535 kB (configured), 65535 kB (tested)
> Gfx adapter    : EGA, VGA, ... (with BIOS)
> FPU            : not installed
> 

I really don't think anyone is using that but I don't really know much
about x86 and the specification this may be part of.

I see the info may be used in drivers/video/fbdev/ and
drivers/platform/x86/thinkpad_acpi.c

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
