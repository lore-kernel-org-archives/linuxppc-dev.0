Return-Path: <anton@samba.org>
Date: Wed, 8 Dec 2010 21:55:03 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Fix incorrect comment about interrupt stack
	allocation
Message-ID: <20101208215503.38a6e28f@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We now allow interrupt stacks anywhere in the first segment which can be
256M or 1TB. Fix the comment.

Signed-off-by: Anton Blanchard <anton@samba.org> 
---

Index: powerpc.git/arch/powerpc/kernel/setup_64.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/setup_64.c	2010-08-19 09:05:17.090741942 +1000
+++ powerpc.git/arch/powerpc/kernel/setup_64.c	2010-08-19 09:06:08.151991499 +1000
@@ -428,8 +428,8 @@ static void __init irqstack_early_init(v
 	unsigned int i;
 
 	/*
-	 * interrupt stacks must be under 256MB, we cannot afford to take
-	 * SLB misses on them.
+	 * Interrupt stacks must be in the first segment since we
+	 * cannot afford to take SLB misses on them.
 	 */
 	for_each_possible_cpu(i) {
 		softirq_ctx[i] = (struct thread_info *)
