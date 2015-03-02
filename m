Return-Path: <Yanjiang.Jin@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1280A1A03BD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Mar 2015 19:35:51 +1100 (AEDT)
From: <yanjiang.jin@windriver.com>
To: <mpe@ellerman.id.au>, <scottwood@freescale.com>
Subject: [PATCH] fsl: mpc85xx: call k(un)map_atomic other than k(un)map
Date: Mon, 2 Mar 2015 16:35:35 +0800
Message-ID: <1425285335-21753-1-git-send-email-yanjiang.jin@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: msm@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Yanjiang Jin <yanjiang.jin@windriver.com>

The k(un)map function may be called in atomic context in the
function map_and_flush(), so use k(un)map_atomic to replace it,
else we would get the below warning during kdump:

BUG: sleeping function called from invalid context at include/linux/highmem.h:58
in_atomic(): 1, irqs_disabled(): 1, pid: 736, name: sh
INFO: lockdep is turned off.
irq event stamp: 0
hardirqs last  enabled at (0): [<          (null)>]           (null)
hardirqs last disabled at (0): [<c000000000066d1c>] .copy_process.part.44+0x50c/0x1360
softirqs last  enabled at (0): [<c000000000066d1c>] .copy_process.part.44+0x50c/0x1360
softirqs last disabled at (0): [<          (null)>]           (null)
CPU: 1 PID: 736 Comm: sh Tainted: G      D W    3.10.62-ltsi-WR6.0.0.0_standard #2
Call Trace:
[c0000000f47cf120] [c00000000000b150] .show_stack+0x170/0x290 (unreliable)
[c0000000f47cf210] [c000000000b71334] .dump_stack+0x28/0x3c
[c0000000f47cf280] [c0000000000bb5d8] .__might_sleep+0x1a8/0x270
[c0000000f47cf310] [c0000000000440cc] .map_and_flush+0x4c/0xc0
[c0000000f47cf390] [c0000000000441cc] .mpc85xx_smp_machine_kexec+0x8c/0xec0
[c0000000f47cf420] [c00000000002ae00] .machine_kexec+0x60/0x90
[c0000000f47cf4b0] [c00000000010957c] .crash_kexec+0x8c/0x100
[c0000000f47cf6a0] [c000000000015df8] .die+0x348/0x450
[c0000000f47cf740] [c00000000002f3a0] .bad_page_fault+0xe0/0x130
[c0000000f47cf7c0] [c00000000001f3e4] storage_fault_common+0x40/0x44

Signed-off-by: Yanjiang Jin <yanjiang.jin@windriver.com>
---
 arch/powerpc/platforms/85xx/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index d7c1e69..8631ac5 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -360,10 +360,10 @@ static void mpc85xx_smp_kexec_down(void *arg)
 static void map_and_flush(unsigned long paddr)
 {
 	struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
-	unsigned long kaddr  = (unsigned long)kmap(page);
+	unsigned long kaddr  = (unsigned long)kmap_atomic(page);
 
 	flush_dcache_range(kaddr, kaddr + PAGE_SIZE);
-	kunmap(page);
+	kunmap_atomic((void *)kaddr);
 }
 
 /**
-- 
1.9.1
