Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 030BFDDEB8
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 20:53:28 +1000 (EST)
Date: Wed, 15 Aug 2007 20:53:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Fix section mismatch in crash_dump.c
Message-Id: <20070815205326.317c5394.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

WARNING: vmlinux.o(.text+0x23258): Section mismatch: reference to .init.text:.lmb_reserve (between '.reserve_kdump_trampoline' and '.restore_processor_state')

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/crash_dump.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 2f6f5a7..ffa91d6 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -25,7 +25,7 @@
 #define DBG(fmt...)
 #endif
 
-void reserve_kdump_trampoline(void)
+void __init reserve_kdump_trampoline(void)
 {
 	lmb_reserve(0, KDUMP_RESERVE_LIMIT);
 }
-- 
1.5.2.4
