Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7LYn4cnpzDqhN
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 01:14:53 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Alan Modra <amodra@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 linux-arch@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Nicolas Pitre <nico@linaro.org>, linux-kbuild@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/5] kbuild: allow archs to select build for link dead
 code/data elimination
Date: Mon, 08 Aug 2016 17:14:27 +0200
Message-ID: <1882847.dG563Vieov@wuerfel>
In-Reply-To: <20160807234947.GV20904@bubble.grove.modra.org>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
 <12986071.MeSB5hmlsH@wuerfel> <20160807234947.GV20904@bubble.grove.modra.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, August 8, 2016 9:19:47 AM CEST Alan Modra wrote:
> On Sun, Aug 07, 2016 at 10:26:19PM +0200, Arnd Bergmann wrote:
> > On Sunday, August 7, 2016 7:27:39 PM CEST Alan Modra wrote:
> > > 
> > > If it can, then Nicholas' patch should be:
> > > 
> > >         *(.text.hot .text.hot.*) *(.text.unlikely .text.unlikely.*) *(.text .text.*)
> > > 
> > > If you can't put .text.fixup too far away then you may as well just use
> > > 
> > >         *(.text .text.*)
> > 
> > I tried this version:
> > 
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index b1f8828e9eac..fc210dacac9a 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -438,7 +438,9 @@
> >   * during second ld run in second ld pass when generating System.map */
> >  #define TEXT_TEXT                                                    \
> >               ALIGN_FUNCTION();                                       \
> > -             *(.text.hot .text .text.fixup .text.unlikely .text.*)   \
> > +             *(.text.hot .text.hot.*)                                \
> > +             *(.text.unlikely .text.fixup .text.unlikely.*)          \
> > +             *(.text .text.*)                                        \
> >               *(.ref.text)                                            \
> >       MEM_KEEP(init.text)                                             \
> >       MEM_KEEP(exit.text)                                             \
> > 
> > but that failed to link an allyesconfig kernel because of references
> > from .fixup to .text.*. Trying your version now:
> 
> Well then, that proves you can't put .text.fixup too far aways from
> the associated input section.
> 
> > *(.text.hot .text.hot.*) *(.text.unlikely .text.unlikely.*) *(.text .text.*)
> 
> Which means this is guaranteed to fail when you test it properly using
> gcc's profiling options, in order to generate .text.hot* and/or
> .text.unlikely* sections.

I've investigated further and it seems that "*(.text.fixup) *(.text .text.*)"
fails just because we list .text.fixup twice. The .text.fixup section
was originally[1] introduced to work around the same link error that
it is causing now: if we use recursive linking, merging .text and .text.fixup
helps avoid the problems of sections that are >32MB before the final
link.

I have reverted that patch now, so ARM uses ".fixup" again like every
other architecture does, and now "*(.fixup) *(.text .text.*)" works
correctly, while ""*(.fixup) *(.text .fixup .text.*)" also fails
the same way that I saw before:

drivers/scsi/sg.o:(.fixup+0x4): relocation truncated to fit: R_ARM_THM_JUMP24 against `.text.sg_ioctl'
drivers/scsi/sg.o:(.fixup+0xc): relocation truncated to fit: R_ARM_THM_JUMP24 against `.text.sg_ioctl'
drivers/scsi/sg.o:(.fixup+0x14): relocation truncated to fit: R_ARM_THM_JUMP24 against `.text.sg_ioctl'
drivers/scsi/sg.o:(.fixup+0x1c): relocation truncated to fit: R_ARM_THM_JUMP24 against `.text.sg_ioctl'
drivers/scsi/sg.o:(.fixup+0x24): relocation truncated to fit: R_ARM_THM_JUMP24 against `.text.sg_ioctl'
drivers/scsi/sg.o:(.fixup+0x2c): relocation truncated to fit: R_ARM_THM_JUMP24 against `.text.sg_ioctl'
drivers/scsi/sg.o:(.fixup+0x34): relocation truncated to fit: R_ARM_THM_JUMP24 against `.text.sg_ioctl'
drivers/scsi/sg.o:(.fixup+0x3c): relocation truncated to fit: R_ARM_THM_JUMP24 against `.text.sg_ioctl'
drivers/scsi/sg.o:(.fixup+0x44): relocation truncated to fit: R_ARM_THM_JUMP24 against `.text.sg_ioctl'

I don't understand what led Andi Kleen to also move .text.hot and
.text.unlikely together with .text [2], but this may have
been a related issue.

> It seems to me the right thing to do would be to change kernel asm to
> generate .text.foo.fixup for any .text.foo section.  A gas feature
> available with binutils-2.26 enabled by --sectname-subst might help
> with implementing that.

I think this what Nico wanted to use anyway to eliminate more functions
from the output.

	Arnd


[1] http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8321
    http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8322

[2] https://lkml.org/lkml/2015/7/19/377
