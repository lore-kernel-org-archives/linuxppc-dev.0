Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Subject: get_pteptr mystery
From: Hollis Blanchard <hollis@austin.ibm.com>
To: devel list <linuxppc-dev@lists.linuxppc.org>
Content-Type: text/plain
Date: 18 Dec 2002 18:06:23 -0600
Message-Id: <1040256384.30597.70.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I need to mark the first kernel code page writeable because I need to
write to 0xc00000fc. Can someone tell me why the following code fails?
get_pteptr returns 0.

	addr = 0xc00000fc;
	if (0 != get_pteptr(&init_mm, addr, &ptep)) {
		/* mark it writable */
		*ptep = pte_mkwrite(*ptep);
		/* flush this page from hw TLB */
		flush_tlb_range(&init_mm, addr, addr+1);
	} else {
		printk(KERN_ERR "couldn't get PTE!\n");
	}

I've also tried using pgd_offset_k/pmd_offset/pte_offset by hand, but it
seems that the first time any error checking is done is in pte_offset,
and that fails. Specifically
	pmd_offset(pgd_offset_k(0xc00000fc)) = c0158000
but
	((pmd *)c0158000)->pmd = 0

My code runs at init time, after mm initialization but before init. Does
that mean I can't use init_mm...?

All I want is the pte pointer for 0xc00000fc. Advice welcome. :)

-Hollis
--
PowerPC Linux
IBM Linux Technology Center


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
