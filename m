Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYRQC5bbjzDrJJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 12:10:59 +1000 (AEST)
Message-ID: <1503022252.4493.132.camel@kernel.crashing.org>
Subject: [PATCH 1/2] kvm/xive: Workaround P9 DD1.0 bug with IPB bit loss
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: kvm-ppc@vger.kernel.org
Cc: linuxppc dev list <linuxppc-dev@lists.ozlabs.org>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, paulus@samba.org
Date: Fri, 18 Aug 2017 12:10:52 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thankfully it only happens when manually manipulating CPPR which
is rather quite rare.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kvm/book3s_xive_template.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_xive_template.c b/arch/powerpc/kvm/book3s_xive_template.c
index 4636ca6e7d38..150be86b1018 100644
--- a/arch/powerpc/kvm/book3s_xive_template.c
+++ b/arch/powerpc/kvm/book3s_xive_template.c
@@ -16,7 +16,16 @@ static void GLUE(X_PFX,ack_pending)(struct kvmppc_xive_vcpu *xc)
 	u8 cppr;
 	u16 ack;
 
-	/* XXX DD1 bug workaround: Check PIPR vs. CPPR first ! */
+	/*
+	 * DD1 bug workaround: If PIPR is less favored than CPPR
+	 * ignore the interrupt or we might incorrectly lose an IPB
+	 * bit.
+	 */
+	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+		u8 pipr = __x_readb(__x_tima + TM_QW1_OS + TM_PIPR);
+		if (pipr >= xc->hw_cppr)
+			return;
+	}
 
 	/* Perform the acknowledge OS to register cycle. */
 	ack = be16_to_cpu(__x_readw(__x_tima + TM_SPC_ACK_OS_REG));
