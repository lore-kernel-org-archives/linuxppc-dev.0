Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id BBC4B1A0BCD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 14:22:50 +1100 (AEDT)
Date: Tue, 3 Feb 2015 14:22:17 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: nvram and generic_nvram modules are problematic, was Re: [PATCH]
 arch: m68k: mac: misc.c: Remove some unused functions
In-Reply-To: <CAMuHMdXcV8nxCvhMDZ3WRrWKXxxjR6d8Uf8gp5w9NUTkyTNTjg@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1502031317130.28495@nippy.intranet>
References: <1420131732-31039-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <alpine.LNX.2.00.1501041045020.15927@nippy.intranet>
 <CAMuHMdXFu3n4d0dMZop186UF+QG=MtLHV=oQr+VszftpEA1kFQ@mail.gmail.com>
 <alpine.LNX.2.00.1502011230150.32582@nippy.intranet>
 <CAMuHMdXcV8nxCvhMDZ3WRrWKXxxjR6d8Uf8gp5w9NUTkyTNTjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sun, 1 Feb 2015, Geert Uytterhoeven wrote:

> On Sun, Feb 1, 2015 at 4:39 AM, Finn Thain wrote:
> > On Sun, 4 Jan 2015, Geert Uytterhoeven wrote:
> > > On Sun, Jan 4, 2015 at 8:21 AM, Finn Thain wrote:
> > > > On Thu, 1 Jan 2015, Rickard Strandqvist wrote:
> > > > > Removes some functions that are not used anywhere: 
> > > > > mac_pram_write() mac_pram_read()
> > > >
> > > > ... I'd rather not remove all of this code. Better to finish the 
> > > > implementation.
> > >
> > > Indeed.
> > >
> > > > Would it be acceptable to utilize drivers/char/generic_nvram.c and 
> > > > CONFIG_GENERIC_NVRAM? This is the PowerMac PRAM driver but looks 
> > > > generic enough that it may not need any modification for 68k Macs.
> > >
> > > Yes, that would be great.
> > >
> >
> > Unfortunately, it seems to be unworkable.
> 
> An alternative could be to just provide an nvram attribute file in 
> sysfs, like many RTC drivers do.
> 

Are attribute files seekable? Even if userspace could use "/dev/nvram" and 
"/sys/whatever/nvram" interchangably, wouldn't it be better if PPC Macs 
and 68k Macs offered a consistent API to userspace?

And your suggestion doesn't solve the problem, that is, to be able to 
build a multi-platform kernel binary in which drivers can access NVRAM.

The __nvram_read_byte(), nvram_read_byte() etc functions defined in 
drivers/char/nvram.c, if allowed to proliferate because random 
architectures might like to use a generic /dev/nvram API, would further 
uglify that file.

If the m68k Mac kernel doesn't define the nvram_read_byte() routine then 
valkyriefb can't use it. (fbdev drivers are apparently the reason why 
powerpc defines them.)

drivers/char/nvram.c has two sets of these routines for PC RTC NVRAM; one 
for m68k (Atari) and one for arm/x86. We don't want to introduce more code 
into drivers/char/nvram.c to support all four configurations:
1) arm/x86
2) atari
3) atari + mac
4) mac

So we'd end up having to move m68k-specific code out of 
drivers/char/nvram.c, to make it generic. And that then begs all of the 
questions in my previous message.

BTW, my experimental patches replaced all of those __nvram_* and nvram_* 
functions with an ops struct. E.g.

$ cat include/linux/nvram.h 
#ifndef _LINUX_NVRAM_H
#define _LINUX_NVRAM_H

#include <uapi/linux/nvram.h>

struct nvram_ops {
        ssize_t         (*read)(char *, size_t, loff_t *);
        ssize_t         (*write)(char *, size_t, loff_t *);
        unsigned char   (*read_byte)(int);
        void            (*write_byte)(unsigned char, int);
        ssize_t         (*get_size)(void);
#ifdef CONFIG_PPC
        void            (*sync)(void);
#else
        long            (*set_checksum)(void);
        long            (*initialize)(void);
#endif
};

extern const struct nvram_ops arch_nvram_ops;

extern const struct nvram_ops rtc_nvram_ops;

#endif  /* _LINUX_NVRAM_H */


This experiment has m68k implement arch_nvram_ops that dispatch to Atari 
or Mac methods (at compile-time for a single-platform kernel, or at 
run-time for a multi-platform kernel binary).

But this implies modifications to fbdev drivers, PPC32 and PPC64, nvram 
and generic_nvram modules. And any work at all done on generic_nvram seems 
to be misguided, unless it is removal.

-- 
