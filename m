Return-Path: <lvivier@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjD3J1mQ7zDr4J
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 20:06:51 +1100 (AEDT)
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@ozlabs.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Sam Bobroff <sbobroff@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH] powerpc/xive: store server for masked interrupt in
 kvmppc_xive_set_xive()
Date: Thu, 23 Nov 2017 10:06:33 +0100
Message-Id: <20171123090633.873-1-lvivier@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is needed to map kvmppc_xive_set_xive() behavior
to kvmppc_xics_set_xive().

As we store the server, kvmppc_xive_get_xive() can return
the good value and we can also allow kvmppc_xive_int_on().

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 arch/powerpc/kvm/book3s_xive.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index bf457843e032..2781b8733038 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -584,10 +584,14 @@ int kvmppc_xive_set_xive(struct kvm *kvm, u32 irq, u32 server,
 	 *       we could initialize interrupts with valid default
 	 */
 
-	if (new_act_prio != MASKED &&
-	    (state->act_server != server ||
-	     state->act_priority != new_act_prio))
-		rc = xive_target_interrupt(kvm, state, server, new_act_prio);
+	if (state->act_server != server ||
+	    state->act_priority != new_act_prio) {
+		if (new_act_prio != MASKED)
+			rc = xive_target_interrupt(kvm, state, server,
+						   new_act_prio);
+		if (!rc)
+			state->act_server = server;
+	}
 
 	/*
 	 * Perform the final unmasking of the interrupt source
@@ -646,14 +650,6 @@ int kvmppc_xive_int_on(struct kvm *kvm, u32 irq)
 
 	pr_devel("int_on(irq=0x%x)\n", irq);
 
-	/*
-	 * Check if interrupt was not targetted
-	 */
-	if (state->act_priority == MASKED) {
-		pr_devel("int_on on untargetted interrupt\n");
-		return -EINVAL;
-	}
-
 	/* If saved_priority is 0xff, do nothing */
 	if (state->saved_priority == MASKED)
 		return 0;
-- 
2.13.6
