Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40t98d1b1bzDqx4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 May 2018 14:28:01 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: greg@kroah.com
Cc: stable@vger.kernel.org,
	tglx@linutronix.de,
	linuxppc-dev@ozlabs.org
Subject: [PATCH stable 4.14 v2 07/23] powerpc/rfi-flush: Differentiate enabled
 and patched flush types
Date: Sat, 26 May 2018 14:27:33 +1000
Message-Id: <20180526042749.5324-8-mpe@ellerman.id.au>
In-Reply-To: <20180526042749.5324-1-mpe@ellerman.id.au>
References: <20180526042749.5324-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>

commit 0063d61ccfc011f379a31acaeba6de7c926fed2c upstream.

Currently the rfi-flush messages print 'Using <type> flush' for all
enabled_flush_types, but that is not necessarily true -- as now the
fallback flush is always enabled on pseries, but the fixup function
overwrites its nop/branch slot with other flush types, if available.

So, replace the 'Using <type> flush' messages with '<type> flush is
available'.

Also, print the patched flush types in the fixup function, so users
can know what is (not) being used (e.g., the slower, fallback flush,
or no flush type at all if flush is disabled via the debugfs switch).

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/setup_64.c    | 6 +++---
 arch/powerpc/lib/feature-fixups.c | 9 ++++++++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index ace6a10a242f..da12b54cbe5c 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -860,15 +860,15 @@ static void init_fallback_flush(void)
 void setup_rfi_flush(enum l1d_flush_type types, bool enable)
 {
 	if (types & L1D_FLUSH_FALLBACK) {
-		pr_info("rfi-flush: Using fallback displacement flush\n");
+		pr_info("rfi-flush: fallback displacement flush available\n");
 		init_fallback_flush();
 	}
 
 	if (types & L1D_FLUSH_ORI)
-		pr_info("rfi-flush: Using ori type flush\n");
+		pr_info("rfi-flush: ori type flush available\n");
 
 	if (types & L1D_FLUSH_MTTRIG)
-		pr_info("rfi-flush: Using mttrig type flush\n");
+		pr_info("rfi-flush: mttrig type flush available\n");
 
 	enabled_flush_types = types;
 
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index d0c0b8443dcf..8ac72f7d638f 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -153,7 +153,14 @@ void do_rfi_flush_fixups(enum l1d_flush_type types)
 		patch_instruction(dest + 2, instrs[2]);
 	}
 
-	printk(KERN_DEBUG "rfi-flush: patched %d locations\n", i);
+	printk(KERN_DEBUG "rfi-flush: patched %d locations (%s flush)\n", i,
+		(types == L1D_FLUSH_NONE)       ? "no" :
+		(types == L1D_FLUSH_FALLBACK)   ? "fallback displacement" :
+		(types &  L1D_FLUSH_ORI)        ? (types & L1D_FLUSH_MTTRIG)
+							? "ori+mttrig type"
+							: "ori type" :
+		(types &  L1D_FLUSH_MTTRIG)     ? "mttrig type"
+						: "unknown");
 }
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
-- 
2.14.1
