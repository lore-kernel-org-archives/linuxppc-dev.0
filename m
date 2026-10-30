Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE43606A325
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V3eSK8ix
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGQ2M3nsbz30Vv;
	Sat, 31 Oct 2026 02:27:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1235"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793374043;
	cv=none; b=aGGkwYSoB1ol8YNXDnsJIPdp6Mswghmuv/W09JB8MlcbCvWVKKVOCkEkaDhih2aPC8E8NmKyhw80iPixw8iNpHiQm9BryJnH5u1UHCY7p68spjh3xGKAP+UUdb4OaGB/+NLQz9iWXNziqMM51WJNryoEHIHTfgDdYAPijHyN+/CJa+X/UWmcCcUIDEM/xIQd4Bc49l6swhbA3cfga33GmnfufTR17fHsASdDRCUJujm0jipeB3jFGbuz1vlhwenVv9RxblNggYJ6YUl3Bx+w0ml66JBZryyE53MKAZsEhEwIcpaN/9uSNcIckvpRlCaC0N9fmLGrwjWN1/vCJW4RFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793374043; c=relaxed/relaxed;
	bh=e+m5QU2XeT3uQPTC6GC01opeM6s+W2OonF16GBipID8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=i6UgyVTLXIZPaznRDl+1L3pkX7G11Ct7NF5ZdGzT3AJI1NUSAmNQyQq8nfh1CIYxYt2MLA6WzC5JxwZ4JShe03sejeN04p1LbUIMO4imct98ObKZ/Cgm5SD2t7uANrq7be8LWEuYHnc8qnXLscBMxFDsJOQNWgL4k8gjxWQE/nzxeTzzWO50FNvHSSuJ3zsWZcWYIOwSf6wkMjWXMqIzkB93NLs7WDaWrWp6PlNeZKCOzeJSRn6/T9VMbhVB6m36Dv2nNeeJLkVUNTsHqA7AXJ3uACRpOx3nOu5KD2ypvagfPLGZGFA1nzMWcfgCFg+GRIhpkeKZ/TBL/z6j5Twr/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V3eSK8ix; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1235; helo=mail-dl1-x1235.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V3eSK8ix;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1235; helo=mail-dl1-x1235.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1235.google.com (mail-dl1-x1235.google.com [IPv6:2607:f8b0:4864:20::1235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGQ2K5mp0z30VV
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 02:27:20 +1100 (AEDT)
Received: by mail-dl1-x1235.google.com with SMTP id a92af1059eb24-15ea896ddc8so1375591c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 08:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793374038; x=1793978838; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=e+m5QU2XeT3uQPTC6GC01opeM6s+W2OonF16GBipID8=;
        b=V3eSK8ixjwr4hdVp3Wb30SqveqzZMoA0ZAv4OUcu7RRMHkZ8/TbiEeHiuGB+MNSm/m
         w3G2IyxZblyyUV/07l2i2BVC9NdYIak3mCSj8P0iwkQY4JWimCbwW64QKd+rGK/hTT8R
         Rpo0iX1eUJBg5DHqGK1qwnt9LoiDz47nrhv39dP3zSnzwl3kgx1ZkvkwE944q0PV7jce
         SvFJr0PQ6T1zVUhw8eIxkcTQg2TQ4E21qgIUPr3BjmCTg+lJIPSA7SSg5TL6MrOhllmc
         NeiOV2CRIPiUfh7Ydw8oSXytYSIBNoFfRtRWYts7g8aQoTKQPjoh57fMauCFp1f2PKPo
         2dQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793374038; x=1793978838;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e+m5QU2XeT3uQPTC6GC01opeM6s+W2OonF16GBipID8=;
        b=DSwI/b4wLh9pxsk/ISyPT1RwosKlFLlnM7nLcglXVbFpPx7Kow1ll41VblgaiwuDKW
         r2maN4io+CUdj3qyaBs0GFHOhIjZppBVPlwly4p/ie6H5HNGT9QUYyq/hOsTH7MvMLxY
         PDXvZpOS8QHAKGmXsoUG9swTPhl0egPWbvoL013324ijJtAUCaGiq+53WISLfkcJPW/M
         sca8YbhV5/WZodmjzhfxmH0oUAjlAtTB69bfb5i9eY+Uxvq7xnxkFW5QGAZ5qtA38cZx
         o0AHP6aF2P+zmPp0Q1sMLU/n+RMUDwnuqn0mGD+XE3ZGSiptTkXbRdOyYl1BHjLFxHHF
         hTdA==
X-Gm-Message-State: AFq9FYJHKrV91UkAQ78paBky4t2+evaLLj8gLIF0iVA0I2hrJ4urOwRB
	PyZINMMUhNVr7afOuwwXPkFFl5pEuO7BBxz3cRkfttXgW4R2zL9qX80S
X-Gm-Gg: AYBFou1pTpsU0KwsQCLxZiRBZBuwSmyFuMiszxRU+kLvKE9LKBME4kB9o9YU6Gq4sA0
	JRKqR3k1Q+fqRpJG8jbWFU9XyDVh5zWCzBov8ilQWao2CFWJpkx1N2EmCxp2jC3wpY30hH4E9Fk
	kcM4eI3iM3m4KE9DGjLziuwAo2M90JIBQPJ6HkUko348uEzUZBI6vsQqzg4WBVrS8WX9suOTyvs
	7GEAYHVoOSqimaf5euibbCghlfbmGG8giJNnZxtir8NSjj9O1sXuEXoS3NsGdPQsNiE+4UusJK4
	2X5oqVfVu2UR2bYhV9Ci9DXsQQOWJdgq9T9bJoHzjeYcicX8i2IbNLECO6deb3OucW0ZdhVvtIq
	BfVrzK9eMD0583TMuE35wt38Pp7tDesc7FPZvtW0n/2mCaz0co/DWp2rZ7W3QRfZOUT5BGbqYGH
	H4z/qmXWF/xU9FXFcusOCGnKiW0So+7o1pTZW+MjNsw3qac6u32OMIRSInaB4+dZCPclwK4t0CX
	W0giPqwGfh8r/HfWWet64r9M8ENKqLYKUOOAFTfEgIntaypu0fc8ZBU8eEEq+uptNoO/1/WQDLn
	R69kvs6YvoGXk2DLDbo0sM40ShY=
X-Received: by 2002:a05:7022:7f0b:b0:13b:3132:6e99 with SMTP id a92af1059eb24-1ac5af2da84mr3344929c88.20.1793374036049;
        Fri, 30 Oct 2026 08:27:16 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42aa8999sm9261448eec.29.2026.10.30.08.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:27:15 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com, nnmlinux@linux.ibm.com, amachhiw@linux.ibm.com, harshpb@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: [PATCH v4] KVM: PPC: Book3S HV: Avoid spurious interrupts caused by LPCR_MER bit
In-Reply-To: <20261005084534.1588611-1-gautam@linux.ibm.com>
Date: Fri, 30 Oct 2026 20:48:15 +0530
Message-ID: <4ie3w72g.ritesh.list@gmail.com>
References: <20261005084534.1588611-1-gautam@linux.ibm.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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
Precedence: list
X-Archived-By: <archiver.kernel.org>

Gautam Menghani <gautam@linux.ibm.com> writes:

> A huge number of spurious interrupts can be seen immediately after a KVM
> on PowerNV guest boots up in XIVE mode.
>
> $ cat /proc/interrupts  | grep SPU
> SPU:     223705     192439     273526     147623   Spurious interrupts
>
> This bug was introduced by commit ecd10702baae5 ("KVM: PPC: Book3S HV:
> Handle pending exceptions on guest entry with MSR_EE"). The root cause
> is that once LPCR_MER bit is set, it is supposed to be reset by
> software. But when a vCPU starts running with LPCR_MER set, the vCPU does
> not exit back to the host until the decrementer expires or there is an
> hcall, etc. This is because KVM on PowerNV guests have support for
> native XIVE, so they are not dependent on host for interrupt emulation.
> Due to this behaviour, a huge number of spurious interrupts are seen
> since LPCR_MER continues to be set and LPCR_MER cannot be reset until the
> vCPU exits to the host.
>
> Fix this behaviour by not using the LPCR_MER bit whenever native XIVE is
> available (currently in case of KVM on PowerNV only), as the XIVE hardware
> can present interrupts to the KVM guest vCPU directly. So the LPCR_MER
> functionality is not required. This reduces the number of spurious
> interrupts drastically.
>

Make sense. 

> Fixes: ecd10702baae5 ("KVM: PPC: Book3S HV: Handle pending exceptions on guest entry with MSR_EE")
> Cc: stable@vger.kernel.org # 6.8+
> Reported-by: Timothy Pearson <tpearson@raptorengineering.com>
> Closes: https://lore.kernel.org/linuxppc-dev/582904882.11159.1786719390349.JavaMail.zimbra@raptorengineeringinc.com
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>


> ---
> v4:
> 1. If interrupt mode is changed to XICS during guest reboot, MER should
> be used. (Amit)
>
> v3:
> 1. Continue the use of LPCR_MER when kernel-irqchip=off (Sashiko)
>
> v2:
> 1. Handle the case where xive_interrupt_pending() is true and also the
> external exception bit is set. (Narayana)
>
>  arch/powerpc/include/asm/kvm_ppc.h | 7 +++++++
>  arch/powerpc/kvm/book3s_hv.c       | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> index 169ea6a7fbad..9178406dc365 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -747,6 +747,11 @@ static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
>  	return vcpu->arch.irq_type == KVMPPC_IRQ_XIVE;
>  }
>  
> +static inline bool kvmppc_xive_native_enabled(struct kvm_vcpu *vcpu)
> +{
> +	return kvmppc_xive_enabled(vcpu) && vcpu->kvm->arch.xive_devices.native;

I was checking the code and I am not sure whether we need to also check
for "vcpu->kvm->arch.xive_devices.native"?

Can you explain why do we need to check for xive_devices.native pointer
to be non-NULL? Because if we don't need this then it simplifies the
code as we can directly use kvmppc_xive_enabled(vcpu) helper.

-ritesh


> +}
> +
>  extern int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
>  					   struct kvm_vcpu *vcpu, u32 cpu);
>  extern void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu);
> @@ -782,6 +787,8 @@ static inline bool kvmppc_xive_rearm_escalation(struct kvm_vcpu *vcpu) { return
>  
>  static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
>  	{ return 0; }
> +static inline bool kvmppc_xive_native_enabled(struct kvm_vcpu *vcpu) { return false; }
> +
>  static inline int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
>  			  struct kvm_vcpu *vcpu, u32 cpu) { return -EBUSY; }
>  static inline void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu) { }
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index dbac3573b2c8..dec89c014c52 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -4980,7 +4980,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
>  			if (!kvmhv_on_pseries() && (__kvmppc_get_msr_hv(vcpu) & MSR_EE))
>  				kvmppc_inject_interrupt_hv(vcpu,
>  							   BOOK3S_INTERRUPT_EXTERNAL, 0);
> -			else
> +			else if (!kvmppc_xive_native_enabled(vcpu))
>  				lpcr |= LPCR_MER;
>  		} else {
>  			/*
> -- 
> 2.52.0

