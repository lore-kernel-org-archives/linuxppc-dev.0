Return-Path: <linuxppc-dev+bounces-27306-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF11C88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 09:39:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkcRS4m8Vz2yFW;
	Tue, 15 Sep 2026 19:39:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789465156;
	cv=none; b=IjZ95ZSC1a8NCiGabLsVJ/E5Z8aokEGNdHmpewNRKbDtO4E+1eTT7uvEqlw3pT1yzS/piiVknlVigdpC18CInXPKiaeFPaT7yV26IM0hyia5jEGpPdP9k9CBXmP7490zX458p0K4IXjk3Bn3MDO/i4yX75rOc4Chg8ve0wzyRWqUcr+sczSmTXL4ygsJpPMRZCRSF9WGIpwKl7VOFQJ4Y/wW4u6+HcjKORSBThi+y/MQvbM/PoeX5owZ5pA0nvEwI5O1pbTyYDd1rIkdT8igHIG6fDzHz6AETMvYop437+Xm7iWM3sy2nxQzI/fCf4Uui6YvMs31C+H+dO3e8550BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789465156; c=relaxed/relaxed;
	bh=ezRQPvyWo9HKe4O3lW/Kc1sT6/UBrvtIblzKloT6GXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mugq9ePcP/+mowF0ln8GXPVDwr5K5uAup/bhvKqbL5PeiW9w1owQUbUS5Ht/+9jMzFj5S/FzSDLwbY6bKCUqNairO+1/mNCpNPGkak98l9AIO5nwbosjda6mGXCp5F7IP73f1IX6gMThUgpEACMdNuyA/TUe023VjtodMD/hm+BXz6vCBfwt2kbWWfhGeI1cmJX6YkOZb9rah6diNrMbv7FSLKjyvmoOnVHmLacXjrzG7icKWVPIf2k1S1/o07Lnod9kRzs0z3nxokBNamaNQzxNrvZYqA+vBqTURd++AHW7SGnAj2aUu89u4qe2I83wVE+A88Gfe0PTCBVSyZO4dA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UwkVdtU4; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UwkVdtU4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkcRR3ckCz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 19:39:15 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F71SFK150546;
	Tue, 15 Sep 2026 09:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ezRQPvyWo9HKe4O3lW/Kc1sT6/UBrv
	tIblzKloT6GXk=; b=UwkVdtU4opqwdFfSknr0pPx0f2W1OgSrqwTI0oT0vseHc3
	qRwd0BBLLRqRWQzPOO/ELCFjsUJSHiBkAtm9ejHaU0qsYbgPoN/3Ds5f7PCf2eJR
	RPzoa5BPijOlTQmvKTYDzKt4pf6W3f230qyjSLZZU7QDxSHg9duE0Tp/s6cuUq4z
	44K09F3dXH8pjIli6V9XJY88DxZOqRqRdUVFY0N/aoYuEEr3cov0ZPe99TBdX027
	9E7Joy56vDqHWJuz/1Vqs+5/ycyEkRcL2e3jR6xGTZsvzkNjwz71dahDaeDzKd5d
	foWVbjDqHCNaYbsHxNoWDGXbyaPOwcE1/Vw4zbFg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf4xb19-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 09:39:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68F6ZG1j3594819;
	Tue, 15 Sep 2026 09:39:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gq03v8q7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 09:39:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68F9cwbB17826142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Sep 2026 09:38:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55BD42004E;
	Tue, 15 Sep 2026 09:38:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D66420049;
	Tue, 15 Sep 2026 09:38:56 +0000 (GMT)
Received: from dhcp-9-123-3-18.bl1-in.ibm.com (unknown [9.123.3.18])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 15 Sep 2026 09:38:56 +0000 (GMT)
Date: Tue, 15 Sep 2026 15:08:53 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Narayana Murty N <nnmlinux@linux.ibm.com>
Cc: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, tpearson@raptorengineering.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Avoid triggering an extra interrupt
 for a vCPU
Message-ID: <aqkSLYpdCLpccFAR@dhcp-9-123-3-18.bl1-in.ibm.com>
References: <20260915060146.33410-1-gautam@linux.ibm.com>
 <647f3494-1e79-43ea-a8ed-157b3f0e6c54@linux.ibm.com>
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
In-Reply-To: <647f3494-1e79-43ea-a8ed-157b3f0e6c54@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ENni7bObFnMqkn-srT6ImvacDnsnq4DT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDEzNyBTYWx0ZWRfXziwMaQTv+bS9
 fUEDYoOzbUTpX/EE7CwbcBn+e8ZeT9BbBBbbGFT/hsrs4sdr8FyNPQnG7rD3dyXU/F4cxXPd6nc
 0vEBjUzJ9SXCqqidZ5JtmlB4ksbk5MM=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aa91237 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=yKAn6K1XAAAA:8 a=_AprYWD3AAAA:8 a=VnNF1IyMAAAA:8 a=gj-Ntr6HeOcHXmKXbbwA:9
 a=CjuIK1q_8ugA:10 a=6M1ixcW_PCWoKiWyFx5v:22 a=fKH2wJO7VO9AkD4yHysb:22
X-Proofpoint-ORIG-GUID: uu7ZSZFdrprEij4rEY3SnoNd3XkCBrpz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDEzNyBTYWx0ZWRfX+yQM9tETzD0Y
 Yd/XxhYxvLf5Ar9u1v8mkkRR5TuY8nE6hE0uVsgFvS3mU5va1PA4SxA9BC7AGJ/vz8ke51Af4cn
 e1wNuGqZrDVTnz8PfmKR0OMKPd0p3kcX/EjV/DigwBSxotSm7v1NkePfgSD5AjGDXZpL9xxo2Q4
 TI078ubQ12wSVstWy3Vq3xFN9EPfW7iAPNq/nIP3+KzJT9wihPTPOqwdy25nqvdDSH/ZEeVvblo
 qmedcRi848EuI3uQQLyzPaOTQLNXK2Yr6Y4EzqmQ5QXVKlxOIVja/HTcfrvEpa85W7urwZrAWjG
 a6cOt3mA/LyJm5UlmXDze6MErnLA5nJ6qusDL4dIvgR0SdDTY8aDajig5WgZEGgRHz/IBk6Ldpk
 uXPl4pPIJ3A8qLifD0pKeysurd11Ga8rc9w7BylWAyy/CNyAyJieJR9ThacBqOnq9HpPOBTqUNY
 DcIP8HqaGkRGOTaL2Iw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_02,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150137

On Tue, Sep 15, 2026 at 02:08:28PM +0530, Narayana Murty N wrote:
> Hi Gautam,
> 
> On 15/09/26 11:31 AM, Gautam Menghani wrote:
> > A huge number of spurious interrupts can be seen immediately after a KVM
> > on PowerNV guest boots up in XIVE mode.
> > 
> > $ cat /proc/interrupts  | grep SPU
> > SPU:     223705     192439     273526     147623   Spurious interrupts
> > 
> > This bug was introduced by commit ecd10702baae5 ("KVM: PPC: Book3S HV:
> > Handle pending exceptions on guest entry with MSR_EE"). The root cause
> > is that when there is an interrupt pending for a vCPU
> > (xive_interrupt_pending() returns true) and MSR_EE is disabled for the
> > vCPU, LPCR_MER ends up getting set for the VCPU. When the vCPU starts
> > running, the XIVE hardware presents the pending interrupt to the vCPU
> > (since the KVM guest has native XIVE support) and then a second spurious
> > interrupt gets presented to the vCPU due to the LPCR_MER bit being set.
> I agree that we should avoid setting LPCR_MER when the pending interrupt
> will already be delivered natively by XIVE on PowerNV.
> > 
> > Fix this behaviour by not queuing up any extra interrupts with LPCR_MER
> > if there is an interrupt already pending in the case of KVM on PowerNV.
> > This reduces the number of spurious interrupts drastically.
> > 
> > Fixes: ecd10702baae5 ("KVM: PPC: Book3S HV: Handle pending exceptions on guest entry with MSR_EE")
> > Cc: stable@vger.kernel.org #6.8+
> > Reported-by: Timothy Pearson <tpearson@raptorengineering.com>
> > Closes: https://lore.kernel.org/linuxppc-dev/582904882.11159.1786719390349.JavaMail.zimbra@raptorengineeringinc.com
> > Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> > ---
> >   arch/powerpc/kvm/book3s_hv.c | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index 7667563fb9ff..fda3767ebc9e 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -4937,9 +4937,8 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
> >   	if (!nested) {
> >   		kvmppc_core_prepare_to_enter(vcpu);
> The current code handles two different indications of an external interrupt:
> > -		if (test_bit(BOOK3S_IRQPRIO_EXTERNAL,
> > -			     &vcpu->arch.pending_exceptions) ||
> > -		    xive_interrupt_pending(vcpu)) {
> > +		if (!xive_interrupt_pending(vcpu) && test_bit(BOOK3S_IRQPRIO_EXTERNAL,
> > +							      &vcpu->arch.pending_exceptions)) {
> >   			/*
> >   			 * For nested HV, don't synthesize but always pass MER,
> >   			 * the L0 will be able to optimise that more
> This means xive_interrupt_pending() now gates the entire block, including
> the BOOK3S_IRQPRIO_EXTERNAL handling, rather than only avoiding the LPCR_MER
> which causes the duplicate interrupt.

Yes valid point. If both conditions are true, we'll never get inside the
if block, which is undesirable. I'll fix this in v2.

> 
> Also, the changelog describes the issue as specific to KVM on PowerNV, while
> this condition also affects the pSeries/nested handling in the same block.

No, xive_interrupt_pending() always returns false for KVM on Pseries. So
effectively, we end up only checking for the BOOK3S_IRQPRIO_EXTERNAL
bit. So this is not a problem for KVM on LPAR / nested guests on
PowerNV.

> 
> Thanks,
> Narayana Murty N

