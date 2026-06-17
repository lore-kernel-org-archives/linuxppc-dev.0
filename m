Return-Path: <linuxppc-dev+bounces-22736-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453F1CD98E2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2026 09:13:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggJ7D1ZWBz2yfD;
	Wed, 17 Jun 2026 19:13:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::532"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781687608;
	cv=none; b=ErHisBf7VrcX+5p9izXvNqK78LItBVszqkqbZiH618HUsrLZ7Z4slQ4J86856LIYsuUwESXKuifqvyJHVb/lZ6pLrCx0dHZ6L9z8B4B1ooSm5yaSLhThBYK9FHS518JPgOi1aW/943LVtb4ypyAOWPt+LpCGNgOeVSloH1egqRbzBm2mthKSxAQxpL7XsM5x4h+4jR2cN5I/lMQque6ocfdA6HwK0AGPTailB7fANy5YuNHAZFiQuKRa5qbT9mfP0XipIiFLJMOEfu9CtH9r7bwujN4SoNHstznMhxHEqsy2RHH1CrdI2GuZ2J4X4GBevyuHd1a5x9iNZs62PfJI+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781687608; c=relaxed/relaxed;
	bh=qx2oqOAa3taxwMjPVJWKAVBWtsdla0AgqsMsxeR0hXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+yQueJlcYNW2vGIODEd9BBx7MoqnVT7cA6iOkVdYQNfkJPwhRd4jMcm0/FuQPzzrDGgnyEmTb2bPw5zW2uxlzkl6FQ0yABSAOViebL+Qq2OKRgPSR9bmfaM9fABe5wyStXgQ8b/gnHXdlciazTPy0BQ053/RQvYl1hvFhPUFSvvfeyGJaODY3n1nLaUgifBqlM5bLrh+rIvTIwsOFPoR1DFV67zK9F1W99qSp4OpHKBQ2N7w+eBqW1OM9HKxtizZPmba3+2YjIZJzNueZHmFMS+loYcxfzPb66meoDhlhWvWv9fdJsJMlC6VhffCprD5Vn7D0dcZQso8/rerR67WA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yqo9aUxC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yqo9aUxC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggJ7B5F4bz2yZZ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2026 19:13:26 +1000 (AEST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-c85c531d4a9so2134543a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2026 02:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781687604; x=1782292404; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qx2oqOAa3taxwMjPVJWKAVBWtsdla0AgqsMsxeR0hXY=;
        b=Yqo9aUxCJPiMw+tVdXdVOS59yB1YYv16FhcWLeLTOVmpM19Uucd9BxgBF2K94hhcHl
         PBha8D/85ByjczfpCXhHQSA4Zis6LPga2WkbyydDugUukfztxR/f5xRPbmbAE0bJAtnV
         c7EMsN/z4vMMIoI9VP6Zt/6O3pDy9yPz/oDHBlQR+NR5h0+194AVIOYiODQxkA1PgXZy
         Jt12Hl9jxzL0LiQ58ExGVhxlCdhBdVmv0LbjIinSg4KMDJdhauIY7J30WSTVXJhS6Kci
         u9fuOUzBg4BG8cVfa3lc0RCZ9UYVL4SoS3sI0DODsJZ6uKyN4IK3aBzAeQI4BO4TH2b+
         u6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781687604; x=1782292404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qx2oqOAa3taxwMjPVJWKAVBWtsdla0AgqsMsxeR0hXY=;
        b=AAyWLlszKjYvyZ5w13Clnal8g0ISbVGqtk3tF/j4UkcRQEHTSdeOf1sCePIqMolWZG
         KuWmMTQvni2tvaDHC/gyiqQ3GKRgKj8SXEUBOw/eE202UwPq9186FSVbKFbF4N+VnbBS
         Mknc5CoJGsvcphIBRro57h2cj+bZ4YNPk8ozd5jU2HJx/zJ7e61JRT3gZLxZBJn8EPB/
         yOA7Gfqv8x8LPZE0esYtnl8UiqhoxPRMuSf4eu3aXeh2io8fLvo1aPj/KmvSDo3Ar9tj
         fdGQjEF7BVTuehCL0VgklFm7Cmu2B8JWhLWKe43I0e2OLozbZ11bV+bUlHi34514s/zD
         HR1Q==
X-Gm-Message-State: AOJu0YxMpMk8/3+L4/LIEc8OlmvAddHto5DKs3SRkvL6NwXk60t0GLRX
	MHzMfmaXfOL7SDFTLYWD8Iougaimw3LKBzEEn0KSfiGrDToZGKjaXJa7
X-Gm-Gg: Acq92OGFjNhdOxc1jvmYlwoPXyPhy2A4/61gXGVSfB2Zu06ZSI9p8dX+Q36H8ouIXS6
	sd4YnN85pmUvC7EJ9RtOeL3KQEuws+9AdRsggk/hfbxZs/pIi99dC66kHCUuu6l+xvUsJotEETZ
	V+nnSF0YcI7uiYHtzNSawzYsGBpnyVLzwqkYP9Iv4LElTHdyRojVF5mm1ganYaQhKOo+8dll5Qj
	WVSsOLjt6ez6lqw7GPMgDSeFsBrU83zFuwt73Pwjwy75nvWNGOtxiRTfPCW+rC6WPDECh66yaBW
	mhqEmd1m1yPuSNq+vp/5NTyHOYeUrkiPldsPgG/6gVWs2bd4b8qH7exBxayem/rAKt5+vA6EF16
	lqNbSuBUWGgrzK+6OGj1VOM2CYrWjGBz8KAI7Qr49IljfXqwrlFl3HKsfnoQAvHX0C5QgoDm32l
	hjW5GHkyayZZHqZDBVXkN+i3rbWSCHmg1fXSLM7730FsFfrEdqEkZw+B0B
X-Received: by 2002:a05:6a20:9192:b0:3b3:1c7b:ff7 with SMTP id adf61e73a8af0-3b8b84f1d1cmr3646837637.46.1781687603540;
        Wed, 17 Jun 2026 02:13:23 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8893894debsm447203a12.7.2026.06.17.02.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 02:13:22 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:43:15 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, 
	Harsh Prateek Bora <harshpb@linux.ibm.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] KVM: PPC: Book3S HV: Validate arch_compat against
 host compatibility mode
Message-ID: <ajJknRi0n7tJDOKQ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260616163405.96962-1-amachhiw@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616163405.96962-1-amachhiw@linux.ibm.com>

On Tue, Jun 16, 2026 at 10:04:05PM +0530, Amit Machhiwal wrote:
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
> This situation should be detected earlier and rejected by KVM. Without
> proper validation, if userspace ignores the error, the guest may continue
> to boot in Power11 raw mode on a Power10 compatibility host, which should
> not be allowed.
> 
> Introduce a validation mechanism that detects unsupported arch_compat
> values early in the guest initialization path. When an unsupported
> arch_compat is requested (e.g., Power11 on a Power10 compatibility mode
> host), kvmppc_set_arch_compat() uses cpu_has_feature(CPU_FTR_P11_PVR) to
> detect the mismatch and sets arch_compat to PVR_ARCH_INVALID (0xffffffff).
> This sentinel value is architecturally safe: PAPR specifies that valid
> logical PVR values must have 0x0f as the first byte, ensuring 0xffffffff
> lies permanently outside the specification-defined range. Setting this
> value triggers kvmppc_sanity_check() to mark the vCPU as invalid by
> setting vcpu->arch.sane to false. On the next vCPU run, kvmppc_vcpu_run_hv()
> checks this flag and returns -EINVAL, preventing the guest from running
> with an invalid processor compatibility configuration.
> 
> With this, when a Power11 arch_compat is requested on a Power10
> compatibility mode host, the guest fails early during boot with:
> 
>   error: kvm run failed Invalid argument
> 
> This provides a much clearer failure mode compared to the previous
> behavior where the guest could boot in Power11 raw mode (if userspace
> ignored the error) or fail late during H_GUEST_SET_STATE.
> 
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Acked-by: Gautam Menghani <gautam@linux.ibm.com>
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Testing: Both Anushree and I have tested the below scenarios:
> 1. P11 guest on P11 host - Works
> 2. P10 compat guest on P11 host - Works
> 3. P11 guest on compat-P10 host - Correctly fails with "Invalid argument"
> 4. P10 guest on compat-P10 host - Works
> 
> Changes in v4:
> * Added documentation for PVR_ARCH_INVALID explaining why 0xffffffff is
>   architecturally safe to use as a sentinel value (PAPR constraint on
>   first byte being 0x0f) [Ritesh]
> * Updated commit message
> * v3: https://lore.kernel.org/all/20260609053327.61563-1-amachhiw@linux.ibm.com/
> 
> Changes in v3:
> * Fixed null pointer dereference in kvmppc_sanity_check(): added check for
>   vcpu->arch.vcore before accessing arch_compat, as vcore is NULL for Book3S
>   PR and BookE guests (only Book3S HV uses vcore) [Reported by Sashiko AI]
> * Added Reviewed-by tag from Vaibhav
> * v2: https://lore.kernel.org/all/20260608201001.65760-1-amachhiw@linux.ibm.com/
> 
> Changes in v2:
> * Fixed issue where v1 allowed guest to boot in Power11 raw mode when
>   userspace ignored the error, by adding validation in kvmppc_sanity_check()
>   to ensure early failure during vCPU run [Found the issue after posting v1,
>   also reported by Gautam.]
> * Introduced PVR_ARCH_INVALID constant for marking invalid arch_compat
> * Dropped all Reviewed-by and Tested-by tags due to code changes; requesting
>   fresh reviews
> * v1: https://lore.kernel.org/all/20260603141539.47620-1-amachhiw@linux.ibm.com/
> 
> Changes in v1:
> * Moved this patch out of the v3 series [1] as discussed here [2]
> * Addressed below review comments from Ritesh:
>   - Based the PVR validation on cpu features
>   - Fixed hcall name typo
>   - Stable backport
> 
> [1] https://lore.kernel.org/all/20260522152744.55251-1-amachhiw@linux.ibm.com/
> [2] https://lore.kernel.org/all/20260522152744.55251-2-amachhiw@linux.ibm.com/
> ---
>  arch/powerpc/include/asm/reg.h | 12 ++++++++++++
>  arch/powerpc/kvm/book3s_hv.c   | 15 ++++++++++++++-
>  arch/powerpc/kvm/powerpc.c     |  4 ++++
>  3 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index 3449dd2b577d..b9ab9df1e2bc 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -1357,6 +1357,18 @@
>  #define PVR_ARCH_31	0x0f000006
>  #define PVR_ARCH_31_P11	0x0f000007
>  
> +/*
> + * Kernel-internal sentinel for invalid processor compatibility modes.
> + * PAPR specifies that the first byte of a valid logical PVR value is
> + * 0x0f. So 0xffffffff lies permanently outside the PAPR-defined range
> + * and is safe to repurpose. KVM stores it in vcpu->arch.arch_compat
> + * when userspace requests an unsupported compatibility mode (e.g.,
> + * Power11 PVR on a Power11 host booted in Power10 compat).
> + * kvmppc_sanity_check() detects this and prevents the vCPU from
> + * running with an unsupported arch_compat.
> + */
> +#define PVR_ARCH_INVALID	0xffffffff
> +
nit:
I think the description of the invalid value should go into the commit
message rather then here. It creates an unnecessary clutter here. If
anyone wants to know why it's added they can always get the blame and
get the description.

Apart from this.

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
>  /* Macros for setting and retrieving special purpose registers */
>  #ifndef __ASSEMBLER__
>  
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3..f9380ef65750 100644
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
> +			if (!cpu_has_feature(CPU_FTR_P11_PVR)) {
> +				arch_compat = PVR_ARCH_INVALID;
> +				goto out;
> +			}
>  			guest_pcr_bit = PCR_ARCH_31;
>  			break;
>  		default:
> @@ -469,6 +481,7 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
>  			return -EINVAL;
>  	}
>  
> +out:
>  	spin_lock(&vc->lock);
>  	vc->arch_compat = arch_compat;
>  	kvmhv_nestedv2_mark_dirty(vcpu, KVMPPC_GSID_LOGICAL_PVR);
> @@ -479,7 +492,7 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
>  	vc->pcr = (host_pcr_bit - guest_pcr_bit) | PCR_MASK;
>  	spin_unlock(&vc->lock);
>  
> -	return 0;
> +	return kvmppc_sanity_check(vcpu);
>  }
>  
>  static void kvmppc_dump_regs(struct kvm_vcpu *vcpu)
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 00302399fc37..98de68379b18 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -258,6 +258,10 @@ int kvmppc_sanity_check(struct kvm_vcpu *vcpu)
>  	if (!vcpu->arch.pvr)
>  		goto out;
>  
> +	if (vcpu->arch.vcore &&
> +		vcpu->arch.vcore->arch_compat == PVR_ARCH_INVALID)
> +		goto out;
> +
>  	/* PAPR only works with book3s_64 */
>  	if ((vcpu->arch.cpu_type != KVM_CPU_3S_64) && vcpu->arch.papr_enabled)
>  		goto out;
> 
> base-commit: 6b5a2b7d9bc156e505f09e698d85d6a1547c1206
> -- 
> 2.50.1 (Apple Git-155)
> 

