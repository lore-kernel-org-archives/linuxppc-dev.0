Return-Path: <RFeany@mrv.com>
Received: from bos-spam.mrv.com (mx5.mrv.com [140.179.254.12])
	by ozlabs.org (Postfix) with ESMTP id 9D3C6B6F2B
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 11:41:32 +1100 (EST)
Date: Wed, 14 Oct 2009 17:41:27 -0700
From: Rex Feany <rfeany@mrv.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: I think I have 8xx working...
Message-ID: <20091015004127.GA15570@laura.chatsunix.int.mrv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The biggest problem for me turned out to be the MMU context IDs being
clamped to 32 when the 8xx only has 16. With this, things are a bit more
stable :)

diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index c2f93dc..15e00c5 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -404,7 +404,8 @@ void __init mmu_context_init(void)
 	}
 
 #ifdef DEBUG_CLAMP_LAST_CONTEXT
-	last_context = DEBUG_CLAMP_LAST_CONTEXT;
+	if (last_context > DEBUG_CLAMP_LAST_CONTEXT)
+	    last_context = DEBUG_CLAMP_LAST_CONTEXT;
 #endif
 	/*
 	 * Allocate the maps used by context management
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index e7dae82..26fb6b9 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -40,7 +40,7 @@
 #include <asm/uaccess.h>
 #include <asm/tlbflush.h>
 #include <asm/siginfo.h>
-
+#include <mm/mmu_decl.h>
 
 #ifdef CONFIG_KPROBES
 static inline int notify_page_fault(struct pt_regs *regs)
@@ -246,6 +246,12 @@ good_area:
 		goto bad_area;
 #endif /* CONFIG_6xx */
 #if defined(CONFIG_8xx)
+	/* 8xx sometimes need to load a invalid/non-present TLBs.
+	 * These must be invalidated separately as linux mm don't.
+	 */
+	if (error_code & 0x40000000) /* no translation? */
+		_tlbil_va(address, 0, 0, 0);
+
         /* The MPC8xx seems to always set 0x80000000, which is
          * "undefined".  Of those that can be set, this is the only
          * one which seems bad.
