Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D5528B7007
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 22:26:50 +1000 (EST)
Received: from mail162-ch1 (localhost [127.0.0.1])	by
 mail162-ch1-R.bigfish.com (Postfix) with ESMTP id 3A6CC1802C1	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 12:25:08 +0000 (UTC)
Received: from CH1EHSMHS003.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.238])	by mail162-ch1.bigfish.com (Postfix) with ESMTP id
 BE1033E004A	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 12:25:05
 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q5PCQfBQ019329	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 05:26:41 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <qemu-ppc@nongnu.org>
Subject: [RFC PATCH 09/17] KVM: PPC64: booke: Hard disable interrupts when
 entering guest
Date: Mon, 25 Jun 2012 15:26:27 +0300
Message-ID: <1340627195-11544-10-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

64-bit host runs with lazy interrupt disabling, so local_irq_disable() does
not disable interrupts right away and does not protect against preemption
required by __kvmppc_vcpu_run(). Define a macro for 64-bit to use
hard_irq_disable().

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kvm/booke.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 93b48e0..db05692 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -45,6 +45,12 @@ unsigned long kvmppc_booke_handlers;
 #define VM_STAT(x) offsetof(struct kvm, stat.x), KVM_STAT_VM
 #define VCPU_STAT(x) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU
 
+#ifdef CONFIG_64BIT
+#define _hard_irq_disable() hard_irq_disable()
+#else
+#define _hard_irq_disable() local_irq_disable()
+#endif
+
 struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "mmio",       VCPU_STAT(mmio_exits) },
 	{ "dcr",        VCPU_STAT(dcr_exits) },
@@ -456,7 +462,7 @@ int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
 		local_irq_enable();
 		kvm_vcpu_block(vcpu);
 		clear_bit(KVM_REQ_UNHALT, &vcpu->requests);
-		local_irq_disable();
+		_hard_irq_disable();
 
 		kvmppc_set_exit_type(vcpu, EMULATED_MTMSRWE_EXITS);
 		r = 1;
@@ -480,7 +486,7 @@ static int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
 		if (need_resched()) {
 			local_irq_enable();
 			cond_resched();
-			local_irq_disable();
+			_hard_irq_disable();
 			continue;
 		}
 
@@ -515,7 +521,7 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 		return -EINVAL;
 	}
 
-	local_irq_disable();
+	_hard_irq_disable();
 	if (kvmppc_prepare_to_enter(vcpu)) {
 		kvm_run->exit_reason = KVM_EXIT_INTR;
 		ret = -EINTR;
@@ -955,7 +961,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	 * aren't already exiting to userspace for some other reason.
 	 */
 	if (!(r & RESUME_HOST)) {
-		local_irq_disable();
+		_hard_irq_disable();
 		if (kvmppc_prepare_to_enter(vcpu)) {
 			run->exit_reason = KVM_EXIT_INTR;
 			r = (-EINTR << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
-- 
1.7.4.1
