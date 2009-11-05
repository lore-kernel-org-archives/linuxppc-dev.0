Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C1556B7BB9
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 Nov 2009 17:12:56 +1100 (EST)
Subject: [PATCH] powerpc/kvm: Remove problematic BUILD_BUG_ON statement
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 05 Nov 2009 17:12:50 +1100
Message-ID: <1257401570.13611.103.camel@pasglop>
Mime-Version: 1.0
Cc: Hollis Blanchard <hollisb@us.ibm.com>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

I'm going to stick this into my -merge branch and send it to Linus today
until we fix it for real

diff --git a/arch/powerpc/kvm/timing.h b/arch/powerpc/kvm/timing.h
index bb13b1f..806ef67 100644
--- a/arch/powerpc/kvm/timing.h
+++ b/arch/powerpc/kvm/timing.h
@@ -48,7 +48,11 @@ static inline void kvmppc_set_exit_type(struct kvm_vcpu *vcpu, int type) {}
 static inline void kvmppc_account_exit_stat(struct kvm_vcpu *vcpu, int type)
 {
 	/* type has to be known at build time for optimization */
+
+	/* The BUILD_BUG_ON below breaks in funny ways, commented out
+	 * for now ... -BenH
 	BUILD_BUG_ON(__builtin_constant_p(type));
+	*/
 	switch (type) {
 	case EXT_INTR_EXITS:
 		vcpu->stat.ext_intr_exits++;
