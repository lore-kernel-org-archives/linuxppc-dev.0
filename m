Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA2DC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:56:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B4362075C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4362075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445VDC6HMYzDqCT
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 22:56:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445Td45gfLzDqWS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 22:29:12 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1MBOfbd080114
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:29:07 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qtevq48rk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:29:06 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@kaod.org>;
 Fri, 22 Feb 2019 11:29:04 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Feb 2019 11:29:00 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1MBSxF648758846
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Feb 2019 11:28:59 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CE274C050;
 Fri, 22 Feb 2019 11:28:59 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C8784C04E;
 Fri, 22 Feb 2019 11:28:59 +0000 (GMT)
Received: from smtp.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.1])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 22 Feb 2019 11:28:59 +0000 (GMT)
Received: from zorba.kaod.org.com (sig-9-145-77-130.uk.ibm.com [9.145.77.130])
 by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id
 97ACC22026B; Fri, 22 Feb 2019 12:28:58 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v2 16/16] KVM: PPC: Book3S HV: XIVE: clear the vCPU interrupt
 presenters
Date: Fri, 22 Feb 2019 12:28:40 +0100
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222112840.25000-1-clg@kaod.org>
References: <20190222112840.25000-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022211-0016-0000-0000-0000025996BF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022211-0017-0000-0000-000032B3EB33
Message-Id: <20190222112840.25000-17-clg@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-22_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=602 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902220081
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

When using the KVM device, there is still a race window with the early
checks in kvmppc_native_connect_vcpu(). Yet to be fixed.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/kvm/book3s_xics.c        | 19 +++++++++++++
 arch/powerpc/kvm/book3s_xive.c        | 39 +++++++++++++++++++++++++--
 arch/powerpc/kvm/book3s_xive_native.c | 16 +++++++++++
 3 files changed, 72 insertions(+), 2 deletions(-)

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
index 7a14512b8944..0a1c11d6881c 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -1105,11 +1105,19 @@ void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu)
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
@@ -1146,6 +1154,10 @@ void kvmppc_xive_cleanup_vcpu(struct kvm_vcpu *vcpu)
 	}
 	/* Free the VP */
 	kfree(xc);
+
+	/* Cleanup the vcpu */
+	vcpu->arch.irq_type = KVMPPC_IRQ_DEFAULT;
+	vcpu->arch.xive_vcpu = NULL;
 }
 
 int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
@@ -1163,7 +1175,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
 	}
 	if (xive->kvm != vcpu->kvm)
 		return -EPERM;
-	if (vcpu->arch.irq_type)
+	if (vcpu->arch.irq_type != KVMPPC_IRQ_DEFAULT)
 		return -EBUSY;
 	if (kvmppc_xive_find_server(vcpu->kvm, cpu)) {
 		pr_devel("Duplicate !\n");
@@ -1833,8 +1845,31 @@ static void kvmppc_xive_free(struct kvm_device *dev)
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
index bf60870144f1..c0655164d9af 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -909,8 +909,24 @@ static void kvmppc_xive_native_free(struct kvm_device *dev)
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
+		 * TODO: There is still a race window with the early
+		 * checks in kvmppc_xive_native_connect_vcpu()
+		 */
+		kvm_for_each_vcpu(i, vcpu, kvm)
+			kvmppc_xive_native_cleanup_vcpu(vcpu);
+	}
+
 	debugfs_remove(xive->dentry);
 
 	pr_devel("Destroying xive native device\n");
-- 
2.20.1

