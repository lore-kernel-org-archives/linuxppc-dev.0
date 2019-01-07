Return-Path: <SRS0=vpml=PP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431A2C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 19:24:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B84206B7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 19:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B84206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YQM93zL5zDqML
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 06:24:53 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YQ2X1SWfzDqPc
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 06:10:27 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x07J3k3O145915
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Jan 2019 14:10:25 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pvawpe5j0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Jan 2019 14:10:25 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@kaod.org>;
 Mon, 7 Jan 2019 19:10:23 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 7 Jan 2019 19:10:20 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x07JAJ7R56426572
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 7 Jan 2019 19:10:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3455DA4055;
 Mon,  7 Jan 2019 19:10:19 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 180A4A4053;
 Mon,  7 Jan 2019 19:10:19 +0000 (GMT)
Received: from smtp.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.1])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  7 Jan 2019 19:10:19 +0000 (GMT)
Received: from zorba.kaod.org.com (sig-9-145-153-156.de.ibm.com
 [9.145.153.156])
 by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id 54B022201CD;
 Mon,  7 Jan 2019 20:10:18 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 19/19] KVM: introduce a KVM_DELETE_DEVICE ioctl
Date: Mon,  7 Jan 2019 20:10:06 +0100
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107191006.10648-1-clg@kaod.org>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107191006.10648-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19010719-0020-0000-0000-000003028B96
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010719-0021-0000-0000-0000215399A3
Message-Id: <20190107191006.10648-3-clg@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-07_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901070160
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

This will be used to destroy the KVM XICS or XIVE device when the
sPAPR machine is reseted. When the VM boots, the CAS negotiation
process will determine which interrupt mode to use and the appropriate
KVM device will then be created.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/linux/kvm_host.h              |  2 ++
 include/uapi/linux/kvm.h              |  2 ++
 arch/powerpc/kvm/book3s_xive.c        | 38 +++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_xive_native.c | 24 +++++++++++++++++
 virt/kvm/kvm_main.c                   | 39 +++++++++++++++++++++++++++
 5 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c38cc5eb7e73..259b6885dc74 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1218,6 +1218,8 @@ struct kvm_device_ops {
 	 */
 	void (*destroy)(struct kvm_device *dev);
 
+	int (*delete)(struct kvm_device *dev);
+
 	int (*set_attr)(struct kvm_device *dev, struct kvm_device_attr *attr);
 	int (*get_attr)(struct kvm_device *dev, struct kvm_device_attr *attr);
 	int (*has_attr)(struct kvm_device *dev, struct kvm_device_attr *attr);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 52bf74a1616e..b00cb4d986cf 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1331,6 +1331,8 @@ struct kvm_s390_ucas_mapping {
 #define KVM_GET_DEVICE_ATTR	  _IOW(KVMIO,  0xe2, struct kvm_device_attr)
 #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct kvm_device_attr)
 
+#define KVM_DELETE_DEVICE	  _IOWR(KVMIO,  0xf0, struct kvm_create_device)
+
 /*
  * ioctls for vcpu fds
  */
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 9b4751713554..5449fb4c87f9 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -1109,11 +1109,19 @@ void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu)
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
@@ -1150,6 +1158,10 @@ void kvmppc_xive_cleanup_vcpu(struct kvm_vcpu *vcpu)
 	}
 	/* Free the VP */
 	kfree(xc);
+
+	/* Cleanup the vcpu */
+	vcpu->arch.irq_type = KVMPPC_IRQ_DEFAULT;
+	vcpu->arch.xive_vcpu = NULL;
 }
 
 int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
@@ -1861,6 +1873,29 @@ static void kvmppc_xive_free(struct kvm_device *dev)
 	kfree(dev);
 }
 
+static int kvmppc_xive_delete(struct kvm_device *dev)
+{
+	struct kvm *kvm = dev->kvm;
+	unsigned int i;
+	struct kvm_vcpu *vcpu;
+
+	if (!kvm->arch.xive)
+		return -EPERM;
+
+	/*
+	 * call kick_all_cpus_sync() to ensure that all CPUs have
+	 * executed any pending interrupts
+	 */
+	if (is_kvmppc_hv_enabled(kvm))
+		kick_all_cpus_sync();
+
+	kvm_for_each_vcpu(i, vcpu, kvm)
+		kvmppc_xive_cleanup_vcpu(vcpu);
+
+	kvmppc_xive_free(dev);
+	return 0;
+}
+
 static int kvmppc_xive_create(struct kvm_device *dev, u32 type)
 {
 	struct kvmppc_xive *xive;
@@ -2035,6 +2070,7 @@ struct kvm_device_ops kvm_xive_ops = {
 	.create = kvmppc_xive_create,
 	.init = kvmppc_xive_init,
 	.destroy = kvmppc_xive_free,
+	.delete = kvmppc_xive_delete,
 	.set_attr = xive_set_attr,
 	.get_attr = xive_get_attr,
 	.has_attr = xive_has_attr,
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index 12edac29995e..7367962e670a 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -979,6 +979,29 @@ static void kvmppc_xive_native_free(struct kvm_device *dev)
 	kfree(dev);
 }
 
+static int kvmppc_xive_native_delete(struct kvm_device *dev)
+{
+	struct kvm *kvm = dev->kvm;
+	unsigned int i;
+	struct kvm_vcpu *vcpu;
+
+	if (!kvm->arch.xive)
+		return -EPERM;
+
+	/*
+	 * call kick_all_cpus_sync() to ensure that all CPUs have
+	 * executed any pending interrupts
+	 */
+	if (is_kvmppc_hv_enabled(kvm))
+		kick_all_cpus_sync();
+
+	kvm_for_each_vcpu(i, vcpu, kvm)
+		kvmppc_xive_native_cleanup_vcpu(vcpu);
+
+	kvmppc_xive_native_free(dev);
+	return 0;
+}
+
 /*
  * ESB MMIO address of chip 0
  */
@@ -1350,6 +1373,7 @@ struct kvm_device_ops kvm_xive_native_ops = {
 	.create = kvmppc_xive_native_create,
 	.init = kvmppc_xive_native_init,
 	.destroy = kvmppc_xive_native_free,
+	.delete = kvmppc_xive_native_delete,
 	.set_attr = kvmppc_xive_native_set_attr,
 	.get_attr = kvmppc_xive_native_get_attr,
 	.has_attr = kvmppc_xive_native_has_attr,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1f888a103f78..c93c35c43675 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3009,6 +3009,31 @@ static int kvm_ioctl_create_device(struct kvm *kvm,
 	return 0;
 }
 
+static int kvm_ioctl_delete_device(struct kvm *kvm,
+				   struct kvm_create_device *cd)
+{
+	struct fd f;
+	struct kvm_device *dev;
+	int ret;
+
+	f = fdget(cd->fd);
+	if (!f.file)
+		return -EBADF;
+
+	dev = kvm_device_from_filp(f.file);
+	fdput(f);
+
+	if (!dev)
+		return -EPERM;
+
+	mutex_lock(&kvm->lock);
+	list_del(&dev->vm_node);
+	mutex_unlock(&kvm->lock);
+	ret = dev->ops->delete(dev);
+
+	return ret;
+}
+
 static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 {
 	switch (arg) {
@@ -3253,6 +3278,20 @@ static long kvm_vm_ioctl(struct file *filp,
 		r = 0;
 		break;
 	}
+	case KVM_DELETE_DEVICE: {
+		struct kvm_create_device cd;
+
+		r = -EFAULT;
+		if (copy_from_user(&cd, argp, sizeof(cd)))
+			goto out;
+
+		r = kvm_ioctl_delete_device(kvm, &cd);
+		if (r)
+			goto out;
+
+		r = 0;
+		break;
+	}
 	case KVM_CHECK_EXTENSION:
 		r = kvm_vm_ioctl_check_extension_generic(kvm, arg);
 		break;
-- 
2.20.1

