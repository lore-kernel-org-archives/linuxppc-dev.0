Return-Path: <linuxppc-dev+bounces-22700-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57303CD98DA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:22:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfmNG5b5xz3brH;
	Tue, 16 Jun 2026 22:22:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781612574;
	cv=none; b=jNSvByAoBSV49c6CXRqYRXp7xNbRzobqejvHrb4NEQWI1TPqJUb8Zz7dj3Ajr307O0aLLHpYZd8qnbquS0VFSbDCP2AV0qvr0f/G0URtst6uCdcG6/nrb2MsOxb8bmApPUJBZOrQ8V00s/bOuNsKPDHGTYh2Yb/Iwy6hBiXI47DuCzjPtfRgGF2oZZBDBBeXJpRCdGYHHVU3AUFJFaM0U1HfIzixiQF3H7nWPdRHkjwqWB1s5BplmwNUiVJjkJewqIO9Q4inV1BiPHXXKGYhx8xNJ114YX9oQ0rU36IBjBoXEEVNT9WcNJYA3MHU4xDvF9QzOW8eXvFUy8QaASMNTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781612574; c=relaxed/relaxed;
	bh=Og7r0xA1yiyG/NyW5xLsDou9gfGoec5B81fGllK9lfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1bWIjyffRA1D7dr/xLIS7kS68LnVR3r3P3wvst08Rfv8PZ8QJ6mOEnyMUD9LFGZpZO4/kWP41Th81w8EnOXr1CxKVrFdD9dJDNckhtEp8HZq3ENG/zOvnK2vvPR+PxsXCBjo/mq1pKDQZmrGc1adVkGY9mtvwkCX777S19BK2YyRBJ1ulCzIgUovQ+N3Nl6cOsfPTxnoLxgkji0uNc8mrwrvGxvfom8bmtxJp6S/n/0f97ep4lhhERhnEysRzh2KCQvSBN9R9zrLa8lZDSVRK7ooD/UTKLaLtxZKsfo6r+3C0M6qQycuygTUMNiHfIvh1aExpBFZ+yDL9IiutYxSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dL0yp2dv; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dL0yp2dv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfmNF43bDz3bqh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 22:22:53 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAIKhF1396029;
	Tue, 16 Jun 2026 12:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Og7r0xA1yiyG/NyW5xLsDou9gfGoec
	5B81fGllK9lfU=; b=dL0yp2dv8zLkLLCr4VLVj8NeeqZY0/mjoupvN7c0a/v7Sf
	zjWWOlqIjA3/lmg9Gf3vQHv3Tlv0FKs8YNiy1ak+HQkA6LnFAI53sNIpRYq2WILL
	SRKTNVxfGKdvF7ROUTySrxzCaKx1dHnzSeOdWbTSOf++n0idG7hBjSOwD6+ga3sr
	xuVUwUdsENjswmHHAbBF2QkJJCtzrnnXmpExKTRR+HGUpP6n7Gni0X3i4fXOXfHd
	wLAqel2wmsRq4btCqYwQOOX0SswywBGQgtSrDvHgMlKRHdrAI+v3McdbAd8233Gs
	nfgdwcFvZNWR1n84+S+wWwcj/JJGOwYwHpGekppw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1h85kpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:22:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GCJaZX026143;
	Tue, 16 Jun 2026 12:22:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esk1h35pr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:22:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GCMboi50856404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 12:22:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE9F120043;
	Tue, 16 Jun 2026 12:22:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A173E20040;
	Tue, 16 Jun 2026 12:22:33 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.43.68.83])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 16 Jun 2026 12:22:33 +0000 (GMT)
Date: Tue, 16 Jun 2026 17:52:25 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Validate arch_compat against
 host compatibility mode
Message-ID: <ajFAAXoQaWCH2ZA3@Gautams-MacBook-Pro.local>
References: <20260609053327.61563-1-amachhiw@linux.ibm.com>
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
In-Reply-To: <20260609053327.61563-1-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEyNSBTYWx0ZWRfX6bwpCPVS2Kiz
 9Lor+EwcDakhOIM+s/tqLej8jxqAFEA3+oRP09HFuwYOqtu+V+HV61Zs/SMxWhyf1K9KpD6UgS7
 dPMB3WBudA5PRctCja9gIv5ptEcEo70=
X-Proofpoint-ORIG-GUID: mjmX00ojuI7emLLota5wL-s8I1BXTEht
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEyNSBTYWx0ZWRfX3DOahM6xl/SO
 x6cFntBNPhY5BH54NI17OiQkv5mPqrCqt9f/863ov5DvPOEONHwvfQ6AnG6QIISjYt66nF80RFX
 D39wz6jATUyZc9Q5Ux/ubiswCnDzXIYiBxZcr7S6FHf5AEEKSHstG58UUSqShk3srJY+aZMbgpL
 KB6IeUuciOKiuRfza7sA13ysYj/FNUENCnwBxECRoRB2a6zf4Q7YkobOqJpnWLymxkKBoO+ZKWd
 lmByXc6FvdQgdKFlkuQjJIH8vN5GhMvzbJyJSf1HgTS+sY7V46q6i5RNLKXgYGTWIJu3+jhNoLP
 uDbBwjKh/FaKqq8uQiYRJWslHxuScVdpgWqprSH2OjqQYBW33qCeHf0qyGhVwJrjHQyEpsWiRhT
 apw3AxghYFJ3BYObMGG0Qp4ZSDYJjSfbTnGoPhMKxVa9M4vLiRuIP5jET8tD4Qz00/nObJY6e01
 mNe6Kh7dLr3Hgqyq4pw==
X-Authority-Analysis: v=2.4 cv=U9uiy+ru c=1 sm=1 tr=0 ts=6a314013 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pR_i7U4pRXRyIL7P0lAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: Poof9hJt87Q5EajYVkw0kvwNr7PiTlt8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160125

On Tue, Jun 09, 2026 at 11:03:27AM +0530, Amit Machhiwal wrote:
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
> detect the mismatch and sets arch_compat to PVR_ARCH_INVALID. This
> triggers kvmppc_sanity_check() to mark the vCPU as invalid by setting
> vcpu->arch.sane to false. On the next vCPU run, kvmppc_vcpu_run_hv()
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
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Changes in v3:
> * Fixed null pointer dereference in kvmppc_sanity_check(): added check for
>   vcpu->arch.vcore before accessing arch_compat, as vcore is NULL for Book3S
>   PR and BookE guests (only Book3S HV uses vcore) [Reported by Sashiko AI]
> * Added Reviewed-by tag from Vaibhav
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
>  arch/powerpc/include/asm/reg.h |  1 +
>  arch/powerpc/kvm/book3s_hv.c   | 15 ++++++++++++++-
>  arch/powerpc/kvm/powerpc.c     |  4 ++++
>  3 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index 3449dd2b577d..7472b9522f71 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -1356,6 +1356,7 @@
>  #define PVR_ARCH_300	0x0f000005
>  #define PVR_ARCH_31	0x0f000006
>  #define PVR_ARCH_31_P11	0x0f000007
> +#define PVR_ARCH_INVALID	0xffffffff
>  
>  /* Macros for setting and retrieving special purpose registers */
>  #ifndef __ASSEMBLER__
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
> base-commit: 2d3090a8aeb596a26935db0955d46c9a5db5c6ce
> -- 
> 2.50.1 (Apple Git-155)


LGTM
Acked-by: Gautam Menghani <gautam@linux.ibm.com>

