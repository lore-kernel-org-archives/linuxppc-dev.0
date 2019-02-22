Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315D2C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:54:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0FC4206DD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0FC4206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445V9q5t5HzDq8t
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 22:54:07 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 445Td35TbWzDqWT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 22:29:11 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1MBOG7L127850
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:29:05 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qtf66364s-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:29:05 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@kaod.org>;
 Fri, 22 Feb 2019 11:29:02 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Feb 2019 11:28:59 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1MBSw0p55509188
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Feb 2019 11:28:58 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0C9DA405C;
 Fri, 22 Feb 2019 11:28:58 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F884A4054;
 Fri, 22 Feb 2019 11:28:58 +0000 (GMT)
Received: from smtp.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.1])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 22 Feb 2019 11:28:58 +0000 (GMT)
Received: from zorba.kaod.org.com (sig-9-145-77-130.uk.ibm.com [9.145.77.130])
 by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id
 DC477220296; Fri, 22 Feb 2019 12:28:57 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v2 15/16] KVM: introduce a KVM_DESTROY_DEVICE ioctl
Date: Fri, 22 Feb 2019 12:28:39 +0100
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222112840.25000-1-clg@kaod.org>
References: <20190222112840.25000-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022211-0028-0000-0000-0000034BB555
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022211-0029-0000-0000-00002409FDC8
Message-Id: <20190222112840.25000-16-clg@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-22_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=691 adultscore=0 classifier=spam adjust=0 reason=mlx
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

The 'destroy' method is currently used to destroy all devices when the
VM is destroyed after the vCPUs have been freed.

This new KVM ioctl exposes the same KVM device method. It acts as a
software reset of the VM to 'destroy' selected devices when necessary
and perform the required cleanups on the vCPUs. Called with the
kvm->lock.

The 'destroy' method could be improved by returning an error code.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/uapi/linux/kvm.h          |  7 ++++++
 virt/kvm/kvm_main.c               | 38 +++++++++++++++++++++++++++++++
 Documentation/virtual/kvm/api.txt | 19 ++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 52bf74a1616e..d78fafa54274 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1183,6 +1183,11 @@ struct kvm_create_device {
 	__u32	flags;	/* in: KVM_CREATE_DEVICE_xxx */
 };
 
+struct kvm_destroy_device {
+	__u32	fd;	/* in: device handle */
+	__u32	flags;	/* in: unused */
+};
+
 struct kvm_device_attr {
 	__u32	flags;		/* no flags currently defined */
 	__u32	group;		/* device-defined */
@@ -1331,6 +1336,8 @@ struct kvm_s390_ucas_mapping {
 #define KVM_GET_DEVICE_ATTR	  _IOW(KVMIO,  0xe2, struct kvm_device_attr)
 #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct kvm_device_attr)
 
+#define KVM_DESTROY_DEVICE	  _IOWR(KVMIO,  0xf0, struct kvm_destroy_device)
+
 /*
  * ioctls for vcpu fds
  */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 84717d8cb5e4..983d5c37f710 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3026,6 +3026,30 @@ static int kvm_ioctl_create_device(struct kvm *kvm,
 	return 0;
 }
 
+static int kvm_ioctl_destroy_device(struct kvm *kvm,
+				    struct kvm_destroy_device *dd)
+{
+	struct fd f;
+	struct kvm_device *dev;
+
+	f = fdget(dd->fd);
+	if (!f.file)
+		return -EBADF;
+
+	dev = kvm_device_from_filp(f.file);
+	fdput(f);
+
+	if (!dev)
+		return -ENODEV;
+
+	mutex_lock(&kvm->lock);
+	list_del(&dev->vm_node);
+	dev->ops->destroy(dev);
+	mutex_unlock(&kvm->lock);
+
+	return 0;
+}
+
 static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 {
 	switch (arg) {
@@ -3270,6 +3294,20 @@ static long kvm_vm_ioctl(struct file *filp,
 		r = 0;
 		break;
 	}
+	case KVM_DESTROY_DEVICE: {
+		struct kvm_destroy_device dd;
+
+		r = -EFAULT;
+		if (copy_from_user(&dd, argp, sizeof(dd)))
+			goto out;
+
+		r = kvm_ioctl_destroy_device(kvm, &dd);
+		if (r)
+			goto out;
+
+		r = 0;
+		break;
+	}
 	case KVM_CHECK_EXTENSION:
 		r = kvm_vm_ioctl_check_extension_generic(kvm, arg);
 		break;
diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 1db1435769b4..c2ba18279298 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -3857,6 +3857,25 @@ number of valid entries in the 'entries' array, which is then filled.
 'index' and 'flags' fields in 'struct kvm_cpuid_entry2' are currently reserved,
 userspace should not expect to get any particular value there.
 
+4.119 KVM_DESTROY_DEVICE
+
+Capability: KVM_CAP_DEVICE_CTRL
+Type: vm ioctl
+Parameters: struct kvm_destroy_device (in)
+Returns: 0 on success, -1 on error
+Errors:
+  ENODEV: The device type is unknown or unsupported
+
+  Other error conditions may be defined by individual device types or
+  have their standard meanings.
+
+Destroys an emulated device in the kernel.
+
+struct kvm_destroy_device {
+	__u32	fd;	/* in: device handle */
+	__u32	flags;	/* unused */
+};
+
 5. The kvm_run structure
 ------------------------
 
-- 
2.20.1

