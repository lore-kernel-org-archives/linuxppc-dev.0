Return-Path: <laurentiu.tudor@nxp.com>
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0060.outbound.protection.outlook.com [104.47.41.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPKPT3R6kzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 02:11:41 +1100 (AEDT)
From: <laurentiu.tudor@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>, <oss@buserror.net>, <mpe@ellerman.id.au>
CC: <madalin.bucur@nxp.com>, <aneesh.kumar@linux.vnet.ibm.com>, "Laurentiu
 Tudor" <laurentiu.tudor@nxp.com>
Subject: [PATCH] powerpc: booke: fix boot crash due to null hugepd
Date: Thu, 16 Feb 2017 09:11:29 -0600
Message-ID: <20170216151129.8971-1-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

On 32-bit book-e machines, hugepd_ok() does not take
into account null hugepd values, causing this crash at boot:

Unable to handle kernel paging request for data at address 0x80000000
Faulting instruction address: 0xc00182a8
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=24
CoreNet Generic
Modules linked in:
CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W       4.10.0-rc8-00016-g69b1f87 #11
task: e5050000 task.stack: e5058000
NIP: c00182a8 LR: c001829c CTR: 00007ffe
REGS: e5059c50 TRAP: 0300   Tainted: G        W        (4.10.0-rc8-00016-g69b1f87)
MSR: 00021002 <CE,ME>
  CR: 88428e82  XER: 00000000
DEAR: 80000000 ESR: 00000000
GPR00: c0107510 e5059d00 e5050000 80000000 bffffff1 e5059d0c e5059d08 00002017
GPR08: 00000000 00000000 00000000 00000000 28428e82 00000000 c00027d0 00000000
GPR16: 00000000 00000000 88a28e82 20000000 48422e82 00000000 88a28e84 dd004000
GPR24: e5059e38 00000000 00000000 bffffff1 dd004000 00000001 00029002 bffffff1
NIP [c00182a8] follow_huge_addr+0x38/0xf0
LR [c001829c] follow_huge_addr+0x2c/0xf0
Call Trace:
[e5059d00] [e5059d00] 0xe5059d00 (unreliable)
[e5059d20] [c0107510] follow_page_mask+0x40/0x3c0
[e5059d80] [c0107958] __get_user_pages+0xc8/0x420
[e5059de0] [c010817c] get_user_pages_remote+0x8c/0x230
[e5059e30] [c013f170] copy_strings+0x110/0x3a0
[e5059ea0] [c013f42c] copy_strings_kernel+0x2c/0x50
[e5059ec0] [c0141324] do_execveat_common+0x474/0x620
[e5059f10] [c01414fc] do_execve+0x2c/0x40
[e5059f20] [c0001f68] try_to_run_init_process+0x18/0x60
[e5059f30] [c000289c] kernel_init+0xcc/0x120
[e5059f40] [c000f1e8] ret_from_kernel_thread+0x5c/0x64
Instruction dump:
bfc10018 7c9f2378 90010024 7fc000a6 7c000146 80630020 38a1000c 38c10008
4bfff869 2c030000 41c20090 81210008 <81430000> 81630004 3860ffea 2f890000
---[ end trace 4bf94e15fd9fa824 ]---

This impacts all nxp (ex-freescale) 32-bit booke platforms.

Fixes: 20717e1ff526 ("powerpc/mm: Fix little-endian 4K hugetlb")

Reported-by: Madalin-Cristian Bucur <madalin.bucur@nxp.com>
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 arch/powerpc/include/asm/nohash/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 0cd8a38..e5805ad 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -230,7 +230,7 @@ static inline int hugepd_ok(hugepd_t hpd)
 	return ((hpd_val(hpd) & 0x4) != 0);
 #else
 	/* We clear the top bit to indicate hugepd */
-	return ((hpd_val(hpd) & PD_HUGE) ==  0);
+	return (hpd_val(hpd) && (hpd_val(hpd) & PD_HUGE) == 0);
 #endif
 }
 
-- 
1.8.3.1
