Message-ID: <40E97EB5.2040008@fh-landshut.de>
Date: Mon, 05 Jul 2004 18:15:49 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
MIME-Version: 1.0
To: okorpil@fh-landshut.de
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: [more info - please help!] MPC7455 DMA buffer strangeness 
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I checked my Page Table Entries (PTEs) for the MPC7455 and MPC8240 after the
remap_page_range() took place.

Except for the RPN part (the physical address of the page) the PTEs match,
ending with the last 11 Bits (flags as in arch/ppc/mm/pgtable.h):

Kernel space: 0x581
User   space: 0x72D

(for user space this does mean - from least significant to most significant:
Page present: 	no,
Hashed PTE: 	yes,
User mode: 	yes,
Guarded: 	yes,
Coherent: 	no,
Inihibited: 	yes,
Write-Through:	no,
Changed:	no,
Referenced:	yes,
Exec:		yes,
Read-Write:	yes.)

This does look correct for my application. But it does yield different results
on the two processors, while both seem to definitely match the same physical
address (the 1st 21 bits do match in the Linux PTEs).

How are these Linux PTEs mapped to the MMU PTEs (64 bit wide descriptors)?

The "Programming Environments Manual For 32-Bit Implementations of the PowerPC
Architecture", the MPC603e and MPC7450 reference manuals depict a completely
different format, so how and where are these converted? (Hopefully not in
assembler! ;) )

I'm so confused by this! It doesn't seem logical that I cannot access those
buffers correctly!

Thanks in advance,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
