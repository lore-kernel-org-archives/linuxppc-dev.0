Return-Path: <linuxppc-dev+bounces-28457-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42946C9832A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 07:32:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hv8yK6xsKz2yDD;
	Tue, 29 Sep 2026 17:32:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790667129;
	cv=none; b=BCpjZXA1x2FqZFFCGtDKxfN05FcrPq9QlGSyZL6oFSJH3/xRjLBTYFjtnZNCRAD6YsqLPNNHxCt9QK9EndoULczgath8wFDNf7RKYnTPV+/LIgDPKvf334JEER/VZknBbv/Ei2JTIPvgPVl1RIi5QIKUMPsBCVYZuANRHbMt6UDwbcUJUbAhqDNd9AGdq57aXMxdath2y0m77fkzRZYOrNcQ8aSZzuXcpszHlgT9iR1J0ON0hk2PPXAzFD5WkGFO48omGY4RvGFqWQ9sw83dskZRT5XGN5N9xtMXUtQ+ONzj+Bk/948ensODK26hpce22DYmjuNcm7Sq/D7e2Fc6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790667129; c=relaxed/relaxed;
	bh=IQ9jngTqByyJcVeQPbMLFvw90PDdA/vF1xnbfxGwiJE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcfPoDarxwo2hNIZDDfGIx2LmsFKlldOOyOCD8rOCfdtJyWT473s3eye5gozlvk1SHzXGQmV+THPfl52L3K2A29R1FdQXzbIV9+JlHSeBSjY78LNId5TmYRFfgID2p+Fm39IqKq/T3CqVwdm2+eS+dN1OR/C/tx/4XwZmipRlOi0gy/07CQUaYAa4AET2Usc36ac60M76247NiSgGNpoiW7VzSCEcDY8zXEDJhCZmwT6hM6tdGN7+tknCnFXY2kvceTB9Sy8y7c/CJ9OgIZ5S0rVLw4cV2n1Ed4ComzKAKfA7w+YDvA3WBTmjutfRQmoTiVQluaGIIF40XOck0xEAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EG3TIX+Y; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EG3TIX+Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv8yJ6ZXFz2xbQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 17:32:08 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T46i1l3039067;
	Tue, 29 Sep 2026 07:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IQ9jng
	TqByyJcVeQPbMLFvw90PDdA/vF1xnbfxGwiJE=; b=EG3TIX+YpygeNicBQvH/ay
	OC3Nfn1jKh8Fa3zCnQA+Qlr2D6qzBxi4KHuWJspDs9xoU1UQaMBxUINoCeBvff6X
	/2XlJkYu3vQU1ho1w9B1p4nFbQ0i8Y64N14wd8yeFYh4ZHWzu6r+R+qSFuvPj3UG
	PMeDB3EH4WpUJIoWFZL4J4hu/W4bdjyhrNDszwB+LfHDaluJ11VwNK8bTKIdzCrL
	kw6KT5ooiaLnBKkR0APOhN7QWs4mSCFmcNR107xg9TcgdaneOBXoW1hi7xRLAxVE
	B0F9XvCRv6ARe7V9Hni8Cp/jiw0QJ8t9VnwU4MGXO5RkkZxeh+mWp6gRo1Ff90MA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pt52rw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 07:31:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68T4I1A01188848;
	Tue, 29 Sep 2026 07:31:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhgp4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 07:31:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68T7Vr6L36503958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 07:31:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F61720043;
	Tue, 29 Sep 2026 07:31:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD6CC20040;
	Tue, 29 Sep 2026 07:31:51 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 29 Sep 2026 07:31:51 +0000 (GMT)
Date: Tue, 29 Sep 2026 13:02:02 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Jyoti Gupta <jyoti@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        sourabhjain@linux.ibm.com
Subject: Re: [PATCH] powerpc/mpic: Fix memory leak of mpic on error paths
Message-ID: <20260929125129.3a2cb188-6a-amachhiw@linux.ibm.com>
Mail-Followup-To: Jyoti Gupta <jyoti@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, 
	sourabhjain@linux.ibm.com
References: <20260924063010.188642-1-jyoti@linux.ibm.com>
 <20260924145126.cf1c0ae1-37-amachhiw@linux.ibm.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260924145126.cf1c0ae1-37-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: oZtA1xWZ4xHWl32Gk95vLv0X0hfLMm2_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyOCBTYWx0ZWRfXwJct2pxTkG6d
 f9UOgqnccQosTfFIQSuqKnqWh0cUOY31HRedekpqVUj54EKRTn53w2CASjMYkY+xPhA8Vc5epNH
 qCZ47/9cvvWXBH9QjK0W1ZBPQ959kqYvbHSGXQkXWqIKh8CMYGCRGlovvTvAMRIZ4u0lUgNeWS+
 TB4aD8Xmd+VBrTGbVmgu7gH14fV68O7894ZEDk6iXpLHFhMHUXi+/DJsk+GqZNlBfVSd85/PTXJ
 MCk+R/pbPWLv56/Bcy6iN6UHZChKU9ho7Q4ZC8/fmJ8CGkK0//HxWIh/m6PUfW79eTsZ31YfHyK
 RtEDdJtIUDklp58bhOOg2PEH8/TyFNHT7NqUmpRz4WChMc5Z6SN4iAe0yb35P+KTaIwL6rDBLnU
 0HsS5mDJfFPSU+uv4TONcR9myl5LHsvD7Vz6sI5EB2I1nPEhni0raHoQdWSm0rJtDewN7TGbNI9
 UkNpSLpIhLEQdIrpqSQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyOCBTYWx0ZWRfX3QG8QhMCMPE6
 ByeFlGDkZKKX4s9nBylMXL+dBVko/IxGNqnEaJ+6tA6Mw3zkQo9e4ZsG9ZEKQuEbJfrtNH2OaSY
 BDBoGK8ZtjyxvGJ3/MLu4/oqHvTJyaY=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abb696e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ZjwvQQGdm79EV9HjngsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 25koA3qREoFGG2UHxidKZD3mMkTB-ROm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290028

Hi Jyoti,

For some reason, you response to this thread is not appearing on the list.  I
think you mail client is messing up the "In-Reply-To" information in the
header.  Fix look into fixing it.

For now, I'll qoute your reply here with my further response.

On 2026/09/24 03:05 PM, Amit Machhiwal wrote:
> On 2026/09/24 12:00 PM, Jyoti Gupta wrote:
> > mpic_alloc() allocates struct mpic (and optionally the protected
> > sources bitmap) but does not free them when mpic_setup_error_int() or
> > irq_domain_create_linear() fails, leaking the memory.
> > 
> > Initialise mpic to NULL and free the bitmap and the mpic in the common
> > error path before dropping the device node reference. The register
> > mappings are not released here.
> > 
> > Signed-off-by: Jyoti Gupta <jyoti@linux.ibm.com>
> 
> I see a couple of problems with this patch:
> 
> 1. The patch does not apply.  Both "git apply" and "git am" fail on this patch.
>    I think the context lines around the irq_domain_create_linear() call have
>    tabs converted to spaces, which causes the context match to fail.
> 
>       ❯ git apply ./20260924_jyoti_powerpc_mpic_fix_memory_leak_of_mpic_on_error_paths.mbx --check --verbose
>       Checking patch arch/powerpc/sysdev/mpic.c...
>       error: while searching for:
>       						 intvec_top,
>       						 &mpic_host_ops, mpic);
> 
>       	/*
>       	 * FIXME: The code leaks the MPIC object and mappings here; this
>       	 * is very unlikely to fail but it ought to be fixed anyways.
>       	 */
>       	if (mpic->irqhost == NULL)
>       		goto err_of_node_put;
> 
> 
>       error: patch failed: arch/powerpc/sysdev/mpic.c:1488
>       error: arch/powerpc/sysdev/mpic.c: patch does not apply
> 
>    Please regenerate with:
> 
>      git format-patch -1
> 
>    and verify with:
> 
>      git apply --check <patch>
> 
>    before resending.
> 
> 2. The mpic_setup_error_int() leak is not actually fixed.  The commit message
>    says both mpic_setup_error_int() and irq_domain_create_linear() failure paths
>    are fixed, but the former still does a bare return NULL:
> 
>      if (fsl_version >= 0x401) {
>          ret = mpic_setup_error_int(mpic, intvec_top - 13);
>          if (ret)
>              return NULL;   /* <-- still leaks mpic and mpic->protected */
>      }
> 
>    This needs to become:
> 
>          if (ret)
>              goto err_of_node_put;
> 
> Thanks,
> Amit
> 
> > ---
> >  arch/powerpc/sysdev/mpic.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> > index 6e8fa94985f3..e777b33f170d 100644
> > --- a/arch/powerpc/sysdev/mpic.c
> > +++ b/arch/powerpc/sysdev/mpic.c
> > @@ -1221,7 +1221,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
> >  				const char *name)
> >  {
> >  	int i, psize, intvec_top;
> > -	struct mpic *mpic;
> > +	struct mpic *mpic = NULL;
> >  	u32 greg_feature;
> >  	const char *vers;
> >  	const u32 *psrc;
> > @@ -1488,10 +1488,6 @@ struct mpic * __init mpic_alloc(struct device_node *node,
> >  						 intvec_top,
> >  						 &mpic_host_ops, mpic);
> >  
> > -	/*
> > -	 * FIXME: The code leaks the MPIC object and mappings here; this
> > -	 * is very unlikely to fail but it ought to be fixed anyways.
> > -	 */
> >  	if (mpic->irqhost == NULL)
> >  		goto err_of_node_put;
> >  
> > @@ -1527,6 +1523,9 @@ struct mpic * __init mpic_alloc(struct device_node *node,
> >  	return mpic;
> >  
> >  err_of_node_put:
> > +	if (mpic)
> > +		bitmap_free(mpic->protected);
> > +	kfree(mpic);
> >  	of_node_put(node);
> >  	return NULL;
> >  }
> > -- 
> > 2.55.0
> > 
> > 
> 

Response from Jyoti:

> The mpic_setup_error_int() leak is intentionally left to a separate patch
> already under

If that's the case, you shouldn't have mentioned about this change in the commit
log of this patch.  The commit log needs to be updated accordingly if that's
what your intent is.

>  review:
> "[PATCH] powerpc: Fix missing of_node_put() calls"
> That patch converts the return NULL at line 1392 to goto err_of_node_put as
> part of a

I could only find below:

https://lore.kernel.org/all/5cef10ab1610113fe162cec1dffd97f3@linux.ibm.com/

Sorry, but I don't think thats the right way to send a patch.  You seem to have
replied to the email which did not land into the mailing lists at all.  Having
said that, I think fixing this particular path in mpic_alloc() would make more
sense in the current patch itself.

Please look into fixing your mail client and send the patches/responses in
proper format.

Thanks,
Amit.

> broader of_node_put() fix series. This patch focuses only on the
> irq_domain_create_linear()
> failure path.
> 
> Thanks,
> Jyoti

