Return-Path: <alexandre.belloni@free-electrons.com>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zc9KP32tGzF164
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Feb 2018 05:46:48 +1100 (AEDT)
Date: Wed, 7 Feb 2018 19:46:43 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] char: nvram: disable on ARM
Message-ID: <20180207184643.GA3404@piout.net>
References: <20180206220534.9929-1-alexandre.belloni@bootlin.com>
 <CAK8P3a0Wmh6acO7W=weX37B2GNbecJQzPhZdVZcXXAwfT6jZ5A@mail.gmail.com>
 <20180207015509.GV3404@piout.net>
 <CAK8P3a3dkAESaqGgLAV9uKKet20rVtBXqBJ-eNGbwQv1i05K7A@mail.gmail.com>
 <20180207124839.GX3404@piout.net>
 <CAK8P3a2HscUSs-iV_3dp7+htN+LPFK2LnmiZNTKamQZwMSVxMA@mail.gmail.com>
 <20180207154700.GY3404@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180207154700.GY3404@piout.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/02/2018 at 16:47:00 +0100, Alexandre Belloni wrote:
> > >> > I really don't think anyone is using that but I don't really know much
> > >> > about x86 and the specification this may be part of.
> > >> >
> > >> > I see the info may be used in drivers/video/fbdev/ and
> > >> > drivers/platform/x86/thinkpad_acpi.c
> > >>
> > >> The thinkpad_acpi driver seems to look at some other bytes
> > >> in the nvram, which have a platform specific meaning.
> > >>
> > >
> > > Yeah, I was more concerned that they need drivers/char/nvram.c for
> > > nvram_read_byte so we can't simply remove the driver.
> > 
> > Ok, so the procfs interface may be obsolete, but we still need an
> > interface into the CMOS NVRAM data.
> > 
> 
> Actually, I just found
> https://unix.stackexchange.com/questions/331419/is-dev-nvram-dangerous-to-write-to
> 
> So it seems to have real values for some people (even if they are
> wrong).
> 
> That also points to https://sourceforge.net/projects/nvram-wakeup/ but I
> don't think it is necessary. The RTC driver should be able to wakeup an
> x86 platform.
> 
> All the other uses of /dev/nvram I could find with a simple google
> search (i.e. saving and restoring CMOS settings) could just use
> /sys/class/rtc/rtc0/device/nvram
> 

Ok, the chromeos guys are using it for verified boot it seems:
https://chromium.googlesource.com/chromiumos/platform/vboot_reference

I'm wondering whether they really care about the checksum though.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
