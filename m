Date: Wed, 15 Dec 1999 17:54:09 -0600
From: Grant Erickson <grant@lcse.umn.edu>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Linux Page Table vs. uP TLB and I/O
Message-ID: <Pine.SGI.4.10.9912151744470.56730-100000@brule.borg.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At present, I'm working on adding in Ethernet support (chips sits at
0xF4000000) and serial console (chips sitting at 0x40000000 and
0x7E000000) support to the 4xx-family port and I've come up with a few
questions:

  1. A page fault is going to occur at some point in time. An entry needs
     to be made in both the Linux page table and in the hardware page
     table.

     What is the interface for translating between a Linux-style PTE and a
     6xx-TLB entry or a 8xx-TLB entry? Or, is this somewhat ad hoc at
     present?

  2. Is there a standard interface for "mapping in" an IO address before
     probing it, such as in the Ethernet driver above. In the TiVo port,
     they hardwire a TLB entry for this in init_MMU, but this seems like a
     bit of a hack.

     Is the right thing to do just let the page fault happen and then
     handle it there for the first access?

  3. How about the mapping that covers the kernel? For performance
     reasons, I can see whay I always want that entry in the TLB; however,
     were it to be flushed, it seems like it should be
     backed by the Linux-style page table. When does the kernel make such
     an entry in the Linux-style table?

Any insight would be much appreciated.

Thanks,

Grant


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
