Return-Path: <linuxppc-dev+bounces-25538-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C949EC5AC7A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 03:26:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGV1h6pFZz3bs2;
	Fri, 07 Aug 2026 13:26:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786073208;
	cv=none; b=U8ts6hD8ZZ80lqp/xSWcUjKsMXq4LHiLaBHP0uuPSQPXykDyLj1xZnyTRMKjKtfbdzOFxxiDLB3SMKMhsgVpkPrs4kqTGCUuZDMdaKJBgudOjYrBkqeS6tJBdSl/QDRt4Qo18Ip1FyqyqtSPY5taJZpieJ6Fmqwqle4NcYJvXS8jVCsQyK9QA7W8oBci/9/Tm2P9Cp82/MlbtqPTTfARXTktPlNSGjXFwJaX/BjCBqTUcwQ5eimlMTK3CDAMZTkodYOKqVnieCVz7wK0L0gUzR3wpr+PcHr+xhH7hPPcF/75HMzBXdX0f46n9Fi6r0uQNxfkmNstrNAEWDPej+PdLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786073208; c=relaxed/relaxed;
	bh=JRf2EBTavDe7BzK6GUvtTHBHqH7rXidb69cs4e3i5nA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=I9EOkBQzOAPZvqz128BgPZ0ic8GIQVh4fUMZg+XMIby0MFCXRjrO/TWDDJpeoHdlh3peOYUHgsF8DhIveoo5zp0dVyxioImAVrOjWSV7aCqxaysTGcNQNu9xabozVn+kmGVFMVEIE6s/PkLHRFuDav0e3B1uJjpuH/SW7UrG1Tn2HbG+0vrDXGZk9XCFqza6gKX2c29QMIcHZImj6eCB9DdQ1Wwjvh6gnSxGd6hGNIWvdCtqtYEjuVfej0V+hH8KvnwcZaobCQ8fLDHXML85ZQCRnhUUzK6GJorKklGU+EhYbS3WEoJTVA7Z9Lhq+wb3omN0eX4zh16ekru3lHby4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qN4ogJrU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qN4ogJrU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGV1g6B2Gz3bs0
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 13:26:47 +1000 (AEST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2cc73e322dbso33067295ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 20:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786073200; x=1786678000; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JRf2EBTavDe7BzK6GUvtTHBHqH7rXidb69cs4e3i5nA=;
        b=qN4ogJrUTScWdoMYUjP7BeUaBiRTxksDs8es/1El7S+HlmwejS/atJVRXcJyx2cxxh
         eArVI2jcBQ1sO0Dofk7Q7ciFxZ8zJ2HG2/Ibxy+y/mONXpWUhIOZ2EXk3zXm3E5w8tkc
         59egQfbzstZNI3gWi3B+p+UXylEvXdI9oEyZLURb2jpinrTuWqO4o4Xt5KTpcsqNGWT3
         69Tya0NjDKkobUtP4CRL+wBXXvqwiBmvhYguC4U2kZoEFJeOz9dtOsBxr3CXXvaVdjrh
         p7fUBK2hDG4f6xMcIdK9lrPoOxRv5JEt29IRmM44YS6zqck4rYZh76RTv5mNlGaC4iei
         n+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786073200; x=1786678000;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JRf2EBTavDe7BzK6GUvtTHBHqH7rXidb69cs4e3i5nA=;
        b=WTocueMxsHqD6SmMnfa9Qssk86uGMGvn0DQbIOxx8qtMfp/uz5ErfBnYeCV4LXoyb4
         c88O13e8ApklmO+MIlMD2wq3IDu+e7UToTAKvWTRyfqEZMRUCKyfiw4++s2O6yTI3Okf
         nzWY19scT+gLMKupu5pqDsrIFoR1Aq9Ka1l9JOhWI7tjTuYw2nSGmXxff9g1bRn4CIU1
         ZY17N2A67FWPRoftjTD4JzKu3zrvqux1USM7nU/MweDsar9JiEsTsuyJ2JdArkLmyPBz
         w1f7aiJqlP5Lf6IJmMpnHLAMqnf31NLGVdxw0K9REdGzC0TRN7aNtiMupx06Rkjbvwt1
         MIxg==
X-Forwarded-Encrypted: i=1; AHgh+RrDXGBgUSNzxlG42AN0hUQQ5emcNHJxkZIi0aIzM8umc95JYAcc1CJzOoZq2rW8xWcyFP5sTWE3j15o70E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx9LnpXrMX0n2KYuKWxWoNz3WEfnc06fCgwU1VqZNjOHLl7Yghj
	JNhwXMTpA6wzUUlf3AsrOJU/8GXZvR50Oxkg6ch5lDGtViBaLZEQ7N1R
X-Gm-Gg: AR+sD12gdwJ9PE/qwEWRxq/JxNJs1b0mYhRLIa4GJts1TOVbBmJVbP5EzQuwNZFc3lN
	/0l5edleQev4Yjn/MSg1tOL17eW65OjZwySW7yTnoIVGsaxrZanVbqVKzNT1J8JqFr0et4DeaWM
	COWIc1H/Z91Hw3qILWyHwhh8xDOqmibdMWRAHkmN3Hd/TS9fqNrOVvhzePj8Ov3ZqTcNNefvRvQ
	Cq+RpobF3oExKAiHumRgQviI6kUS/q4cabSQ1QfikiJlmduxL+lNBz8V4+VH4p0YnN8AGgKcfb1
	bQ9aZZDMtkYqy7ah9nExc1B0YcED8C9jDrjAp/aXVJXrQ9HpRBJ6B8hcyzuxpfuC3XPme/xSJ8g
	BGRSoLdvkJD3nQZ9gqDmsEMKg/OeHmh6M0Xn2KjCUJSmDl5tFXY3AMgB5hEuBUyb/nvrxaLtsRl
	0WHYkYzFokU1blupYsMZfeCijORQRNYOt5K0V3bV5u98HqK8Ap7vupgFZQYkk=
X-Received: by 2002:a05:6a20:7fa1:b0:3c8:e140:63c3 with SMTP id adf61e73a8af0-3cb86076804mr21598472637.37.1786073200060;
        Thu, 06 Aug 2026 20:26:40 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be86e90asm1946929eec.3.2026.08.06.20.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 20:26:38 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Amit Machhiwal <amachhiw@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [PATCH v7 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
In-Reply-To: <20260806170645.11892-2-amachhiw@linux.ibm.com>
Date: Fri, 07 Aug 2026 08:38:36 +0530
Message-ID: <ik5mlj9n.ritesh.list@gmail.com>
References: <20260806170645.11892-1-amachhiw@linux.ibm.com> <20260806170645.11892-2-amachhiw@linux.ibm.com>
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

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> Introduce a new capability and ioctl to expose CPU compatibility modes
> supported by the host processor for nested guests.
>
> On IBM POWER systems, newer processor generations (N) can operate in
> compatibility modes corresponding to earlier generations, like (N-1) and
> (N-2). This is particularly relevant for nested virtualization, where
> nested KVM guests may need to run with a specific processor compatibility
> level.
>
> Introduce KVM_CAP_PPC_COMPAT_CAPS capability and the corresponding
> KVM_PPC_GET_COMPAT_CAPS vm ioctl. The ioctl returns a bitmap describing
> the compatibility modes supported by the host in respective bit numbers,
> allowing userspace (e.g., QEMU) to select an appropriate compatibility
> level when configuring nested KVM guests.
>
> The ioctl handling is added in kvm_arch_vm_ioctl() and retrieves host
> CPU compatibility capabilities via a PowerPC-specific backend
> implementation when available.
>
> The struct kvm_ppc_compat_caps places the 'size' field first so it can
> be read alone via get_user() before copy_struct_from_user() is called,
> avoiding pointer arithmetic to locate the size field.
>
> The ioctl is defined using _IO so the ioctl number remains stable even if
> the struct grows in future versions. It uses copy_struct_from_user() and
> copy_struct_to_user() to provide forward- and backward-compatible
> extensibility: older userspace passing a smaller struct to a newer kernel
> gets zero-padded trailing fields, while newer userspace passing a larger
> struct to an older kernel (usize > ksize) gets sizeof(struct
> kvm_ppc_compat_caps) written back to host_caps.size so it can retry with the
> older kernel-supported size, after which the kernel returns -E2BIG.
>
> KVM_PPC_COMPAT_CAPS_SIZE_VER0 is defined as a frozen integer constant
> (24) marking the size of the initial struct version, used as the
> minimum floor for size field validation, similar to other versioned
> struct interfaces in the kernel.
>
> The 'flags' field is reserved for future use. The kernel rejects any
> call where flags is non-zero with -EINVAL, preventing garbage values
> from being baked into ABI permanently.
>
> The ioctl returns appropriate error codes: EINVAL for an invalid size
> or non-zero reserved fields, E2BIG if new userspace provides a larger
> struct than the kernel knows about (with ksize written back into
> host_caps.size for the retry), EFAULT for failed copy operations, and
> ENOTTY if the backend doesn't implement get_compat_caps.
>
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Changes in this version:
>   - KVM_CAP_PPC_COMPAT_CAPS: add hv_enabled guard to align the capability
>     check with ioctl availability; a PR KVM VM on pseries now correctly
>     returns 0 for the capability [Sashiko]
>
>  arch/powerpc/include/asm/kvm_ppc.h  |  1 +
>  arch/powerpc/include/uapi/asm/kvm.h |  8 ++++
>  arch/powerpc/kvm/powerpc.c          | 71 +++++++++++++++++++++++++++++
>  include/uapi/linux/kvm.h            |  3 ++
>  4 files changed, 83 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> index 0953f2daa466..169ea6a7fbad 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -319,6 +319,7 @@ struct kvmppc_ops {
>  	bool (*hash_v3_possible)(void);
>  	int (*create_vm_debugfs)(struct kvm *kvm);
>  	int (*create_vcpu_debugfs)(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry);
> +	int (*get_compat_caps)(struct kvm_ppc_compat_caps *host_caps);
>  };
>  
>  extern struct kvmppc_ops *kvmppc_hv_ops;
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
> index 077c5437f521..19e53d5ae540 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -437,6 +437,14 @@ struct kvm_ppc_cpu_char {
>  	__u64	behaviour_mask;		/* valid bits in behaviour */
>  };
>  
> +/* For KVM_PPC_GET_COMPAT_CAPS */
> +struct kvm_ppc_compat_caps {
> +	__u64	size;			/* Size of this structure */
> +	__u64	flags;			/* Reserved for future use */
> +	__u64	compat_capabilities;	/* Capabilities supported by the host */
> +};
> +#define KVM_PPC_COMPAT_CAPS_SIZE_VER0	24 /* sizeof first published struct */
> +
>  /*
>   * Values for character and character_mask.
>   * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index b6b83fe3233f..e64b3cfadd3a 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -703,6 +703,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  			}
>  		}
>  		break;
> +#if defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE)
> +	case KVM_CAP_PPC_COMPAT_CAPS:
> +		r = 0;
> +		if (hv_enabled && kvmhv_on_pseries())

I think sashiko is just complaining in the 1st patch because we have not
yet wired up the kvmppc_hv_ops->get_compat_caps() yet in patch-1. I
think it is expecting..

if (hv_enabled && kvmhv_on_pseries() && kvmppc_hv_ops->get_compat_caps)

But either way is fine.


> +			r = 1;
> +		break;
> +#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
>  	default:
>  		r = 0;
>  		break;
> @@ -2469,6 +2476,70 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>  		r = kvm->arch.kvm_ops->svm_off(kvm);
>  		break;
>  	}
> +	case KVM_PPC_GET_COMPAT_CAPS: {
> +		struct kvm_ppc_compat_caps host_caps = {};
> +		u64 usize;
> +
> +		/*
> +		 * Read the size field first to drive copy_struct_from_user.
> +		 * size must be the first field of the struct.
> +		 */
> +		r = -EFAULT;
> +		if (get_user(usize, (__u64 __user *)argp))
> +			goto out;
> +
> +		/*
> +		 * Enforce a minimum: reject buffers smaller than the initial
> +		 * struct version (VER0). This allows old userspace compiled
> +		 * against the original struct to still work on a newer kernel
> +		 * that has grown the struct with appended fields.
> +		 */
> +		r = -EINVAL;
> +		if (usize < KVM_PPC_COMPAT_CAPS_SIZE_VER0)
> +			goto out;
> +
> +		/*
> +		 * New userspace with a larger struct called an older kernel.
> +		 * Write back ksize in host_caps.size so userspace knows which
> +		 * older struct to retry with, then fail with -E2BIG.
> +		 */
> +		if (usize > sizeof(host_caps)) {
> +			host_caps.size = sizeof(host_caps);
> +			r = -EFAULT;
> +			if (put_user(host_caps.size, (__u64 __user *)argp))
> +				goto out;
> +			r = -E2BIG;
> +			goto out;
> +		}

You anyways mentioned copy_struct_from_user() is taking care of both
forward and backward compat. Then what is the point of this check?
shouldn't we get rid of this complete if logic? I don't see a point of
this if we are anyway using copy_struct_from_user().

> +
> +		/*
> +		 * copy_struct_from_user() handles forward/backward compat:
> +		 *   usize == ksize: verbatim copy
> +		 *   usize <  ksize: zero-pad trailing (old userspace, new kernel)

+		 *   usize >  ksize: succeed iff the trailing bytes userspace
+		 *                   sent are zero, else -E2BIG

shouldn't we add usize > ksize case details, like ^^^,  which
copy_struct_from_user() handles since we are already adding the details
of other 2 cases.


</btw snip from copy_struct_from_user kdoc>

 * There are three cases to consider:
 *  * If @usize == @ksize, then it's copied verbatim.
 *  * If @usize < @ksize, then the userspace has passed an old struct to a
 *    newer kernel. The rest of the trailing bytes in @dst (@ksize - @usize)
 *    are to be zero-filled.
 *  * If @usize > @ksize, then the userspace has passed a new struct to an
 *    older kernel. The trailing bytes unknown to the kernel (@usize - @ksize)
 *    are checked to ensure they are zeroed, otherwise -E2BIG is returned.
 *
 * Returns (in all cases, some data may have been copied):
 *  * -E2BIG:  (@usize > @ksize) and there are non-zero trailing bytes in @src.
 *  * -EFAULT: access to userspace failed.
 
> +		 */
> +		r = copy_struct_from_user(&host_caps, sizeof(host_caps),
> +					  argp, usize);
> +		if (r)
> +			goto out;
> +
> +		/* Reserved fields must be zero */
> +		r = -EINVAL;
> +		if (host_caps.flags)
> +			goto out;
> +
> +		r = -ENOTTY;
> +		if (!kvm->arch.kvm_ops->get_compat_caps)
> +			goto out;
> +
> +		r = kvm->arch.kvm_ops->get_compat_caps(&host_caps);
> +		if (r)
> +			goto out;
> +
> +		host_caps.size = sizeof(host_caps);

shouldn't this be, since we don't want to be reporting a larger size to
the user?

          host_caps.size = min_t(u64, usize, sizeof(host_caps));


> +		r = copy_struct_to_user(argp, usize, &host_caps,
> +					sizeof(host_caps), NULL);
> +		break;
> +	}
>  	default: {
>  		struct kvm *kvm = filp->private_data;
>  		r = kvm->arch.kvm_ops->arch_vm_ioctl(filp, ioctl, arg);
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 419011097fa8..70e36e6a0ad4 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -997,6 +997,7 @@ struct kvm_enable_cap {
>  #define KVM_CAP_S390_KEYOP 247
>  #define KVM_CAP_S390_VSIE_ESAMODE 248
>  #define KVM_CAP_S390_HPAGE_2G 249
> +#define KVM_CAP_PPC_COMPAT_CAPS 250
>  
>  struct kvm_irq_routing_irqchip {
>  	__u32 irqchip;
> @@ -1341,6 +1342,8 @@ struct kvm_s390_keyop {
>  /* Available with KVM_CAP_COUNTER_OFFSET */
>  #define KVM_ARM_SET_COUNTER_OFFSET _IOW(KVMIO,  0xb5, struct kvm_arm_counter_offset)
>  #define KVM_ARM_GET_REG_WRITABLE_MASKS _IOR(KVMIO,  0xb6, struct reg_mask_range)
> +/* Available with KVM_CAP_PPC_COMPAT_CAPS */
> +#define KVM_PPC_GET_COMPAT_CAPS	_IO(KVMIO,  0xb8)
>  
>  /* ioctl for vm fd */
>  #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
> -- 
> 2.50.1 (Apple Git-155)

