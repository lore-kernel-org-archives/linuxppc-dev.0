Return-Path: <linuxppc-dev+bounces-27540-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75909C982C1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 05:34:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlkwJ5V0dz2xJJ;
	Thu, 17 Sep 2026 15:34:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789623280;
	cv=none; b=TtGJfDIL4cxuhRdX22ngYPkGHMZp6+wyuvjSDMbyyEWQ4jIDeGfw/IzU7xkW5kGV6wjHg6f0V8myr1qPxOojtrgeRxNSq38e6n8DOSHyo5IUr4FsvRefyR1OTrNkTO9ueDPGbuyCkhlw7xM326JGlzbpwsbe6gESBhfEuE4jh78ZS/+sFvoGmeboHcY1iy3jgQvSs/MJU4qMB0do/oqs2IzTBqcyhEu6LfSjsthTsQ6fQNSmUGMR2bcwYElxKPgXMkcggHSlAmnSmfiPMRbzKXAgN/4bbpi3WXY8Dqv7YDtcEc0pt+iH37fFCwexM5UtFl44wVlr+WnBrlhLs0phSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789623280; c=relaxed/relaxed;
	bh=EN12YxGwDOevEQLxErJJmhDMDR9urf34jZUqtUqQfdo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEYU8KNiiOPGZidvHF3ELoy2XXcNL88oJmrQinFi2FXKSJD0bKVXfDCwz+To2IHeeaVA/qXxRjOXd2jcALLzYjHaeMNPq0ITO/SnckiyaD9oNaqIILCBQGFTKg5l/e9XUU9/sqJbfWGOWkhWzx+HU5C8lafW3c5PJob0VhABJSBo5Qxuowpqbro3oEFomXw5eZCma3hCiNVHpz5nAOZ+PQQaHEQ0aXMiW1eUdWy4JpdtFLRi9eSlFlJVCM9q+hl3/Z3HnjRBym/Z/YCPcJ+PG0ji4CglyCWX1vO8ywC2YpbUiHqT4FvGYInbOqD/kd1kXHpyvtOO/DVazQDYm+r+bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EhB7I7LR; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EhB7I7LR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlkwH5nH0z2xCC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 15:34:39 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H4rGUY046034;
	Thu, 17 Sep 2026 05:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=EN12YxGwDOevEQLxErJJmhDMDR9urf
	34jZUqtUqQfdo=; b=EhB7I7LR6H/rDXVp1390bXEqlVcPa1p9ooxASFjFtK3xyB
	jVeY5De9lDtP6Wd1dseLWY9tAdQhtlsvtrLUrMTph+DNGKmBFIeHEAoO6tnpXGwx
	YyyMpm2e/3MECvvRDYp0WTwO7Or0djjPglGZPamj6GhWnrYCK/7nXpOSYOauuIv9
	u4/iyr1/2j3pOPW68o+40Bmpt0f6L4XptAJorMlUERGw9IVXEgbhJ4Sj0A8RvL4u
	mfJ/NKibWdZY8VYM4nfFtT30CcWQuqnw6Wi1xigU4ZPGDJOujxeWf+7rqJevT79E
	awhvEAvArXioNKVkvAxZCcahEZaOyuOjFaZlbBYw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcv8311-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 05:34:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68H5Tigi2681124;
	Thu, 17 Sep 2026 05:34:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gra3yr0he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 05:34:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68H5YHxp36634882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 05:34:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CB2820040;
	Thu, 17 Sep 2026 05:34:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B662720043;
	Thu, 17 Sep 2026 05:34:15 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.43.86.77])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 17 Sep 2026 05:34:15 +0000 (GMT)
Date: Thu, 17 Sep 2026 11:04:13 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Free the queue pages in error path
Message-ID: <aqt71Sreh_uNXB-0@Gautams-MacBook-Pro.local>
References: <20260916111210.1982-1-gautam@linux.ibm.com>
 <20260916203756.b91f68b1-db-amachhiw@linux.ibm.com>
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
In-Reply-To: <20260916203756.b91f68b1-db-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA3MSBTYWx0ZWRfX6mXMtiOkFCf0
 7pMh87VCqAU9QPWg+aHjl5nNY+YcmKvzFlo9Z5LbIjXTq1C90mu5xU7GHb/gk22m3CIz6ckiMhm
 cNK63HRG/uamhYXGoRgGDJ1PCvkyGWw=
X-Proofpoint-ORIG-GUID: dSS6FMJ3W682ZqDLaGLL1T8gAILSUQod
X-Proofpoint-GUID: O4TiKN4ToQs_uUDYYY6GPiFUYKQYUMNe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA3MSBTYWx0ZWRfX+e0QAFt4Gr+8
 Idl3yMDtL+YpxcyZJfjWtPqG4IEnJze4IjC9SsCO5kMW4FCIqZlHwCIr7/WXrWXWPnRFn+yZTvF
 KXNm3qUP1Mi6Y9raDV5626P5swwvEzzlN8PpeMtvx4k8awjfvyoOeSJUBt5mu76NIPyPU/VZIGk
 2ADyWe9V8rhf6eNEo0D2Gv4oSLWEQkR7aHlsZIHa3AyhtiG3Ivn9+RSJjTuUMcwXeLRdI2XBqRS
 zimX5One3HImeOKmuL34i4+sXMUeDmhhClTNq5dmHgiHNCHv1Dauk2jnKdSywRfWndDn6S7FI3Y
 M1PN+YlW8do2HcVnVKs+965Glxs/BSQxGzR6o0C/aIMi/3gm1E0ib27a6r6m7mn5LJh+FROujdV
 JQmkOW8I+eNOmw9mgNXqpXw0rqlg1zwyssrPwtz6Rb8pmy5PtXUpUWNlt3C9aP0qXSm0mcnJ/X5
 iZcCJwdkTf2qIdnacLA==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aab7bde cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=Az6Wni84_z5dSisljGIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170071

On Wed, Sep 16, 2026 at 08:42:15PM +0530, Amit Machhiwal wrote:
> On 2026/09/16 04:42 PM, Gautam Menghani wrote:
> > If the xive_native_configure_queue() call fails, the qpage allocated is
> > not freed, which results in wasted memory. Fix this by freeing the qpage
> > in the error path.
> > 
> > Fixes: 5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE interrupt controller")
> > Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> > ---
> >  arch/powerpc/kvm/book3s_xive.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
> > index 1d67237783b7..6f8648d9302b 100644
> > --- a/arch/powerpc/kvm/book3s_xive.c
> > +++ b/arch/powerpc/kvm/book3s_xive.c
> > @@ -961,9 +961,11 @@ static int xive_provision_queue(struct kvm_vcpu *vcpu, u8 prio)
> >  	 */
> >  	rc = xive_native_configure_queue(xc->vp_id, q, prio, qpage,
> >  					 xive->q_order, true);
> > -	if (rc)
> > +	if (rc) {
> > +		free_pages((unsigned long)qpage, xive->q_page_order);
> >  		pr_err("Failed to configure queue %d for VCPU %d\n",
> >  		       prio, xc->server_num);
> 
> Fix looks correct.  xive_native_configure_queue() only sets q->qpage on success,
> so without this fix the cleanup path in kvmppc_xive_cleanup_vcpu() would never
> reclaim the pages.  The use of q_page_order for freeing is consistent with the
> rest of the file.
> 
> One nit: I would prefer emitting the error log first and then perform cleanup
> which I think looks more consistent:

Yes agreed, will send a v2.

Thanks,
Gautam

