Subject: Large TLBs on 40x
From: Josh Boyer <jwboyer@charter.net>
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1091574342.2578.83.camel@c68.115.86.108.roc.mn.charter.com>
Mime-Version: 1.0
Date: Tue, 03 Aug 2004 18:05:42 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Howdy,

In 2.6, the PPC mm code for 4xx platforms uses large TLB entries for
most of RAM.  Specifically, I am looking at arch/ppc/mm/4xx_mmu.c at the
mmu_mapin_ram function.  In there, the pmd pointers are setup with
_PMD_SIZE_16M | _PAGE_HWEXEC | _PAGE_HWWRITE.

Doesn't this allow the text pages of the kernel to be written to?  So to
my understanding, a buggy driver that went off into the weeds could
corrupt the text pages of the kernel.

I would think that you would want the kernel text pages to be
non-writable so that if something like the above scenario happened you
don't have possibly bad text pages.  Debugging wouldn't be much fun.

I think I am missing something here.  If so, please excuse my lack of
knowledge on TLBs, but I am somewhat new to the low level stuff.  Anyone
care to point out what I am missing?

thx,
josh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
