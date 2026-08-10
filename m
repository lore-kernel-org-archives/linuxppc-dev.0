Return-Path: <linuxppc-dev+bounces-25667-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C7AC5AD55
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 11:24:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJXTN2L5dz300M;
	Mon, 10 Aug 2026 21:24:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786361064;
	cv=none; b=QGTdUrZ4OxYBA53iXphNZWsJAbqN0zTZ5cttPbGOX4MkfwbaMNsp1/yzXxmeBkOX1cflINrhR0OQmQaz2YnEbjqHMxgE/D+3HOoRJpPMVdICjuc4uxlVKuValWDv0z77lkCelAFMjv+iWqowPO3QBhIVJnOA/okx+dT9/b2fa2jhbe9W/DjrTRgDufpH52qZd8DYLl3H0AIUo19u6jzKF0cnwVtV2XKGirg1iek/lo9PgxqZQf2hZotdDhC+x4hqaI4Wrw1w92XiVDKUmxRhlbv6+2TRoDZgBC/KmwSK1rtfKD+M0Y90bkRgm8jgeVEAlLD6QztXg6iqjYxtra8y9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786361064; c=relaxed/relaxed;
	bh=UyXnN6KzqqJafPgk0FbzkSe5GizCPL6xsVcbzR06fSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nH1/VvM2pTvt5J0YNAToqeOWWyeI3z6Iav7xE182EkmNzZmn28O4FzZPICJKpWXLCqbqD/8qm9qVmnlhRjVQ9P4Qw2hPh4QP6ptZiiBykSBJvvyhZm4O/V3rbtBGAYc/PRq1H3bqGNbfLjLU62AuDKOgVIlbtLHuIu0ccHYoJagNAYXeZCfmveAkhSlIPdv7bJi2POntH1IFIOIUk3a+Q3qAKi7bUvh7bSJQZCULdu8k89XM8GetQdzI5AseZALrx8B0axVuxY/4AAcqNtCyP81Qm2xCVDbnqZeMzKbgLQGZ4/147FGk61kbYB2I4RARxI66l9ujwntZZIILqcUgyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ey4XELE8; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ey4XELE8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJXTL3dMtz2yr6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 21:24:21 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A9VcIV156698;
	Mon, 10 Aug 2026 11:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=UyXnN6KzqqJafPgk0FbzkSe5GizCPL
	6xsVcbzR06fSQ=; b=ey4XELE8P4LqkXJzkBoDkQwJNDXiQGQgdk1fWGZH45dihF
	InmzcUyVnz4NwvKPjUon+HtuJkOAX55/71yQttNUQpI4QmEfizeoMIjnGdDcm7YL
	3BONUyttv6IkhyXFxFSL0stFpssQWXfH/fBrQ959wTAVaJpQDKe8qmH1FUNGwe7b
	JkfkyInoOK+r2f8xXq5EnszhuDOz063ucyOsf/jk59d1v6/Jj4jN+Pkl+ioJ/4hc
	Iev7vmlLhjBThb84ETYb3Jubc4cNwD6MaQkzLvXeO82AoFiiH5d564MF+BvmxK2U
	FB9cBicXhiLk2zGqR/Ljkxk7c3p+cN0PyeWRVpAA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23gmps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 11:24:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ABBIvs018945;
	Mon, 10 Aug 2026 11:24:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5vvmwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 11:24:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67ABO11l27460040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 11:24:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6355020040;
	Mon, 10 Aug 2026 11:24:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3C5620043;
	Mon, 10 Aug 2026 11:23:59 +0000 (GMT)
Received: from Unknown_32:98:3c:96:ca:91 (unknown [9.124.217.120])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 10 Aug 2026 11:23:58 +0000 (GMT)
Date: Mon, 10 Aug 2026 16:53:51 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] KVM: PPC: Book3S HV nestedv2: Don't drop pending
 doorbell across L2 entry
Message-ID: <anm0x87QdleHJkCi@Unknown_32:98:3c:96:ca:91>
References: <20260803034426.44249-1-vaibhav@linux.ibm.com>
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
In-Reply-To: <20260803034426.44249-1-vaibhav@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a79b4d5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=0B3C9rvBywIFNyW0WCgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA5NiBTYWx0ZWRfX8wKet0Q3JIQ3
 sdxfvyZMlSdGgm4y5uBNx2FFoxAUX4aKECEfOcZFMNuqHDvks65NC3wjY8dFZXpDNNsFRNVfOMZ
 qKUXkI8UpMYpiHN14adTI8o7hxuczdM122t7aTrvoetwAjyljZ0KpKOPcpeZBqAf8G6va22HYKf
 hxpQtKUCETmjqW/CM2+f7leDKv1OFfRfzZtcXVv+n0EFIHECXU7BPa9e37w0f2rrBIiPYIxlvLe
 boW8WW8AwbCXXSSosPU6Vt4+fNpqmIPbHihRTfSUoDKG17BO+6BUizeqrwR/S6POB2utZRQFiu2
 /EK1mxP3WHbyGsMz93DxxbmKgFcPBqzum6RTqSMCgBG75DEMok8B546LO1tPh/Rd09sf/VnClJV
 5Ft6UBakq+8NPc1dUff9mJKSRGnCXU39+vqVf72Kjgws3Lf4RGKh/BR+GBpmXHvcHFX/auidgl6
 Js2vgOCTlUPPiSxVhwA==
X-Proofpoint-ORIG-GUID: UaURIJ5ryHTsV_Mxcq6-doVJ76csltgy
X-Proofpoint-GUID: UaURIJ5ryHTsV_Mxcq6-doVJ76csltgy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA5NiBTYWx0ZWRfX3M2L6+l9pcHA
 lMLOS/7CI3J/fa56Lzk1sykkBojHh8Zqeg0Ty50MsQB/fqtmiEegZ9apNxEB7t+BNmyErZZVS1g
 F9z1g4eatAmO+6PupxXDHk5lu9jmsKA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100096

On Mon, Aug 03, 2026 at 09:14:25AM +0530, Vaibhav Jain wrote:
> On nestedv2 the L1 converts a pending doorbell into guest DPDES state at
> the top of kvmhv_vcpu_entry_nestedv2() and immediately forgets about it:
> 
> 	if (vcpu->arch.doorbell_request) {
> 		vcpu->arch.doorbell_request = 0;
> 		kvmppc_set_dpdes(vcpu, 1);
> 	}
> 
> Clearing 'doorbell_request' at this point assumes that handing DPDES to the
> L0 is equivalent to the L2 having taken the doorbell. That is not true, and
> the doorbell can be lost in two ways:
> 
>   - The block runs before the lazy_irq_pending() check, so the doorbell is
>     consumed even on the path that returns 0 without ever calling
>     H_GUEST_RUN_VCPU.
> 
>   - DPDES stays pending in the L2 until it is actually delivered. The L2
>     may exit for an unrelated reason (hcall, page fault, HDEC) with the
>     doorbell still set, typically because it was running with MSR[EE]=0.
>     Nothing reloads DPDES afterwards, so the L1 never learns this.
> 
> Once 'doorbell_request' has been cleared, the L1 has no record of the
> pending doorbell. kvmppc_doorbell_pending() returns false, so
> kvmppc_read_dpdes() reports the target thread as idle when a sibling vCPU
> emulates 'mfspr DPDES', and the vCPU can be treated as having no work
> pending and blocked. From the L2's point of view the doorbell is silently
> lost, which shows up as an SMT guest hanging on a doorbell-based IPI.
> 
> Fix this by making 'doorbell_request' track the L2's DPDES rather than
> being consumed by entry:
> 
>   - inject DPDES after the early-return paths and before
>     kvmhv_nestedv2_flush_vcpu() serializes it into the vcpu run input
>     buffer, and no longer clear 'doorbell_request' there,
> 
>   - after H_GUEST_RUN_VCPU, reload DPDES from the L0. The run output only
>     carries the state the L0 chose to return and the 'valids' bitmap is
>     zeroed on exit, so an explicit kvmhv_nestedv2_cached_reload() is
>     needed to see the L2's current value,
> 
>   - if DPDES is still set the doorbell was not delivered, so keep
>     'doorbell_request' pending so that it is re-injected on the next
>     entry; otherwise clear it.
> 
> This keeps a pending doorbell visible to the L1 for as long as the L2 has
> not consumed it, so vCPU wakeup and DPDES emulation on sibling vCPUs stay
> consistent with the L2's actual state.
> 
> Fixes: 54ec2bd9e017 ("KVM: PPC: Book3S HV nestedv2: Fix doorbell emulation")
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Assisted-by: Claude:Opus-5
> ---
>  arch/powerpc/kvm/book3s_hv.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3..40f8717b8a7d 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -15,6 +15,7 @@
>   * by Alexander Graf <agraf@suse.de>.
>   */
>  
> +#include "asm/guest-state-buffer.h"
>  #include <linux/kvm_host.h>
>  #include <linux/kernel.h>
>  #include <linux/err.h>
> @@ -4253,11 +4254,6 @@ static int kvmhv_vcpu_entry_nestedv2(struct kvm_vcpu *vcpu, u64 time_limit,
>  	int trap;
>  	long rc;
>  
> -	if (vcpu->arch.doorbell_request) {
> -		vcpu->arch.doorbell_request = 0;
> -		kvmppc_set_dpdes(vcpu, 1);
> -	}
> -
>  	io = &vcpu->arch.nestedv2_io;
>  
>  	msr = mfmsr();
> @@ -4265,6 +4261,9 @@ static int kvmhv_vcpu_entry_nestedv2(struct kvm_vcpu *vcpu, u64 time_limit,
>  	if (lazy_irq_pending())
>  		return 0;
>  
> +	if (vcpu->arch.doorbell_request)
> +		kvmppc_set_dpdes(vcpu, 1);
> +
>  	rc = kvmhv_nestedv2_flush_vcpu(vcpu, time_limit);
>  	if (rc < 0)
>  		return -EINVAL;
> @@ -4296,6 +4295,17 @@ static int kvmhv_vcpu_entry_nestedv2(struct kvm_vcpu *vcpu, u64 time_limit,
>  	if (rc < 0)
>  		return -EINVAL;
>  
> +	/* Check if privileged door bell was requested and handled */
> +	if (vcpu->arch.vcore->dpdes) {
> +		kvmhv_nestedv2_cached_reload(vcpu, KVMPPC_GSID_DPDES);
> +		if (vcpu->arch.vcore->dpdes)
> +			vcpu->arch.doorbell_request |= vcpu->arch.vcore->dpdes;
> +		else
> +			cpu->arch.doorbell_request = 0;

This is a compile error, should be "vcpu->"


> +	} else {
> +		vcpu->arch.doorbell_request = 0;
> +	}
> +

I think this entire block after vcpu exit can be reduced to just

    if (vcpu->arch.doorbell_request)
        vcpu->arch.doorbell_request = kvmppc_get_dpdes(vcpu);


- Gautam

