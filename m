Return-Path: <anton@ozlabs.org>
Date: Mon, 8 Feb 2010 16:37:29 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] Clear MSR_RI during RTAS calls
Message-ID: <20100208053729.GO32246@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


RTAS should never cause an exception but if it does (for example accessing
outside our RMO) then we might go a long way through the kernel before
oopsing. If we unset MSR_RI we should at least stop things on exception
exit.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

The setting of MSR_RI during RTAS calls went in ages ago (2003), and I'm
not sure why. Clearly an exception inside RTAS is fatal since we most likely
have a bad r13.

Index: powerpc.git/arch/powerpc/kernel/entry_64.S
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/entry_64.S	2010-02-08 12:25:51.543072119 +1100
+++ powerpc.git/arch/powerpc/kernel/entry_64.S	2010-02-08 12:26:56.043513290 +1100
@@ -791,9 +791,8 @@ _GLOBAL(enter_rtas)
 	
         li      r9,1
         rldicr  r9,r9,MSR_SF_LG,(63-MSR_SF_LG)
-	ori	r9,r9,MSR_IR|MSR_DR|MSR_FE0|MSR_FE1|MSR_FP
+	ori	r9,r9,MSR_IR|MSR_DR|MSR_FE0|MSR_FE1|MSR_FP|MSR_RI
 	andc	r6,r0,r9
-	ori	r6,r6,MSR_RI
 	sync				/* disable interrupts so SRR0/1 */
 	mtmsrd	r0			/* don't get trashed */
 
