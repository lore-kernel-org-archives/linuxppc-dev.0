Return-Path: <linuxppc-dev+bounces-27812-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0C9C982DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 07:05:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpDkl0pwhz2xk7;
	Mon, 21 Sep 2026 17:05:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789974303;
	cv=none; b=HKfzPyY9l8wHvz8dePr4jhdRdCBpOhg0kXuLliuaBzqiePw1usCGEBRiYPt3cLWrOXifTdAOhfVkcrf1M10jQ3rEb0VlV9LjCtb6fGNHAy6LuK0/oR7gmhuqG2Uat9UovteIK53qAiu5HpfT+B5ojjGsr0cWwnfI+R9lXf08rTZIs2LYOJWIGjia0bowylMvnQMY2kg2YVfc1WG/dnK97wtMJxSWHMmPcdY3VUYPdP7mDMV42Rm0AZax4/ROwhV5m09COoBlS1QhWEqMQ+PCOvI1Q0btC1Z0c45bVT3dA0kXs2JQZtaZnbCpl2niew4kpjocd2MwEl8rPGS9wKjWZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789974303; c=relaxed/relaxed;
	bh=+kP1iCLZakbh0FG6jVlAEp35ZfDOaz3git5jCqXt0KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyPGP9MjAWt9sVvlZlpA7iFFk5oHTHb0soJ1ArfepZPyjPbMWESyEDohbAOKOa9lk2r5WKF54/3+3TwKERN4XvtnFVqZpOc23YzKKzI+/SErbQ4eKxjuSpF+u6TAoy1gJ4JZtYbNVP03rhlVL02zhYXlboFE10UaQC9tSpdBtajqC3Dao7Cx6fnt85f0z5xFbN9eEvOEIIjxUKhup4thQ5hmfeV2vrDVZgxkPV9X99llbEBeGsBprpac/M9YvX4gbo/pi7cFmxIj36cN6nTPRFN3nYaFs084ADxJDjPa7F7JojJboS4YM/8OD4ttT/IS/rJYji+FaSPife+W1LheEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=d70JbJvf; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=d70JbJvf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpDkk1L6wz2xbQ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 17:05:01 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L3aSYG3307017;
	Mon, 21 Sep 2026 07:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=+kP1iCLZakbh0FG6jVlAEp35ZfDOaz
	3git5jCqXt0KU=; b=d70JbJvfz0VVPd+YltVMouduLOibR5DRjO7TU8cBXcGmwD
	m2EXy0RGeIeW1PPjL0duZfrK5RCPF3/pymdunmeO/6ScCeSXPx9AcPUGmzWPpv+y
	Wdkl2yXwxP+eizVtA+v0FO94qbcxqe2E3nsAMIqzI3niVL3NHqJu9y6M55yLo9Tn
	sQPum9bAcV5pT52qZHfHs/N1bjH3nfd46ztNcxphXnPoCWMPKFv2v1zx01zFy6zB
	TwI2spOYWgmWjHuqkjLM/tUTfvGPjArFvYAmjcIySLA33B4esvjBHpTMcsJwDb4G
	/1rj613Ue68ra2h/Ab+OiTp9S2nqg3iGUOXr0Klg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgq716q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 07:04:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L3XYog628081;
	Mon, 21 Sep 2026 07:04:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vcatf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 07:04:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L74ne545416796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 07:04:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35F4D20040;
	Mon, 21 Sep 2026 07:04:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 159B920043;
	Mon, 21 Sep 2026 07:04:48 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com (unknown [9.123.6.5])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 21 Sep 2026 07:04:47 +0000 (GMT)
Date: Mon, 21 Sep 2026 12:35:51 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] KVM: PPC: Book3S HV: Avoid spurious interrupts caused
 by LPCR_MER bit
Message-ID: <arDWLD7CuAwVV4LM@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
References: <20260918055848.28390-1-gautam@linux.ibm.com>
 <20260918060829.D84C61F000FF@smtp.kernel.org>
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
In-Reply-To: <20260918060829.D84C61F000FF@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab0d714 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=yKAn6K1XAAAA:8 a=VnNF1IyMAAAA:8 a=C0UQplxeHUNF3Q06eqEA:9 a=CjuIK1q_8ugA:10
 a=6M1ixcW_PCWoKiWyFx5v:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDA5MyBTYWx0ZWRfXyK3cOmMYTXx6
 ZOb3yQAS9Yj6TuD2pOm+dGLgUuLU4YsAkBM9xvJ05OBhdNNgtdysTDS2NGnxczwy6MgHPzchkDO
 lgWTLhK5bxhXjxP58WVFDC+8kCc4IxM8v3SYNciS2uR+hP7DmbkRZrAb9MbIZmRlOFhhWIRg2bR
 AohF9MOgPLN++F2KwsMh8Ym8ZAqz9rQcKV61kg16BYCTea2PdVEEGslSqaYrgCQoEyH3fm+9oD2
 K9cscwWDAwf05bxt6B+Ex5SyJUaSvoOdV5zf2p8yyody+mmkNi7VLqydxRJ6xxzGSYiT+4ygmfi
 wkLFOkQRa4EkJ/FVCEEwp5KCJlko304epQXs/PDnhI0zv0j1hW9Q8thT5swmXos4Rzbh+nDd4v/
 Jr6DmKJSaiX55mnchF86+pn7rW1sA+p++j35+GsPYB6SrS41ahWyxlnjH1ieO8OCeaEA1bKlTQS
 nw1pm2aEX83dQVMO0nA==
X-Proofpoint-ORIG-GUID: GygjeXbEPNI_UQ74as96vUtXmWo3C4IQ
X-Proofpoint-GUID: GygjeXbEPNI_UQ74as96vUtXmWo3C4IQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDA5MyBTYWx0ZWRfX/OPJRO0rJ89s
 o6dfnZlS/J4UObS/sfueUQBGxoPd2qSYguD/nx/h1p2DJi2UtqeQpTPiT2yOoOf2QQDoDwVcsu5
 sTR44QqX4ev4RkAEsHgSWZpcAMyWxQ8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210093

On Fri, Sep 18, 2026 at 06:08:29AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] kvm: ppc: software-injected external interrupts lost on XIVE hosts
> --
> 
> commit 05773d5b089dd4410c7e3e3a1611da5479c7d1a4
> Author: Gautam Menghani <gautam@linux.ibm.com>
> 
> KVM: PPC: Book3S HV: Avoid spurious interrupts caused by LPCR_MER bit
> 
> This commit aims to avoid a huge number of spurious interrupts on KVM PowerNV
> guests in XIVE mode by not using the LPCR_MER bit when the hardware can
> present interrupts directly. It modifies kvmhv_run_single_vcpu() to skip
> setting LPCR_MER when xics_on_xive() returns true.
> 
> Closes: https://lore.kernel.org/linuxppc-dev/582904882.11159.1786719390349.JavaMail.zimbra@raptorengineeringinc.com
> 
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index dbac3573b2c89..f4d12a97311b9 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -4980,7 +4980,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
> >  			if (!kvmhv_on_pseries() && (__kvmppc_get_msr_hv(vcpu) & MSR_EE))
> >  				kvmppc_inject_interrupt_hv(vcpu,
> >  							   BOOK3S_INTERRUPT_EXTERNAL, 0);
> > -			else
> > +			else if (!xics_on_xive())
> >  				lpcr |= LPCR_MER;
> 
> [Severity: High]
> Does this unconditionally disable LPCR_MER on XIVE hosts, potentially dropping
> software-injected external interrupts when MSR_EE=0?
> 
> The outer condition in kvmhv_run_single_vcpu() checks if either a KVM software
> interrupt (BOOK3S_IRQPRIO_EXTERNAL) or a hardware XIVE interrupt is pending.
> 
> When MSR_EE=0 on guest entry, the patched code evaluates:
> 
>     else if (!xics_on_xive())
>         lpcr |= LPCR_MER;
> 
> Since xics_on_xive() evaluates to true globally on bare-metal POWER9+ hosts
> with XIVE enabled, regardless of whether the guest uses the in-kernel XIVE
> irqchip, bypassing LPCR_MER here seems to cause software-injected interrupts
> (such as those from userspace via the KVM_INTERRUPT ioctl) to lose the
> hardware trap mechanism that normally fires when the guest later sets
> MSR_EE=1.
> 
> Could this lead to dropped or severely delayed external interrupts for guests
> using a userspace irqchip?

Yes this is a valid case. When kernel irqchip is off, the guest vCPU will be required to make an extra
exit to the host for interrupt injection. Will fix this in v3.

Thanks,
Gautam

