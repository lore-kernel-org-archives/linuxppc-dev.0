From: Brad Boyer <flar@cegt201.bradley.edu>
Message-Id: <199906102103.QAA15072@cegt201.bradley.edu>
Subject: Re: EM86 port for LinuxPPC?
To: jpgarcia@execpc.com (Joseph Palani Garcia)
Date: Thu, 10 Jun 1999 16:03:00 -0500 (CDT)
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.GSO.3.95.990610130308.9290A-100000@earth> from "Joseph Palani Garcia" at Jun 10, 99 01:13:51 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Some may have noticed the EM86 x86 "emulator" for alpha/linux to run
> x86/linux binaries.  I recently added the define to my kernel compile and
> it compiled the binary support (the em86 program gets help from the
> kernel, so theres a kernel define in the alpha kernel config).  Anyway,
> I downloaded all the source from digital's site, and tried compiling it.
> It all compiled fine except for one thing, the thing i am doubious about.
> a source file that is only about 25 lines of assembly.  What i think it
> does is reroute the syscalls to the friend in the kernel.  It seems to me
> that because of this, it may be bound to the alpha architecure.  Is there
> a way to port this to ppc?  or is there just too many dissimilarities
> between alpha and ppc archs?  ( i haven't tried doing it yet because i
> don't know if its worth the time in learning alpha and ppc assm/arch just
> to get x86/linux bins to run... or im just lazy)

I looked into this earlier, and even started to work on it, but I went
on to something else before I got finished.  The major problems as I
saw them were that all the code for EM86 assumes a 64 bit
little-endian architecture, and it would be annoying to track down all
those assumptions and correct them.  That is doable, but time
consuming.  The other major headache is that the actual CPU emulation
used is the proprietary FX32 library from DEC.  We would have to write
our own x86 emulation library to replace it.  This isn't so much of a
problem, because there is already a basic x86 emulator in one of the
bootloaders, to be able to run BIOS code from PCI cards with x86 BIOS
chips on them.  I started looking at it, but then I went on to
something that was more interesting, and I felt was more useful.  I'd
be glad to share more detailed thoughts on this if anyone wants.

	Brad Boyer
	flar@cegt201.bradley.edu

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
