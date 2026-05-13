Return-Path: <linuxppc-dev+bounces-20845-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564EECD4F24
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 10:08:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFq1L0NMLz2xvH;
	Wed, 13 May 2026 20:08:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778666934;
	cv=none; b=QowoH4nLdNHb2/OcbtvTSuAhbKvPJSVxg3f5jjhPUY2ZdfMZk1W6m35UavtyvbhIrtNguGbHVVza4MU3vnWsSnI69NkVj09v9nsCXC+UKna4y3GuFrmgglE2M71mJXGoZFEBX6bKUZN50zFafln9hGeE8ICU1H13Gi19s2XYSLfR5EsVFm0iVTtBtNCnkNaoSPg4XhxERN5cDDNeOVhUsQx+tOJZGCVD/tAefbZMNIMckIABxkWWoer2yDZFaYs3P7C8epkJ9dBqrNzWwP/5RtKncC5E5H0Zs18WmEii5yYhMrJh4oTmpjf6EJ8Ho8NivWQtrAsFXdX/659recRDMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778666934; c=relaxed/relaxed;
	bh=/Ue2spGrn56X4TfU8hYc54q9HRRp5buBXeXnKQKtLZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8yoEF24fOMU8/8ax+S3dg1p/Yp5oIQkNtRsdmWvGztj9RZz5JDpeuAvk8O3vMJ8nmHiRdjGSPIv2tyDOnAAuSxvZWD7m/6hKR8e1ZGn1quRun0Zjyroe40hlKbJemurlxIUqWfWMRie2MXSYnL+lzAAPBSpe6mQcwCHp6knNsLFqxUt3vcfERPGUfH0ocWRby5ShfilMjkwNQ2gV/pFC4VsKTZ9LTc3t88vqc8ovX8i9QvTADUlFl6Ar4okV/O7sshcelEJ4q7VPfvYARsrH/+07vmEBJABAVeBvUMz+xRxqqFULtjUF9arLxjhortoAGcYo8XoJzjHIijBhaHrow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Jaiefri1; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Jaiefri1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFq1K1WnJz2xn3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 20:08:52 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D20gKY2761190;
	Wed, 13 May 2026 10:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/Ue2spGrn56X4TfU8
	hYc54q9HRRp5buBXeXnKQKtLZY=; b=Jaiefri1dF3CzN92AMaIMz+UEJaqCbRLm
	SBM3vNhUBPVfQVI50lt/+4nIODa9YKlApptnW4Cu381vqmnP7LbdmeLW2fNrFg0b
	S4M6s3ynbgIOEjsBdmbKNJZx7Np4BJQc03wen5wYdah/rkyNyags2vtSKfhLwRAK
	jVbMWyfX83w/k/U+vQp1rVYegnnqBwKBqya9IBeYijMCIxOV6H1n2HvGes9/3DaN
	0GBhVLeziJbiKh4gA69V65mnZ/khbppafqINBscgZ2o9t4eUWBEZ2qqG5CVWtfVu
	Vvo2Y6QKU7fOyjIRLzM6Q6Hz8qGcHx5OlUV36I+Dv/SAdUQC7S4Sw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6pupr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 10:08:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64D9sQ5J017710;
	Wed, 13 May 2026 10:08:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgq7tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 10:08:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64DA8Vt945547818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 10:08:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA1702004F;
	Wed, 13 May 2026 10:08:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E01EE20065;
	Wed, 13 May 2026 10:08:29 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.0.51])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2026 10:08:29 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
Date: Wed, 13 May 2026 15:37:51 +0530
Message-ID: <20260513100755.83215-3-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513100755.83215-1-amachhiw@linux.ibm.com>
References: <20260513100755.83215-1-amachhiw@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: FzB0T6nTlJjdFQqILFNtle6O10i1NPfd
X-Proofpoint-GUID: ksypFeiv_aU8udWo87-lkGi2QUEoqOXK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDEwNSBTYWx0ZWRfX4l5KJ8UJ/Rg1
 HK8mZAuyeLQQpEG52jhVErEXjWypQS2iAVCGLbQiRwlK2rhs5aCiuzJytn1jJYlvB4FWMjz6JuL
 etVC0qZFEDJfgNjdXNG4eG/rptdLWXL1O7o0WQjR6DwybaCxqlsDpptc78485HlRHyEt9IbMblb
 jA2ftjnPSaXd0Hbgukx+BKWwudhD8GsEnL9AMXkJFud4va601U6T9JW/B5oGi6Awk3gf/owdQsz
 mOGwl95TFQPuJY60OyllN62AgMB7jEcQcmsEbNZHOSuOYe9XOQyNM3HnI+GCMF0irLER8TF2/lO
 /F803oC84fi91jZBooCXMv5OYMympg0nKeCLpy9e/tQl3y5z4t3XWP5NRzMzNOf4NzLHKfLd78a
 Kqhd/1c+7eZ5+4VCpJ0PJibVnJi5Is1ojurTOlSuj51suJK7v8FqSlMMbCvMO54uMiJEc8O66/B
 sRh9dftSVMRmoCkl8vg==
X-Authority-Analysis: v=2.4 cv=P8UKQCAu c=1 sm=1 tr=0 ts=6a044da4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=D7P34WnVX5hk26v0a_EA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130105

Introduce a new capability and ioctl to expose CPU compatibility modes
supported by the host processor for nested guests.

On IBM POWER systems, newer processor generations (N) can operate in
compatibility modes corresponding to earlier generations, like (N-1) and
(N-2). This is particularly relevant for nested virtualization, where
nested KVM guests may need to run with a specific processor compatibility
level.

Introduce KVM_CAP_PPC_COMPAT_CAPS capability and the corresponding
KVM_PPC_GET_COMPAT_CAPS vm ioctl. The ioctl returns a bitmap describing
the compatibility modes supported by the host in respective bit numbers,
allowing userspace (e.g., QEMU) to select an appropriate compatibility
level when configuring nested KVM guests.

The ioctl handling is added in kvm_arch_vm_ioctl() and retrieves host
CPU compatibility capabilities via a PowerPC-specific backend
implementation when available. If the capability is not supported, the
ioctl returns success with no capabilities set, allowing userspace to
fall back gracefully.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 arch/powerpc/include/asm/kvm_ppc.h  |  1 +
 arch/powerpc/include/uapi/asm/kvm.h |  6 ++++++
 arch/powerpc/kvm/powerpc.c          | 21 +++++++++++++++++++++
 include/uapi/linux/kvm.h            |  4 ++++
 4 files changed, 32 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 0953f2daa466..cadfb839e836 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -319,6 +319,7 @@ struct kvmppc_ops {
 	bool (*hash_v3_possible)(void);
 	int (*create_vm_debugfs)(struct kvm *kvm);
 	int (*create_vcpu_debugfs)(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry);
+	int (*get_compat_cpu_ver)(struct kvm_ppc_compat_caps *host_caps);
 };
 
 extern struct kvmppc_ops *kvmppc_hv_ops;
diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 077c5437f521..081d6c7f7f70 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -437,6 +437,12 @@ struct kvm_ppc_cpu_char {
 	__u64	behaviour_mask;		/* valid bits in behaviour */
 };
 
+/* For KVM_PPC_GET_COMPAT_CAPS */
+struct kvm_ppc_compat_caps {
+	__u64	flags;			/* Reserved for future use */
+	__u64	compat_capabilities;	/* Capabilities supported by the host */
+};
+
 /*
  * Values for character and character_mask.
  * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 00302399fc37..91a0228942e1 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -697,6 +697,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 			}
 		}
 		break;
+#if defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE)
+	case KVM_CAP_PPC_COMPAT_CAPS:
+		r = 0;
+		if (kvmhv_on_pseries())
+			r = 1;
+		break;
+#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 	default:
 		r = 0;
 		break;
@@ -2463,6 +2470,20 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		r = kvm->arch.kvm_ops->svm_off(kvm);
 		break;
 	}
+	case KVM_PPC_GET_COMPAT_CAPS: {
+		struct kvm_ppc_compat_caps host_caps;
+
+		r = 0;
+		memset(&host_caps, 0, sizeof(host_caps));
+		if (!kvm->arch.kvm_ops->get_compat_cpu_ver)
+			goto out;
+
+		r = kvm->arch.kvm_ops->get_compat_cpu_ver(&host_caps);
+		if (!r && copy_to_user(argp, &host_caps,
+				     sizeof(host_caps)))
+			r = -EFAULT;
+		break;
+	}
 	default: {
 		struct kvm *kvm = filp->private_data;
 		r = kvm->arch.kvm_ops->arch_vm_ioctl(filp, ioctl, arg);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 6c8afa2047bf..1788a0068662 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -996,6 +996,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_USER_OPEREXEC 246
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
+#define KVM_CAP_PPC_COMPAT_CAPS 249
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1349,6 +1350,9 @@ struct kvm_s390_keyop {
 #define KVM_GET_DEVICE_ATTR	  _IOW(KVMIO,  0xe2, struct kvm_device_attr)
 #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct kvm_device_attr)
 
+/* Available with KVM_CAP_PPC_COMPAT_CAPS */
+#define KVM_PPC_GET_COMPAT_CAPS	_IOR(KVMIO,  0xe4, struct kvm_ppc_compat_caps)
+
 /*
  * ioctls for vcpu fds
  */
-- 
2.50.1 (Apple Git-155)


