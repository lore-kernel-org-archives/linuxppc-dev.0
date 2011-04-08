Return-Path: <anton@samba.org>
Date: Fri, 8 Apr 2011 17:44:21 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Fix oops if scan_dispatch_log is called too early
Message-ID: <20110408174421.7627a283@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We currently enable interrupts before the dispatch log for the boot
cpu is setup. If a timer interrupt comes in early enough we oops in
scan_dispatch_log:

Unable to handle kernel paging request for data at address 0x00000010

...

.scan_dispatch_log+0xb0/0x170
.account_system_vtime+0xa0/0x220
.irq_enter+0x88/0xc0
.do_IRQ+0x48/0x230

The patch below adds a check to scan_dispatch_log to ensure the
dispatch log has been allocated.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: <stable@kernel.org>
---

Index: powerpc.git/arch/powerpc/kernel/time.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/time.c	2011-04-05 18:38:40.814489516 +1000
+++ powerpc.git/arch/powerpc/kernel/time.c	2011-04-08 12:16:41.864748155 +1000
@@ -229,6 +229,9 @@ static u64 scan_dispatch_log(u64 stop_tb
 	u64 stolen = 0;
 	u64 dtb;
 
+	if (!dtl)
+		return 0;
+
 	if (i == vpa->dtl_idx)
 		return 0;
 	while (i < vpa->dtl_idx) {
