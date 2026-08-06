Return-Path: <linuxppc-dev+bounces-25482-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DA8C55ABF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 13:49:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hG7t337N1z308Q;
	Thu, 06 Aug 2026 23:48:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786024139;
	cv=none; b=VOxCNhb1lcO4jWmIKS52WKdAra3BLjLZYua39pMjdMkJsk9lhPtpR2pRHo3uWgzdMCosd6r5TYZB6xK1h+pQ5dhygiAi5llUPyS+dADuD+LjFgmmQaUqLFi3N1Qn9H+VjqKEIaXHvxAen0nM357u2tEanb7ZrmAiuOd/5PZS7VARvNEuzHMHmKOys5xcoad5u8wuL0OaNfX+2GCHhhdcazNTum22WDO9jdXZspIL8MmObPHphlr8KxcaahoEROEY1Ggj+QOVSjVzLt/p72PSk1Xa48Opc47vlkhfxDIgEfqNrhQkNoF84IyI78VmBp1dOINe+Gkw0N+dn0CJL3DDJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786024139; c=relaxed/relaxed;
	bh=QjVIN0UdWGoOCTancp6az5kLjHEYcF1w7gKX5HKdYSA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=CxPinogNr+SbpKmGfBXK1nAKmA0LBBkrkMEWV7xM+cr9OY7KOZcZbZzQ9Jx0m5RC0V0nNxutjiEk31u8j6GdwWH6jVXxa4k+4hDLGG7Nl/PUfAGRqM4VGGuWeOhucRiFihR95fJWRvWTbRcuevOHtdKxQuhGPrllWdAp7praPdO3vUBQNGm7tJr5gDaccndGASInOqUjO2PIkZkgU8Olf4NMiFYoNxBpz4LYPiZq09SC59rHpaXMH6WnjSlGdbkRDCWj75UhAU1t2iz3wct08bS8J2dhgF2lSlRES1gE7HEK05umPkQbBYQlSztuhZxw6a/fSYNQY3v8DadNBbc5Cw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OwQKIRKF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OwQKIRKF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hG7t22QYZz304x
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 23:48:57 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2caea3f742bso31528205ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 06:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786024135; x=1786628935; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QjVIN0UdWGoOCTancp6az5kLjHEYcF1w7gKX5HKdYSA=;
        b=OwQKIRKFxiyRMpRkCTOoLTRDIJQYMOf1Kuaw0htnIWOP0+qEc0aF1Nmr8wXj1R3VQT
         sJ78OjdnXpNGZbyhnYhwNgPidBhganHrCbY+/5QJExuwaaAk/9mQdbzJ24v0QkEFkJFV
         PxedMD4b1VyJ/gDO1ebcGja/hdJUN0FJcXMhSsWEaIAUg8HO9BU0QjL5K6yIIe9DUx/s
         6YJNcPZdPJDBhhgq7sps6JDTNyQ7VLG5bQW8fkB9ShqaKtSC55+onQ0QhZCHBZF6AYs/
         dzdOB0khBxTf+SDUpMf4df6KSPg+WN/f2fQEVWRFicJTbWtukQbPUiTwHIalH1GjbAxz
         krQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786024135; x=1786628935;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QjVIN0UdWGoOCTancp6az5kLjHEYcF1w7gKX5HKdYSA=;
        b=VSpUOILM+waRXJzX0MXr5v+OOZ6lOygJ6HrqE5cMYyuDEJBywEebVzwJsrge3caFFn
         o1b5p2xfGIOAj0uxPceljwMXht98HAlJd+AsC7fKNj1Jb5ULbPyiUXxADsCSJVTefew2
         nFXsxYxVOwtgSJgwIleeoaYfnAmYpZ1tdTQPyy1zwVtTKSvfqKxMEGtvTjeOMT/W3Fh1
         ZAT1M3lNcPRvjwvWPVKtWDEd2ql7oqFlx45J+QFIafoHpDko7+hc6ZkqlUbnToK3R0TH
         gIDJicHAhNkJ+HVGjmSyPlcQ6x4KQNO34Q65UjWw2f5DGLD/cozshOehJgW3wMS4Qa49
         vuFw==
X-Forwarded-Encrypted: i=1; AHgh+RrRamHuTmNWbJ03iIP6l1oQbxOz3JfESDuoGWb5eqq8AmvPh+4iESUqIS8BetLio7njhJyQ5J1+AA1eokg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyA5GZUjZW6GJ5kSR3fkmZ+BfmwRYOqLBYLiXiOv4AXEgbhZena
	G8jba1F/p9PmxFEuK4ChyzJmUwgDeUf0stNbleG97hdoBicrXOtqrmRn
X-Gm-Gg: AR+sD11w+g4pfheANi1o2OojxA+/YCBddrgeZeAxpdFYtNruxhzJkltw/58yJLhpcDw
	FvDodjgsEJdU3GtAbRMIppGahWOSnqroP520hy8mkNtiO2tGvOR8eALxLbgCiVh06o3WQGGWWn7
	qTSnau/ZV7rIUq+9f3QbVWd11+2S0i/SQdlOKeFuC3UDP1SiUt0RZZvR70izlX88dpbKCR5+4VS
	mALK1HKSkQ2ctxkhmCEZ8pg0NfPlYAzu7BdZ6k4L65GcodetCBR1KGzQ2KsUtQRq6zNBUx3Jnkc
	1oBgWx1BLQ0i3B7gHobjEg7ENo3XjqJMmPMAtF7Y5Kx1fODV8PArPp7T4dVH+/IGBFtCF01o8gP
	bDibzucV8XwH7FWHz9IOAugSZ+F6K+lpW1bhfamcPBd8Gpl6sZ9xUZFRNsCzwZduUujxYQL91Lb
	F5D+ACRlZLg7KjEGqr9YMhrplnMLKOwgjgJ3lDa/H2DJqmoGBmO7XefvbY8Go=
X-Received: by 2002:a05:6a21:6013:b0:3c3:7ac4:dac0 with SMTP id adf61e73a8af0-3cb85df2790mr19356193637.13.1786024134598;
        Thu, 06 Aug 2026 06:48:54 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315ae6c1fd4sm6563410eec.14.2026.08.06.06.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 06:48:53 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 0/4] KVM: PPC: Expose CPU compatibility modes for nested guests
In-Reply-To: <20260806104222.7e435b28-8d-amachhiw@linux.ibm.com>
Date: Thu, 06 Aug 2026 18:35:31 +0530
Message-ID: <mruzl7qc.ritesh.list@gmail.com>
References: <20260804180705.59160-1-amachhiw@linux.ibm.com> <tsp8l8cw.ritesh.list@gmail.com> <20260806104222.7e435b28-8d-amachhiw@linux.ibm.com>
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

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> Hi Ritesh,
>
> Thanks for taking a look. Please find my response inline.
>
> On 2026/08/06 12:09 AM, Ritesh Harjani wrote:
>> 
>> Hi Amit,
>> 
>> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
>> 
>> > On POWER systems, newer processor generations can operate in compatibility
>> > modes corresponding to earlier generations (e.g., a Power11 system running
>> > in Power10 compatibility mode). In such cases, the effective CPU level
>> > exposed to guests differs from the physical processor generation.
>> >
>> > This creates a problem for nested virtualization. When booting a nested KVM
>> > guest (L2) inside a host KVM guest (L1) running in a compatibility mode,
>> > userspace (e.g., QEMU) may derive the CPU model from the raw hardware PVR
>> > and attempt to configure the nested guest accordingly. However, the L1
>> > partition is constrained by the compatibility level negotiated with the
>> > hypervisor (L0), and requests exceeding that level are rejected, leading to
>> > guest boot failures such as:
>> >
>> >   KVM-NESTEDv2: couldn't set guest wide elements
>> >
>> > This series provides a mechanism for userspace to query the effective CPU
>> > compatibility modes supported by the host, so it can select an appropriate
>> > CPU model for nested guests.
>> >
>> > To achieve this, the series introduces a new KVM capability and ioctl
>> > (KVM_CAP_PPC_COMPAT_CAPS / KVM_PPC_GET_COMPAT_CAPS) that expose the
>> > compatibility modes supported by the host.
>> >
>> 
>> Sorry, but I am somehow not convinced on whether we need all of this
>> machinary just to get these 3 bits of information, which we are
>> returning today.
>> 
>> Since KVM_CHECK_EXTENSION can already return an int, so why can't we use
>> KVM_CAP_PPC_COMPAT_CAPS itself and return the bitmap of supported compat
>> modes to the user?
>> Say if the cap is not supported, we can return 0, otherwise we can
>> return the bitmap of supported compat modes. This will easily allow us
>> to use 31-bits which as I see would be hardly a problem in the near
>> future. In the future if it grows - we can always use KVM_CAP_PPC_COMPAT_CAPS2.
>> 
>> This should reduce the code complexity both in the kernel and
>> userspace and we don't even need a new ioctl then.
>
> Thanks for the suggestion. I considered this approach

Then we should have brought that up early on during the design
discussion. But for the sake of discussion let's call this as
approach-2.

> but would like to
> go with a dedicated ioctl for the following reasons:
>

> 1. Intended semantics: The KVM API documentation states:
>
>    ..kvm defines extension identifiers and a facility to query
>    whether a particular extension identifier is available.  If it is, a
>    set of ioctls is available for application use.
>
>    [...]
>
>    KVM defines many constants of the form KVM_CAP_*, each corresponding
>    to a set of functionality provided by one or more ioctls. Availability
>    of these capabilities can be checked with KVM_CHECK_EXTENSION.
>
>    The intended role of KVM_CAP_* is to signal ioctl availability, not
>    to serve as a data retrieval mechanism itself.

That's not entirely true. We do return data as part of check extension
for e.g. for getting the SMT modes check KVM_CAP_PPC_SMT_POSSIBLE.

>
>    You may take a look at KVM_CAP_PPC_GET_CPU_CHAR for instance.
>
> 2. Return type constraint: KVM_CHECK_EXTENSION returns a signed 32-bit int. The
>    capability bits are defined as (1ULL << 62), (1ULL << 61), and (1ULL << 60) —
>    64-bit values that cannot fit in a 32-bit return. Renumbering them to small
>    integers would be a UAPI change and would lose alignment with the

There is no _change_ in the UAPI so far. This is the patch which is
defining that in the first place.

>    H_GUEST_CAP_* values from the hypervisor ABI.

No please. Those are 2 different ABIs and there is no need to set a hard
dependency among the two.

>
> 3. Extensibility: The struct-based approach with the size field provides clean
>    forward and backward ABI versioning via copy_struct_from/to_user(), without
>    needing a KVM_CAP_PPC_COMPAT_CAPS2 in the future.
>

This only make sense if we really have a usecase already in mind which
you are planning to extend it for. Otherwise, IMO, this is a lot of
machinary and I think we should consider the simpler approach.

IMO - I think approach-2 is a much simpler for this usecase. I don't see
any valid reason on why we should not do that instead. We don't need an
extra ioctl and all the struct machinary along with that just for
returning a bitmask. The existing check extension ioctl can be
easily used for this purpose.

Would it be possible for you to give, approach-2 a try? Do you see any
geniunine roadblock or limitation with that?

-ritesh


