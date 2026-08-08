Return-Path: <linuxppc-dev+bounces-25622-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2264FC5AD2B
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2026 01:09:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hH2wm2mtGz2y2B;
	Sat, 08 Aug 2026 11:09:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786151368;
	cv=none; b=kWLLKrNc4Baz/Gn0SUjDNF+H8MLcblk1S3n+7+8KrtuS0qRYuNkrBrqU4c5PduZRkdztLAvyieJzmCxrGTOysX54IHpkn/Jpcyum91Oq+ReHRiDJyBPzXRHH35opPe7aQAM0TIp29l/ZybHyDXdEbz21bu6cfImRA/PwRBByMTb9LIkxXKIOMxZ6GQeaa7jZK0Hcyz42hBkDLZuSciCl8A8FTZX5R+YGWbkRPd6EbTL79CCWAc90RUqNMujzAu2Ps20TitnYr3ycQFxJzHULN7Yx6ERi1wWDj599uUYoL4Cvf6bSi00FhRFJAn2TM4QEwcvc4DGllzJ56EFoB/mNog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786151368; c=relaxed/relaxed;
	bh=6xF7Vf0vsAzDGiN9uOUXdMTijirUIpfVi3ov9/6Fs1k=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=lnPM/fgn7T47w+VmjNdPoi1kKkfcna19G1KYnnn6FhoqaVhx4DwMsi/j9KPpLafnrLgAIuv7U4gGzJB5arb1pZvFfk6WFqY2hZ7YUI3lMFZvxTaEloMLE1Y/OS25oPv3lsKISf5b8ut9WJGuofZFWpnsXG1XBwEYfIJt5yT5OrKMhUWA4iaZAWZa/4cIY3BR3h85CqiyrEKnDDMaBSdFcGXK2EK+hdfR8yG4e/GlDe0zOsKdWLZBPcMvIkoTx+NWq1WOmCCfShut2F6W09IcRuKR4aarxKsE6rmcxTj/39I+WHs6IdQOel7TIoZkN7lCrrN/UCYM+sMaon4Ww1DIJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Swjh5Yxn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Swjh5Yxn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hH2wl2C8Xz2xRs
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 11:09:26 +1000 (AEST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-ca97d139d8dso36956a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 18:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786151363; x=1786756163; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6xF7Vf0vsAzDGiN9uOUXdMTijirUIpfVi3ov9/6Fs1k=;
        b=Swjh5Yxnp9dxoJibsQA0W3dg8XKp/rYrT8JsDoCbJQPm2jEuOpQ3sx/v6mgLEn5ji9
         /WQeH/0SK7b0f3+r+fvg4iWKJUgPbsyC5GAJoEEpDtcMlEj8KbEePWj+oe5f9ZpTpOss
         yZax9A4ra7ZtSXRBtPerTEG6CBJofDKU14t84C5pdWHSapIATyBTOvPgLF/dYSL8Q3uz
         jMtizkACys0ntn5j79w22ysXLAx00UkS1m+dtDNQy9Ufi2w2DQruyVz9wCl3+6lx1U5S
         VBzExuWiWModZADlfriMzJKCeiYWrOUGvUI7M4MbVmNC9pMT3eVI70msGiSVJup+oNaj
         ujUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786151363; x=1786756163;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6xF7Vf0vsAzDGiN9uOUXdMTijirUIpfVi3ov9/6Fs1k=;
        b=ozLZNK7S+VzWEandCYrMF8hQ6w1TM4h1ZIpyh3+pVU3yV7wN6pcTzZgs/0kukskFn+
         VgcMJOX0lh/SAkeZdnB5Qzy0PllXeCuvxbaJFKIbbPmyfYbUJd0ZIU7rXJvpwnWtRqxo
         TY8wFvmzuAfJSmdwofzkZ1s2kUmoC7yYen5OF8edZur5sirvO0/5R6RnWkkPq3xrEacc
         9xLL2Qau+FMJJkZ6JqPsty47LIjWm8OSyTi/QOZR7I7anXg5oKqzTZZj2xZ0tFGbRcgu
         ZPr/oPBmB8liKlp9cv7393oiUlDSEbrNczPH7xlgiP8v0Iylvx/g5z9DkgVV0yvxEX4l
         xcyg==
X-Forwarded-Encrypted: i=1; AHgh+RpyDB79lvIs+OfAGLu4CJ7RPmWy+MpAPLFp8iyMo+DMzyXqkQ2AKMhwVmLjh81SZcrMOuH98XfEweaP9+A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyf4Ou/qhafYEqVC46uXf4kzokkh6SJW4cGO8ySapiVQ/sD24dg
	GdDX0mnrRn2ObfPqVlYJAqsh9PBnSx4seZB5KG8lMx+ZxDUufdOllVI2
X-Gm-Gg: AR+sD10EtFl1F6uDwFV8ebxVyShaBTLa6K+NmGVMTGbgoO1qvKZqiX873m0n6FOCnmV
	w/8Te1ppbPngIRyPFrVJV3IIAMqBVje3GTJnWMcQGKD+bcYzM/dNep1NPgfd2GbwE1pFcftQjnM
	zhz4j/oXFi75He8buxs4CcJ90UQdmpH/5WLzkdDASSqRFozBifZifMKP0KBQ7wdorO61eA2MDOl
	CMq+ZqKrSzR+GcZQCfmk7SuY084SI68ugz9bgrxLfo2daV/Cuxfa3b+xwIT0rlh1VFsAoRkIZm4
	Fog3YbyG1Bn/Yxbe7GGN9s7W3sRXT3qZ+zy4ULEKP+GXDRuE+1b9Kw7D0CI03QQ6jOZHjCU3OrX
	yiWfvS5wQI5D6BThQse/RaUH+C/ickiXFgFQe6h4NTnOr6BONcPdEIlr9xpQiwQ/kqxHkLzRYwg
	Pn3J3EBG1qNKb/2XgW9YYceyc3s4olKof481tP231i0sxUqRipinsquU2Jbzc=
X-Received: by 2002:a05:6a20:c79a:b0:3b4:71c1:ab29 with SMTP id adf61e73a8af0-3cbce7d128emr5049089637.16.1786151363483;
        Fri, 07 Aug 2026 18:09:23 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141018f18d6sm12260170c88.0.2026.08.07.18.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 18:09:22 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Amit Machhiwal <amachhiw@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [PATCH v8 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl
In-Reply-To: <20260807172433.82045-2-amachhiw@linux.ibm.com>
Date: Sat, 08 Aug 2026 06:30:40 +0530
Message-ID: <33wpl93b.ritesh.list@gmail.com>
References: <20260807172433.82045-1-amachhiw@linux.ibm.com> <20260807172433.82045-2-amachhiw@linux.ibm.com>
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
> gets zero-padded trailing fields. Newer userspace passing a larger struct to
> an older kernel (usize > ksize) succeeds if trailing bytes are zero (the
> kernel reports back min(usize, ksize) as the filled size); if trailing bytes
> are non-zero, the kernel writes back ksize into host_caps.size and returns
> -E2BIG so userspace can retry with the correct size.
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
> The ioctl returns appropriate error codes: E2BIG if usize exceeds
> PAGE_SIZE, or if new userspace provides a larger struct with non-zero
> trailing bytes (with ksize written back into host_caps.size for the
> retry); EINVAL for an invalid size or non-zero reserved fields; EFAULT
> for failed copy operations; and ENOTTY if the backend doesn't implement
> get_compat_caps.
>
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Changes in this version:
>   - Add PAGE_SIZE guard after get_user() to bound the check_zeroed_user()
>     scan in the usize > ksize path [Ritesh]
>   - Drop manual usize > sizeof(host_caps) pre-check; delegate entirely to
>     copy_struct_from_user() which succeeds on zero trailing bytes and
>     returns -E2BIG only on non-zero trailing bytes; handle -E2BIG with
>     ksize writeback and -EFAULT escalation if put_user() fails [Ritesh]
>   - Fix host_caps.size on success path: use min_t(u64, usize,
>     sizeof(host_caps)) so new userspace with zero trailing bytes gets back
>     the number of bytes the kernel actually populated, not usize [Ritesh]
>

Thanks for addressing them!
The only remaining comments from Sashiko now are because, it cannot find
the implementation of ->get_compat_caps() since it is in the next patch.

So as for this patch, the changes looks good to me. Please feel free to
add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

>  arch/powerpc/include/asm/kvm_ppc.h  |  1 +
>  arch/powerpc/include/uapi/asm/kvm.h |  8 +++
>  arch/powerpc/kvm/powerpc.c          | 78 +++++++++++++++++++++++++++++
>  include/uapi/linux/kvm.h            |  3 ++
>  4 files changed, 90 insertions(+)


