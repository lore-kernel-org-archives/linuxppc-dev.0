Return-Path: <linuxppc-dev+bounces-21982-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D228CD6E55
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 15:24:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVs1h1ksPz2ySJ;
	Thu, 04 Jun 2026 01:24:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::534"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780500264;
	cv=none; b=WX2ipyOtOEnKF2QJ6VnMfTc5vZtcRfVmoNU96ocnWk2gkT+Mbhnj3yf1NyJ+35vfutR3QhvXsDtw+dlc0fDIvSkW4Es6mO141eE2Al+hLIeX/qxix1JmR2r9jPmvCDxD/zY0IP+57BN8K4ky7rcx+jBn0//qQD2LJpwlwubV+9vh0ZnAJz20XrH3h86NaxfnN6lyZv/KaZsYWu0kx3txbqkJpNCoG6F5aWuY5op7Sqh//84VAwJLIJ7iv1yLQxMo+rNugy7277B7ambKjWAg1H6IE2eq4YXgJ5/qD+sophMnVaqqE2WQcQ370qGsvfYDtZ9xGUJZTGNaZP5c3en/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780500264; c=relaxed/relaxed;
	bh=acwBnprFgwqGQFKcy6Zu5y1vKCe+2/zpivoZrYetfHk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=FtumcXNN3GP+i433iqhMrqHDaQTziqsneuA/WzBHI7+WfSxBSKkfAt1nCSyxx13i/7hheRXMsUQIr4L1d3fAsgUIfLdF5VNvUn346bvap3E8vy71MizhW70CIyLLAxStWzxTICjhjEf68yGyMFskavIoW9ZG5wiLy9WhSSXqLiY3QMJRoPkT5mETMIWy8ELkMdSzocmgdnC3KxcGV08va6aTFihvkpDlKanSjXEXqpCE970nRL3IjdJwx+vSKuSGz9FQ+Yeo9StSbi3dh/bvWxMgSBCuJOd9lNc1Wj2P8k7ouZ0gP14NI3LN7wUmX8Ahe4xcZ6zZ+j45KmUw5CJDxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T5Hdz/TH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T5Hdz/TH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVs1g09Dzz2yQL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 01:24:21 +1000 (AEST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-c8585ecdd71so1851931a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780500259; x=1781105059; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=acwBnprFgwqGQFKcy6Zu5y1vKCe+2/zpivoZrYetfHk=;
        b=T5Hdz/THV2PKOmtcGOeE96HScc5UwKxx+/lr2hcgy3RhFtEYgLW8oxjfQiMazGfNTb
         laz6xyxfaHPl2EXt+90PlM5S64H0AkmB2IOkIwcX/bRnDuiVM0dFZsa5j04e8oJTFafW
         XSvKWttu6TR4KlEvUEkwsrjOZsJkCBIO/DG1wAGY5jW3KYpzBMqBgnd0GXP3/YJmngih
         xDnMeo2a12Relb5GG3wLUNTB0tNzktotWcvS65Y4DrkTUtF8KNA/43HSQgFKiuac9u46
         q+hocKan7Oc06ydQOB+qXY3g/GB2NRub+uQC8lm7r1ZUyqLutylVpp2Kj7TfU9YbbTB4
         Euag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780500259; x=1781105059;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=acwBnprFgwqGQFKcy6Zu5y1vKCe+2/zpivoZrYetfHk=;
        b=Hws9VGoOWPJ7OSrkgTUJ3wS2JE1tjpc5xv20+z/wdH0Wzn5LzV/lI/7DbOCgP8y7VR
         LitESLx6qQYdc0ie2MyCV3t5p0D38N9p5dNT2+5cp4fgTL/i8IWtnX0nezQE6mzqE5aZ
         /i0M5UuPgbBvKWieFq8adZDWdhJ/d68vYW3gK2r4mFGnlxILx6DChmRFXBpfUBX+lWqw
         WzpR9qSa5fEjbIrOBxmLmaF8SssSZn6x+9uVhofghpAyopKemz5ltsYhiGs9EBNA0xwc
         G88dyAem/sIGVh3ahDhczBNK0QtJTYlDxHt637f0U0e1Kh+nIR+Qm0Dd72LuVxUHCbh/
         K/Ag==
X-Forwarded-Encrypted: i=1; AFNElJ8SYPe5pYPAklA7JWKIblGQTBdBlLYKIhcWTRBsK7el8flKfxskEUO3BLSqZGW4/FPm5TU8mb/D/BbBuLY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxrd5PWgMKWMDoWp8HNEEPvndJ6XAysPH6ygdN/SN6dCqFD2B1x
	ZM6LywhfaVwTyuqt0B1t1I5MI7xwWw5rvU+mEos9DMZz4NhQnMOA7WY4
X-Gm-Gg: Acq92OF/WmrVnN1/Q5e3gDXle7su1t/nzlERciXHkR09ZidcDtGzbW6zw9vMGby8V7v
	4UmZpEjOCS4fO58OMfYhLqEJFg7fsj6kKdZ+6UM4fLZSaKMF/rp/InSG6Zz0rVBstCj3PtzlsaM
	HRX4Udck+exiy52CKN1ZccyyflT0Ka0DSNSacw9XMJlLG6MUOybkmpK+lzWy0YapGYPZbr0RE+l
	Iqie/0CjZjg+nOyMVDqbbuti86geMxyzKhpbrJWq7MtyBMZyj41ZgHr8YDa2E44vppt67m8dpCd
	54da/4OntsYLB2rSZLYHzoDerT0/qfoy2ZxUP6tOlvwKasskIO+aHrlmtsVbdjBjLwFAhhQ6TOY
	YfRtYWYu4uH/CL23PUNQa4BpVy6uyx1tU0290NZG+kAONwJ+o+w9TtOvRm7gYIzZc5tOMJul/ms
	G1Dan3GmxgRp6+AnE/N9tFKAFdfazHlG/7
X-Received: by 2002:a05:6a21:691:b0:3a2:d68d:9e78 with SMTP id adf61e73a8af0-3b49732971emr4778730637.4.1780500258903;
        Wed, 03 Jun 2026 08:24:18 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df043ce0sm2671767a12.11.2026.06.03.08.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:24:18 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, kvm@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
In-Reply-To: <20260603141539.47620-1-amachhiw@linux.ibm.com>
Date: Wed, 03 Jun 2026 20:41:15 +0530
Message-ID: <pl278xrg.ritesh.list@gmail.com>
References: <20260603141539.47620-1-amachhiw@linux.ibm.com>
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

> On IBM POWER systems, newer processor generations can operate in
> compatibility modes corresponding to earlier generations. This becomes
> relevant for nested virtualization, where nested KVM guests may need to
> run with a specific processor compatibility level.
>
> Currently, when running a nested KVM guest (L2) inside a Power11 pSeries
> logical partition (L1) booted in Power10 compatibility mode, the guest
> fails to boot while setting 'arch_compat'. This happens because the CPU
> class is derived from the hardware PVR (via mfspr()), which reflects the
> physical processor generation (Power11), rather than the effective
> compatibility mode (Power10).
>
> As a result, userspace may request a Power11 arch_compat for the L2
> guest. However, the L1 partition, running in Power10 compatibility, has
> only negotiated support up to Power10 with the Power Hypervisor (L0).
> When H_GUEST_SET_STATE is invoked with a Power11 Logical PVR, the
> hypervisor rejects the request, leading to a late guest boot failure:
>
>   KVM-NESTEDv2: couldn't set guest wide elements
>   [..KVM reg dump..]
>

Thanks! It make sense to return a proper error code to the user (VMM)
while the VM/VCPU are being initialized, rather then the guest failing
to boot with a weird error like this, at the time when kernel makes this
H_GUEST_SET_STATE hcall.

> This situation should be detected earlier. Rejecting unsupported
> 'arch_compat' values in 'kvmppc_set_arch_compat()' avoids issuing an
> invalid H_GUEST_SET_STATE hcall and provides a clearer failure mode.
>
> Add a check to reject Power11 'arch_compat' requests when the host is
> running in Power10 compatibility mode, returning -EINVAL early instead
> of deferring the failure to the hypervisor.
>
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Cc: <stable@vger.kernel.org> # v6.13+

Sure, v6.13 sounds fair as you pointed out.

> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Changelog:
>
> * Moved this patch out of the v3 series [1] as discussed here [2]
> * Addressed below review comments from Ritesh:
>   - Based the PVR validation on cpu features
>   - Fixed hcall name typo
>   - Stable backport

The changes looks good to me. Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


