Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <E0A487F3EEFFD111A3C5004033933F9ABBF677@POSTOFFICE>
From: Derrik Weeks <derrikW@iotech.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Request for hanging Init explanation
Date: Tue, 5 Feb 2002 13:39:11 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


System: MPC855T, 16M sdram, 1M flash.
MontaVista HardHat Linux 2.2.14

There are several references on this mailing list to kernels hanging on the
invocation of the INIT routine, which becomes pid 1, and controls user
space.  I'm porting Linux from an Embedded Planet CLLF board to our
proprietary hardware, and I've just had the same issue, and the resolution
was, per this mail list, to move the IMMR location above the kernel address
of C0000000.  I've moved my IMMR from 10000000 to FA200000 and everything
now works as advertised, the question is why???  There is a don't move the
IMMR message in the kernel source for the CLLF, but this appeared to be more
related to the fact that the CLLF board has memory mapped control registers
that are decoded off the IMMR + offset rather than a kernel need.   A single
comment stating the kernel needs the IMMR to be mapped above it's virtual
address would have saved me a great deal of pain.

With my previous memory map, there were no memory conflicts, even when the
kernel translated from physical 0 to virtual C0000000, there was no conflict
with the IMMR space, unless the memory manager itself virtually mapped the
IMMR to an unusable space.  In which case why would having a high memory
location make any difference.  This has caused me several weeks of pain, and
I would truly love to know the reason for this requirement.  I tried to
follow the applicable links in the mail thread, but they weren't intact any
more, and the references to the Documentation directory were not in my
distribution.  Any light that you can shed on this would be greatly
appreciated.

Also, is "any" memory mapped application subject to the same constraint of
needing to be above the kernel?

Thanks,
D. Weeks
Digital hardware Architect
IOtech, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
