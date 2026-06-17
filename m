Return-Path: <linuxppc-dev+bounces-22737-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082D4CD98EE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2026 09:17:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggJCx1RtBz2yfD;
	Wed, 17 Jun 2026 19:17:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781687853;
	cv=none; b=DO/4DEOEUyXsBuebEa93zGPX4RnRrCYL3TWgvcw7/3ARjwnnVZaH0LqeMmfkPCHy4fmG+E4ye89E/dXs4dEM71HfI8QENRwWzYMQXSwbBrv+xM+6IXZ70WmdWBxLDBNF/eFfYZB4zlwDBuyC1+YCa9ILmSKSKyOg117fZE9fqkRwbEUbvQ2BSrfyoy3IOTYW22ED+J/CEvHL6vqHtx9jdiWznbMaLRUaLNGfEtvsoiGEFRDr5J82HXXJ7NR8RyJGKp9GHKSgrAfCaIX3Zm9GkezYK/oNqtZUhdyx8FSIq5qIvFQYYyyOTbzbNTkS9hTSyGkg3DNf1yp2T93+bKF4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781687853; c=relaxed/relaxed;
	bh=mEZb6LJ8Uk1AgrpJuSRf5PMAcIBsdsc1p+ANTmomdOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeOJ92ifqLEV2t8RHmhLL6KnTzXEdoaXj2VvQ42OSu/s5RgV3IclYOVKKkAnWqQI3xG4LxaVSqXS5o8ohd9FL0+Bo2PCy9vkuHUAgoXXXHrqDpseczYX4RZpwo5+rCxrNcuDW88eN0Hsp9HDqzlQg3JG3LgZvwGBMwKt4k+8fc5RunllYUcAoLPdYYjoGu1O4UnzWQfR9lSqjCLXa70XBYyWvFR41q1yvOFJr6wL+J6oj7qZqw/GT6uG+sjg83KAum/Bv3h5jELIoQ3b5WdtdnfyU/p3enSK1JXmL9ZDKM4itejVJYernfR5LhUjsR3cw0fdV90fB2GhKPwVqG6Nhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DUn0Ank1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DUn0Ank1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggJCw1yQbz2yZZ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2026 19:17:31 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2c6be9cd7afso2081165ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2026 02:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781687849; x=1782292649; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mEZb6LJ8Uk1AgrpJuSRf5PMAcIBsdsc1p+ANTmomdOU=;
        b=DUn0Ank10vIgqhhB5KvPmaMOmmaZAPrwsPwtsfzIobmmgzGOaLx7DeJz7SrAu0BaRr
         8NVIh54Aqp076kdLJrX6ya7PwS5OKhC5oEQinT3whqp9A1SwIYHXUR6j60xKi2/dbfjg
         Tn4qUE0GcujoqT3LFOESWQb3FZsfXbVAY0r2EdbrFg+iERCyZnpOVHPKjHrjoYJQbDZv
         r4NAgnjjsTg64nEGvWKCnimWnjdL6mPM3vmDzvT8lET4izZ+/4o6FkMKd+/oEeozVGhi
         ruAhW0VihqkQeafBy5BnV8GV4t0oPrY5Dbq1JFU6Y2uEED8pnOP3b0c7WIN1/wFhv9D0
         APJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781687849; x=1782292649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEZb6LJ8Uk1AgrpJuSRf5PMAcIBsdsc1p+ANTmomdOU=;
        b=tDet5hJ8AkmA7QXjnC/EKJB8oFnAv3ZeFia5RyTLPaP2Faw2geVsJs9GTWkK9o9Ie0
         /qZr9XM/VvaRJPp9noD0VgJrViPobOBiXEENKepfLsvn0fZ+cTiErXZTfEWl3Yk+3SeZ
         jTora7NvjW/bSaURqAW7Tn/lVrmOaTsJ0NneAtuy2qEdIFeLBq3Ik9mwc3i+tSUn5zfM
         HN3bBM45TMIzU6xsVQ8sZfV3BknYMuiieJ4Hj7jxltbjYUHvdHzpr1LKASdyq3w3eFdp
         PeLdDV+rBBZ24q+n9Nibm/kf1gs0xnS/NuaXfahVRDzfEEfk2aK7SMMZaylKATqwfXDS
         2Ahw==
X-Gm-Message-State: AOJu0YwFDY8M8di0FbGmT8I3Yu+6A6gV8mshe8JafzuSIgtL1lYVlO8j
	C+RkRRCBwd4bL3iCrR6Vyv0/NNhFsO4GrRgUBVZrE53YBuBIdRfetO6u
X-Gm-Gg: AfdE7cncoFpRnFHXm8qibG8FiT2rdhII8O/qLTPOnRT3La/64iS+JBJlO+XGLhIxji6
	dgG8R6GXCdB+47es5u3PO2Eci5AchR1677T8uyIVMNFEUCipQRWTh7S1ipOOpbncn2fSjfSv2vJ
	VMARNcMGWOTnBBm0N38cHSDE+8ZzI0q89NS/slCjdOfZad6Pr0CmZriAiPjqL/1Ie4zBWZ9gHLt
	Jda0LA7lB+zAVOwSdI6slbstOALZgOrC/xIMjTgx49gA3uJcg8aLgOiB1ndFEIspuA2a9KRUcXf
	lH0AXlHw74A10p860ONSz6cPntYX1WO7QLGVSFh3BtPA6OUDjpiP7FvZDaxxq4XrH4usqZpRgOz
	Ep9NR0LAxf3QoY28nxFmH1n/kPEjFpnsIa/WDSB/5H/nvy+ylM88O7rqe6Wcg67yBNRRXEFMlYt
	wj4GaH/1Dxo7KYLowoZU1B7XB/TSOswBgSK1UVa68s1hF60doq58u2BNDr
X-Received: by 2002:a17:902:e88e:b0:2bd:606d:b342 with SMTP id d9443c01a7336-2c6bc21f1f9mr27060005ad.26.1781687849338;
        Wed, 17 Jun 2026 02:17:29 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a1878493sm41114495ad.81.2026.06.17.02.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 02:17:28 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:47:21 +0530
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
Message-ID: <ajJlstOjsnAQ-SEH@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260616163405.96962-1-amachhiw@linux.ibm.com>
 <ajJknRi0n7tJDOKQ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
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
In-Reply-To: <ajJknRi0n7tJDOKQ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>

On Wed, Jun 17, 2026 at 02:43:15PM +0530, Mukesh Kumar Chaurasiya wrote:
> On Tue, Jun 16, 2026 at 10:04:05PM +0530, Amit Machhiwal wrote:
> > On IBM POWER systems, newer processor generations can operate in
> > compatibility modes corresponding to earlier generations. This becomes
> > relevant for nested virtualization, where nested KVM guests may need to
> > run with a specific processor compatibility level.
> > 
> > Currently, when running a nested KVM guest (L2) inside a Power11 pSeries
> > logical partition (L1) booted in Power10 compatibility mode, the guest
> > fails to boot while setting 'arch_compat'. This happens because the CPU
> > class is derived from the hardware PVR (via mfspr()), which reflects the
> > physical processor generation (Power11), rather than the effective
> > compatibility mode (Power10).
> > 
> > As a result, userspace may request a Power11 arch_compat for the L2
> > guest. However, the L1 partition, running in Power10 compatibility, has
> > only negotiated support up to Power10 with the Power Hypervisor (L0).
> > When H_GUEST_SET_STATE is invoked with a Power11 Logical PVR, the
> > hypervisor rejects the request, leading to a late guest boot failure:
> > 
> >   KVM-NESTEDv2: couldn't set guest wide elements
> >   [..KVM reg dump..]
> > 
> > This situation should be detected earlier and rejected by KVM. Without
> > proper validation, if userspace ignores the error, the guest may continue
> > to boot in Power11 raw mode on a Power10 compatibility host, which should
> > not be allowed.
> > 
> > Introduce a validation mechanism that detects unsupported arch_compat
> > values early in the guest initialization path. When an unsupported
> > arch_compat is requested (e.g., Power11 on a Power10 compatibility mode
> > host), kvmppc_set_arch_compat() uses cpu_has_feature(CPU_FTR_P11_PVR) to
> > detect the mismatch and sets arch_compat to PVR_ARCH_INVALID (0xffffffff).
> > This sentinel value is architecturally safe: PAPR specifies that valid
> > logical PVR values must have 0x0f as the first byte, ensuring 0xffffffff
> > lies permanently outside the specification-defined range. Setting this
> > value triggers kvmppc_sanity_check() to mark the vCPU as invalid by
> > setting vcpu->arch.sane to false. On the next vCPU run, kvmppc_vcpu_run_hv()
> > checks this flag and returns -EINVAL, preventing the guest from running
> > with an invalid processor compatibility configuration.
> > 
> > With this, when a Power11 arch_compat is requested on a Power10
> > compatibility mode host, the guest fails early during boot with:
> > 
> >   error: kvm run failed Invalid argument
> > 
> > This provides a much clearer failure mode compared to the previous
> > behavior where the guest could boot in Power11 raw mode (if userspace
> > ignored the error) or fail late during H_GUEST_SET_STATE.
> > 
> > Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> > Acked-by: Gautam Menghani <gautam@linux.ibm.com>
> > Cc: stable@vger.kernel.org # v6.13+
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> > Testing: Both Anushree and I have tested the below scenarios:
> > 1. P11 guest on P11 host - Works
> > 2. P10 compat guest on P11 host - Works
> > 3. P11 guest on compat-P10 host - Correctly fails with "Invalid argument"
> > 4. P10 guest on compat-P10 host - Works
> > 
> > Changes in v4:
> > * Added documentation for PVR_ARCH_INVALID explaining why 0xffffffff is
> >   architecturally safe to use as a sentinel value (PAPR constraint on
> >   first byte being 0x0f) [Ritesh]
> > * Updated commit message
> > * v3: https://lore.kernel.org/all/20260609053327.61563-1-amachhiw@linux.ibm.com/
> > 
> > Changes in v3:
> > * Fixed null pointer dereference in kvmppc_sanity_check(): added check for
> >   vcpu->arch.vcore before accessing arch_compat, as vcore is NULL for Book3S
> >   PR and BookE guests (only Book3S HV uses vcore) [Reported by Sashiko AI]
> > * Added Reviewed-by tag from Vaibhav
> > * v2: https://lore.kernel.org/all/20260608201001.65760-1-amachhiw@linux.ibm.com/
> > 
> > Changes in v2:
> > * Fixed issue where v1 allowed guest to boot in Power11 raw mode when
> >   userspace ignored the error, by adding validation in kvmppc_sanity_check()
> >   to ensure early failure during vCPU run [Found the issue after posting v1,
> >   also reported by Gautam.]
> > * Introduced PVR_ARCH_INVALID constant for marking invalid arch_compat
> > * Dropped all Reviewed-by and Tested-by tags due to code changes; requesting
> >   fresh reviews
> > * v1: https://lore.kernel.org/all/20260603141539.47620-1-amachhiw@linux.ibm.com/
> > 
> > Changes in v1:
> > * Moved this patch out of the v3 series [1] as discussed here [2]
> > * Addressed below review comments from Ritesh:
> >   - Based the PVR validation on cpu features
> >   - Fixed hcall name typo
> >   - Stable backport
> > 
> > [1] https://lore.kernel.org/all/20260522152744.55251-1-amachhiw@linux.ibm.com/
> > [2] https://lore.kernel.org/all/20260522152744.55251-2-amachhiw@linux.ibm.com/
> > ---
> >  arch/powerpc/include/asm/reg.h | 12 ++++++++++++
> >  arch/powerpc/kvm/book3s_hv.c   | 15 ++++++++++++++-
> >  arch/powerpc/kvm/powerpc.c     |  4 ++++
> >  3 files changed, 30 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> > index 3449dd2b577d..b9ab9df1e2bc 100644
> > --- a/arch/powerpc/include/asm/reg.h
> > +++ b/arch/powerpc/include/asm/reg.h
> > @@ -1357,6 +1357,18 @@
> >  #define PVR_ARCH_31	0x0f000006
> >  #define PVR_ARCH_31_P11	0x0f000007
> >  
> > +/*
> > + * Kernel-internal sentinel for invalid processor compatibility modes.
> > + * PAPR specifies that the first byte of a valid logical PVR value is
> > + * 0x0f. So 0xffffffff lies permanently outside the PAPR-defined range
> > + * and is safe to repurpose. KVM stores it in vcpu->arch.arch_compat
> > + * when userspace requests an unsupported compatibility mode (e.g.,
> > + * Power11 PVR on a Power11 host booted in Power10 compat).
> > + * kvmppc_sanity_check() detects this and prevents the vCPU from
> > + * running with an unsupported arch_compat.
> > + */
> > +#define PVR_ARCH_INVALID	0xffffffff
> > +
> nit:
> I think the description of the invalid value should go into the commit
> message rather then here. It creates an unnecessary clutter here. If
> anyone wants to know why it's added they can always get the blame and
> get the description.
> 
> Apart from this.
> 
> Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

I just saw the conversation on previous version. After that it makes
sense to have it here.

Regards,
Mukesh
> >  /* Macros for setting and retrieving special purpose registers */
> >  #ifndef __ASSEMBLER__
> >  
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index 61dbeea317f3..f9380ef65750 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -446,7 +446,19 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
> >  			guest_pcr_bit = PCR_ARCH_300;
> >  			break;
> >  		case PVR_ARCH_31:
> > +			guest_pcr_bit = PCR_ARCH_31;
> > +			break;
> >  		case PVR_ARCH_31_P11:
> > +			/*
> > +			 * Need to check this for ISA 3.1, as Power10 and
> > +			 * Power11 share the same PCR. For any subsequent ISA
> > +			 * versions, this will be taken care of by the guest vs
> > +			 * host PCR comparison below.
> > +			 */
> > +			if (!cpu_has_feature(CPU_FTR_P11_PVR)) {
> > +				arch_compat = PVR_ARCH_INVALID;
> > +				goto out;
> > +			}
> >  			guest_pcr_bit = PCR_ARCH_31;
> >  			break;
> >  		default:
> > @@ -469,6 +481,7 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
> >  			return -EINVAL;
> >  	}
> >  
> > +out:
> >  	spin_lock(&vc->lock);
> >  	vc->arch_compat = arch_compat;
> >  	kvmhv_nestedv2_mark_dirty(vcpu, KVMPPC_GSID_LOGICAL_PVR);
> > @@ -479,7 +492,7 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
> >  	vc->pcr = (host_pcr_bit - guest_pcr_bit) | PCR_MASK;
> >  	spin_unlock(&vc->lock);
> >  
> > -	return 0;
> > +	return kvmppc_sanity_check(vcpu);
> >  }
> >  
> >  static void kvmppc_dump_regs(struct kvm_vcpu *vcpu)
> > diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> > index 00302399fc37..98de68379b18 100644
> > --- a/arch/powerpc/kvm/powerpc.c
> > +++ b/arch/powerpc/kvm/powerpc.c
> > @@ -258,6 +258,10 @@ int kvmppc_sanity_check(struct kvm_vcpu *vcpu)
> >  	if (!vcpu->arch.pvr)
> >  		goto out;
> >  
> > +	if (vcpu->arch.vcore &&
> > +		vcpu->arch.vcore->arch_compat == PVR_ARCH_INVALID)
> > +		goto out;
> > +
> >  	/* PAPR only works with book3s_64 */
> >  	if ((vcpu->arch.cpu_type != KVM_CPU_3S_64) && vcpu->arch.papr_enabled)
> >  		goto out;
> > 
> > base-commit: 6b5a2b7d9bc156e505f09e698d85d6a1547c1206
> > -- 
> > 2.50.1 (Apple Git-155)
> > 

