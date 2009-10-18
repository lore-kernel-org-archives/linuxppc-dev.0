Return-Path: <anton@ozlabs.org>
Date: Sun, 18 Oct 2009 22:24:29 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 3/3] powerpc: perf_event: Hide iseries_check_pending_irqs
Message-ID: <20091018112429.GP4808@kryten>
References: <20091018112328.GN4808@kryten> <20091018112406.GO4808@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091018112406.GO4808@kryten>
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu, paulus@samba.org,
	a.p.zijlstra@chello.nl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


If CONFIG_PPC_ISERIES isn't defined we end up with iseries_check_pending_irqs
and do_work at the same address. perf ends up picking
iseries_check_pending_irqs which creates confusing backtraces. Hide it.

Signed-off-by: Anton Blanchard <anton@samba.org>
--

Index: linux.trees.git/arch/powerpc/kernel/entry_64.S
===================================================================
--- linux.trees.git.orig/arch/powerpc/kernel/entry_64.S	2009-10-16 11:06:10.000000000 +1100
+++ linux.trees.git/arch/powerpc/kernel/entry_64.S	2009-10-16 11:06:28.000000000 +1100
@@ -551,7 +551,7 @@ restore:
 BEGIN_FW_FTR_SECTION
 	ld	r5,SOFTE(r1)
 FW_FTR_SECTION_ELSE
-	b	iseries_check_pending_irqs
+	b	.Liseries_check_pending_irqs
 ALT_FW_FTR_SECTION_END_IFCLR(FW_FEATURE_ISERIES)
 2:
 	TRACE_AND_RESTORE_IRQ(r5);
@@ -623,7 +623,7 @@ ALT_FW_FTR_SECTION_END_IFCLR(FW_FEATURE_
 
 #endif /* CONFIG_PPC_BOOK3E */
 
-iseries_check_pending_irqs:
+.Liseries_check_pending_irqs:
 #ifdef CONFIG_PPC_ISERIES
 	ld	r5,SOFTE(r1)
 	cmpdi	0,r5,0
