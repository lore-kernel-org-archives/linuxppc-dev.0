Return-Path: <linuxppc-dev+bounces-25571-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D205FC5AC7C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 12:20:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGjsn1jN4z3c4D;
	Fri, 07 Aug 2026 22:20:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786105245;
	cv=none; b=IYFTmrjjowftveR51MF3ZQLjV89LZ+c1HfCNTvOH3qFIr3hWxWfi00ysK03CdGbErgXut8mmrusTpzjspBU9q5VH7IYQBPXG/1r/RryVT8DAAyRYkUd2ZCiBGqJNtvU+ncfUHc33MUNSjRCI4zIkvCH1MuyRionC0J1df/VZgSY1s0rCfhklGL2CL8OzPzIm3PYS2iRi+CITy3R3gpNmx/AhT7JCgjf/8SvZeyrkDu3IvCmNziOX74q80fsoawKJCbWFK5kUKTP6FEa+lfHiUvKJe7hto26zEL/MZPOOq7dpCcLl3MNd37JgtaCqcWgwbEGD81mF0sHP8WfbHvYLww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786105245; c=relaxed/relaxed;
	bh=0tG8zJDco0wN4AtuqRb9EhlwypKdV5rZoYmTq31XTTw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=RwVOylD97N2X9JeZsYdxWWIuRs6wHtSUgJkWfP1/bf4XV2fC4t3iF8acxy2sUaECh6U5lOOX+jI9RwfEvFwfAJ98DWs8tZVCvdkNQZnC27sgnbfG14Lig9Zd8GrDZirt70e+BgraKQUJ3UaTVwG/mFL3MKfIDrICGSExs7nNqFRB8Rt1jczz0oF8hcKxR7wvMGoKBeFlLKR7bsX7DZi4KPWE3TFC00FBlannfpLrS3v8X2CqbVereYutl9zMfeOl+QFsTdNEHTuKehZxJL/fCsreZxus8NNKOF51rXrNdSEweDwOgD/yrhfQNyNrcQwybGe1jM43BDt2tgRaCbATJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=haK0D1cH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=haK0D1cH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGjsm2gQ7z3c3v
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 22:20:43 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-848643382fcso3669093b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 05:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786105241; x=1786710041; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0tG8zJDco0wN4AtuqRb9EhlwypKdV5rZoYmTq31XTTw=;
        b=haK0D1cH9rKsCWvvlnRkc+WKzuUANFqHT2WTW4EsV1uT9ZD44dc2WtWVZkCn0UJQ1d
         dWjUbbhaDb63p4D6kZfpQKomIEu/8CStOpvcrvnp2mQPWlPMlWGE4+ZWY+RIrowSbV83
         diOjAxlXdnL6amuw81mCUsYyGfOvyBDjNH9EEUY9BPDjlrRjz9lPCuyB2w07ZBGreyvt
         xFAeiwz0fPN+E3wbfw1QnvYdbSmmQYTElVT/faeG5oR0gtIaPxX+giIUGA7XvSAdJtqN
         vRRwGkorfpgsrkSTeB95v1DvA6nWlWimKdMIh1i0Vf06OJ0OBXb+xlku9kLRodlovNHb
         m4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786105241; x=1786710041;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0tG8zJDco0wN4AtuqRb9EhlwypKdV5rZoYmTq31XTTw=;
        b=kos1UjmJxM2A3I/MIjn4pigHOE6TQ3YfWD9vIVwYCDoLrzZHfQLaNHmpl0ORsnkOxf
         7Bm/F5IkSVP7OmBhyZP2nZHYMvj9OXspgL3yNqyXxq075n6fC3UQE7Qfv1rNsJeKCkON
         3BEfW8i8S8AEjI3aF0Iv/RyRXROCTM3jootzCu/rYv/y6aOksEokhlKSy9mqELytQV/m
         z8JWb+XAtAShyBpSanBw49OZ7c/W7qmB+1gGKVCeNci31vD8i33uAaQaauFY2HyFEyYL
         V+PIXoP5QMjdiLYj4SKdr4HjZiVasFcDaYP0mcTKMqKH8u5azgPcSRGxLTOzxabVOTeC
         5Cxg==
X-Forwarded-Encrypted: i=1; AHgh+RoYPGfN4fDOR6OG9kK20BA4Uc0HxxtFZ+0z6eFwG8ByAwpQeR218aDm6IDG/orTCDJQZofUSe4GgLUbh5o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy1ZQXyEMTIo85I0R9CEOfrD0Amg+iS1fxC3p68plbKWcRFUGoe
	4mNMq5x0jOVzDV3K+0fMmt+NHgoB/0S+dAk52pHQbf4jd/Q9SNrs9DtP
X-Gm-Gg: AR+sD13m9eXhe2d4JqZjCiU1KLgqXtaZ8xjMSocZLdTQef0r3elljgw0e92bfghcLjG
	0EgVOE5suB/s5PaZ8sLARCLY+sTv2lqRKtM0Hg4Usb0zE8tPlwz35EtNvUbbKm8QDq90FumdhIE
	4cTIZjHSfnL1dkE7zK9oY6v98HKb/+t8Udo1egNX6WCHTNmkRWbFjCkE/qEV7D7YL5c+Fd4N8A8
	o36DuEDcwVY4gEAldk7GjOoD/8z3WulpRxLcT+W7rgvTCEDZG0XtdaFrqRICLWAU7p6QZcV6Rvg
	8JnG2eqpWYCZU5rrQGnXFYnKTpQzJ+SdMJsOeA+Em4+7T81+W4B5BXBa9MZ84TSIX6M7l6m29CB
	BTKLoV+XXaxIV4Ehwv/HAAlrKmHO3/GnaQldJcHkFXRCnHXF2VA2FPz5GbU7i5EOvQomHvqomkO
	oXStKZFuzxjLeJspnr39oXzGgysQoyDW8J6LUK+UYqjZJA4Zi4UgqanAfP+pYM7J3qwGCavGY=
X-Received: by 2002:a05:6a20:4321:b0:3c3:b57b:6291 with SMTP id adf61e73a8af0-3cb85e6689fmr24988534637.18.1786105240838;
        Fri, 07 Aug 2026 05:20:40 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be8a706fsm7279585eec.8.2026.08.07.05.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 05:20:39 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [PATCH v7 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
In-Reply-To: <8q6ikvqo.ritesh.list@gmail.com>
Date: Fri, 07 Aug 2026 17:45:18 +0530
Message-ID: <5x1mktyh.ritesh.list@gmail.com>
References: <20260806170645.11892-1-amachhiw@linux.ibm.com> <20260806170645.11892-2-amachhiw@linux.ibm.com> <ik5mlj9n.ritesh.list@gmail.com> <20260807161434.73dfde8c-36-amachhiw@linux.ibm.com> <8q6ikvqo.ritesh.list@gmail.com>
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
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
>
>> Hi Ritesh,
>>
>> Thanks for reviewing this patch. Please find my response inline below.
>>
>> On 2026/08/07 08:38 AM, Ritesh Harjani wrote:
>>> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
>>> 
>>> > Introduce a new capability and ioctl to expose CPU compatibility modes
>>> > supported by the host processor for nested guests.
>>> >
>>> > On IBM POWER systems, newer processor generations (N) can operate in
>>> > compatibility modes corresponding to earlier generations, like (N-1) and
>>> > (N-2). This is particularly relevant for nested virtualization, where
>>> > nested KVM guests may need to run with a specific processor compatibility
>>> > level.
>>> >
>>> > Introduce KVM_CAP_PPC_COMPAT_CAPS capability and the corresponding
>>> > KVM_PPC_GET_COMPAT_CAPS vm ioctl. The ioctl returns a bitmap describing
>>> > the compatibility modes supported by the host in respective bit numbers,
>>> > allowing userspace (e.g., QEMU) to select an appropriate compatibility
>>> > level when configuring nested KVM guests.
>>> >
>>> > The ioctl handling is added in kvm_arch_vm_ioctl() and retrieves host
>>> > CPU compatibility capabilities via a PowerPC-specific backend
>>> > implementation when available.
>>> >
>>> > The struct kvm_ppc_compat_caps places the 'size' field first so it can
>>> > be read alone via get_user() before copy_struct_from_user() is called,
>>> > avoiding pointer arithmetic to locate the size field.
>>> >
>>> > The ioctl is defined using _IO so the ioctl number remains stable even if
>>> > the struct grows in future versions. It uses copy_struct_from_user() and
>>> > copy_struct_to_user() to provide forward- and backward-compatible
>>> > extensibility: older userspace passing a smaller struct to a newer kernel
>>> > gets zero-padded trailing fields, while newer userspace passing a larger
>>> > struct to an older kernel (usize > ksize) gets sizeof(struct
>>> > kvm_ppc_compat_caps) written back to host_caps.size so it can retry with the
>>> > older kernel-supported size, after which the kernel returns -E2BIG.
>>> >
>>> > KVM_PPC_COMPAT_CAPS_SIZE_VER0 is defined as a frozen integer constant
>>> > (24) marking the size of the initial struct version, used as the
>>> > minimum floor for size field validation, similar to other versioned
>>> > struct interfaces in the kernel.
>>> >
>>> > The 'flags' field is reserved for future use. The kernel rejects any
>>> > call where flags is non-zero with -EINVAL, preventing garbage values
>>> > from being baked into ABI permanently.
>>> >
>>> > The ioctl returns appropriate error codes: EINVAL for an invalid size
>>> > or non-zero reserved fields, E2BIG if new userspace provides a larger
>>> > struct than the kernel knows about (with ksize written back into
>>> > host_caps.size for the retry), EFAULT for failed copy operations, and
>>> > ENOTTY if the backend doesn't implement get_compat_caps.
>>> >
>>> > Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>>> > Tested-by: Gautam Menghani <gautam@linux.ibm.com>
>>> > Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
>>> > Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
>>> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
>>> > ---
>>> > Changes in this version:
>>> >   - KVM_CAP_PPC_COMPAT_CAPS: add hv_enabled guard to align the capability
>>> >     check with ioctl availability; a PR KVM VM on pseries now correctly
>>> >     returns 0 for the capability [Sashiko]
>>> >
>>> >  arch/powerpc/include/asm/kvm_ppc.h  |  1 +
>>> >  arch/powerpc/include/uapi/asm/kvm.h |  8 ++++
>>> >  arch/powerpc/kvm/powerpc.c          | 71 +++++++++++++++++++++++++++++
>>> >  include/uapi/linux/kvm.h            |  3 ++
>>> >  4 files changed, 83 insertions(+)
>>> >
>>> > diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
>>> > index 0953f2daa466..169ea6a7fbad 100644
>>> > --- a/arch/powerpc/include/asm/kvm_ppc.h
>>> > +++ b/arch/powerpc/include/asm/kvm_ppc.h
>>> > @@ -319,6 +319,7 @@ struct kvmppc_ops {
>>> >  	bool (*hash_v3_possible)(void);
>>> >  	int (*create_vm_debugfs)(struct kvm *kvm);
>>> >  	int (*create_vcpu_debugfs)(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry);
>>> > +	int (*get_compat_caps)(struct kvm_ppc_compat_caps *host_caps);
>>> >  };
>>> >  
>>> >  extern struct kvmppc_ops *kvmppc_hv_ops;
>>> > diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
>>> > index 077c5437f521..19e53d5ae540 100644
>>> > --- a/arch/powerpc/include/uapi/asm/kvm.h
>>> > +++ b/arch/powerpc/include/uapi/asm/kvm.h
>>> > @@ -437,6 +437,14 @@ struct kvm_ppc_cpu_char {
>>> >  	__u64	behaviour_mask;		/* valid bits in behaviour */
>>> >  };
>>> >  
>>> > +/* For KVM_PPC_GET_COMPAT_CAPS */
>>> > +struct kvm_ppc_compat_caps {
>>> > +	__u64	size;			/* Size of this structure */
>>> > +	__u64	flags;			/* Reserved for future use */
>>> > +	__u64	compat_capabilities;	/* Capabilities supported by the host */
>>> > +};
>>> > +#define KVM_PPC_COMPAT_CAPS_SIZE_VER0	24 /* sizeof first published struct */
>>> > +
>>> >  /*
>>> >   * Values for character and character_mask.
>>> >   * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
>>> > diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
>>> > index b6b83fe3233f..e64b3cfadd3a 100644
>>> > --- a/arch/powerpc/kvm/powerpc.c
>>> > +++ b/arch/powerpc/kvm/powerpc.c
>>> > @@ -703,6 +703,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>> >  			}
>>> >  		}
>>> >  		break;
>>> > +#if defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE)
>>> > +	case KVM_CAP_PPC_COMPAT_CAPS:
>>> > +		r = 0;
>>> > +		if (hv_enabled && kvmhv_on_pseries())
>>> 
>>> I think sashiko is just complaining in the 1st patch because we have not
>>> yet wired up the kvmppc_hv_ops->get_compat_caps() yet in patch-1. I
>>> think it is expecting..
>>> 
>>> if (hv_enabled && kvmhv_on_pseries() && kvmppc_hv_ops->get_compat_caps)
>>> 
>>> But either way is fine.
>>> 
>>> 
>>> > +			r = 1;
>>> > +		break;
>>> > +#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
>>> >  	default:
>>> >  		r = 0;
>>> >  		break;
>>> > @@ -2469,6 +2476,70 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
>>> >  		r = kvm->arch.kvm_ops->svm_off(kvm);
>>> >  		break;
>>> >  	}
>>> > +	case KVM_PPC_GET_COMPAT_CAPS: {
>>> > +		struct kvm_ppc_compat_caps host_caps = {};
>>> > +		u64 usize;
>>> > +
>>> > +		/*
>>> > +		 * Read the size field first to drive copy_struct_from_user.
>>> > +		 * size must be the first field of the struct.
>>> > +		 */
>>> > +		r = -EFAULT;
>>> > +		if (get_user(usize, (__u64 __user *)argp))
>>> > +			goto out;
>>> > +
>>> > +		/*
>>> > +		 * Enforce a minimum: reject buffers smaller than the initial
>>> > +		 * struct version (VER0). This allows old userspace compiled
>>> > +		 * against the original struct to still work on a newer kernel
>>> > +		 * that has grown the struct with appended fields.
>>> > +		 */
>>> > +		r = -EINVAL;
>>> > +		if (usize < KVM_PPC_COMPAT_CAPS_SIZE_VER0)
>>> > +			goto out;
>>> > +
>>> > +		/*
>>> > +		 * New userspace with a larger struct called an older kernel.
>>> > +		 * Write back ksize in host_caps.size so userspace knows which
>>> > +		 * older struct to retry with, then fail with -E2BIG.
>>> > +		 */
>>> > +		if (usize > sizeof(host_caps)) {
>>> > +			host_caps.size = sizeof(host_caps);
>>> > +			r = -EFAULT;
>>> > +			if (put_user(host_caps.size, (__u64 __user *)argp))
>>> > +				goto out;
>>> > +			r = -E2BIG;
>>> > +			goto out;
>>> > +		}
>>> 
>>> You anyways mentioned copy_struct_from_user() is taking care of both
>>> forward and backward compat. Then what is the point of this check?
>>> shouldn't we get rid of this complete if logic? I don't see a point of
>>> this if we are anyway using copy_struct_from_user().
>>
>> The pre-check is intentional and serves a purpose that
>> copy_struct_from_user() alone cannot provide: explicit kernel struct
>> size discovery.
>>
>> copy_struct_from_user() returns -E2BIG when usize > ksize and trailing
>> bytes are non-zero — but it gives userspace no way to know what ksize to
>> retry with. It also silently succeeds when trailing bytes are zero,
>> which means a new userspace on an old kernel would never learn the
>> kernel's struct size at all.
>>
>> This design is different by intent: when new userspace passes a larger
>> struct, we always return -E2BIG and write back sizeof(host_caps) into
>> the size field so userspace learns the exact kernel-supported size and
>> can retry with it. This explicit negotiation is verified in the ABI
>> extensibility testing in the cover letter ("Newer struct on QEMU, older
>> kernel -> works"). The explicit -E2BIG + ksize writeback makes the
>> version negotiation unambiguous.
>>
>
> yup, my bad, should have seen the comment in the code above.
>
> But isn't this a bad design? Tomorrow, say we have a v2, a larger
> version of this struct and if your newer Qemu (with larger struct size)
> is running on an older kernel with a smaller struct size, then you will
> fail it because usize > ksize even though the userspace has zero filled
> the rest of the trailing bytes... 
>      if (usize > sizeof(host_caps)) 
>
> Instead wouldn't it be better if we do something like this?
>
> 		r = copy_struct_from_user(&host_caps, sizeof(host_caps),
> 					  argp, usize);
> 		if (r) {
> 			if (r == -E2BIG)
> 				put_user(sizeof(host_caps), &argp->size);
> 			goto out;
> 		}
>
> So, we only fail if the userspace has passed a newer struct and the
> trailing bytes, which are unknown to this older kernel, are zeroed,
> otherwise we return -E2BIG.

Sorry made some typos in above paragraph, what I meant is - 

So we only fail with -E2BIG if the userspace has passed a newer struct
and the trailing bytes, which are unknown to this older kernel, are
non-zero. if they're all zero, the call succeeds, since those bytes are
safe to ignore. We also write the ksize back on the failure path, so the
user knows what ksize this kernel supports.


