Return-Path: <linuxppc-dev+bounces-25623-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6E7C5AD2B
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2026 01:28:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hH3M01Sbhz2y2B;
	Sat, 08 Aug 2026 11:28:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786152524;
	cv=none; b=IqGbDZhlYQAXqEYw6267E9gxohW660180yERJiNeFjFz/Fmsx4uI9YqMiHQxgyBA4QCoHu3lpQqw6QFNiwQ1vDIyd422mroMbClwIGyUp+PdTnGqxUuYZuVmjqRk0795hhJU2QEXCnzpzPSKYnALrqhd8E6VT6hIYzmCYctyNsA2JqZgdYDrfKGg9cueBeQt1aa1L64p9lyTmWJMr6nPfwqkfMBGjlFMn7MSE3ctMjI2J4veKMa3mS6pMVBiFXzQOMtmVBWfuCW2IzpcngwlG0yZDIulm8muJUnFYFQU+y9hmhm4eUpO8jwoF6xZ22s8tXVjp5Jkk4KHeSroyQMGOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786152524; c=relaxed/relaxed;
	bh=gV4/f4i3yCF3yK6Yu68MBc1aKGo1uWVG8UkP+jo3PLM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=GxL4mTzZ23x1Xh/3mwr73Y1fVEf4/El0f/Ct9fuBTJaxdQkGaH7tAaeb4WEnoMklLs9cqNId/6dNaFPGgnQICa4hFLi9mR8rh6WrhDdRB6rx0jPkd0JG+1sApZaheGiPnVZnflHT1ZNpnepbSeZ+URJkca/g6f6vCwICuCNOLuA5PcvT+4WjzURjWdkt1JQCNqtOjnhFn5txfwSEKb6hKIp1B2s9Cr3oL4vMYnYOnJjmSre1oVGyBiLHTsygWleNGlpGHvRyRGuD6/7eKTnfGsv7ibOk6JE3Fkv+e91p5kErg0Zn92R6y2CTXWVSyevEm2b+U+CJfn0tSKjP8Qq23w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gI0+IRqi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gI0+IRqi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hH3Ly4qZqz2xRs
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 11:28:41 +1000 (AEST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso1861815ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 18:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786152519; x=1786757319; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gV4/f4i3yCF3yK6Yu68MBc1aKGo1uWVG8UkP+jo3PLM=;
        b=gI0+IRqiDBvnfq4ZoP6XXSrSyFMriD7b66z1EyBJOZJw0PZw9oBmhsSjKQQrNJ4ylX
         UuaCtVJH63W/37269lqHfo8A4WTNv4QPiXqPzyGJ23NVSBz56ShPb+T4bPCRR8xpghcN
         uuAtU5QAh+Zu5r24mTmAsGmVTyi5NUkFEhX+Rj/PmYXQz7afWGltP+FOOrh0ivy+N/hF
         LUc0bno7nMEUTv0XbqfizVnzgoGH7vbW+Kk4RhIgQYgxJZJ1pYMXBHTYo0Y9m2Ty2a/7
         OeG1sbKogiJUNq62mC2DFYTnGyq7ZhOa0MFXSH34+jrJxKMb3vXefGrOdcvG1nNuEW9D
         I7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786152519; x=1786757319;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gV4/f4i3yCF3yK6Yu68MBc1aKGo1uWVG8UkP+jo3PLM=;
        b=ccTqt/cdc0oL9/UURjPj3PGswoT1oj/T5s3DtXB1pfW6hu+1M796pS4b482XC08XU+
         j5fal0mjN3j/9hnfEKXhTeXTaZAR6o+MyneEF/Xw0XhNkiwMCbGjOR0MgRT4S5ME2PVS
         n/hB45a+p/nBjxxn/kSIM/Zh9UZDS8FvuYwhwAKGK30P+Sq/bLTvivg39umdvbVYmiSt
         NmaTTTgryYkErYuKlQoksVij6PDD/EPCtH+5Sg0TvlgfKgB2SIu7kY2W3jvM2ANaZFvs
         FZJeuYOr2kqW7jqFEWfk4URCbjo560k4Jyo3xdr4vtnum4HG22CtCGwFOTzgoXa4eyRm
         Cn8g==
X-Forwarded-Encrypted: i=1; AHgh+Rp0BwXBsV3CAVF1lRbNVmE6TDC9edeDSnwZ1EqBltNOditgzR/B6Cia2j7E1bKkaIqIjZdZEXOhRmbhpyc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzCscQy5HXthJI3QsFVDTbYjak/ur+XTQlj1GqiSYOsg9zfz/YJ
	godPrv06IdBvJvQbGEQ398um+iXUWzdC4GkPUFwtaPNpM8OfYEYesc7U
X-Gm-Gg: AR+sD10h1e4bQrKZgq3H/JtosF2k4xwzDlpMt0P49BBu5STOqz3uJwfcrORhdM6fRxn
	pPHFKy75iOhKCdcV9Ulli/BwefMFMPFQ0FFfGeFHazsiEztzEpPgmKBIQd2buUABpNwX98krTYN
	qJ4IOE4q75un/ZSUbBuTL9WGSD4g5dt29ZR9cgoQV6cHnqBprYFieBnRP3O38MGb6UG1oKiHk/L
	H5VaUUD5FpB51s8cWquJbNraM+FW+VqT/Uj/ZYehKLV+LdFMYOa/U304txIW7Ir8HQjOJDe3y9r
	4nj+l6+xcL7dHIjBFOaxU1tifhcJfNGBcVcwdLLDy9KLlOlS06jS/dePjVfXxFqhGc1MOEbqqQI
	Rn9Sp5Ehm/Jik3W6JGZAnqkRmfD2ggJHtZ2ucJCPEEl50iC2Q0dhvEcsRzTGMKB3KFZfIpEPpQU
	noyFKtZ/G9JQQMbKqBVKU1A63A3iqs3x357MXZIj6A/u8h9e0kq4ctkzTNefPa
X-Received: by 2002:a17:903:2d1:b0:2cc:90aa:8787 with SMTP id d9443c01a7336-2d0ca7b54e0mr347379485ad.6.1786152518599;
        Fri, 07 Aug 2026 18:28:38 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be568bd3sm12374806eec.0.2026.08.07.18.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 18:28:36 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Amit Machhiwal <amachhiw@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [PATCH v8 4/4] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
In-Reply-To: <20260807172433.82045-5-amachhiw@linux.ibm.com>
Date: Sat, 08 Aug 2026 06:45:07 +0530
Message-ID: <zeyxjtus.ritesh.list@gmail.com>
References: <20260807172433.82045-1-amachhiw@linux.ibm.com> <20260807172433.82045-5-amachhiw@linux.ibm.com>
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

> Add documentation for the KVM_PPC_GET_COMPAT_CAPS ioctl to the KVM API
> documentation.
>
> The ioctl exposes host processor compatibility modes supported for
> nested KVM guests on PowerPC systems. The documentation covers error
> code descriptions including E2BIG for forward compatibility, the
> extensible size-based versioning contract using
> KVM_PPC_COMPAT_CAPS_SIZE_VER0, the rationale for rejecting non-zero
> reserved fields to prevent ABI ambiguity, bit numbering clarification
> for IBM MSB-0 convention, and KVM-specific capability bit constants.
>
> Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Changes in this version:
>   - Update E2BIG description: document PAGE_SIZE guard as first case;
>     -E2BIG for usize > ksize is only returned when trailing bytes are
>     non-zero; zero trailing bytes now succeed [Ritesh]
>   - Rewrite versioning paragraph as three explicit cases to match the
>     corrected copy_struct_from_user() / copy_struct_to_user() contract,
>     including the usize > ksize zero-trailing-bytes success path [Ritesh]
>
>  Documentation/virt/kvm/api.rst | 89 ++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index e3003a241d5b..e656d117cd0b 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6566,6 +6566,95 @@ KVM_S390_KEYOP_SSKE
>    Sets the storage key for the guest address ``guest_addr`` to the key
>    specified in ``key``, returning the previous value in ``key``.
>  
> +4.145 KVM_PPC_GET_COMPAT_CAPS
> +-----------------------------
> +:Capability: KVM_CAP_PPC_COMPAT_CAPS
> +:Architectures: powerpc
> +:Type: vm ioctl
> +:Parameters: struct kvm_ppc_compat_caps (in/out)
> +:Returns: 0 on success, negative value on failure
> +
> +Errors include:
> +
> +  ======== ============================================================
> +  EFAULT   if ``struct kvm_ppc_compat_caps`` cannot be read from or
> +           written to userspace
> +  EINVAL   if the ``size`` field is smaller than
> +           ``KVM_PPC_COMPAT_CAPS_SIZE_VER0``, if the ``flags`` field
> +           is non-zero, or if the backend fails to retrieve or map
> +           CPU compatibility capabilities
> +  E2BIG    if ``size`` exceeds ``PAGE_SIZE`` (pathological input guard),
> +           or if ``size`` is larger than the kernel's struct size and
> +           the unknown trailing bytes are non-zero (new userspace on
> +           old kernel with non-default fields set); in the latter case
> +           the kernel writes back its own struct size into the ``size``
> +           field so userspace can retry with the correct size
> +  ENOTTY   if the backend does not implement the ``get_compat_caps``
> +           operation (e.g., on non-HV KVM implementations where the
> +           required KVM operations are not available)
> +  ======== ============================================================
> +
> +IBM POWER system server-based processors provide a compatibility mode feature
> +where an Nth generation processor can operate in modes consistent with earlier
> +generations such as (N-1) and (N-2).
> +
> +This ioctl provides userspace with information about the CPU compatibility modes
> +supported by the current host processor for booting the nested KVM guests on
> +KVM on PowerNV (nested API v1) and KVM on PowerVM (nested API v2) platforms.
> +
> +::
> +
> +  struct kvm_ppc_compat_caps {
> +	__u64	size;			/* Size of this structure */
> +	__u64	flags;			/* Reserved for future use, must be 0 */
> +	__u64	compat_capabilities;	/* Capabilities supported by the host */
> +  };
> +
> +Before calling this ioctl, userspace must set the ``size`` field to
> +``sizeof(struct kvm_ppc_compat_caps)`` and zero the ``flags`` field.
> +The kernel rejects non-zero ``flags`` with ``-EINVAL`` to prevent
> +uninitialized stack values from being silently accepted, keeping the
> +field available for future use without ABI ambiguity.
> +
> +The ioctl uses ``copy_struct_from_user()`` and ``copy_struct_to_user()``
> +to support extensible versioning across three cases:
> +
> +- If ``size`` is smaller than the kernel's struct size (old userspace,
> +  new kernel), the kernel zero-pads the unknown trailing fields before
> +  returning, and writes back ``size`` unchanged so userspace knows how
> +  many bytes were filled.

I agree with Sashiko comment here. This para is slightly misleading.
This sounds like we are zero padding to userspace struct before
returning. Whereas what we intend to say here is, when we copy user
struct into kernel (copy_struct_from_user()), we zero pad the trailing
bytes in kernel's struct.

> +- If ``size`` equals the kernel's struct size, the struct is copied
> +  verbatim.
> +- If ``size`` is larger than the kernel's struct size (new userspace,
> +  old kernel) and the unknown trailing bytes are all zero, the call
> +  succeeds as if the sizes matched. If any trailing bytes are non-zero,
> +  the kernel returns ``-E2BIG`` and writes back its own struct size into
> +  the ``size`` field so userspace can retry with the correct size.
>

BTW - I anyway feel this is too much. We can get rid of all 3 points
which explains how struct copying is working. We have more than enough
documentation around how copy_struct_{from|to}_user() works and we have
also added the comments around the code. So I think this is just
unnecessary.

We can just say:
   +The ioctl uses ``copy_struct_from_user()`` and ``copy_struct_to_user()``
   +to support extensible versioning.


With that taken care, please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


