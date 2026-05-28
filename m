Return-Path: <linuxppc-dev+bounces-21629-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E2BCD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 10:50:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gR3D46zm6z2xM6;
	Thu, 28 May 2026 20:50:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779965412;
	cv=none; b=SPWialfS0AvWq/Q8IIqra1rBB7pROzbcNFfByLmmoZyGsde4rPAjtgGwMGuUHw5BU25Qne4OUslv8ybsy9bNKL9C0dp/yAJWKIaK352iLDCd6lkkp7Z/MBPDAzzUinbqgdvyzKZwlBtC1qvC9QFm0n+ESV28kfjmquFSssOmXhVTQO69j5EwUL5ihHtAyvmhzBIK77simDBsjyFNlFXxIXIrjvZdDS3dS8bFENP1JCtlWmZRfpd2os6hCo+7C3f1+wx6eW3bO3VCXCsrXcii80ak4KZ8f/v/CAENIsJiGa4XkFZ4Oys+5zAVMoAi9a6XNrxdFcd6I5xUBitZRylqMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779965412; c=relaxed/relaxed;
	bh=46bMWh+gCQYzpY1dEMifCzkdbqK+/RCfas0dsX6v9EQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=WFVriX/mPg07RnL8ln4zRu/sm80c3SIHnSNoR/jR9sfZq6ZYCYqTcLLKqoB7t8dTH3VAjxReA0tmL67UV3QFgYhHS/3hw5DknxK9q0Nqg/PUmsE1Quew+yGpWGWOAjvX941LCcDwuhdZjojr+pgA8yh2Vzaooc2sq6bMA3KnbGItmAvamenMX8TZoyWJAbCF1uIiiEGR/2a1uD8Rh6MqdPiT7X54cwVdAiSqmQn5cNpnpx9OKw9qcTjU4giA607PpY6t9didbOiAc6SApwxa2qZOyGXuZUMIwO26voc459HWojRI8XApaoHThJCcZmMQKmZ6AQXiWioJniUiJRUR9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OIlaMZec; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OIlaMZec;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gR3D31P1Gz2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 20:50:10 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2b941cd869cso82272785ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 03:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779965407; x=1780570207; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=46bMWh+gCQYzpY1dEMifCzkdbqK+/RCfas0dsX6v9EQ=;
        b=OIlaMZecRr69xVPiU69nlUqDJgbWfM9IDl1tm+hU5wFwBfKGak3vOhIW/Zn+dPwC2a
         zio1VU6noXpUB8Tof6UV4fDB/aBdnLORZm8USoNhNXqYFeiEcz8DrGsRdHBP3FdrIquc
         CTOD9ww6TMUuZ/Q2BTvD6mP3FoJKxkP1w+q9mtUexoSK1XEI0xV+wzCH3plNnkLITc9d
         tjXkniIiQ4+cExzBP/Cn+HvmYhpDuGI6y0yfQ1yZPj2NtY7EncvlhzjpYfwKfnXM0ocY
         Z2onJcD7H01/ae3WqMVjc0t4wI07CLTAFbYTK6efj/4ACDf/q8npBnECLBrmx+dvREZn
         NbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779965407; x=1780570207;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46bMWh+gCQYzpY1dEMifCzkdbqK+/RCfas0dsX6v9EQ=;
        b=cKG8R0dj3dD2xpAdM0COEtQKBeBil2oqGy64K1pqf8/JOEIfO4drSlPAQcr6IofCo6
         iixKERURCgHYfT+SADQxS5h7tVBQXH7mwrmjwqm5Z79aoHXSc9cfID05vbmGcuaXm9gE
         keWgAYV5k3PT93vZkND724hjOdxqWxH0ER61A7DVfDm+0FgWn9+k3InE/ijPsetIiylC
         yeIGHr0+BB4tZ6//4rl4nZWhHQQShscCwFuGSNyyJW24LP4pIvSW6msuHWGgOTMHwDKW
         A+UYpb1ezC8UWavHHTgVWJQ4OIKgPf7EzYD5gZfcFQQX9V5Ho+Wt5HwN3fmuWm9rr9Le
         G9UA==
X-Forwarded-Encrypted: i=1; AFNElJ9mSQSvg7+ooD1jGpdN9e7lilnLIoG7+SnbJ/RXLtW19MbxHicoOMHKX7IcKQPGIVmA6cBMmW4Qg2Pxqa0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzZdKu/i8qz/s1tWuBojT5UV1Vzf14unfiZ6WFq1WrYSB5mnHIk
	YFVyOLGiwTfaNsJx8r2W+rTulkYtHZr27innuuNJQgyY/LUmU+ZOQSDJ
X-Gm-Gg: Acq92OFIYk1oEnplNK/S9dpUBN8aPblt0AWkv1Y+yuuMFG/bV7X2ZKVLmUvSqCLYcpR
	5WlwOsxPx0Hq8T4DK9Xohccg1mAzEGzWdRSYTCmG/Ej6ABHhN0u8ObndnrKX0jc94FM5QyPsOXp
	iQ4ndKFAL+glZmistfrDYhrdSb0GqMJOcO8iNFa7DUzA/gWClsQv+YHV7XBaPzOZ5mDIXlpjbQv
	Ch9M6PlZ0bp4gz8Sli+C4DZHJ0NJyiTHMCSQ+NGl3dwwAjTJdvGy53mmD1eqzXfnFg1gsAt8MMj
	7Ptbk1kVBPwhy78485hJiJCkuIfcdSWN5Qa3wqYbORX+Vb0o6MTSiD94hX0YSn64sLrzKAwRiz2
	4TrrRtdiSybOe1uRm+zMKxBrcjOsn3j2MoGbRKxO1uhi2XPXkh8mQtPA2abOyaDZgiX/TaOgoSU
	WXmR6asL28We/jKRxok7mL0JXdXQtNutq/
X-Received: by 2002:a17:902:e845:b0:2ba:4f37:d3a7 with SMTP id d9443c01a7336-2beb06a63c6mr311583635ad.27.1779965407101;
        Thu, 28 May 2026 03:50:07 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56bc151sm180571765ad.24.2026.05.28.03.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 03:50:06 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Amit Machhiwal <amachhiw@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH v3 1/5] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
In-Reply-To: <20260522152744.55251-2-amachhiw@linux.ibm.com>
Date: Thu, 28 May 2026 08:43:04 +0530
Message-ID: <pl2g6xbz.ritesh.list@gmail.com>
References: <20260522152744.55251-1-amachhiw@linux.ibm.com> <20260522152744.55251-2-amachhiw@linux.ibm.com>
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
> When H_SET_STATE is invoked with a Power11 Logical PVR, the hypervisor

s/H_SET_STATE/H_GUEST_SET_STATE 

> rejects the request, leading to a late guest boot failure:
>
>   KVM-NESTEDv2: couldn't set guest wide elements
>   [..KVM reg dump..]
>

I think irrespective of the other UAPI changes, we should still get this
fixed - so that we don't see a late KVM guest boot failure msgs.

So, in this review, I would like to mainly look at fixing this issue
first and would request if we can defer the UAPI changes as a separate
patch series please.


> This situation should be detected earlier. Rejecting unsupported
> 'arch_compat' values in 'kvmppc_set_arch_compat()' avoids issuing an
> invalid H_SET_STATE hcall and provides a clearer failure mode.

s/H_SET_STATE/H_GUEST_SET_STATE

>
> Add a check to reject Power11 'arch_compat' requests when the host is
> running in Power10 compatibility mode, returning -EINVAL early instead
> of deferring the failure to the hypervisor.
>
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3..249d1f2e4e2c 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -446,7 +446,19 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
>  			guest_pcr_bit = PCR_ARCH_300;
>  			break;
>  		case PVR_ARCH_31:
> +			guest_pcr_bit = PCR_ARCH_31;
> +			break;
>  		case PVR_ARCH_31_P11:
> +			/*
> +			 * Need to check this for ISA 3.1, as Power10 and
> +			 * Power11 share the same PCR. For any subsequent ISA
> +			 * versions, this will be taken care of by the guest vs
> +			 * host PCR comparison below.
> +			 */
> +			if ((PVR_ARCH_31 & cur_cpu_spec->pvr_mask) ==
> +				cur_cpu_spec->pvr_value) {
> +				return -EINVAL;
> +			}

Instead of the complicated check can we simply do this?
			if (!cpu_has_feature(CPU_FTR_P11_PVR))
				return -EINVAL;

which means that if the Qemu is trying to set the arch_compat with P11
PVR (arch_compat) and if the host cpu FTR doesn't support P11 PVR, then
simply return -EINVAL

-ritesh


