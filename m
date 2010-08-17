Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D0F34B730F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 Aug 2010 23:58:17 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 26/26] KVM: PPC: allow ppc440gp to pass the compatibility check
Date: Tue, 17 Aug 2010 15:58:01 +0200
Message-Id: <1282053481-18787-27-git-send-email-agraf@suse.de>
In-Reply-To: <1282053481-18787-1-git-send-email-agraf@suse.de>
References: <1282053481-18787-1-git-send-email-agraf@suse.de>
Cc: Hollis Blanchard <hollis_blanchard@mentor.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hollis Blanchard <hollis_blanchard@mentor.com>

Match only the first part of cur_cpu_spec->platform.

440GP (the first 440 processor) is identified by the string "ppc440gp", while
all later 440 processors use simply "ppc440".

Signed-off-by: Hollis Blanchard <hollis_blanchard@mentor.com>
Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/44x.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/44x.c b/arch/powerpc/kvm/44x.c
index e7b1f3f..74d0e74 100644
--- a/arch/powerpc/kvm/44x.c
+++ b/arch/powerpc/kvm/44x.c
@@ -43,7 +43,7 @@ int kvmppc_core_check_processor_compat(void)
 {
 	int r;
 
-	if (strcmp(cur_cpu_spec->platform, "ppc440") == 0)
+	if (strncmp(cur_cpu_spec->platform, "ppc440", 6) == 0)
 		r = 0;
 	else
 		r = -ENOTSUPP;
@@ -72,6 +72,7 @@ int kvmppc_core_vcpu_setup(struct kvm_vcpu *vcpu)
 	/* Since the guest can directly access the timebase, it must know the
 	 * real timebase frequency. Accordingly, it must see the state of
 	 * CCR1[TCS]. */
+	/* XXX CCR1 doesn't exist on all 440 SoCs. */
 	vcpu->arch.ccr1 = mfspr(SPRN_CCR1);
 
 	for (i = 0; i < ARRAY_SIZE(vcpu_44x->shadow_refs); i++)
-- 
1.6.0.2
