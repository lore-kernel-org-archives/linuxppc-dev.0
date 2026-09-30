Return-Path: <linuxppc-dev+bounces-28590-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B698CA5FC4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 16:41:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hw15k742Nz2xwP;
	Thu, 01 Oct 2026 02:41:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790786490;
	cv=none; b=QQYTKXuwbZ57pK2PIjTe7LZuVUUfEDlhH4VmGwHGsGKhhlRRvCarm8QHkquQh3omOzwVdtMjIvphG12/caoUDaAz++f9J5M+fQkkcOibCF0ajxnb0aCnlUsS197Bj/4woGgaxzdNA4+dV+qIc6l9QYi9H4JKZjU5SDsb1RxgMJjRaVAHW4P6I+S6WlgoupbB2YujZyRuDKbTOwxDrzFJgKMhU92+fLEWhDK7kn77X1V+QxYEeiAu20iC+kWrOmzf+jCEps2TxKLmd0Auqctcn//8Rdsq8KbCubNQUbUzfoLmqejm04mVYNfZ3Dapvm+wwJZ0ctcR3RnYw3gPLm/LVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790786490; c=relaxed/relaxed;
	bh=0oMXs5+TrKE1cJXnC3cLBqcfOFtA41Wr69Z/a67ZBXM=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=P5C87fLTlhSP1UpxqPG090Ufnwjcoy37+a340lpJNPBe6MQiSmNyuIG1oOpZ+OZ5/i7Thr1I61f4suqFZjRnD8iEZTEXOObxYy2UWRWuhU9NgkNoh5/FDcgMfaeDQpkwdP59l7K2S0CJMvcpcIC16Do88NIM8QmBax/E20eVblDVdpOEqA1aSWVqkNM6PVEZKWtnvjTTOpGoiw7jHbCwlyNEjGdEIwaudjriYsrfgmIMU2VQlCpWx9EluOes52C64dSFdh814nXTogYIDWtEg3UJoeUTKxOtLFfcCahJ/+uuYkZD+vFeQCo3EbvTtw72ksl8DRArsQpa0fq2JrHLrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qEyThTF4; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qEyThTF4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hw15k1xMdz2xM9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 02:41:30 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE5JZr3203027;
	Wed, 30 Sep 2026 16:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=0oMXs5+TrKE1cJXnC3cLBqcfOFtA
	41Wr69Z/a67ZBXM=; b=qEyThTF4iZiUzkctPcHKJyEtrmi+WbwPfz0hhZs+s7iF
	hdshmuhrfqObz7JCndZgxaRb5OKb+1lnXGWMW+jhTua/VCGTbtBPjKU3KbK4ZtzT
	1PYGLYS/XSEl15TRa5Nz+9u6n3/yNPjHpm/mUM1c5+0l3UbBZC0SHGuar/9FMCKt
	Ve8HdGxu+ozXfh1o/3qg7kVnQeUVehg9gz+IaBbxmmf4YK/Gz5WjSh9qv6ZTkPnH
	dkPXAspYtK2jX9LU4R1VDiJVFKnrSjB+bUPUUZIXLLKpJkJf7Ub3aPn6xPGA8tsL
	7sK9p4ZhNlvGUDBmmpmPToLkunj9NxjukQq7dA325w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5ed5b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 16:41:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68UEHupv3569204;
	Wed, 30 Sep 2026 16:41:19 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcs9y8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 16:41:19 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68UGfGU665995154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 16:41:17 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D738A5805D;
	Wed, 30 Sep 2026 16:41:16 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57DF458058;
	Wed, 30 Sep 2026 16:41:16 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 16:41:16 +0000 (GMT)
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
Date: Wed, 30 Sep 2026 22:11:16 +0530
From: Jyoti Gupta <jyoti@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        sshegde@linux.ibm.com, sourabhjain@linux.ibm.com,
        amachhiw@linux.ibm.com
Subject: Re: [PATCH] powerpc/mpic: Fix memory leak of mpic on error paths
Message-ID: <fb3c8fc047e29000ddaab61fc707868e@linux.ibm.com>
X-Sender: jyoti@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2NiBTYWx0ZWRfX8JK13+h61AHi
 3wr8aejjcy5gYylp5eq+f9bDyvwSY39n5DEx2wiDKbOf8oEXUwGGnqjwLsS3Mfjw1PwDlcHb2RG
 +j9QybWCiYxnuoTtEHWmDUGRejy9bkQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2NiBTYWx0ZWRfX+bwJmxaeeeIf
 xU8EYWUihaT5cZ5fyOY9FDYXZxs6YmhftaLITRteIkdDwEyDa5yacBswx/Y2d52CgjHH7NrJEXN
 7bC+aETlUx40ZFT/BXxBriVoGZgE3jn7qp7Cz7o35HDUgAWJCzG+/Wik4eeQ1O4rIf0hvVqz6LP
 p5sEpdJ1+XppGilwnvDRWSXPbvZr97svhDfEu/3jMtL33416buM7ypxCU8zGSz+M9hw8mM+MZhS
 IKVuIiRO9ByOHEknc55mO/cEIYaBV+oIaFDLQXz5he/bpgRw0ePDq8wF9Y+q2wDekOn0Qtiowrl
 q0Xa0mKQXxCLfrJtyZKHgy/ysZCgfCwYHUCyJno7iMjLt1fPEjHXJrt5yJH5O+yX+pfOMjg+2fl
 aW4MDWqXehJv0/92N7ZgzHFpcN+HWttKW6GJLWyq2U84z04MxO0ixr+MDdcYonU+hp0vPFUCnPF
 Lc6x8nIYAczxf02iHLA==
X-Proofpoint-GUID: HMCUrs0G3CLbfVTmiyVo09wMtrQ_N5SA
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abd3bb0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=voM4FWlXAAAA:8 a=e5wYs6-hrR6EjXF8iz8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-ORIG-GUID: 05ZUrhGKtacQygCjCRTCBGxLKMAyFzBw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300066

On 2026-09-29 13:02, Amit Machhiwal wrote:
> Hi Jyoti,
> 
> For some reason, you response to this thread is not appearing on the 
> list.  I
> think you mail client is messing up the "In-Reply-To" information in 
> the
> header.  Fix look into fixing it.
> 
> For now, I'll qoute your reply here with my further response.
> 
Hello Amit ,

I'm not sure why my reply did not reach the list,but it is visible at 
the link below:
https://lore.kernel.org/all/e3c17fc50f7897b08fbd67a120087467@linux.ibm.com/

let me know if this looks fine.

> On 2026/09/24 03:05 PM, Amit Machhiwal wrote:
>> On 2026/09/24 12:00 PM, Jyoti Gupta wrote:
>> > mpic_alloc() allocates struct mpic (and optionally the protected
>> > sources bitmap) but does not free them when mpic_setup_error_int() or
>> > irq_domain_create_linear() fails, leaking the memory.
>> >
>> > Initialise mpic to NULL and free the bitmap and the mpic in the common
>> > error path before dropping the device node reference. The register
>> > mappings are not released here.
>> >
>> > Signed-off-by: Jyoti Gupta <jyoti@linux.ibm.com>
>> 
>> I see a couple of problems with this patch:
>> 
>> 1. The patch does not apply.  Both "git apply" and "git am" fail on 
>> this patch.
>>    I think the context lines around the irq_domain_create_linear() 
>> call have
>>    tabs converted to spaces, which causes the context match to fail.
>> 
>>       ❯ git apply 
>> ./20260924_jyoti_powerpc_mpic_fix_memory_leak_of_mpic_on_error_paths.mbx 
>> --check --verbose
>>       Checking patch arch/powerpc/sysdev/mpic.c...
>>       error: while searching for:
>>       						 intvec_top,
>>       						 &mpic_host_ops, mpic);
>> 
>>       	/*
>>       	 * FIXME: The code leaks the MPIC object and mappings here; 
>> this
>>       	 * is very unlikely to fail but it ought to be fixed anyways.
>>       	 */
>>       	if (mpic->irqhost == NULL)
>>       		goto err_of_node_put;
>> 
>> 
>>       error: patch failed: arch/powerpc/sysdev/mpic.c:1488
>>       error: arch/powerpc/sysdev/mpic.c: patch does not apply
>> 
>>    Please regenerate with:
>> 
>>      git format-patch -1
>> 
>>    and verify with:
>> 
>>      git apply --check <patch>
>> 
>>    before resending.
>> 
>> 2. The mpic_setup_error_int() leak is not actually fixed.  The commit 
>> message
>>    says both mpic_setup_error_int() and irq_domain_create_linear() 
>> failure paths
>>    are fixed, but the former still does a bare return NULL:
>> 
>>      if (fsl_version >= 0x401) {
>>          ret = mpic_setup_error_int(mpic, intvec_top - 13);
>>          if (ret)
>>              return NULL;   /* <-- still leaks mpic and 
>> mpic->protected */
>>      }
>> 
>>    This needs to become:
>> 
>>          if (ret)
>>              goto err_of_node_put;
>> 
>> Thanks,
>> Amit
>> 
>> > ---
>> >  arch/powerpc/sysdev/mpic.c | 9 ++++-----
>> >  1 file changed, 4 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
>> > index 6e8fa94985f3..e777b33f170d 100644
>> > --- a/arch/powerpc/sysdev/mpic.c
>> > +++ b/arch/powerpc/sysdev/mpic.c
>> > @@ -1221,7 +1221,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>> >  				const char *name)
>> >  {
>> >  	int i, psize, intvec_top;
>> > -	struct mpic *mpic;
>> > +	struct mpic *mpic = NULL;
>> >  	u32 greg_feature;
>> >  	const char *vers;
>> >  	const u32 *psrc;
>> > @@ -1488,10 +1488,6 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>> >  						 intvec_top,
>> >  						 &mpic_host_ops, mpic);
>> >
>> > -	/*
>> > -	 * FIXME: The code leaks the MPIC object and mappings here; this
>> > -	 * is very unlikely to fail but it ought to be fixed anyways.
>> > -	 */
>> >  	if (mpic->irqhost == NULL)
>> >  		goto err_of_node_put;
>> >
>> > @@ -1527,6 +1523,9 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>> >  	return mpic;
>> >
>> >  err_of_node_put:
>> > +	if (mpic)
>> > +		bitmap_free(mpic->protected);
>> > +	kfree(mpic);
>> >  	of_node_put(node);
>> >  	return NULL;
>> >  }
>> > --
>> > 2.55.0
>> >
>> >
>> 
> 
> Response from Jyoti:
> 
>> The mpic_setup_error_int() leak is intentionally left to a separate 
>> patch
>> already under
> 
> If that's the case, you shouldn't have mentioned about this change in 
> the commit
> log of this patch.  The commit log needs to be updated accordingly if 
> that's
> what your intent is.

Agree,I'llfix it in v2.

>>  review:
>> "[PATCH] powerpc: Fix missing of_node_put() calls"
>> That patch converts the return NULL at line 1392 to goto 
>> err_of_node_put as
>> part of a
> 
> I could only find below:
> 
> https://lore.kernel.org/all/5cef10ab1610113fe162cec1dffd97f3@linux.ibm.com/
> 
> Sorry, but I don't think thats the right way to send a patch.  You seem 
> to have
> replied to the email which did not land into the mailing lists at all.

Yes, I made a mistake earlier by not keeping 
linuxppc-dev@lists.ozlabs.org
in the loop. I later replied to all with the list included, but I 
understand
that was not the right way to do it. I'll resend the patch as a fresh 
thread
in the proper format.

> Having
> said that, I think fixing this particular path in mpic_alloc() would 
> make more
> sense in the current patch itself.

sure we can do that too.

> Please look into fixing your mail client and send the patches/responses 
> in
> proper format.
> 

Got it.

Thanks,
Jyoti

> Thanks,
> Amit.
> 
>> broader of_node_put() fix series. This patch focuses only on the
>> irq_domain_create_linear()
>> failure path.
>> 
>> Thanks,
>> Jyoti


