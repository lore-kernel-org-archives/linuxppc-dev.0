Return-Path: <linuxppc-dev+bounces-25645-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC28C55174
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2026 16:12:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hHQyf1n1Zz2yll;
	Sun, 09 Aug 2026 02:12:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786205546;
	cv=none; b=VJVSN8N8pjySu3Xw+Ykmk4OWhKWZrvR5NI6mYMCsjWkqXVUht5UAXpJiei9txLhdfpJFdGNfO5YqHmZxCfsUGvjs/8UfMgQqgw+2jNMYPKSl2IVnnmgMN9n37Z/6NjeQSuemrd0XkCdtOaPjEbTYayDA1Vg8/TepXnQYE/bfd34QRbZ+uxTUr2qcNuPCaL8t5YpyISWvrKdvb1tFtKhV7xIls2dHyqXnz+hMCLvjgwa6D774qYHdOEknwIa8y/WNaHRLbf3uVLdbNk+e8flv4jyxydLSsvH4ZBLQ7eXNkcwJTzymtC8tYy2IcvtltCEZaC/vtgFsrDCJsEp1MLBvBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786205546; c=relaxed/relaxed;
	bh=56mbsJmtqmy/6GZvl8Gn67gvMFzrx22mXIbhqmxFqOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9U60wFx+DPkYhh9ActQLcum/GtGa38F88nSFfDpNmA6IBmZ3xPWEP9XHKZS9NxiP2qTR6ym5ZaqWbItN6AKzSzrEp37Ik84ek6PwmeQEdfVvLcAfcloGIiGAO7TL1x4tUnh/qBhqgUYIKUTSwImQcsmqgq+BFhDsiJVYDmU9vfB/vtYHQN04EJ2ufWLPiSuM6XrGMG0HbpFQHopQ24ef9P+A6zSUMsa0CduoxbzxSfA0GbbaJ27qfy+NoILg/VWxnuithKOuhJgMzpNndEB4CFDUcZ62bW8RfgR/ztqmPpcnacdxZYgU3IXsuRq9CHC9MrRXdeqXA8Xog2YZAtdHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BM3hQbnX; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BM3hQbnX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hHQyd0xQBz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Aug 2026 02:12:24 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 678E2A6S259720;
	Sat, 8 Aug 2026 16:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=56mbsJmtqmy/6GZvl
	8Gn67gvMFzrx22mXIbhqmxFqOw=; b=BM3hQbnXqsvPH8ZEq2QGx20tHTAQ00M3M
	4mVyV4ynWuXvKDXvCpGtMISd3fDIR6HjEmTlpRSRxjNyGkXJQft74px/GX5EYasu
	MN4zqKOpnuT1fDxEemsbhL8qEOXs6mmHfzMgVM7PHssbsULNcLHGsVXJl2SowOQ1
	qbtgx315ZgfwC9tbKXw4DkCGdsRPfOh/SLFWLxWzX9sY0MievAcXbXXhN0iPwrGV
	UH1xPR336n9LKjlyPXP3wQJS6SqYvEbXCfmfB6kcqsmyIsRxZAmEA4tPH46QupEL
	OZEHP4SQPz3XQhgwST25m6UHfoht0P/8a2TFZbBKEPLLUxht7hc5w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvkchh44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 16:12:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 678GBG1d015185;
	Sat, 8 Aug 2026 16:12:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhuvuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 16:12:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 678GC8Rl28115390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Aug 2026 16:12:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D43B220043;
	Sat,  8 Aug 2026 16:12:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07C9D20040;
	Sat,  8 Aug 2026 16:12:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.213.63])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  8 Aug 2026 16:12:04 +0000 (GMT)
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
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Gautam Menghani <gautam@linux.ibm.com>
Subject: [PATCH v9 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
Date: Sat,  8 Aug 2026 21:41:45 +0530
Message-ID: <20260808161148.66673-2-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260808161148.66673-1-amachhiw@linux.ibm.com>
References: <20260808161148.66673-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-GUID: O1o0nyjWLggnEO-jipgUopbzYHUQ_01W
X-Authority-Analysis: v=2.4 cv=J86aKgnS c=1 sm=1 tr=0 ts=6a77555e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=ETYFO_97Qo2pusGNp_0A:9
X-Proofpoint-ORIG-GUID: HA7DU7A_yCku5bpWKxzQGhUfyhTJTFBy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDEzNyBTYWx0ZWRfX2MzLawupy+Dz
 ZWugiyjBiokFqSEFpyH6HSCbOBn6JVKpDUuGgB3yZj8ZWEAqM+wWLg6YJhy7lk0nm3XGFQq4x9f
 CYce2wZapkCJxOFyHz44LPJs7BIgoW8S+GhJl04jBDqIt0aE68hZStqBQWAnIcnLoGPX0SaOuqE
 K+8Xolv9enrOD9ys5hvJMYD3FBLgpY076qwEhXBufXlTIMwl8nW5yt34+qb9SCooCduIfFlakxb
 BSA48jI+7akQfnZBmHLgLjyxCyrwZ1LGga/LQeIArCPbCaCdkXbODkPffo7nZiEAao0dSRckxfF
 JX7mU+CxVtgLL2uy4ljCu5BCqlkKpEKayC3RynA1Wwt6Zs2Kn3xtiow52apgm+OJ1NV4CXYxlIw
 m6II52hVJ272OX9AgMxw81ZAgJIelULk+sW8D0whaEq9xY1hPkWKvOLFAHygbopPlRBXYV/1n8x
 Lc6M7BrO7VHHkJMrAHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDEzNyBTYWx0ZWRfX+x2kg/OZLWId
 DGm0U8/7Ejv6NSXWOusB8uh7sDrwbIqgErtr2Mnzh0zNgEv4uarp3eOzVAQlw3cFZRLCGg8akNR
 0TheWkuhhbDVNlepLgJiziNtGNc+biU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608080137

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
gets zero-padded trailing fields. Newer userspace passing a larger struct to
an older kernel (usize > ksize) succeeds if trailing bytes are zero (the
kernel reports back min(usize, ksize) as the filled size); if trailing bytes
are non-zero, the kernel writes back ksize into host_caps.size and returns
-E2BIG so userspace can retry with the correct size.

KVM_PPC_COMPAT_CAPS_SIZE_VER0 is defined as a frozen integer constant
(24) marking the size of the initial struct version, used as the
minimum floor for size field validation, similar to other versioned
struct interfaces in the kernel.

The 'flags' field is reserved for future use. The kernel rejects any
call where flags is non-zero with -EINVAL, preventing garbage values
from being baked into ABI permanently.

The ioctl returns appropriate error codes: E2BIG if usize exceeds
PAGE_SIZE, or if new userspace provides a larger struct with non-zero
trailing bytes (with ksize written back into host_caps.size for the
retry); EINVAL for an invalid size or non-zero reserved fields; EFAULT
for failed copy operations; and ENOTTY if the backend doesn't implement
get_compat_caps.

Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 arch/powerpc/include/asm/kvm_ppc.h  |  1 +
 arch/powerpc/include/uapi/asm/kvm.h |  8 +++
 arch/powerpc/kvm/powerpc.c          | 78 +++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h            |  3 ++
 4 files changed, 90 insertions(+)

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
index b6b83fe3233f..14a661a88d4e 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -703,6 +703,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 			}
 		}
 		break;
+#if defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE)
+	case KVM_CAP_PPC_COMPAT_CAPS:
+		r = 0;
+		if (hv_enabled && kvmhv_on_pseries())
+			r = 1;
+		break;
+#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 	default:
 		r = 0;
 		break;
@@ -2469,6 +2476,77 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
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
+		r = -E2BIG;
+		if (unlikely(usize > PAGE_SIZE))
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
+		 * copy_struct_from_user() handles forward/backward compat:
+		 *   usize == ksize: verbatim copy
+		 *   usize <  ksize: zero-pad trailing (old userspace, new kernel)
+		 *   usize >  ksize: succeed iff trailing bytes are zero, else -E2BIG
+		 */
+		r = copy_struct_from_user(&host_caps, sizeof(host_caps),
+					  argp, usize);
+		if (r) {
+			/*
+			 * New userspace with a larger struct called an older
+			 * kernel. Write back ksize in host_caps.size so
+			 * userspace knows which older struct to retry with,
+			 * then fail with -E2BIG.
+			 */
+			if (r == -E2BIG)
+				if (put_user((__u64)sizeof(host_caps),
+					     (__u64 __user *)argp))
+					r = -EFAULT;
+			goto out;
+		}
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
+		/*
+		 * Report the number of bytes actually populated by the kernel,
+		 * not usize: if new userspace passed a larger struct with zero
+		 * trailing bytes, we only filled sizeof(host_caps) bytes.
+		 */
+		host_caps.size = min_t(u64, usize, sizeof(host_caps));
+		r = copy_struct_to_user(argp, usize, &host_caps,
+					sizeof(host_caps), NULL);
+		break;
+	}
 	default: {
 		struct kvm *kvm = filp->private_data;
 		r = kvm->arch.kvm_ops->arch_vm_ioctl(filp, ioctl, arg);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 419011097fa8..70e36e6a0ad4 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -997,6 +997,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
 #define KVM_CAP_S390_HPAGE_2G 249
+#define KVM_CAP_PPC_COMPAT_CAPS 250
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1341,6 +1342,8 @@ struct kvm_s390_keyop {
 /* Available with KVM_CAP_COUNTER_OFFSET */
 #define KVM_ARM_SET_COUNTER_OFFSET _IOW(KVMIO,  0xb5, struct kvm_arm_counter_offset)
 #define KVM_ARM_GET_REG_WRITABLE_MASKS _IOR(KVMIO,  0xb6, struct reg_mask_range)
+/* Available with KVM_CAP_PPC_COMPAT_CAPS */
+#define KVM_PPC_GET_COMPAT_CAPS	_IO(KVMIO,  0xb8)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
-- 
2.50.1 (Apple Git-155)


