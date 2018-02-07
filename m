Return-Path: <alexandre.belloni@free-electrons.com>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zc5LD0gcYzF14f
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Feb 2018 02:47:15 +1100 (AEDT)
Date: Wed, 7 Feb 2018 16:47:00 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] char: nvram: disable on ARM
Message-ID: <20180207154700.GY3404@piout.net>
References: <20180206220534.9929-1-alexandre.belloni@bootlin.com>
 <CAK8P3a0Wmh6acO7W=weX37B2GNbecJQzPhZdVZcXXAwfT6jZ5A@mail.gmail.com>
 <20180207015509.GV3404@piout.net>
 <CAK8P3a3dkAESaqGgLAV9uKKet20rVtBXqBJ-eNGbwQv1i05K7A@mail.gmail.com>
 <20180207124839.GX3404@piout.net>
 <CAK8P3a2HscUSs-iV_3dp7+htN+LPFK2LnmiZNTKamQZwMSVxMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAK8P3a2HscUSs-iV_3dp7+htN+LPFK2LnmiZNTKamQZwMSVxMA@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/02/2018 at 15:00:04 +0100, Arnd Bergmann wrote:
> On Wed, Feb 7, 2018 at 1:48 PM, Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> > On 07/02/2018 at 11:33:55 +0100, Arnd Bergmann wrote:
> >> On Wed, Feb 7, 2018 at 2:55 AM, Alexandre Belloni
> 
> >> >> $ cat /proc/driver/nvram
> >> >> Checksum status: valid
> >> >> # floppies     : 0
> >> >> Floppy 0 type  : none
> >> >> Floppy 1 type  : none
> >> >> HD 0 type      : none
> >> >> HD 1 type      : none
> >> >> HD type 48 data: 0/0/0 C/H/S, precomp 0, lz 0
> >> >> HD type 49 data: 156/0/0 C/H/S, precomp 0, lz 0
> >> >> DOS base memory: 635 kB
> >> >> Extended memory: 65535 kB (configured), 65535 kB (tested)
> >> >> Gfx adapter    : EGA, VGA, ... (with BIOS)
> >> >> FPU            : not installed
> >> >>
> >> >
> >> > I really don't think anyone is using that but I don't really know much
> >> > about x86 and the specification this may be part of.
> >> >
> >> > I see the info may be used in drivers/video/fbdev/ and
> >> > drivers/platform/x86/thinkpad_acpi.c
> >>
> >> The thinkpad_acpi driver seems to look at some other bytes
> >> in the nvram, which have a platform specific meaning.
> >>
> >
> > Yeah, I was more concerned that they need drivers/char/nvram.c for
> > nvram_read_byte so we can't simply remove the driver.
> 
> Ok, so the procfs interface may be obsolete, but we still need an
> interface into the CMOS NVRAM data.
> 

Actually, I just found
https://unix.stackexchange.com/questions/331419/is-dev-nvram-dangerous-to-write-to

So it seems to have real values for some people (even if they are
wrong).

That also points to https://sourceforge.net/projects/nvram-wakeup/ but I
don't think it is necessary. The RTC driver should be able to wakeup an
x86 platform.

All the other uses of /dev/nvram I could find with a simple google
search (i.e. saving and restoring CMOS settings) could just use
/sys/class/rtc/rtc0/device/nvram

> I see that the x86 version of nvram_read_byte is just a wrapper
> around CMOS_READ(14 + addr). We also have some drivers
> that call the low-level function directly:
> 
> arch/x86/include/asm/floppy.h:  val = CMOS_READ(0x10) & 15;
> arch/x86/kernel/bootflag.c:     v = CMOS_READ(sbf_port);
> drivers/char/mwave/smapi.c:     usSmapiID = CMOS_READ(0x7C);
> drivers/input/misc/wistron_btns.c:              qlen = CMOS_READ(cmos_address);
> 
> I suppose we could make the thinkpad driver do the same,
> or provide a 'static inline' version of nvram_read_byte somewhere.
> 

I guess we can do that, provided we take rtc_lock before using
CMOS_READ.

Thinking of it, I think this means we don't need the lock for powerpc as
nvram_read_byte doesn't take it. So I guess it is only needed on x86.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
