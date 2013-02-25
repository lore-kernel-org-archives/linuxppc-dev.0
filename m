Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CD6F32C02A9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2013 20:29:48 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 25 Feb 2013 14:57:45 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C795D1258054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2013 15:00:29 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1P9Tapc27787430
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2013 14:59:36 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1P9TcKW021877
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2013 20:29:38 +1100
Message-ID: <1361784575.3001.5.camel@ThinkPad-T5421.cn.ibm.com>
Subject: [RFC PATCH powerpc] try secondary hash before BUG in
 kernel_map_linear_page()
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 25 Feb 2013 17:29:35 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch tries to fix following issue when CONFIG_DEBUG_PAGEALLOC
is enabled:

[  543.075675] ------------[ cut here ]------------
[  543.075701] kernel BUG at arch/powerpc/mm/hash_utils_64.c:1239!
[  543.075714] Oops: Exception in kernel mode, sig: 5 [#1]
[  543.075722] PREEMPT SMP NR_CPUS=16 DEBUG_PAGEALLOC NUMA pSeries
[  543.075741] Modules linked in: binfmt_misc ehea
[  543.075759] NIP: c000000000036eb0 LR: c000000000036ea4 CTR: c00000000005a594
[  543.075771] REGS: c0000000a90832c0 TRAP: 0700   Not tainted  (3.8.0-next-20130222)
[  543.075781] MSR: 8000000000029032 <SF,EE,ME,IR,DR,RI>  CR: 22224482  XER: 00000000
[  543.075816] SOFTE: 0
[  543.075823] CFAR: c00000000004c200
[  543.075830] TASK = c0000000e506b750[23934] 'cc1' THREAD: c0000000a9080000 CPU: 1
GPR00: 0000000000000001 c0000000a9083540 c000000000c600a8 ffffffffffffffff
GPR04: 0000000000000050 fffffffffffffffa c0000000a90834e0 00000000004ff594
GPR08: 0000000000000001 0000000000000000 000000009592d4d8 c000000000c86854
GPR12: 0000000000000002 c000000006ead300 0000000000a51000 0000000000000001
GPR16: f000000003354380 ffffffffffffffff ffffffffffffff80 0000000000000000
GPR20: 0000000000000001 c000000000c600a8 0000000000000001 0000000000000001
GPR24: 0000000003354380 c000000000000000 0000000000000000 c000000000b65950
GPR28: 0000002000000000 00000000000cd50e 0000000000bf50d9 c000000000c7c230
[  543.076005] NIP [c000000000036eb0] .kernel_map_pages+0x1e0/0x3f8
[  543.076016] LR [c000000000036ea4] .kernel_map_pages+0x1d4/0x3f8
[  543.076025] Call Trace:
[  543.076033] [c0000000a9083540] [c000000000036ea4] .kernel_map_pages+0x1d4/0x3f8 (unreliable)
[  543.076053] [c0000000a9083640] [c000000000167638] .get_page_from_freelist+0x6cc/0x8dc
[  543.076067] [c0000000a9083800] [c000000000167a48] .__alloc_pages_nodemask+0x200/0x96c
[  543.076082] [c0000000a90839c0] [c0000000001ade44] .alloc_pages_vma+0x160/0x1e4
[  543.076098] [c0000000a9083a80] [c00000000018ce04] .handle_pte_fault+0x1b0/0x7e8
[  543.076113] [c0000000a9083b50] [c00000000018d5a8] .handle_mm_fault+0x16c/0x1a0
[  543.076129] [c0000000a9083c00] [c0000000007bf1dc] .do_page_fault+0x4d0/0x7a4
[  543.076144] [c0000000a9083e30] [c0000000000090e8] handle_page_fault+0x10/0x30
[  543.076155] Instruction dump:
[  543.076163] 7c630038 78631d88 e80a0000 f8410028 7c0903a6 e91f01de e96a0010 e84a0008
[  543.076192] 4e800421 e8410028 7c7107b4 7a200fe0 <0b000000> 7f63db78 48785781 60000000
[  543.076224] ---[ end trace bd5807e8d6ae186b ]---

The code is borrowed from that in __hash_page_huge().

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_utils_64.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 1b6e127..31c7924 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1231,11 +1231,28 @@ static void kernel_map_linear_page(unsigned long vaddr, unsigned long lmi)
 	int ret;
 
 	hash = hpt_hash(vpn, PAGE_SHIFT, mmu_kernel_ssize);
+
+repeat:
 	hpteg = ((hash & htab_hash_mask) * HPTES_PER_GROUP);
 
 	ret = ppc_md.hpte_insert(hpteg, vpn, __pa(vaddr),
 				 mode, HPTE_V_BOLTED,
 				 mmu_linear_psize, mmu_kernel_ssize);
+
+	if (unlikely(ret == -1)) {
+		hpteg = (~hash & htab_hash_mask) * HPTES_PER_GROUP;
+		ret = ppc_md.hpte_insert(hpteg, vpn, __pa(vaddr), mode,
+					 HPTE_V_SECONDARY,
+					 mmu_linear_psize, mmu_kernel_ssize);
+		if (ret == -1) {
+			if (mftb() & 0x1)
+				hpteg = (hash & htab_hash_mask) *
+					 HPTES_PER_GROUP;
+			ppc_md.hpte_remove(hpteg);
+			goto repeat;
+		}
+	}
+
 	BUG_ON (ret < 0);
 	spin_lock(&linear_map_hash_lock);
 	BUG_ON(linear_map_hash_slots[lmi] & 0x80);
-- 
1.7.9.5
