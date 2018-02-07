Return-Path: <arndbergmann@gmail.com>
Received: from mail-ot0-x241.google.com (mail-ot0-x241.google.com
 [IPv6:2607:f8b0:4003:c0f::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zbyNk38FPzDrC3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Feb 2018 21:33:58 +1100 (AEDT)
Received: by mail-ot0-x241.google.com with SMTP id a2so353344otf.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Feb 2018 02:33:57 -0800 (PST)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180207015509.GV3404@piout.net>
References: <20180206220534.9929-1-alexandre.belloni@bootlin.com>
 <CAK8P3a0Wmh6acO7W=weX37B2GNbecJQzPhZdVZcXXAwfT6jZ5A@mail.gmail.com>
 <20180207015509.GV3404@piout.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Feb 2018 11:33:55 +0100
Message-ID: <CAK8P3a3dkAESaqGgLAV9uKKet20rVtBXqBJ-eNGbwQv1i05K7A@mail.gmail.com>
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

On Wed, Feb 7, 2018 at 2:55 AM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 06/02/2018 at 23:55:02 +0100, Arnd Bergmann wrote:
>> * arch/arm/kernel/time.c has this code
>>
>> #if defined(CONFIG_RTC_DRV_CMOS) || defined(CONFIG_RTC_DRV_CMOS_MODULE) || \
>>     defined(CONFIG_NVRAM) || defined(CONFIG_NVRAM_MODULE)
>> /* this needs a better home */
>> DEFINE_SPINLOCK(rtc_lock);
>> EXPORT_SYMBOL(rtc_lock);
>> #endif  /* pc-style 'CMOS' RTC support */
>>
>> That can be adapted now, or maybe we could move all definitions into
>> a common place (that needs some more planning).
>>
>
> Yes, on arm, the rtc_lock is mostly there to please
> drivers/rtc/rtc-cmos.c. Maybe we could make the locking in this driver
> x86 and PPC specific.
>
> If we can get rid of arch/powerpc/platforms/chrp/time.c and
> arch/powerpc/platforms/maple/time.c (so much duplicated code), then it
> is x86 only.

What about these:

arch/alpha/kernel/rtc.c:        spin_lock(&rtc_lock);
arch/alpha/kernel/rtc.c:        spin_unlock(&rtc_lock);
arch/alpha/kernel/time.c:DEFINE_SPINLOCK(rtc_lock);
arch/alpha/kernel/time.c:EXPORT_SYMBOL(rtc_lock);
arch/arm/kernel/time.c:DEFINE_SPINLOCK(rtc_lock);
arch/arm/kernel/time.c:EXPORT_SYMBOL(rtc_lock);
arch/m32r/kernel/time.c:DEFINE_SPINLOCK(rtc_lock);
arch/m32r/kernel/time.c:EXPORT_SYMBOL(rtc_lock);
arch/m68k/atari/time.c:DEFINE_SPINLOCK(rtc_lock);
arch/m68k/atari/time.c:EXPORT_SYMBOL_GPL(rtc_lock);
arch/mn10300/kernel/rtc.c:DEFINE_SPINLOCK(rtc_lock);
arch/mn10300/kernel/rtc.c:EXPORT_SYMBOL(rtc_lock);
arch/powerpc/kernel/time.c:DEFINE_SPINLOCK(rtc_lock);
arch/powerpc/kernel/time.c:EXPORT_SYMBOL_GPL(rtc_lock);
arch/sparc/kernel/time_32.c:DEFINE_SPINLOCK(rtc_lock);
arch/sparc/kernel/time_32.c:EXPORT_SYMBOL(rtc_lock);
arch/sparc/kernel/time_64.c:DEFINE_SPINLOCK(rtc_lock);

Are they all obsolete?

>> * similarly, this line in nvram.c can be simplified:
>> #if defined(CONFIG_ATARI)
>> #  define MACH ATARI
>> #elif defined(__i386__) || defined(__x86_64__) || defined(__arm__)  /* and ?? */
>> #  define MACH PC
>> #else
>> #  error Cannot build nvram driver for this machine configuration.
>> #endif
>>
>> * GENERIC_NVRAM is not really generic, instead this seems to be the
>>   chardev that is used for 32-bit powerpc (powermac, 85xx, 86xx), while
>>   64-bit powerpc (cell, maple, opal, pseries) use code from
>>   arch/powerpc/kernel/nvram_64.c, with the same underlying arch hooks.
>>   The nvram_64 code appears to be mostly a superset of the 32-bit
>>   generic_nvram one.
>>
>> * The code in drivers/char/nvram is not used at all when
>>    GENERIC_NVRAM is set, and half the code in there is different
>>    between x86 and atari.
>>
>> * most of the external interface in include/linux/nvram.h is
>>   unused, the rest tends to be architecture specific
>>
>> * The procfs file appears to be completely useless on any 64-bit
>>    x86 machine, this is what I see:
>>
>> $ cat /proc/driver/nvram
>> Checksum status: valid
>> # floppies     : 0
>> Floppy 0 type  : none
>> Floppy 1 type  : none
>> HD 0 type      : none
>> HD 1 type      : none
>> HD type 48 data: 0/0/0 C/H/S, precomp 0, lz 0
>> HD type 49 data: 156/0/0 C/H/S, precomp 0, lz 0
>> DOS base memory: 635 kB
>> Extended memory: 65535 kB (configured), 65535 kB (tested)
>> Gfx adapter    : EGA, VGA, ... (with BIOS)
>> FPU            : not installed
>>
>
> I really don't think anyone is using that but I don't really know much
> about x86 and the specification this may be part of.
>
> I see the info may be used in drivers/video/fbdev/ and
> drivers/platform/x86/thinkpad_acpi.c

The thinkpad_acpi driver seems to look at some other bytes
in the nvram, which have a platform specific meaning.

For drivers/video/fbdev/, these appear to all be for pre-x86
Apple Macintosh (m68k or powerpc).

       Arnd
