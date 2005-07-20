Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D3ED367CB5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Jul 2005 04:10:03 +1000 (EST)
Date: Wed, 20 Jul 2005 03:29:00 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Anton =?iso-8859-1?Q?W=F6llert?= <a.woellert@gmail.com>,
	linuxppc-embedded@ozlabs.org
Message-ID: <20050720062859.GA8477@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [PATCH] 8xx: avoid icbi misbehaviour in __flush_dcache_icache_phys
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Anton,

Can you please test the following which is equivalent to your=20
suggest changes, the only difference being the location, contained=20
inside flush_dcache_icache_page(). After confirmation that it works
we can send up to the kernel maintainers.

We should still try to understand why this is happening, possibly=20
matching it to a published CPU errata bug, or inform Freescale
otherwise.

I've written that entry down in the 8xx TODO list.

Thanks!

-------------

On 8xx, in the case where a pagefault happens for a process who's not
the owner of the vma in question (ptrace for instance), the flush=20
operation is performed via the physical address.

Unfortunately, that results in a strange, unexplainable "icbi"=20
instruction fault, most likely due to a CPU bug (see oops below).

Avoid that by flushing the page via its kernel virtual address.=20

Oops: kernel access of bad area, sig: 11 [#2]
NIP: C000543C LR: C000B060 SP: C0F35DF0 REGS: c0f35d40 TRAP: 0300 Not tai=
nted
MSR: 00009022 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 10
DAR: 00000010, DSISR: C2000000
TASK =3D c0ea8430[761] 'gdbserver' THREAD: c0f34000
Last syscall: 26
GPR00: 00009022 C0F35DF0 C0EA8430 00F59000 00000100 FFFFFFFF 00F58000
00000001
GPR08: C021DAEF C0270000 00009032 C0270000 22044024 10025428 01000800
00000001
GPR16: 007FFF3F 00000001 00000000 7FBC6AC0 00F61022 00000001 C0839300
C01E0000
GPR24: 00CD0889 C082F568 3000AC18 C02A7A00 C0EA15C8 00F588A9 C02ACB00
C02ACB00
NIP [c000543c] __flush_dcache_icache_phys+0x38/0x54
LR [c000b060] flush_dcache_icache_page+0x20/0x30
Call trace:
[c000b154] update_mmu_cache+0x7c/0xa4
[c005ae98] do_wp_page+0x460/0x5ec
[c005c8a0] handle_mm_fault+0x7cc/0x91c
[c005ccec] get_user_pages+0x2fc/0x65c
[c0027104] access_process_vm+0x9c/0x1d4
[c00076e0] sys_ptrace+0x240/0x4a4
[c0002bd0] ret_from_syscall+0x0/0x44

From: Anton W=F6llert <a.woellert@gmail.com>=20
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

--- a/arch/ppc/mm/init.c.orig	2005-07-20 03:05:44.000000000 -0300
+++ b/arch/ppc/mm/init.c	2005-07-20 03:05:46.000000000 -0300
@@ -577,6 +577,9 @@
 #ifdef CONFIG_BOOKE
 	__flush_dcache_icache(kmap(page));
 	kunmap(page);
+#elif CONFIG_8xx
+	/* On 8xx there is no need to kmap since highmem is not supported */
+	__flush_dcache_icache(page_address(page));=20
 #else
 	__flush_dcache_icache_phys(page_to_pfn(page) << PAGE_SHIFT);
 #endif
