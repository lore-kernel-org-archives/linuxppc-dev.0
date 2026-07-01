Return-Path: <linuxppc-dev+bounces-23243-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BDFC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 05:14:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqp9J6LQ0z2ygm;
	Wed, 01 Jul 2026 15:14:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782882884;
	cv=none; b=Hyy9ce4N2km0xY0UAnH940qRYl2N/3hLJmg7m0yev1AiNujgESVyZyw3XKwCUqAVpnpxc35YS2ewWgIYp3AEWS06ngU5Rf0ADyFdfcA0q01ITuuSq1hGH8pxCBQ5xyaPZPkjtgFY5FgZYJ1wxzRIvG6M8tViVld5uuEFn4mAt958vvJInzQf45blvxmx1c1PMjgk90Aju+iVo1pSKe5TCGomfE5WzEggj8ND+0xJrjDPp8l+3Y5wu+nr7IMdYQVEKl3UCuF4NMy1iR37GTJBlhIYSDUYjOlMrrL0WwmJM8q40qkQOELsijK8YZ48uMX8pk/qIbPD684wk7H5npm31Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782882884; c=relaxed/relaxed;
	bh=c6knvnfA5iL/1dPM5MgvBIT0GcCnHUPS6SefoNLC0Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kW0ReqVco/XyZdhWkfoXSyAXZwk1U33LxDyTlD6hxRdEEtYSK+HhetdxvqTDhS0g8BZGrJZ6XgPaxbflmJngK4VbSCE78Ku/Qf+M1s+etPbWHZxiX+Iwn/UYc6fTtZx8uKYgKAVIufi/ydOVXoJU/bF8U7/Xtd9UttY0yp13GScris255gtdPwvT+H/bQsySrba22M/C40FEqmrogMLFA5ksRqbSYXogiL9f0cKt48Mboqo5GMsedHlzbnZoz8hfKtdlc3MKhcFDAsHGXSV8RQCpgZm7jsHkVluBv3A9x6SWuBOQ0HELc+5xO4Q93ivBvMiXRO1m5j2/xy0CHtfruA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=k3onVI5w; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=k3onVI5w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqp9J0fV8z2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 15:14:43 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6613Ie3T3868033;
	Wed, 1 Jul 2026 05:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=c6knvnfA5iL/1dPM5
	MgvBIT0GcCnHUPS6SefoNLC0Cw=; b=k3onVI5wfHkvgXgmZC9PETHA/5b5Obnfw
	WVfhw4TKkqlvX77eyck0ioovI6dBCN5s6t2LqCtwURZGSMlkko0dK/rhzV5hDY95
	msfJmb2plkZeVNhv9BhQbn4mARV8xy0aEQbrkdMuOJHXpLVm/RIldfeUkwafT1BW
	tbMF5SR302+pDY7qa84ppI5PZaJl8W8KvN9Jhs+F85avELkSkCMqIpWz2Oiy8WzG
	oTyMGln0dN20FT/9RfXb7ODmlfbdre47Xbq+YpIFKCMbuTyLCS4pA/nW3bUgFlzj
	OBTD5CkwJi1kDbyyzCC1NQvBxNqgs4kiRVyZFtKqZweAKHcxcUyJQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5tn4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 05:14:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66154YWn027800;
	Wed, 1 Jul 2026 05:14:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gdk7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 05:14:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6615EU5G50397558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 05:14:30 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFE5020040;
	Wed,  1 Jul 2026 05:14:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 463F320049;
	Wed,  1 Jul 2026 05:14:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.211.190])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 05:14:26 +0000 (GMT)
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
        Shuah Khan <skhan@linuxfoundation.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v5 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
Date: Wed,  1 Jul 2026 10:44:06 +0530
Message-ID: <20260701051409.51820-2-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260701051409.51820-1-amachhiw@linux.ibm.com>
References: <20260701051409.51820-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA0NiBTYWx0ZWRfX2yxxItvD/m4h
 1/80vtRZWkRZRmxg1GLQSloGPxxTNMhXjmLvh5tfABltfPKHYIA/RVFqdJr8GhRJ6VihSVVr3Vx
 NUccrn2jzoSk3dXQN3I+bRW3EryNGvD6P0HRh2bgVJhckpnYARrhuLySoTyDbKLVDbtqUPg2tfn
 0v5uFruwdNOjwZ4PRZQOUBg0UmcMrGuvHrdIKrOqt2FcZee1WRIwl/ArTHoY+gHLtrsEavN/T9I
 118VWXO8pfZc7wlD/CY78MXatEDZQzOCJkRUw8vg9f35wAjRGgfc/+bwGdiPe3BgCfAWKTRy16G
 pZoYxUX0hz5TRsRRWZ3OmX9xHBXs2JeA4uiMuqs4sE/5H+IX4NjwKEhn9olrTYQwMtAAAqS3d5L
 LD1BDTVQjc+0xOy9/ILVdTbFjuJ5zKXzzO59XX3mqsgkB/DIacsAps446ANmK6OI5Sbj+VExzDP
 REUiUcoM3IP/6xsOkUw==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a44a23b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=JeXnUFxHR7YI7sCAd4sA:9
X-Proofpoint-ORIG-GUID: EQRoo642JErQbpOHcw6zQJTWl3qkNhy2
X-Proofpoint-GUID: nKZMGv-Uesoe8QaHTDZgtIrLtyNaanAT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA0NiBTYWx0ZWRfX/pp0RDCTzSkC
 42KAT8Hn+1BfnklLcb71Xqo4AG57IM9ifUBnU60nX+0KtsFrjgai92Em7RFeLGBNXUbuPkcAntx
 KVwdSFP29I6Fc9Gilb0YK9D/fYdqC/s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010046

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
implementation when available.

The struct kvm_ppc_compat_caps places the 'size' field first so it can
be read alone via get_user() before copy_struct_from_user() is called,
avoiding pointer arithmetic to locate the size field.

The ioctl is defined using _IO so the ioctl number remains stable even if
the struct grows in future versions. It uses copy_struct_from_user() and
copy_struct_to_user() to provide forward- and backward-compatible
extensibility: older userspace passing a smaller struct to a newer kernel
gets zero-padded trailing fields, while newer userspace passing a larger
struct to an older kernel (usize > ksize) gets sizeof(struct
kvm_ppc_compat_caps)written back to host_caps.size so it can retry with the
older kernel-supported size, after which the kernel returns -E2BIG.

KVM_PPC_COMPAT_CAPS_SIZE_VER0 is defined as a frozen integer constant
(24) marking the size of the initial struct version, used as the
minimum floor for size field validation, similar to other versioned
struct interfaces in the kernel.

The 'flags' field is reserved for future use. The kernel rejects any
call where flags is non-zero with -EINVAL, preventing garbage values
from being baked into ABI permanently.

The ioctl returns appropriate error codes: EINVAL for an invalid size
or non-zero reserved fields, E2BIG if new userspace provides a larger
struct than the kernel knows about (with ksize written back into
host_caps.size for the retry), EFAULT for failed copy operations, and
ENOTTY if the backend doesn't implement get_compat_caps.

Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes in this version:
  - Moved size as the first member of the struct
  - Replaced strict size equality check with copy_struct_from_user() and
    copy_struct_to_user() for proper forward and backward ABI compatibility
  - Added KVM_PPC_COMPAT_CAPS_SIZE_VER0 (24) as a frozen version floor
    constant, following the convention used by similar interfaces in the kernel
  - Added flags == 0 enforcement to prevent uninitialized stack values from
    being baked into ABI permanently

 arch/powerpc/include/asm/kvm_ppc.h  |  1 +
 arch/powerpc/include/uapi/asm/kvm.h |  8 ++++
 arch/powerpc/kvm/powerpc.c          | 71 +++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h            |  4 ++
 4 files changed, 84 insertions(+)

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
index 077c5437f521..19e53d5ae540 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -437,6 +437,14 @@ struct kvm_ppc_cpu_char {
 	__u64	behaviour_mask;		/* valid bits in behaviour */
 };
 
+/* For KVM_PPC_GET_COMPAT_CAPS */
+struct kvm_ppc_compat_caps {
+	__u64	size;			/* Size of this structure */
+	__u64	flags;			/* Reserved for future use */
+	__u64	compat_capabilities;	/* Capabilities supported by the host */
+};
+#define KVM_PPC_COMPAT_CAPS_SIZE_VER0	24 /* sizeof first published struct */
+
 /*
  * Values for character and character_mask.
  * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 98de68379b18..a2919b8b31c0 100644
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
@@ -2467,6 +2474,70 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		r = kvm->arch.kvm_ops->svm_off(kvm);
 		break;
 	}
+	case KVM_PPC_GET_COMPAT_CAPS: {
+		struct kvm_ppc_compat_caps host_caps = {};
+		u64 usize;
+
+		/*
+		 * Read the size field first to drive copy_struct_from_user.
+		 * size must be the first field of the struct.
+		 */
+		r = -EFAULT;
+		if (get_user(usize, (__u64 __user *)argp))
+			goto out;
+
+		/*
+		 * Enforce a minimum: reject buffers smaller than the initial
+		 * struct version (VER0). This allows old userspace compiled
+		 * against the original struct to still work on a newer kernel
+		 * that has grown the struct with appended fields.
+		 */
+		r = -EINVAL;
+		if (usize < KVM_PPC_COMPAT_CAPS_SIZE_VER0)
+			goto out;
+
+		/*
+		 * New userspace with a larger struct called an older kernel.
+		 * Write back ksize in host_caps.size so userspace knows which
+		 * older struct to retry with, then fail with -E2BIG.
+		 */
+		if (usize > sizeof(host_caps)) {
+			host_caps.size = sizeof(host_caps);
+			r = -EFAULT;
+			if (put_user(host_caps.size, (__u64 __user *)argp))
+				goto out;
+			r = -E2BIG;
+			goto out;
+		}
+
+		/*
+		 * copy_struct_from_user() handles forward/backward compat:
+		 *   usize == ksize: verbatim copy
+		 *   usize <  ksize: zero-pad trailing (old userspace, new kernel)
+		 */
+		r = copy_struct_from_user(&host_caps, sizeof(host_caps),
+					  argp, usize);
+		if (r)
+			goto out;
+
+		/* Reserved fields must be zero */
+		r = -EINVAL;
+		if (host_caps.flags)
+			goto out;
+
+		r = -ENOTTY;
+		if (!kvm->arch.kvm_ops->get_compat_caps)
+			goto out;
+
+		r = kvm->arch.kvm_ops->get_compat_caps(&host_caps);
+		if (r)
+			goto out;
+
+		host_caps.size = sizeof(host_caps);
+		r = copy_struct_to_user(argp, usize, &host_caps,
+					sizeof(host_caps), NULL);
+		break;
+	}
 	default: {
 		struct kvm *kvm = filp->private_data;
 		r = kvm->arch.kvm_ops->arch_vm_ioctl(filp, ioctl, arg);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 419011097fa8..1cf9a959669e 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -997,6 +997,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
 #define KVM_CAP_S390_HPAGE_2G 249
+#define KVM_CAP_PPC_COMPAT_CAPS 250
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1350,6 +1351,9 @@ struct kvm_s390_keyop {
 #define KVM_GET_DEVICE_ATTR	  _IOW(KVMIO,  0xe2, struct kvm_device_attr)
 #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct kvm_device_attr)
 
+/* Available with KVM_CAP_PPC_COMPAT_CAPS */
+#define KVM_PPC_GET_COMPAT_CAPS	_IO(KVMIO,  0xe4)
+
 /*
  * ioctls for vcpu fds
  */
-- 
2.50.1 (Apple Git-155)


