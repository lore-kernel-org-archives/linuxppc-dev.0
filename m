Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FC1C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 12:29:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA48D21871
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 12:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA48D21871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LPz43z8jzDq9K
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 23:29:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.34.195; helo=11.mo4.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 454 seconds by postgrey-1.36 at bilbo;
 Fri, 15 Mar 2019 23:17:23 AEDT
Received: from 11.mo4.mail-out.ovh.net (11.mo4.mail-out.ovh.net
 [46.105.34.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LPhz68XZzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 23:17:22 +1100 (AEDT)
Received: from player793.ha.ovh.net (unknown [10.109.159.222])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 6438E1DEC82
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 13:09:44 +0100 (CET)
Received: from kaod.org (lfbn-1-2226-17.w90-76.abo.wanadoo.fr [90.76.48.17])
 (Authenticated sender: clg@kaod.org)
 by player793.ha.ovh.net (Postfix) with ESMTPSA id 3FD733CD2267;
 Fri, 15 Mar 2019 12:09:35 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v3 17/17] KVM: PPC: Book3S HV: XIVE: clear the vCPU interrupt
 presenters
Date: Fri, 15 Mar 2019 13:06:09 +0100
Message-Id: <20190315120609.25910-18-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190315120609.25910-1-clg@kaod.org>
References: <20190315120609.25910-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10810890906650184663
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrheehgdefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: kvm@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When the VM boots, the CAS negotiation process determines which
interrupt mode to use and invokes a machine reset. At that time, the
previous KVM interrupt device is 'destroyed' before the chosen one is
created. Upon destruction, the vCPU interrupt presenters using the KVM
device should be cleared first, the machine will reconnect them later
to the new device after it is created.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---

 Changes since v2 :

 - removed comments on possible race in kvmppc_native_connect_vcpu()
   for the XIVE KVM device. This is still an issue in the
   XICS-over-XIVE device.

 arch/powerpc/kvm/book3s_xics.c        | 19 +++++++++++++
 arch/powerpc/kvm/book3s_xive.c        | 39 +++++++++++++++++++++++++--
 arch/powerpc/kvm/book3s_xive_native.c | 12 +++++++++
 3 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index f27ee57ab46e..81cdabf4295f 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -1342,6 +1342,25 @@ static void kvmppc_xics_free(struct kvm_device *dev)
 	struct kvmppc_xics *xics = dev->private;
 	int i;
 	struct kvm *kvm = xics->kvm;
+	struct kvm_vcpu *vcpu;
+
+	/*
+	 * When destroying the VM, the vCPUs are destroyed first and
+	 * the vCPU list should be empty. If this is not the case,
+	 * then we are simply destroying the device and we should
+	 * clean up the vCPU interrupt presenters first.
+	 */
+	if (atomic_read(&kvm->online_vcpus) != 0) {
+		/*
+		 * call kick_all_cpus_sync() to ensure that all CPUs
+		 * have executed any pending interrupts
+		 */
+		if (is_kvmppc_hv_enabled(kvm))
+			kick_all_cpus_sync();
+
+		kvm_for_each_vcpu(i, vcpu, kvm)
+			kvmppc_xics_free_icp(vcpu);
+	}
 
 	debugfs_remove(xics->dentry);
 
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 480a3fc6b9fd..cf6a4c6c5a28 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -1100,11 +1100,19 @@ void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu)
 void kvmppc_xive_cleanup_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
-	struct kvmppc_xive *xive = xc->xive;
+	struct kvmppc_xive *xive;
 	int i;
 
+	if (!kvmppc_xics_enabled(vcpu))
+		return;
+
+	if (!xc)
+		return;
+
 	pr_devel("cleanup_vcpu(cpu=%d)\n", xc->server_num);
 
+	xive = xc->xive;
+
 	/* Ensure no interrupt is still routed to that VP */
 	xc->valid = false;
 	kvmppc_xive_disable_vcpu_interrupts(vcpu);
@@ -1141,6 +1149,10 @@ void kvmppc_xive_cleanup_vcpu(struct kvm_vcpu *vcpu)
 	}
 	/* Free the VP */
 	kfree(xc);
+
+	/* Cleanup the vcpu */
+	vcpu->arch.irq_type = KVMPPC_IRQ_DEFAULT;
+	vcpu->arch.xive_vcpu = NULL;
 }
 
 int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
@@ -1158,7 +1170,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
 	}
 	if (xive->kvm != vcpu->kvm)
 		return -EPERM;
-	if (vcpu->arch.irq_type)
+	if (vcpu->arch.irq_type != KVMPPC_IRQ_DEFAULT)
 		return -EBUSY;
 	if (kvmppc_xive_find_server(vcpu->kvm, cpu)) {
 		pr_devel("Duplicate !\n");
@@ -1828,8 +1840,31 @@ static void kvmppc_xive_free(struct kvm_device *dev)
 {
 	struct kvmppc_xive *xive = dev->private;
 	struct kvm *kvm = xive->kvm;
+	struct kvm_vcpu *vcpu;
 	int i;
 
+	/*
+	 * When destroying the VM, the vCPUs are destroyed first and
+	 * the vCPU list should be empty. If this is not the case,
+	 * then we are simply destroying the device and we should
+	 * clean up the vCPU interrupt presenters first.
+	 */
+	if (atomic_read(&kvm->online_vcpus) != 0) {
+		/*
+		 * call kick_all_cpus_sync() to ensure that all CPUs
+		 * have executed any pending interrupts
+		 */
+		if (is_kvmppc_hv_enabled(kvm))
+			kick_all_cpus_sync();
+
+		/*
+		 * TODO: There is still a race window with the early
+		 * checks in kvmppc_native_connect_vcpu()
+		 */
+		kvm_for_each_vcpu(i, vcpu, kvm)
+			kvmppc_xive_cleanup_vcpu(vcpu);
+	}
+
 	debugfs_remove(xive->dentry);
 
 	if (kvm)
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index 67a1bb26a4cc..8f7be5e23177 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -956,8 +956,20 @@ static void kvmppc_xive_native_free(struct kvm_device *dev)
 {
 	struct kvmppc_xive *xive = dev->private;
 	struct kvm *kvm = xive->kvm;
+	struct kvm_vcpu *vcpu;
 	int i;
 
+	/*
+	 * When destroying the VM, the vCPUs are destroyed first and
+	 * the vCPU list should be empty. If this is not the case,
+	 * then we are simply destroying the device and we should
+	 * clean up the vCPU interrupt presenters first.
+	 */
+	if (atomic_read(&kvm->online_vcpus) != 0) {
+		kvm_for_each_vcpu(i, vcpu, kvm)
+			kvmppc_xive_native_cleanup_vcpu(vcpu);
+	}
+
 	debugfs_remove(xive->dentry);
 
 	pr_devel("Destroying xive native device\n");
-- 
2.20.1

