Message-ID: <BE1C564723B3D21191FD0000F840E39801D81514@rfcmx2.rfc.comm.harris.com>
From: "Brown, David (dbrown03)" <DBrown03@harris.com>
To: "'duncanp@research.canon.com.au'" <duncanp@research.canon.com.au>,
        Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: flash drivers 
Date: Wed, 10 May 2000 09:41:50 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm planning to use drivers/char/amd_flash.c myself, as a flat stream
"file".

The ftp://ftp.denx.de/pub/LinuxPPC/usr/src/CDK.tar.gz sources also include a
flash translation layer (ftl.c) so flash can be used as a read/write
filesystem.  I won't be using that though, since I noticed a patent
reference in drivers/block/ftl.c, which an exemption for PCMCIA drivers.  In
linuxppc we're usually talking about on-board flash, so be careful.  I'd
guess that such encumbered code won't make the standard kernel.

It would be nice if we could have something like drivers/block/ftl.c without
using patented methods.  If that's not possible, the next best thing would
be a specific exemption for use on the linuxppc kernels, even if flash is
on-board instead of PCMCIA.




> -----Original Message-----
> From: duncanp@research.canon.com.au
> [mailto:duncanp@research.canon.com.au]
> Sent: Tuesday, May 09, 2000 11:04 PM
> To: Wolfgang Denk
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: flash drivers
>
>
>
> Hi Wolfgang,
>
> Thanks for this driver - its exactly what I was looking for.
>
> The code did not work as-is for my configuration - i'm using
> a 1x16 bit
> flash device (AM29LV160B). So, i've made some small changes, and
> attached patches to amd_flash.c and flash.h. Pretty much all of the
> changes i've made relate to addressing on a 16 bit wide interface
> rather than the 32 bit wide interface you had already tested with, but
> there are some others:
>
> I don't think cfi_read_short() and cfi_read_char() were dealing with
> endianess properly - they just happened to work correctly
> with your 4x8
> bit configuration, but would be broken for anything else - i think the
> changes i've put in fix that.
>
> I've removed cfi_read_int() because it was only used to read the Erase
> Block Region Information, which is broken into 2 16 bit fields anyway.
>
> I also have an Embedded Planet board with 4x8 bit flash devices
> (AM29LV160B) which I haven't tested this stuff with yet - I
> hope to get
> around to that in the next few days, but I'm leaving work next week to
> go travelling (6 months worth of holidaying in asia, then i'm
> heading to
> ireland to work), so I might run out of time, which is why
> I've sent you
> these patches now.
>
> Please let me know what you think.
>
> Dunk.
>
>
>
> On 26 Apr, Wolfgang Denk wrote:
> >
> > In message
> <20000426082939.EC8373C960@elph.research.canon.com.au> you wrote:
> >>
> >> I'm about to go and write some software to allow us to
> program on-board
> >> flash devices. I'm planing on putting all of the code in a kernel
> >> driver - i've seen some flash drivers which put some code in the
> >> kernel, and other code (to write the flash - I gather the
> algorithms
> >> vary a fair bit between deivices) in user space.
> >
> > For CFI conformant FLASH devices you can use (or  easily
> adapt)  the
> > FLASH  driver  that is included with my port of Linux for
> the TQM8xxL
> > board; get
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/CDK.tar.gz and have
> a look at the files  CDK/patches/linux-2.2.13/FLASH.patch  and  maybe
> CDK/patches/linux-2.2.13/FTL.patch
>
>> So, before I go and do this, has anyone already done something similar
>> they would be happy to share with me?
>
> While I was trying to make this as portable as possible, I only could
> test it in a configuration with two banks of 16 bit FLASH memory. You
> may have to make minor adjustemnts for other configurations.
>
> Feedback appreciated.
>
>> I'd like to write this so it can be dropped into the standard kernels
>> and adapted to new 8xx based boards without much effort, so if anybody
>> has any comments they'd like to make, please lemme know.
>
> If my version of the drivers proves helpful, I'd  like  to  integrate
> whatever changes needed to make it work on other hardware as well.
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> Roses are red
> Violets are blue
> Some poems rhyme
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
