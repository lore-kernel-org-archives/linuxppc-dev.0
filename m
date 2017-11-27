Return-Path: <clg@kaod.org>
Received: from 16.mo4.mail-out.ovh.net (16.mo4.mail-out.ovh.net
 [188.165.55.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ylm7K1m3xzDr2T
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 23:19:07 +1100 (AEDT)
Received: from player798.ha.ovh.net (b7.ovh.net [213.186.33.57])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 2C05410AB5F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 08:30:31 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH] KVM: PPC: Book3S HV: check for XIVE device before executing
 the XICS hcalls
Date: Mon, 27 Nov 2017 08:30:17 +0100
Message-Id: <20171127073017.25463-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When QEMU is started with the option kernel_irqchip=òff, the kvm XICS
hcalls are being used even though a kvm XICS device has not been
created on the host, resulting quickly in a failure and a broken
guest.

The test checking if there is a XIVE device in the VM before executing
the XICS hcalls is missing from the recent XICS-over-XIVE glue.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/kvm/book3s_xive_template.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_xive_template.c b/arch/powerpc/kvm/book3s_xive_template.c
index c7a5deadd1cc..7aa4e02df97c 100644
--- a/arch/powerpc/kvm/book3s_xive_template.c
+++ b/arch/powerpc/kvm/book3s_xive_template.c
@@ -276,11 +276,15 @@ static u32 GLUE(X_PFX,scan_interrupts)(struct kvmppc_xive_vcpu *xc,
 X_STATIC unsigned long GLUE(X_PFX,h_xirr)(struct kvm_vcpu *vcpu)
 {
 	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+	struct kvmppc_xive *xive = vcpu->kvm->arch.xive;
 	u8 old_cppr;
 	u32 hirq;
 
 	pr_devel("H_XIRR\n");
 
+	if (!xive)
+		return H_TOO_HARD;
+
 	xc->GLUE(X_STAT_PFX,h_xirr)++;
 
 	/* First collect pending bits from HW */
@@ -335,11 +339,15 @@ X_STATIC unsigned long GLUE(X_PFX,h_xirr)(struct kvm_vcpu *vcpu)
 X_STATIC unsigned long GLUE(X_PFX,h_ipoll)(struct kvm_vcpu *vcpu, unsigned long server)
 {
 	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+	struct kvmppc_xive *xive = vcpu->kvm->arch.xive;
 	u8 pending = xc->pending;
 	u32 hirq;
 
 	pr_devel("H_IPOLL(server=%ld)\n", server);
 
+	if (!xive)
+		return H_TOO_HARD;
+
 	xc->GLUE(X_STAT_PFX,h_ipoll)++;
 
 	/* Grab the target VCPU if not the current one */
@@ -388,8 +396,12 @@ static void GLUE(X_PFX,push_pending_to_hw)(struct kvmppc_xive_vcpu *xc)
 X_STATIC int GLUE(X_PFX,h_cppr)(struct kvm_vcpu *vcpu, unsigned long cppr)
 {
 	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+	struct kvmppc_xive *xive = vcpu->kvm->arch.xive;
 	u8 old_cppr;
 
+	if (!xive)
+		return H_TOO_HARD;
+
 	pr_devel("H_CPPR(cppr=%ld)\n", cppr);
 
 	xc->GLUE(X_STAT_PFX,h_cppr)++;
@@ -435,6 +447,9 @@ X_STATIC int GLUE(X_PFX,h_eoi)(struct kvm_vcpu *vcpu, unsigned long xirr)
 	u16 src;
 	int rc = 0;
 
+	if (!xive)
+		return H_TOO_HARD;
+
 	pr_devel("H_EOI(xirr=%08lx)\n", xirr);
 
 	xc->GLUE(X_STAT_PFX,h_eoi)++;
@@ -532,9 +547,13 @@ X_STATIC int GLUE(X_PFX,h_ipi)(struct kvm_vcpu *vcpu, unsigned long server,
 			       unsigned long mfrr)
 {
 	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
+	struct kvmppc_xive *xive = vcpu->kvm->arch.xive;
 
 	pr_devel("H_IPI(server=%08lx,mfrr=%ld)\n", server, mfrr);
 
+	if (!xive)
+		return H_TOO_HARD;
+
 	xc->GLUE(X_STAT_PFX,h_ipi)++;
 
 	/* Find target */
-- 
2.13.6
