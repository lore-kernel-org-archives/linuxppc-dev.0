Return-Path: <mlei30@yahoo.com>
Received: from web61023.mail.yahoo.com (web61023.mail.yahoo.com
	[209.73.179.17]) by ozlabs.org (Postfix) with SMTP id 5DE1F67A79
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jul 2005 06:17:03 +1000 (EST)
Message-ID: <20050713201022.69351.qmail@web61023.mail.yahoo.com>
Date: Wed, 13 Jul 2005 13:10:21 -0700 (PDT)
From: ming lei <mlei30@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: double kernel page table entry for the same physical page?!
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


1. In PPC MMU_init sets up kernel page table for all
the physical pages available(say size is A) to the
virt address starting from PAGE_OFFSET to
(PAGE_OFFSET+A).

Question: does the linux ever touch this section of
page table(virt address from PAGE_OFFSET to
PAGE_OFFSET+A) again? like remove or modify one of the
entry?

2. In VMALLOC, say we have virt address
B(B>PAGE_OFFSET+A), sets up the page table entry for
this B to any one of the physical pages.

Question: For every physical page, it should already
be mapped in #1, but vmalloc maps it again to a virt
address higher. Does it mean in kernel page table, we
may have two PTE entries pointing to the same physical
page, even their virt addresses are different?

Last question:
If this is true, is this platform implemention
specific? Does i386 implemention have same situation?

Thanks,
Ming



		
____________________________________________________
Start your day with Yahoo! - make it your home page
http://www.yahoo.com/r/hs
 
