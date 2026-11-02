Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FF9606A58C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jrsDzUSF
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJDqK5442z2xlY;
	Tue, 03 Nov 2026 01:39:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793630349;
	cv=none; b=NQN56bGxG2wkaNPCsFTAWoib3y8e99Iebp4UI32soityXsx0t/KMiR1GCAm5o7ENu2r5UTm6jo7fPR5KSusljwNcE7ND6gd5Hus/l2h0DhWdqLnvFpPwSagYqx/A8ogkGZYRSpaDUNBxJ2caOA11PC8A0751zLMQ+HRTiHgpczS6F/yXl7D39/z+By6kuU+xPkPc9Hsb5+K6XBFojcrc3wSbR1qRbBYbimJ7xe+mYdtUtALra/pOqDoL6vd1cJMNEOf45Rvd0VxwFnQBWruFFBAfUoM+D6Pwfuk126j5nI9lWkXWo9qnsZKto4hkTqtfZB6BHq6mtbQu+gEcL/4wqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793630349; c=relaxed/relaxed;
	bh=t3uMzKFF0fpXKNPzeuZqcP8SHbCjBILits3drrR5UAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iu1D6oWlD7Wm9L0FGsRhgVcIIHRuknJgDHMj2v77E8kzOBT9x6mZssKsLq0h2pEM7cIrCMeynYet1uivBEwhGHQtaumtxqZKIKFHGntVUReBo+q4FpzJabQtyj8ffDIlyCr3ZUbv3LLxcIL/EWAzdnMuJ3sue/vqc68KqAY5CutGfhiIS8kyx6b7JJC9RNi9u+60FAKh7hkIHo8so53LpEpeR/ZbrltZgU7IIGRwIt+SBiJkeYUPg//J6UwUJmSKMEvUI2wFpiEyeEbHnm8jnIPYP1kJ6gTbkc1Ni7IYiz8+RfAjzw+4rEnnRv8tLGZTxDpao0IKHNtuBcmn5Jj94g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jrsDzUSF; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jrsDzUSF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJDqJ36fFz2xjQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 01:39:08 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2EEEvg3103442;
	Mon, 2 Nov 2026 14:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=t3uMzKFF0fpXKNPzeuZqcP8SHbCjBI
	Lits3drrR5UAs=; b=jrsDzUSF/OggKdN81wWhb4EQ3nK8LML9mgaSnR8qAY70jz
	0DbJXtS4PJuv8PQiLy7abs+fG7sndfj6ShOJulStFvMaB4jzVmChtTE0sAet0Vm3
	A1+30vWOdajDQi0XubC1JRA8+Z0IFqBUkwIt3tZHqrS7135+dwCfgEZ9oFFGPewC
	l25ok0YfFnDEr9VN3wS8SYboK6sKCmQ6lfAwbRcX9ljp4AV5DyeSlhrCxiJoEWty
	Y1DzMBTvPDR+g06pwD9FhYxvyUDi1W8x+t9hc8THVHlowf7A2mNVTcdtd7GnSpo3
	aFq1FAonyVk3KK0s0pDgB8L2nMIRTSxdOjGsR3jA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn826h1td-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 14:38:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2E5w6Q1034496;
	Mon, 2 Nov 2026 14:38:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnu1vebv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 14:38:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2EcS5845613524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 14:38:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A89912004D;
	Mon,  2 Nov 2026 14:38:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A5D02004E;
	Mon,  2 Nov 2026 14:38:22 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com (unknown [9.39.25.78])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  2 Nov 2026 14:38:21 +0000 (GMT)
Date: Mon, 2 Nov 2026 20:08:19 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
        Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>, Fuad Tabba <fuad.tabba@linux.dev>,
        Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>, Nicholas Piggin <npiggin@gmail.com>,
        Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Stefan Teodorescu <fane@google.com>
Subject: Re: [PATCH 3/7] KVM: PPC: Explicitly force IPIs when directly
 kicking vCPUs
Message-ID: <auiZYdVzhFbnj0iy@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
References: <20261028190259.1819571-1-seanjc@google.com>
 <20261028190259.1819571-4-seanjc@google.com>
 <auStM0rbFol79h5o@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
 <auTohixp3V5-vNsB@google.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auTohixp3V5-vNsB@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: MVuzkhZ7vtCvo0_kidGaNnCzUH4z2Q5t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1NiBTYWx0ZWRfX9NPC/owi16S7
 9yPcxDuxCXAVRis8gROnpHUQtX1lgGRd8hAKUnleFK3QWlX1SdAjhFR8oEvK54MRQDdismPxh+K
 SQ8loUK3UQRzfSLpS9uRj+aWjubkYTlbIquMNg8PhpfWVJkZ76O3xxEXr80qfN6IOD19XJfjKtr
 634hKk5awadYPmt24Ux7BsSNM3cqVRZujAolWeljDDPrwops7bov/t92bCk4p83QwKy6YXStSnl
 0VsEIPP7bIE5T7r4zJSL0tKzTIgSYx+WFY3Qwo3DYgWTx5sTM9UVeBsh0rxrl31K1IM0pQFj1A7
 gw+VtvRxiUYjK/87Jg4SStypE42sXR/2o22pNseu+/r/yDHR8uGSsjBtiHv4st3RTmohj8hx7JP
 UCE4D1U1IEi/wr/eFIXPrL9wTCpxRXnB0VIgaijskvnY1QOUMWWKwaAo3sk8IykSUxckF0V1iQL
 y3XMeya+tQcv90pkeiQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1NiBTYWx0ZWRfX/Jv0f66eb8FC
 gBsCZTcz1I/pV05gMEXUAwMes48ABsD2pbDotd5Qxpz6XqvBunVHHDSaqleBJACDat+c8lSkusL
 mmZ2c5c7i5Q1tgycd0AKgoXZ+Q680vQ=
X-Proofpoint-GUID: 3_YY6ZYXsy9uBgG-NjaOA9L9V7gYRG4x
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6ae8a06a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=duh_M4KPJp97uAtK-N0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020056
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 11:57:10AM -0700, Sean Christopherson wrote:
> On Fri, Oct 30, 2026, Gautam Menghani wrote:
> > On Wed, Oct 28, 2026 at 12:02:55PM -0700, Sean Christopherson wrote:
> > > Explicitly force an IPI when invoking kvm_vcpu_kick() directly instead of
> > > relying on kvm_arch_vcpu_should_kick() to unconditionally return 1/true.
> > > This will allow dropping kvm_arch_vcpu_should_kick() in favor of
> > > kvm_request_needs_ipi().
> > > 
> > > No functional change intended (1 || 1 == true).
> > > 
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  arch/powerpc/include/asm/kvm_ppc.h | 13 ++++++++++++-
> > >  arch/powerpc/kvm/book3s.c          |  4 ++--
> > >  arch/powerpc/kvm/book3s_pr.c       |  2 +-
> > >  arch/powerpc/kvm/booke.c           |  6 +++---
> > >  arch/powerpc/kvm/e500_emulate.c    |  2 +-
> > >  arch/powerpc/kvm/powerpc.c         |  2 +-
> > >  6 files changed, 20 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> > > index 169ea6a7fbad..bbe7378ad0ef 100644
> > > --- a/arch/powerpc/include/asm/kvm_ppc.h
> > > +++ b/arch/powerpc/include/asm/kvm_ppc.h
> > > @@ -30,6 +30,17 @@
> > >  #endif
> > >  #include <asm/inst.h>
> > >  
> > > +/*
> > > + * TODO: For unknown reasons, KVM PPC has historically ignored vcpu->mode when
> > > + *       determining if kicking a vCPU needs an IPI.  Either document why that
> > > + *       behavior is necessary, or drop this helper and the @force param from
> > > + *       __kvm_vcpu_kick().
> > > + */
> > > +static inline void kvmppc_vcpu_kick(struct kvm_vcpu *vcpu)
> > > +{
> > > +	__kvm_vcpu_kick(vcpu, false, true);
> > > +}
> > > +
> > 
> > AFAICS, there is no reason for PPC to always return 1. I was looking at
> > the old patches on mailing list and found this - https://lore.kernel.org/kvm/0FEE585F-5E21-47F2-A3F0-AD0DE05EBB43@suse.de
> > 
> > ```
> > How about we return 1 for kvm_arch_vcpu_in_guest_mode() on !x86 always, just
> > like it's done today basically? Then we can worry about needless IPIs later
> > and don't regress from the respective current kick implementations.
> > ```
> 
> FWIW, I found that as well, but there are a metric ton of kvm_vcpu_kick() calls
> that have been added since then, and they scared me.
> 
> > However, I'll do some testing and get back by mid next week to make sure
> > there are no suprises.
> 
> Thanks!  If we can drop the PPC behavior, that would be wonderful!  Though if
> we do that, it should be for 7.5 in a follow-up (this series really should go
> into 7.4 due to the SNP issue).


Yeah I looked into it and realized that the newer variants of KVM on PPC
are not even using vcpu->mode at all. So that has to be fixed from our
end.

For this series,
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com> # PPC

