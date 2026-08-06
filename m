Return-Path: <linuxppc-dev+bounces-25497-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85C5C56208
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:07:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGDGt1Fbyz308X;
	Fri, 07 Aug 2026 03:07:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786036038;
	cv=none; b=iUR7V8Nx8LAYXZCsZ8Qk4pX5TS0zKL0RXOiin2vdhVqPmrXGM5a1PkggzAbpS89lYlOCbt68NTCrrbddTcsayPjpoyniBxHr4OfaRQRSnfmUL1ec2dUQOg23LziDaV82oryxAapsURkM8V5S2X1YCsovOtquAoJdViAAeVKAAfHPvYledytLltmgBEvY5vSeZ3mGmrcZSQFuPxXPG94GH2doIMOYpPO0vl6R8YB+9803ZaUayBdIFUaU6JtzDcQYDm1UgdktMGRkKSr+LrK36ITL0fyd248NTBZfl80AVrkdVrcyOUBkSnwzh/R5Bk77lsf4PCIvke2ls7+4JETkJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786036038; c=relaxed/relaxed;
	bh=XF0yfXZadJRhpb/eQ/yc//gnd8Qnt7yOLj2Rb/LJK5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdiHHA59KkHkbLqKL+X/gpHqPJpP3WOJhs7Fl1jfobeWoOYhpB1EDtPAgT5U67YVyKYzrKZ5+Ds4R50Uln679VSowPruKn+qeDb/tQ7flFr3LaMppSeBHgUjqLHUcFi54LVIXe5tqimdooukmSB3TgOrOSdiB/1G9/Y3jaICpqmE5g3U+MioAt5bnoD7mu72ehCfQeu01keWMRmuwMxKunaW7GsndgZJbTfOsmGrarHdrEa+thiplguNYMCKr0048aEBt3iElTnXuPvk34++CU5p/R146RQrWSC3mGcMn7N8YEeN9qr1TzpJoEm/laJumO8AxiPsrlmXJ+igr/4fNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FrgXaUd+; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FrgXaUd+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGDGs3DSYz3080
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 03:07:16 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676Eo06U2966159;
	Thu, 6 Aug 2026 17:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XF0yfXZadJRhpb/eQ
	/yc//gnd8Qnt7yOLj2Rb/LJK5Q=; b=FrgXaUd+HVvOdXXBLbHgcio4NjdExVp67
	iRpyllY0MNctZ5cl/q+oo17GJr/mu/Jw0TWLtGWBLNjNHRLh06tV9/5nNclDihXY
	ldk8jBbTl41bbG8551aPdJ/xFyjKRArzdDXHNpYRCO+Lr4V6ovqIPkkYtXmSvo1D
	fB3EeVJtuSY+ckf5A+KLkKDVRNvLb+F6rNSjpOg6/3rZGqE/w3xtOo7qBa1KVJCL
	uRc0VM3JukD+QGJ6EotpxIblWTFE+s48s+9e50PupzII5KHWh/7LgpFYJOibwY9z
	z9TK35Hk3YeOXHY0wS/BqX1z+NXUaehEJCvJ+D6Tcd1HZTB9pRwHA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h59gpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 17:07:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676GuNIK004041;
	Thu, 6 Aug 2026 17:07:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyuw55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 17:07:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676H716Q32047494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 17:07:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B721520043;
	Thu,  6 Aug 2026 17:07:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5FED20040;
	Thu,  6 Aug 2026 17:06:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.29.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 17:06:57 +0000 (GMT)
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
        Gautam Menghani <gautam@linux.ibm.com>
Subject: [PATCH v7 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
Date: Thu,  6 Aug 2026 22:36:42 +0530
Message-ID: <20260806170645.11892-2-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260806170645.11892-1-amachhiw@linux.ibm.com>
References: <20260806170645.11892-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEzMSBTYWx0ZWRfX1i8d98aaaXYk
 lOnqE+CT7NWzJWlYS9ulEc3fE+N1uEhjAmz8DwJDX+lWwrdtV+kwo9y1VCRBybc5VvHg/hYEAR0
 V/Vy3SC9e8jf9NbjHfqla+rnHkbsCrg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEzMSBTYWx0ZWRfXw5CDzGHTj1Kk
 OVIubkRZ9h72hyFgoGyPxXZx/ubTPcrl40ga32AKxmcmzFi1MlBFH7ybuQnIXzzp+p7fkjOzYiV
 k02/kv6BDJkqryExZLKxRVMzke6hkuz64QJZkGOKrFRbaDBCQhkSbZn3wU1p777YDw9P90jbdlw
 moZgHmsDLkHWrH0ex8vdXotT1T2mFVwJyzpn6+cgGe0j+SKjnExr1EoyCQKEIePAoInMCpHjkIP
 FnwHJCAQa8JEHnx8tQjk2V7kdokw5dX43CYnPSE/TWHLNhO25PIlkkdUw9JG3weyE65SyowCCoW
 9n4rd+RTIYAIK77sQNq6QRm1oetXZO/kB4POmH7pBLzn2B/xZckjHmuD3t8Msrx0J5omopuGSTs
 jvxKQQ5c0qRsDXL5CL4pdIn4SNHyJh1fXWkd0jAB6pcipLpdOfv3VPMqcavQh4Bfvj4O812dCZq
 ouOsVxDl1kIN8iNUrrg==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a74bf3b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=rQyBRTFaFC3FL7QHXY8A:9
X-Proofpoint-ORIG-GUID: xw4h6RMYoy5kFufRhgRZvgjVBJV1WePw
X-Proofpoint-GUID: ysCEd5QDaFYDo4jTNYcOiNiQ16EPj3ac
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060131

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
kvm_ppc_compat_caps) written back to host_caps.size so it can retry with the
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
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes in this version:
  - KVM_CAP_PPC_COMPAT_CAPS: add hv_enabled guard to align the capability
    check with ioctl availability; a PR KVM VM on pseries now correctly
    returns 0 for the capability [Sashiko]

 arch/powerpc/include/asm/kvm_ppc.h  |  1 +
 arch/powerpc/include/uapi/asm/kvm.h |  8 ++++
 arch/powerpc/kvm/powerpc.c          | 71 +++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h            |  3 ++
 4 files changed, 83 insertions(+)

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
index b6b83fe3233f..e64b3cfadd3a 100644
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
@@ -2469,6 +2476,70 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
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


