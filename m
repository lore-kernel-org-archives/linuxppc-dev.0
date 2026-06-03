Return-Path: <linuxppc-dev+bounces-21987-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5020CD6E69
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 17:57:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVwQN1MQhz2ySJ;
	Thu, 04 Jun 2026 03:57:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780509452;
	cv=none; b=THL+Hfqa2/b2LGALBhh/LsbvwLNBHrWzEXoR7V8znTnRe7zqW3rtU1ZbD6kxdeOrWPtJ7fbxW27uXcMtw7Xu67vHt0OtbsGFtp/augMnW9yIzcShJN4L/6HEMm3OsKrCIF6qoS7kPD3VT0XH2YPnpxPWkhTgGVWoKoVwZTDa3FgiexUZ01glOx6ZM5MDDNe8uiClWoevWC9kyvyAUlb9xrs45GPPKm+F8/K79wyNIsiQMHrbTHSygoAIf/DBfN/lwHwth+BZOVOR+uJ7zjC5QEmchGwCRX7nFNJCm9s5UwtnoAWApCDP++RVtLNfyIyBN747uz5yRyyde9mw1pPnAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780509452; c=relaxed/relaxed;
	bh=y5NJyP02PKnej6VpVmEwU/XOAuXGRvDv3YzLJ6IcwRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzCiIo0GCNwUG/rOk6sGkkjG2va7Y1y8QHMfQ28hioF8LiB1IM9qoqJ+qAAvwjswIcgVWmykaqM+7L/ljwNEBo4ru3JEhYliLGYlWlgRi7cpbBJ5d/dClGcODvPSYy2S560TNElFMNLkiytVHnkXjpRZlQTPTF70CW/cXzXS57cI0wDvxe/ndoADWovf78YxoyqrKmmZLMzGV3pkfkppDrwrRcwoE1fECSaUdGQsisBYzR+D4f+Erxy5Y75S0wQYSXY8oeLf233jHWQuJwSynnq6WYQsPAigha8lv40snzvyVYXIo/xu27YfKMYL0J4JKaErJcjnLPNY9dfjn/3+JQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QnvyWXd7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QnvyWXd7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVwQM1RVqz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 03:57:30 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-36d98b9aa9aso3686018a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 10:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780509448; x=1781114248; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y5NJyP02PKnej6VpVmEwU/XOAuXGRvDv3YzLJ6IcwRU=;
        b=QnvyWXd7ocBfIehc0L0h2ivsuPR4DWAfWsmF5fU1oeJq9IGBvDRUyYAPCApHkxA7C7
         fhKqUnXeFFwYABDTyS84XO5+m3NZ8OOCsVHoF6PtHaVmLdFGey58KhiQFAh8RV517cF1
         50KTnO0OBPdzFnKAzOUpGJCJhnieiRwNwrsLG6A20AjoWiNCleycT+jfKC+Fdjb+8o1E
         J7I5N7Ix20rt/yCg8w3Dn6qLdmz3umuTtAyvFLsbjzYEQswxNDumsx6uux8kr1MekpEd
         fv9I4+zQLznxbG7MX2ckr1yN3DcMgvaPrgrRWL0QKaYR7ao0t5+avnlX+w/M/m/eHZXj
         dokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780509448; x=1781114248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5NJyP02PKnej6VpVmEwU/XOAuXGRvDv3YzLJ6IcwRU=;
        b=KJtPm4/aIfr9Pu7G+CsQ1OQAbJlyF+N1KspL4qxkq9IypzyQYwoeCiwWPydeyXXbx8
         Z0/TeLsPbk1cAgQQl1iZb666SNHVKeHBF43TmvCSD3fSEjSdMncn6kmCmqA9QlKdLeLM
         G8q+BKvSauOU+VmxwYrNFckj4khm8To4U7LAqhKtmuO1OjpVcTFNiSeSsBlwSgRcjpwP
         +HUwWeCUMMds7vFZOjnHoiOObKWZBXyQYtkNE5Y4SMS+GxgGO+ip6PzNH1BxHzObXthh
         BvgB5BYx45Ot30FeAArwCi0hZm+kGtKMR7eleYYHItj4psBT7GFIfsIm9mp2UhacV9xi
         kJ2Q==
X-Gm-Message-State: AOJu0Yz7UH0VhjCG1Llwqjtm1XNU2CB6QEtc9ZtIlXubHFz8MOkYWHXV
	1ek1mSvjQVXPsTq5tNi/AoXtINW0BK2wIAy2Hz6PMVf0ceJCa/4hO5x8
X-Gm-Gg: Acq92OFW4sbOhkDxYL8y/6a1HZIEDvoHWc2f8ttcYbuD6kWnvket1P5VcrnRNoN1y0B
	qChBwnSuayDDbPGtbcJ1ozKJKSHM7yKlFCKEw4PIGnSc1QvIjnTSkJhrSAM1J/5xwwNJU62IIlp
	FdnLL2iQ7PMNi5hFpTYbxwr27KTOqaf7C/C9hHPSvxXTCXDWNA2GQ97Xc1HUkP0MOw9p5qoerIS
	GQPIn0nGB/mI2B9jVPsSNplWFZGGKEUJUvOWR15FnPSdbhvQlntp8d3M/Kt3xVEh1haL2FGZy7R
	zzqwItU5W76KyLw2977yLiKEPV2/LhWOf6E4tVtJvLGt6Jrn4y8mIRpMkAIGCAeuDQa8wzpts0M
	B9I5dDCukKku9gap6W6eYmrE9h1MkNPbfuQ4Mm4Wdb6RhiimuS9AyJEE4p8W8WSjq9cMG240oki
	F0mruB3wvcnoKTZ6HHd1bwxGwERhwCRUNAL956byFL8eThCo6uSQiMEvNnQphSaO/A0d3LKgW91
	Nf84ZxaOQ==
X-Received: by 2002:a17:90b:2f86:b0:36a:8ce7:b879 with SMTP id 98e67ed59e1d1-36e3247616fmr4614626a91.5.1780509447706;
        Wed, 03 Jun 2026 10:57:27 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf82841sm381273a91.2.2026.06.03.10.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 10:57:27 -0700 (PDT)
Date: Wed, 3 Jun 2026 23:27:20 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, 
	Harsh Prateek Bora <harshpb@linux.ibm.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	kvm@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Validate arch_compat against host
 compatibility mode
Message-ID: <aiBq0ACz3yW4OQQe@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603141539.47620-1-amachhiw@linux.ibm.com>

On Wed, Jun 03, 2026 at 07:45:39PM +0530, Amit Machhiwal wrote:
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
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Changelog:
> 
> * Moved this patch out of the v3 series [1] as discussed here [2]
> * Addressed below review comments from Ritesh:
>   - Based the PVR validation on cpu features
>   - Fixed hcall name typo
>   - Stable backport
> 
> [1] https://lore.kernel.org/all/20260522152744.55251-1-amachhiw@linux.ibm.com/
> [2] https://lore.kernel.org/all/20260522152744.55251-2-amachhiw@linux.ibm.com/
> ---
>  arch/powerpc/kvm/book3s_hv.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3..e16dbb199366 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -446,7 +446,17 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
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
> +			if (!cpu_has_feature(CPU_FTR_P11_PVR))
> +				return -EINVAL;
>  			guest_pcr_bit = PCR_ARCH_31;
>  			break;
>  		default:
> 
> base-commit: ba3e43a9e601636f5edb54e259a74f96ca3b8fd8
> -- 
> 2.50.1 (Apple Git-155)
> 
yeah this makes sense to throw an error early.
LGTM

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

