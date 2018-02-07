Return-Path: <alexandre.belloni@free-electrons.com>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zc1NH3vdlzF0Qq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Feb 2018 23:48:45 +1100 (AEDT)
Date: Wed, 7 Feb 2018 13:48:39 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] char: nvram: disable on ARM
Message-ID: <20180207124839.GX3404@piout.net>
References: <20180206220534.9929-1-alexandre.belloni@bootlin.com>
 <CAK8P3a0Wmh6acO7W=weX37B2GNbecJQzPhZdVZcXXAwfT6jZ5A@mail.gmail.com>
 <20180207015509.GV3404@piout.net>
 <CAK8P3a3dkAESaqGgLAV9uKKet20rVtBXqBJ-eNGbwQv1i05K7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAK8P3a3dkAESaqGgLAV9uKKet20rVtBXqBJ-eNGbwQv1i05K7A@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/02/2018 at 11:33:55 +0100, Arnd Bergmann wrote:
> On Wed, Feb 7, 2018 at 2:55 AM, Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> > On 06/02/2018 at 23:55:02 +0100, Arnd Bergmann wrote:
> >> * arch/arm/kernel/time.c has this code
> >>
> >> #if defined(CONFIG_RTC_DRV_CMOS) || defined(CONFIG_RTC_DRV_CMOS_MODULE) || \
> >>     defined(CONFIG_NVRAM) || defined(CONFIG_NVRAM_MODULE)
> >> /* this needs a better home */
> >> DEFINE_SPINLOCK(rtc_lock);
> >> EXPORT_SYMBOL(rtc_lock);
> >> #endif  /* pc-style 'CMOS' RTC support */
> >>
> >> That can be adapted now, or maybe we could move all definitions into
> >> a common place (that needs some more planning).
> >>
> >
> > Yes, on arm, the rtc_lock is mostly there to please
> > drivers/rtc/rtc-cmos.c. Maybe we could make the locking in this driver
> > x86 and PPC specific.
> >
> > If we can get rid of arch/powerpc/platforms/chrp/time.c and
> > arch/powerpc/platforms/maple/time.c (so much duplicated code), then it
> > is x86 only.
> 
> What about these:
> 
> arch/alpha/kernel/rtc.c:        spin_lock(&rtc_lock);
> arch/alpha/kernel/rtc.c:        spin_unlock(&rtc_lock);
> arch/alpha/kernel/time.c:DEFINE_SPINLOCK(rtc_lock);
> arch/alpha/kernel/time.c:EXPORT_SYMBOL(rtc_lock);
> arch/arm/kernel/time.c:DEFINE_SPINLOCK(rtc_lock);
> arch/arm/kernel/time.c:EXPORT_SYMBOL(rtc_lock);
> arch/m32r/kernel/time.c:DEFINE_SPINLOCK(rtc_lock);
> arch/m32r/kernel/time.c:EXPORT_SYMBOL(rtc_lock);
> arch/m68k/atari/time.c:DEFINE_SPINLOCK(rtc_lock);
> arch/m68k/atari/time.c:EXPORT_SYMBOL_GPL(rtc_lock);
> arch/mn10300/kernel/rtc.c:DEFINE_SPINLOCK(rtc_lock);
> arch/mn10300/kernel/rtc.c:EXPORT_SYMBOL(rtc_lock);
> arch/powerpc/kernel/time.c:DEFINE_SPINLOCK(rtc_lock);
> arch/powerpc/kernel/time.c:EXPORT_SYMBOL_GPL(rtc_lock);
> arch/sparc/kernel/time_32.c:DEFINE_SPINLOCK(rtc_lock);
> arch/sparc/kernel/time_32.c:EXPORT_SYMBOL(rtc_lock);
> arch/sparc/kernel/time_64.c:DEFINE_SPINLOCK(rtc_lock);
> 
> Are they all obsolete?
> 

Yes and no. For those architecture, the spinlock is only used to make
the driver compile. It is probably not actually needed or at least it
can be made local to the driver.

For alpha, I just realized I never sent a patch removing the spinlock
usage, I'll do that this cycle:
https://github.com/alexandrebelloni/linux/commit/e79e2a754a3a67f2d7e906bfda0042f9dcf66a0b

> >> $ cat /proc/driver/nvram
> >> Checksum status: valid
> >> # floppies     : 0
> >> Floppy 0 type  : none
> >> Floppy 1 type  : none
> >> HD 0 type      : none
> >> HD 1 type      : none
> >> HD type 48 data: 0/0/0 C/H/S, precomp 0, lz 0
> >> HD type 49 data: 156/0/0 C/H/S, precomp 0, lz 0
> >> DOS base memory: 635 kB
> >> Extended memory: 65535 kB (configured), 65535 kB (tested)
> >> Gfx adapter    : EGA, VGA, ... (with BIOS)
> >> FPU            : not installed
> >>
> >
> > I really don't think anyone is using that but I don't really know much
> > about x86 and the specification this may be part of.
> >
> > I see the info may be used in drivers/video/fbdev/ and
> > drivers/platform/x86/thinkpad_acpi.c
> 
> The thinkpad_acpi driver seems to look at some other bytes
> in the nvram, which have a platform specific meaning.
> 

Yeah, I was more concerned that they need drivers/char/nvram.c for
nvram_read_byte so we can't simply remove the driver.

> For drivers/video/fbdev/, these appear to all be for pre-x86
> Apple Macintosh (m68k or powerpc).
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
