Return-Path: <linuxppc-dev+bounces-25541-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7C1C2A09B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 04:43:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGWkb6fj0z3bwf;
	Fri, 07 Aug 2026 14:43:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786077831;
	cv=none; b=LmIpSve0x/gotA2gI96iH+lGR07O5vrxWvWeQo6HdjjhjH5j0PI+ZyG2DQG+n4i+h5AjeqMYY16h59pisX9vFMKj6jU02botWvMqiSauNbyBqLUNZrIQjXywSmk8GGE2CvUqwoIR0gJT+jky9KqvZZp5LVVhiXQ8m8iWTFkBeCWctox2ST/SqIjImgSwJmkYhySxXZwpsshGmhaBEw74xOP865NsMl7Pkk2MMzZHo3uECfdkyHrAlOG2BCBn8o55GrEhS0/I2IHsx7GzzzWDMQI07AWqMjGZqOFLK3TWvRRg6/zaXsoZbrkCqBEcLRhP25nZLy7mr2Ssj698GXICjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786077831; c=relaxed/relaxed;
	bh=QgHVsHtQu5HJOyA8OxcWU271rWUfL0isA+SyxkEMQI4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=kV/yyxP7XID24IYTaP/1s1YLZMATSV1bY84JyKiuM7NQRbtDKm6kKQxt+78bjDFuOyVE/A//jHT5h5Cgt27TNxiLQtNRJr7J6/YZtTGQdpuFSRUwvUkIwE5HjQ51v6/XH8pmphmzycnym8glW6NnsbplpRrZYF3ZKZ2iyl3LKJdR5vPRbZGUw+EDMqRqk8avbrd/Ta4yaNx/+QugWmgTIM8YxkKw3a8FN0ektLgBFTUFIkA3yT2Uihb4bXZ73h/uPjIHkM9ctMVhROIC9ycKJTKcIX/Tgcugl0Y1pt2ipvCfTNFCGvASFIr7M/LOA14wkoi3FiSjEMYN55RcwycNgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Er1oi75x; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Er1oi75x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGWkZ6thHz3bs2
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 14:43:50 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2cc891373e0so36138265ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 21:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786077828; x=1786682628; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QgHVsHtQu5HJOyA8OxcWU271rWUfL0isA+SyxkEMQI4=;
        b=Er1oi75xQ89ym1USjlzP7OXGLpvg2skXwnzcyEpGkMs1MUUzG90Wwanvbsjt9ybK4J
         UgNicKCRa2iCMLi7+KG3wLKZ30isTJQq3LFkSVxDcXU78LhCgT+tRaEScbwZkXZS+fVC
         tgzTKmXCOOe1Z8nD0KMvJs8uRQAgQlNaRY+gvHUWFFkN1ZQAKW0q1qXgrmb0PU7+9U1W
         P7gDJfV/I5v2tLPWnCd+ytnx+g8KGEw5MiEqjsOma9i17mtUw/3wG3AjpOVukx4m8GXs
         tfh+Vka+IoyEZ0xaZmFh4wwK9fSSPpNHFbhjC5jF/5v/B0Hb2rMEeKmYGKDZAJok2xsf
         eFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786077828; x=1786682628;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QgHVsHtQu5HJOyA8OxcWU271rWUfL0isA+SyxkEMQI4=;
        b=QrrBG1QT8UBGZ3cznopeSa1TE2Hb0smToI8CBuel3ZxTtymsCW21aPHG7c0w590WXK
         cRoTkB3HfXtoUnH7/Xu/eTE2MBKr28x6qaTzTdxmYyfj9VBP0eGrkp+mZbwCXphsSEL/
         mfwpII3zGImD2/9Tz+vBszKPyKx/u9BBUDePca5wrLf+ofw31NsaJjnsqX/jtbNOU2k/
         U9tCFU4f4zFfUajHc7cwnhJMlKItTXVrlb5IlO/MFo9zRn6mYvRitgXK6bw1a5Pw6Ds6
         pO+PJNZXag2VV1pLn3bdjknKACiDnGByPLzk9OwXTIRQYm4xO0YPHSGk0c3ewPcxyr7T
         97vQ==
X-Forwarded-Encrypted: i=1; AHgh+RoGM0k0zf1qAjo+hb/vikbgSrWKgOjx7BoZGRWRmo9X6Luope+NwS2VCSbe9mJRFnd5p3XTLqze0OkZQaU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxhVKOyBC3gyytX+MqgnFl63XRE4KdZKy7rUbhOvrgb2w0DQ3PV
	pgEmFy9q0cHMlkUrfHP6VqUv/pJVXsu20f55uxvtJRzkKvHsNdpKOyxO
X-Gm-Gg: AR+sD11zqPrGL3gDFyKZzilnXRpmr7z9cwVoNCQzk5vF52qM8+NrwDhovqUHzKSoDx5
	EcFc0bJtpAkbCUI05Xq75xYwpSVU/ueArj7oCHSlw7AU1y0qrXHaWJbTy+ll5W4vS7jVwCogzMd
	UDYA4RStr1yZvtQC4lsiI3MYH4AbmaJKJ9wrku5TKWBJqY6MJcYOJHML58PDzanCrbGewL7r0sa
	Cf5NIaE1xrg3VF8zCHIM6mGT12aS8RHNJr1TM/MNzLSrx1JsNm6Mi/mJCfnVLE0f+/Ca99TrBWo
	KrT5F/vscpUI61X5CgaGM581hURzhx7/QIAsWk553q5ryV98mEBvSyDECXwANdijGTgNnkqbdvt
	YRKhr8P3pEAKWzkneHLYLzoWkLyqUdBO4AFusX/9RyV3RFzCB0c6FTRuTDcmdX2ZWymDK+vWfnM
	RCJh7bQMHprMgEniR5ZpFGinahS5vNBRJiNqe7N7XtPyG1pPf2adCaTj0JEyY=
X-Received: by 2002:a17:902:d581:b0:2cf:a108:7605 with SMTP id d9443c01a7336-2d0ca75b37cmr255853705ad.11.1786077827947;
        Thu, 06 Aug 2026 21:43:47 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec5aac2sm2577332eec.30.2026.08.06.21.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 21:43:47 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Amit Machhiwal <amachhiw@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [PATCH v7 4/4] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
In-Reply-To: <20260806170645.11892-5-amachhiw@linux.ibm.com>
Date: Fri, 07 Aug 2026 10:05:22 +0530
Message-ID: <cxvulf91.ritesh.list@gmail.com>
References: <20260806170645.11892-1-amachhiw@linux.ibm.com> <20260806170645.11892-5-amachhiw@linux.ibm.com>
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
>  Documentation/virt/kvm/api.rst | 79 ++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index e3003a241d5b..22fedb0aa34b 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6566,6 +6566,85 @@ KVM_S390_KEYOP_SSKE
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
> +  E2BIG    if ``size`` is larger than the kernel's struct size
> +           (new userspace on old kernel); the kernel writes back its
> +           own struct size into the ``size`` field so userspace can
> +           retry with the correct size
> +  ENOTTY   if the backend does not implement the ``get_compat_caps``
> +           operation (e.g., on non-HV KVM implementations where the
> +           required KVM operations are not available)

Amit, this may not be true anymore right after your changes in v7?
Can we please update the documentation accordingly as well.

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
> +to support extensible versioning: if userspace passes a struct smaller
> +than the current kernel version (``size >= KVM_PPC_COMPAT_CAPS_SIZE_VER0``),
> +the kernel zero-pads unknown trailing fields. If userspace passes a larger

So I already requested that we should fix this. We cannot write more
bytes than requested by the user, since that memory may not be allocated
for this struct in userspace.

On checking Sashiko comments in reply to this patch - I think that is
also complaining of the same thing that it could cause buffer overflow.


> +struct (``size > sizeof(struct kvm_ppc_compat_caps)``), the kernel writes
> +back its own struct size into the ``size`` field and returns ``-E2BIG``,
> +allowing userspace to discover the kernel's struct size and retry.
> +``KVM_PPC_COMPAT_CAPS_SIZE_VER0`` (24) is a frozen constant marking the
> +size of the initial struct version.

Once we update the comments in patch-1 - I think we should correct this
documentation too accordingly. We should just simply use
copy_to|from_user_struct() style for doing this.

> +
> +The ``compat_capabilities`` bit field describes the processor compatibility
> +modes supported by the host. The following bits indicate support for specific
> +processor modes (using IBM's MSB-0 convention where bit 0 is the most
> +significant bit):
> +
> +- ``KVM_PPC_COMPAT_CAP_POWER9``  (bit 1) -- KVM guests can run in Power9 processor mode
> +- ``KVM_PPC_COMPAT_CAP_POWER10`` (bit 2) -- KVM guests can run in Power10 processor mode
> +- ``KVM_PPC_COMPAT_CAP_POWER11`` (bit 3) -- KVM guests can run in Power11 processor mode
> +
> +.. note::
> +
> +   The bit numbering above uses IBM's MSB-0 convention (bit 0 is the most
> +   significant bit). In the actual implementation, these are defined as:
> +
> +   - ``KVM_PPC_COMPAT_CAP_POWER9``  = ``(1ULL << 62)``
> +   - ``KVM_PPC_COMPAT_CAP_POWER10`` = ``(1ULL << 61)``
> +   - ``KVM_PPC_COMPAT_CAP_POWER11`` = ``(1ULL << 60)``
> +
> +   Userspace should use the defined constants from ``<linux/kvm.h>`` rather
> +   than hardcoding bit positions.
> +
>  .. _kvm_run:
>  
>  5. The kvm_run structure
> -- 
> 2.50.1 (Apple Git-155)

