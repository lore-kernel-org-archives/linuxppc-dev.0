Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Fri, 9 Feb 2001 16:19:31 -0500
From: =?ISO-8859-1?Q?S=E9bastien_C=F4t=E9?= <scote1@matrox.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Progress - new problem
Message-ID: <20010209161931.A30585@dyn-52-73.matrox.com>
References: <NDBBIBBPELJMGDCMPCLAIEMDCHAA.conor.ogorman@virtualaccess.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: <NDBBIBBPELJMGDCMPCLAIEMDCHAA.conor.ogorman@virtualaccess.com>; from conor.ogorman@virtualaccess.com on Fri, Feb 09, 2001 at 11:24:46 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I progressed quite a bit since my last e-mail... I put back KERNELBASE +
PAGE_OFFSET + KERNELLOAD to 0xc0000000 even though it complicates debugging
quite a bit.  Now, the kernel goes through create_elf_tables without a
problem.  The elf file (init) seems to have been loaded correctly.

Now, the problem.  When the kernel tries to jump to the first address of
the executable (0x10000074), I get an Instruction Access Exception and it
jumps to address 0x400.  I guess this should be ok and the the memory pages
should then be set up correctly.  However, these pages never seem to be set
correctly!  The kernel jumps back and forth between the executable
(0x10000074) and InstructionAccess (0x400), forever it seems.  Now I have
no idea what could be wrong!

Here is what my BATs point to (I didn't change the default configuration):
IBAT0 = 0
IBAT1 = 0
IBAT2 = C0000000 pointing to 0
IBAT3 = 0

DBAT0 = F0000000 pointing to F0000000
DBAT1 = 80000000 pointing to 80000000
DBAT2 = C0000000 pointing to 0
DBAT3 = 0

Board is similar to Sandpoint, processor is 7400 running in little-endian.
Btw, r3 hasn't been filled with PReP at boot, I didn't think it would
really matter (and since I got this far, I think it didn't).

Thanks!

Sébastien Côté

P.S.:  What do you guys use for debugging?  Is there any debugger out there
that does address translation (from MMU) to see what instruction gets
executed when you're at a virtual address?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
