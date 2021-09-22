Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC20C433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Sep 2021 15:29:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DDBA60F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Sep 2021 15:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6DDBA60F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HF2Jh5k0Nz2ywV
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Sep 2021 01:29:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qd+E98qR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=nathanl@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=qd+E98qR; dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HF2Ht0XBfz2xxn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Sep 2021 01:28:25 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MEndWS003800; 
 Wed, 22 Sep 2021 11:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=hwdzGlrpRGiS6JWV1SHNFdnStRdlsftxdBcSs0nzl3w=;
 b=qd+E98qRK3nUb7XWANTHwCAVLSNbQGjRRlAvOHRGxKL9ylW8R7btJ48wn1eretSDZQ7L
 G7ve4DRFXlJ0m5syNEduxRt0jZO3ovUV1+3RL24WdN+cKdrjLjl9oK8lBVsonYcMsjPT
 IjlW3yRe3T/Jh74Er1E4sWTSRihxQcr6yPD5P9p2+W+YIO5qci1TEouHIWst7zgUQ4Bl
 nBu7lQzln0r9yY2fNv1nQYv0uPlaxkfKNDS8Iks+L9ViF59m7jp7vcTTaKAG28PjPJMd
 0mHY+kmjiz+p9RZFZ3B1eQzHYFY1vszcb7HYANxKlh3CXfKSLvfGBy8gLeejKyIMTINW sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3b8509vbtf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Sep 2021 11:28:15 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18MD1AES004863;
 Wed, 22 Sep 2021 11:28:15 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3b8509vbsw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Sep 2021 11:28:15 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18MFRPTv015178;
 Wed, 22 Sep 2021 15:28:14 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma03dal.us.ibm.com with ESMTP id 3b7q6fn3e9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Sep 2021 15:28:14 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 18MFSDBX41419070
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Sep 2021 15:28:13 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE05B78067;
 Wed, 22 Sep 2021 15:28:12 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4DCC78074;
 Wed, 22 Sep 2021 15:28:12 +0000 (GMT)
Received: from localhost (unknown [9.211.63.177])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 22 Sep 2021 15:28:12 +0000 (GMT)
From: Nathan Lynch <nathanl@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/paravirt: correct preempt debug splat in
 vcpu_is_preempted()
In-Reply-To: <87fstxi0hc.fsf@mpe.ellerman.id.au>
References: <20210921031213.2029824-1-nathanl@linux.ibm.com>
 <87fstxi0hc.fsf@mpe.ellerman.id.au>
Date: Wed, 22 Sep 2021 10:28:12 -0500
Message-ID: <87h7ecocj7.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eAi6LgbUFmr6odflnhkssty9S7DZcKS3
X-Proofpoint-ORIG-GUID: rKSYWHvTFttfseyCQc6ImKaNndPdTAjw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-22_05,2021-09-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220107
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: srikar@linux.vnet.ibm.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> writes:
> Nathan Lynch <nathanl@linux.ibm.com> writes:
>> --- a/arch/powerpc/include/asm/paravirt.h
>> +++ b/arch/powerpc/include/asm/paravirt.h
>> @@ -97,7 +97,14 @@ static inline bool vcpu_is_preempted(int cpu)
>>  
>>  #ifdef CONFIG_PPC_SPLPAR
>>  	if (!is_kvm_guest()) {
>> -		int first_cpu = cpu_first_thread_sibling(smp_processor_id());
>> +		int first_cpu;
>> +
>> +		/*
>> +		 * This is only a guess at best, and this function may be
>> +		 * called with preemption enabled. Using raw_smp_processor_id()
>> +		 * does not damage accuracy.
>> +		 */
>> +		first_cpu = cpu_first_thread_sibling(raw_smp_processor_id());
>
> This change seems good, except I think the comment needs to be a lot
> more explicit about what it's doing and why.
>
> A casual reader is going to be confused about vcpu preemption vs
> "preemption", which are basically unrelated yet use the same word.
>
> It's not clear how raw_smp_processor_id() is related to (Linux)
> preemption, unless you know that smp_processor_id() is the alternative
> and it contains a preemption check.
>
> And "this is only a guess" is not clear on what *this* is, you're
> referring to the result of the whole function, but that's not obvious.

You're right.

>
>>  		/*
>>  		 * Preemption can only happen at core granularity. This CPU
>                    ^^^^^^^^^^
>                    Means something different to "preemption" above.
>
> I know you didn't write that comment, and maybe we need to rewrite some
> of those existing comments to make it clear they're not talking about
> Linux preemption.

Thanks, agreed on all points. I'll rework the existing comments and any
new ones to clearly distinguish between the two senses of preemption
here.
