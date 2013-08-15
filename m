Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/6] powerpc/pseries: Add a warning in the case of cross-cpu
 VPA registration
Date: Thu, 15 Aug 2013 15:22:15 +1000
Message-Id: <1376544139-26783-2-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1376544139-26783-1-git-send-email-michael@ellerman.id.au>
References: <1376544139-26783-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The spec says it "may be problematic" if CPU x registers the VPA of
CPU y. Add a warning in case we ever do that.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/lpar.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 8bad880..73d6c1b 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -68,6 +68,12 @@ void vpa_init(int cpu)
 	struct paca_struct *pp;
 	struct dtl_entry *dtl;
 
+	/*
+	 * The spec says it "may be problematic" if CPU x registers the VPA of
+	 * CPU y. We should never do that, but wail if we ever do.
+	 */
+	WARN_ON(cpu != smp_processor_id());
+
 	if (cpu_has_feature(CPU_FTR_ALTIVEC))
 		lppaca_of(cpu).vmxregs_in_use = 1;
 
-- 
1.8.1.2
