Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0185.outbound.protection.outlook.com [207.46.163.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6FBC7140B00
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 10:47:09 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/fsl-booke64: Set vmemmap_psize to 4K
Date: Mon, 5 May 2014 19:46:55 -0500
Message-ID: <1399337215-15086-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The only way Freescale booke chips support mappings larger than 4K
is via TLB1.  The only way we support (direct) TLB1 entries is via
hugetlb, which is not what map_kernel_page() does when given a large
page size.

Without this, a kernel with CONFIG_SPARSEMEM_VMEMMAP enabled crashes on
boot with messages such as:

PID hash table entries: 4096 (order: 3, 32768 bytes)
Sorting __ex_table...
BUG: Bad page state in process swapper  pfn:00a2f
page:8000040000023a48 count:0 mapcount:0 mapping:0000040000ffce48 index:0x40000ffbe50
page flags: 0x40000ffda40(active|arch_1|private|private_2|head|tail|swapcache|mappedtodisk|reclaim|swapbacked|unevictable|mlocked)
page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
bad because of flags:
page flags: 0x311840(active|private|private_2|swapcache|unevictable|mlocked)
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 3.15.0-rc1-00003-g7fa250c #299
Call Trace:
[c00000000098ba20] [c000000000008b3c] .show_stack+0x7c/0x1cc (unreliable)
[c00000000098baf0] [c00000000060aa50] .dump_stack+0x88/0xb4
[c00000000098bb70] [c0000000000c0468] .bad_page+0x144/0x1a0
[c00000000098bc10] [c0000000000c0628] .free_pages_prepare+0x164/0x17c
[c00000000098bcc0] [c0000000000c24cc] .free_hot_cold_page+0x48/0x214
[c00000000098bd60] [c00000000086c318] .free_all_bootmem+0x1fc/0x354
[c00000000098be70] [c00000000085da84] .mem_init+0xac/0xdc
[c00000000098bef0] [c0000000008547b0] .start_kernel+0x21c/0x4d4
[c00000000098bf90] [c000000000000448] .start_here_common+0x20/0x58

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/mm/tlb_nohash.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index ae3d5b7..92cb18d 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -596,8 +596,13 @@ static void __early_init_mmu(int boot_cpu)
 	/* XXX This should be decided at runtime based on supported
 	 * page sizes in the TLB, but for now let's assume 16M is
 	 * always there and a good fit (which it probably is)
+	 *
+	 * Freescale booke only supports 4K pages in TLB0, so use that.
 	 */
-	mmu_vmemmap_psize = MMU_PAGE_16M;
+	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E))
+		mmu_vmemmap_psize = MMU_PAGE_4K;
+	else
+		mmu_vmemmap_psize = MMU_PAGE_16M;
 
 	/* XXX This code only checks for TLB 0 capabilities and doesn't
 	 *     check what page size combos are supported by the HW. It
-- 
1.9.1
