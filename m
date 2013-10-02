Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/tm: Turn interrupts hard off in tm_reclaim()
Date: Wed,  2 Oct 2013 17:15:15 +1000
Message-Id: <1380698115-25841-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1380698115-25841-1-git-send-email-mikey@neuling.org>
References: <1380698115-25841-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We can't take IRQs in tm_reclaim as we might have a bogus r13 and r1.

This turns IRQs hard off in this function.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/tm.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index 7b60b98..8ece190 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -123,6 +123,7 @@ _GLOBAL(tm_reclaim)
 	mr	r15, r14
 	ori	r15, r15, MSR_FP
 	li	r16, MSR_RI
+	ori	r16, r16, MSR_EE /* IRQs hard off */
 	andc	r15, r15, r16
 	oris	r15, r15, MSR_VEC@h
 #ifdef CONFIG_VSX
-- 
1.8.1.2
