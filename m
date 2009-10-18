Return-Path: <anton@ozlabs.org>
Date: Sun, 18 Oct 2009 22:23:28 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 1/3] powerpc: perf_event: Cleanup copy_page output by
	hiding setup symbol
Message-ID: <20091018112328.GN4808@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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


A lot of hits in "setup" doesn't make much sense, so hide this symbol and
allow all the hits to end up in copy_4k_page.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux.trees.git/arch/powerpc/lib/copypage_64.S
===================================================================
--- linux.trees.git.orig/arch/powerpc/lib/copypage_64.S	2009-07-06 10:13:56.000000000 +1000
+++ linux.trees.git/arch/powerpc/lib/copypage_64.S	2009-07-06 10:13:57.000000000 +1000
@@ -26,11 +26,11 @@
 	srd	r8,r5,r11
 
 	mtctr	r8
-setup:
+.Lsetup:
 	dcbt	r9,r4
 	dcbz	r9,r3
 	add	r9,r9,r12
-	bdnz	setup
+	bdnz	.Lsetup
 END_FTR_SECTION_IFSET(CPU_FTR_CP_USE_DCBTZ)
 	addi	r3,r3,-8
 	srdi    r8,r5,7		/* page is copied in 128 byte strides */
