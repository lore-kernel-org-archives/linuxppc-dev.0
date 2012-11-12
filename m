Return-Path: <anton@samba.org>
Date: Mon, 12 Nov 2012 16:01:05 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Fix CONFIG_RELOCATABLE=y CONFIG_CRASH_DUMP=n build
Message-ID: <20121112160105.3500c602@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


If we build a kernel with CONFIG_RELOCATABLE=y CONFIG_CRASH_DUMP=n,
the kernel fails when we run at a non zero offset. It turns out
we were incorrectly wrapping some of the relocatable kernel code
with CONFIG_CRASH_DUMP.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: <stable@kernel.org>
---

Index: b/arch/powerpc/kernel/head_64.S
===================================================================
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -422,7 +422,7 @@ _STATIC(__after_prom_start)
 	tovirt(r6,r6)			/* on booke, we already run at PAGE_OFFSET */
 #endif
 
-#ifdef CONFIG_CRASH_DUMP
+#ifdef CONFIG_RELOCATABLE
 /*
  * Check if the kernel has to be running as relocatable kernel based on the
  * variable __run_at_load, if it is set the kernel is treated as relocatable
