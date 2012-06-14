Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <michael@ellerman.id.au>
From: Michael Neuling <mikey@neuling.org>
Date: Thu, 14 Jun 2012 16:15:40 +1000
Subject: [PATCH 4/18] powerpc: Fix sldi to take literal not register name
In-Reply-To: <1339654536.159274.140684871779.qpush@ale>
Message-Id: <20120614061540.4C497D4360B@localhost.localdomain>
Cc: mikey@neuling.org, linuxppc-dev@ozlabs.org, schwab@linux-m68k.org,
 Anton Blanchard <anton@samba.org>, Olof Johannsson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Was introduced by:
 commit 19ccb76a1938ab364a412253daec64613acbf3df
 Author: Paul Mackerras <paulus@samba.org>
 Date:   Sat Jul 23 17:42:46 2011 +1000

Talking to paulus, this shouldn't be a literal.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/kvm/book3s_hv_rmhandlers.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: powerpc-test/arch/powerpc/kvm/book3s_hv_rmhandlers.S
===================================================================
--- powerpc-test.orig/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ powerpc-test/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -810,7 +810,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
 	lwz	r3,VCORE_NAPPING_THREADS(r5)
 	lwz	r4,VCPU_PTID(r9)
 	li	r0,1
-	sldi	r0,r0,r4
+	sld	r0,r0,r4
 	andc.	r3,r3,r0		/* no sense IPI'ing ourselves */
 	beq	43f
 	mulli	r4,r4,PACA_SIZE		/* get paca for thread 0 */
