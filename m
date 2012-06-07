Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: Fix sldi to take literal not register name
In-reply-to: <1339049882.2215.10.camel@concordia>
References: <20120604175858.38dac554@kryten> <20120605120222.6722a3e3@kryten>
 <178E3BC0-C6E2-4E33-BA66-8144F192A151@kernel.crashing.org>
 <1339017602.7150.174.camel@pasglop> <4725.1339049104@neuling.org>
 <1339049235.2215.2.camel@concordia> <5626.1339049529@neuling.org>
 <1339049882.2215.10.camel@concordia>
Date: Fri, 08 Jun 2012 09:52:29 +1000
Message-ID: <9666.1339113149@neuling.org>
Cc: Michael Ellerman <michael@ellerman.id.au>,
 Anton Blanchard <anton@samba.org>, olof@lixom.net,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix sldi to take literal not register name.

Was introduced by:
 commit 19ccb76a1938ab364a412253daec64613acbf3df
 Author: Paul Mackerras <paulus@samba.org>
 Date:   Sat Jul 23 17:42:46 2011 +1000

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
I got sick off the bike-shedding in a vacuum and started doing the
conversion.  Found this as a result.

I'll post the full conversion at some point, but this fix is useful
now.  

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index a84aafc..969caeb 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -810,7 +810,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
 	lwz	r3,VCORE_NAPPING_THREADS(r5)
 	lwz	r4,VCPU_PTID(r9)
 	li	r0,1
-	sldi	r0,r0,r4
+	sldi	r0,r0,4
 	andc.	r3,r3,r0		/* no sense IPI'ing ourselves */
 	beq	43f
 	mulli	r4,r4,PACA_SIZE		/* get paca for thread 0 */
