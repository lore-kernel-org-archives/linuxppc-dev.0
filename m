Return-Path: <anton@samba.org>
Date: Mon, 9 May 2011 17:20:19 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Remove static branch hint in giveup_altivec
Message-ID: <20110509172019.6733177e@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


A static branch hint will override dynamic branch prediction on
recent POWER CPUs. Since we are about to use more altivec in the
kernel remove the static hint in giveup_altivec that assumes
a userspace task is using altivec.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-powerpc/arch/powerpc/kernel/vector.S
===================================================================
--- linux-powerpc.orig/arch/powerpc/kernel/vector.S	2011-04-24 12:38:26.329650611 +1000
+++ linux-powerpc/arch/powerpc/kernel/vector.S	2011-04-24 12:39:27.850785617 +1000
@@ -102,7 +102,7 @@ _GLOBAL(giveup_altivec)
 	MTMSRD(r5)			/* enable use of VMX now */
 	isync
 	PPC_LCMPI	0,r3,0
-	beqlr-				/* if no previous owner, done */
+	beqlr				/* if no previous owner, done */
 	addi	r3,r3,THREAD		/* want THREAD of task */
 	PPC_LL	r5,PT_REGS(r3)
 	PPC_LCMPI	0,r5,0
