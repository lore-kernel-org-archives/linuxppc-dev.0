Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from pophost.sonytel.be (vervifontaine.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 09018B70B3
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Sep 2009 19:53:18 +1000 (EST)
Date: Tue, 22 Sep 2009 11:53:27 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [LTP] mmapstress03 weirdness? (fwd)
In-Reply-To: <1253578781.7103.186.camel@pasglop>
Message-ID: <alpine.LRH.2.00.0909221151550.328@vixen.sonytel.be>
References: <alpine.LRH.2.00.0909211539520.16077@vixen.sonytel.be>
	<1253578781.7103.186.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linux Test Project <Ltp-list@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 22 Sep 2009, Benjamin Herrenschmidt wrote:
> On Mon, 2009-09-21 at 15:40 +0200, Geert Uytterhoeven wrote:
> > With 32-bit userland, this boils down to:
> > | mmap addr 0x7fff0000 size 0x7fff0000
> > | mmap returned 0x7fff0000
> > 
> > i.e. mmap() succeeds, but (1) the test expects it to fail, so the test returns
> > TFAIL, but (2) ltp-pan still reports that the tests passed?
> 
> What is the output of /proc/<pid>/maps after that mmap ?

| 00100000-00120000 r-xp 00100000 00:00 0                                  [vdso]
| 0f470000-0f5d0000 r-xp 00000000 03:03 56852565                           /lib/libc-2.5.so
| 0f5d0000-0f5e0000 r--p 00160000 03:03 56852565                           /lib/libc-2.5.so
| 0f5e0000-0f5f0000 rw-p 00170000 03:03 56852565                           /lib/libc-2.5.so
| 0ffc0000-0ffe0000 r-xp 00000000 03:03 56852482                           /lib/ld-2.5.so
| 0ffe0000-0fff0000 r--p 00010000 03:03 56852482                           /lib/ld-2.5.so
| 0fff0000-10000000 rw-p 00020000 03:03 56852482                           /lib/ld-2.5.so
| 10000000-10010000 r-xp 00000000 03:03 65571126                           /tmp/a.out
| 10010000-10020000 rw-p 00000000 03:03 65571126                           /tmp/a.out
| 7fff0000-fffe0000 rw-s 00000000 00:09 5580806                            /dev/zero (deleted)

I.e. the big mmap() took out the stack mapping, which was previously at:

| ffa00000-ffb50000 rw-p ffa00000 00:00 0                                  [stack]

> With a 64-bit kernel, 32-bit userspace has access to the entire 4G
> address space, so mapping 2G-64k at the 2G-64k point can work, provided
> you aren't overlapping an existing mapping such as the stack.
> 
> > In addition, sometimes mmapstress03 fails due to SEGV. I created a small test
> > program that just does the above mmap(), and depending on the distro and what
> > else I print later it crashes with a SEGV, too. Probably this happens because
> > the mmap() did succeed, and corrupted some existing mappings, cfr. the notes
> > for MAP_FIXED:
> 
> That's possible.
> 
> >        MAP_FIXED
> >               Don’t  interpret  addr  as  a hint: place the mapping at exactly
> >               that address.  addr must be a multiple of the page size.  If the
> >               memory  region  specified  by addr and len overlaps pages of any
> >               existing mapping(s), then the overlapped part  of  the  existing
> >               mapping(s)  will  be discarded.  If the specified address cannot
> >               be used, mmap() will fail.  Because requiring  a  fixed  address
> >               for  a  mapping is less portable, the use of this option is dis‐
> >               couraged.
> 
> Yeah, I suppose the test might be wiping out its own stack for example

Indeed.

> IE. I think that test is just bogus :-)
> 
> > JFYI, with 64-bit userland, this boils down to:
> > 
> > | mmap addr 0x7fffffffffff0000 size 0x7fffffffffff0000
> > | mmap returned 0xffffffffffffffff
> > 
> > i.e. mmap() fails as expected, and the test succeeds.
> 
> Right because on 64-bit userspace, you only are allowed something like
> 16T of address space.
> 
> > Does all of this sound OK?
> > Thanks for your comments!
> 
> Yes, I think so far, it's just bogus tests :-)

Thanks for the confirmation, Segher and Ben!

With kind regards,

Geert Uytterhoeven
Software Architect
Techsoft Centre

Technology and Software Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
