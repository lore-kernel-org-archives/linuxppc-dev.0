Return-Path: <B40534@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A476C2C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 18:49:31 +1000 (EST)
From: Wang Dongsheng <dongsheng.wang@freescale.com>
To: <avorontsov@ru.mvista.com>
Subject: [PATCH] powerpc/mpc85xx: fix non-bootcpu cannot up after hibernation
 resume
Date: Tue, 14 May 2013 16:05:56 +0800
Message-ID: <1368518756-9850-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: chenhui.zhao@freescale.com, Wang Dongsheng <dongsheng.wang@freescale.com>,
 rjw@sisk.pl, paulus@samba.org, scottwood@freescale.com,
 johannes@sipsolutions.net, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This problem belongs to the core synchronization issues.
The cpu1 already updated spin_table values, but bootcore cannot get
this value in time.

After bootcpu hibiernation restore the pages. we are now running
with the kernel data of the old kernel fully restored. if we reset
the non-bootcpus that will be reset cache(tlb), the non-bootcpus
will get new address(map virtual and physical address spaces).
but bootcpu tlb cache still use boot kernel data, so we need to
invalidate the bootcpu tlb cache make it to get new main memory data.

log:
Enabling non-boot CPUs ...
smp_85xx_kick_cpu: timeout waiting for core 1 to reset
smp: failed starting cpu 1 (rc -2)
Error taking CPU1 up: -2

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/arch/powerpc/kernel/swsusp_booke.S b/arch/powerpc/kernel/swsusp_booke.S
index 11a3930..9503249 100644
--- a/arch/powerpc/kernel/swsusp_booke.S
+++ b/arch/powerpc/kernel/swsusp_booke.S
@@ -141,6 +141,19 @@ _GLOBAL(swsusp_arch_resume)
 	lis	r11,swsusp_save_area@h
 	ori	r11,r11,swsusp_save_area@l
 
+	/*
+	 * The boot core get a virtual address, when the boot process,
+	 * the virtual address corresponds to a physical address. After
+	 * hibernation resume memory snapshots, The corresponding
+	 * relationship between the virtual memory and physical memory
+	 * might change again. We need to get a new page table. So we
+	 * need to invalidate TLB after resume pages.
+	 *
+	 * Invalidations TLB Using tlbilx/tlbivax/MMUCSR0.
+	 * tlbilx used here.
+	 */
+	bl	_tlbil_all
+
 	lwz	r4,SL_SPRG0(r11)
 	mtsprg	0,r4
 	lwz	r4,SL_SPRG1(r11)
-- 
1.8.0
