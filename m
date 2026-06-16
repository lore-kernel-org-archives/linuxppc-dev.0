Return-Path: <linuxppc-dev+bounces-22702-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5BFCD98E1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:35:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfmfX2LVdz3bt2;
	Tue, 16 Jun 2026 22:35:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781613316;
	cv=none; b=OIACi0cofLOKHtdy9rGO1O2h+f3m0Wiza64xRtesP5iINKJDH758OT/MuBZ40YQhogZFDzcRmVafyUqVF+GqD55WG/31qUuvO9frXOYFaET9yGNfULFHiSDY7blJP4KfOQ11qMUkzDlgdHc95tiz7MRuq5CGrfU6ZRJyE7RmD2HLHASyf2v8HOMxrXVkE4KWknFCuCxGOuWCK7G38LWdky6doLbOJigGy0rD2AxJcOSP5LV0jIpACqLVYi6fhLcSVwSOuX7MK+sa0GAmbwAQ3/Tm4M/6ZvwixTydcOuzYclE23PHBVVR5Ojwafkll/L7AhcSWOXznmPzael8X6PYEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781613316; c=relaxed/relaxed;
	bh=d01Jr+zIFxm9XBE6/u1GwbnVRdKFNo4Xn2vGSaz5Xec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Itas6GbPJpldEDjo6kvNWmUOSvvk8wWk0xquh9ieQoQqXsNmXBZPqCldAWVpawqXf2KDstBonoSouBisIA4dgqxe1U4LAbMFhXZakoWKSko4LiLlS9cNA05OHZJfJq8hKZG72GIsojcCdIZOYE/qTnqiKq7yw2u4vuYTskRLtox+D8HQkXLbA81GHT/7SEA26YDxLpYFQZ+tjYkpC2nX+pbX9cJbRR4kENnzvQnNlxWTe17DBVt+TtwYe83mba8FOlzWEE6JbWb7PDqTEP3dwWwqZLeQYkyqknrF9wV85oVuM+EKPZhC7M1tDaN6n4TNoOD2C/RWngOmVrUivhATFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AeUiq3b/; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AeUiq3b/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfmfW2zdGz3brH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 22:35:15 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAIoq81157025;
	Tue, 16 Jun 2026 12:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=d01Jr+zIFxm9XBE6/
	u1GwbnVRdKFNo4Xn2vGSaz5Xec=; b=AeUiq3b/vqc1STbwmeQx6gbJdNK4aFnU/
	4bIM0ACwmQlmAUqlrMYkge/7rCyut/3rP8x2EDblZN+jcbUrl0J5BaixP6V75xxl
	OZbSY2CibGPd3mh7dOr0fHlUEuVWJnhBbwkuTU8g4FKFaY8yguKEbo7GSrVunsIX
	1W+zTTGaa7zemsjjK2xBVqyZHxMovYzxE8Z54cmPnRs2nXl4sOBJVG6Z2JgZJ7lv
	JQoKiGyjla1uU9SFS9vumfqKK2NxugixFsBvMwi3KkXUfu0usfGWwR+BLdMA1YwL
	YVZYxkIbDb1Blqhqet9ZBMbvC+3e6YLb0KGikjDM5htB2Rpmr7JlA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1eg52pv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:35:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GCYhxA010657;
	Tue, 16 Jun 2026 12:35:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esk1h37jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:35:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GCYwYq30933356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 12:34:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A1D22004D;
	Tue, 16 Jun 2026 12:34:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 898752004B;
	Tue, 16 Jun 2026 12:34:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.31.150])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 12:34:54 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lkp@intel.com
Subject: [PATCH v4 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
Date: Tue, 16 Jun 2026 18:03:11 +0530
Message-ID: <20260616123314.82721-2-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260616123314.82721-1-amachhiw@linux.ibm.com>
References: <20260616123314.82721-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEyNSBTYWx0ZWRfXwSAaDJLHZohm
 Oc0p2TmaxyVjTDuI+lXC3Y0jaDE/1evj8SlTaBVMuxbYd6S9UAlpOrJbXHGyWS5EQyVOBa8kymW
 8zPHeQrA1C2wiUaUAF05wfYuI1M4DQ0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEyNSBTYWx0ZWRfX0Xp4T/B9ItYT
 DX5f+8pOoBdvyaXhOdrwulNdZe+VlY5c9wLHoRF7TXNZr9AzoM6bITfvOmd9YNMt3067PNZlcFF
 c5vcT2bagGrkG5C0H01l8USwLIeCnWekIy7TQnogeGAMIh6vhepVzjbCeNkg3fyk0fMaVT4jRtI
 nddvW6R2HtAef2JVNmUWrcc67fq9/X6TNrmxYjykjo6QAeHWWVWgfsox08YM9d55jJvV+vZBYzy
 jc7CbSwZqagJMni20S+esJQUGn/QU2VUpHTzRs/slTInznTJtqk08YMM2fhmzCQdBPcNUkDgFWl
 kHgXdIiZnZ6a61WKDO+k2Imr3WXHZ/hXohirjj69frNbC6MZGInhEHKEdF0l+4CeOfNkWvggA7y
 IUgYG+VyU564HWEv5JzZCAe23k7O7kxUxQ3L0ycLKpO3pzBD96gSMYNpinNMVix+19aYYqDpSN8
 ikCnqE8oWTuL6jZxflw==
X-Proofpoint-GUID: iB1oMBoD6w7QdQ2huzdQyDrOGH8VtaXC
X-Authority-Analysis: v=2.4 cv=NuDhtcdJ c=1 sm=1 tr=0 ts=6a3142f7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=ZcW8PA29WFY-58e7T6MA:9
X-Proofpoint-ORIG-GUID: ZI2vAO0opOWNQymFbbNAm29FPH4irg-n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160125

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
implementation when available. The implementation validates the structure
size from userspace to ensure forward compatibility and returns
appropriate error codes (EINVAL for invalid size, EFAULT for copy
failures, ENOTTY if backend is not implemented). The struct
kvm_ppc_compat_caps includes a size field to support future ABI
extensions.

Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 arch/powerpc/include/asm/kvm_ppc.h  |  1 +
 arch/powerpc/include/uapi/asm/kvm.h |  7 ++++++
 arch/powerpc/kvm/powerpc.c          | 35 +++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h            |  4 ++++
 4 files changed, 47 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 0953f2daa466..169ea6a7fbad 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -319,6 +319,7 @@ struct kvmppc_ops {
 	bool (*hash_v3_possible)(void);
 	int (*create_vm_debugfs)(struct kvm *kvm);
 	int (*create_vcpu_debugfs)(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry);
+	int (*get_compat_caps)(struct kvm_ppc_compat_caps *host_caps);
 };
 
 extern struct kvmppc_ops *kvmppc_hv_ops;
diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 077c5437f521..8a38be6c3b03 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -437,6 +437,13 @@ struct kvm_ppc_cpu_char {
 	__u64	behaviour_mask;		/* valid bits in behaviour */
 };
 
+/* For KVM_PPC_GET_COMPAT_CAPS */
+struct kvm_ppc_compat_caps {
+	__u64	flags;			/* Reserved for future use */
+	__u64	size;			/* Size of this structure */
+	__u64	compat_capabilities;	/* Capabilities supported by the host */
+};
+
 /*
  * Values for character and character_mask.
  * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 98de68379b18..9153b0034b45 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -701,6 +701,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
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
@@ -2467,6 +2474,34 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		r = kvm->arch.kvm_ops->svm_off(kvm);
 		break;
 	}
+	case KVM_PPC_GET_COMPAT_CAPS: {
+		struct kvm_ppc_compat_caps host_caps;
+		u64 user_size;
+
+		r = -EFAULT;
+		/* First, get the size field from userspace to validate */
+		if (copy_from_user(&user_size, &((struct kvm_ppc_compat_caps
+		     __user *)argp)->size, sizeof(user_size))) {
+			goto out;
+		}
+
+		/* Validate size - must be at least the current structure size */
+		r = -EINVAL;
+		if (user_size < sizeof(host_caps))
+			goto out;
+
+		r = -ENOTTY;
+		memset(&host_caps, 0, sizeof(host_caps));
+		if (!kvm->arch.kvm_ops->get_compat_caps)
+			goto out;
+
+		r = kvm->arch.kvm_ops->get_compat_caps(&host_caps);
+		/* Set the actual size of the structure we're returning */
+		host_caps.size = sizeof(host_caps);
+		if (!r && copy_to_user(argp, &host_caps, sizeof(host_caps)))
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


