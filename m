Date: Wed, 1 Mar 2000 14:07:11 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Gary Thomas <gdt@linuxppc.org>
cc: Paul Mackerras <paulus@linuxcare.com>, Cort Dougan <cort@fsmlabs.com>,
        Cort Dougan <cort@fsmlabs.com>,
        Linux/PPC Developer list <linuxppc-dev@lists.linuxppc.org>
Subject: RE: insw/outsw in ide.h
In-Reply-To: <XFMail.000301053713.gdt@linuxppc.org>
Message-ID: <Pine.LNX.4.05.10003011405210.30603-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 1 Mar 2000, Gary Thomas wrote:
> On 01-Mar-00 Paul Mackerras wrote:
> > Is there any PPC platform that needs to use a byte-swapping insw/outsw in
> > the IDE driver?  (I can't see why any platform would, but you never
> > know...)
> >
> > I have changed the insw/outsw/insl/outsl in include/asm-ppc/io.h to be the
> > non-swapping form (in my tree at least, I'll push it to bk soon).  I would
> > like to take out the special definitions of insw/outsw in
> > include/asm-ppc/ide.h and just let the ide driver use the standard
> > (non-swapping) form.  Will this cause a problem for any PPC platforms?
>
> I can't tell for sure, but won't this break existing [already installed]
> systems?  I agree that the data path really doesn't matter, but once it's
> on the media it probably does.
>
> Have you tested this change on a system with an IDE drive that has a
> live file system in place?

I know some people who formatted their disks on ia32 boxes and transferred them
to their CHRP boxes later, so the current code should work.

An easy way to find out is to try to mount a CD-ROM in an IDE CD-ROM drive. If
it works, endianness is OK.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
