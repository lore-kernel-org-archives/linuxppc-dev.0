Return-Path: <linuxppc-dev+bounces-21953-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0706ECD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 06:31:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVdC1434zz2yNn;
	Wed, 03 Jun 2026 16:31:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780468301;
	cv=none; b=TwyrYMEA/GvFuqmwjABLhUzkgDhXMdnbXWe2IL7SNEpphsxzPxWe1GT29H4OOyrwV552MjlAX9rlpc1UGC8yVMhPSwGjVKOKBiUpdKsdy16Xpese3THnANZfaq4ekIe8XKTy9qZW9EA9OXkvEXetZ1sYSWsfQya6YIlaIvzzf065BM06oxLVJC48SNNxcyqA7fRKH2PnpXCGuzlXWBlWrBq6UNsLfudlVV6K29G7Kn0sgicJ60lMIRdsfrRF663J2KPoYEVsN1o9IgawpTE0sj3pMLbXLp5RCh8dKQmIm3NdmPtf3y+RGlVcqQGiUAqagXFDKGo59dDOIFMSCyAkdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780468301; c=relaxed/relaxed;
	bh=vpfiUpP7svL7IHXiwn4wMTU4yD8RUacEtIF8X7A+ATM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MCPCC7xyKyGEkZjOCmhTSH2GFU6TvIMLUzk/DQGLaarBOaP60eENQyl5gQWdZke+dUpww7xrNLRFLVYqRPSluaXne4E/QC94rLYfdFbdrwhcPVVfncq54LfYS5KXjFmeQtQnLbsJlPshJZuUEf+/olhEwH8+FrbGHdSuOUFMO+rwx8KQS6KSoppU8GSv99p6UJ7sIsiiGZMC9/iSJ/atpFKx8Htmy52HmmNPOu6TMHl6tc2xKdhX+Hjt1fSBmAbsSpcxgSZ6kcpoUOjsCutyEeYnDNs/4ZFtWTKmn3rED8DeoLg4kOEBJ/Y2pdBcRInQ1driOm0cisR7HKuKHu0oMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lvIr5bWK; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lvIr5bWK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVdC03KGXz2xc2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 16:31:40 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652NEGd93263017;
	Wed, 3 Jun 2026 06:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vpfiUp
	P7svL7IHXiwn4wMTU4yD8RUacEtIF8X7A+ATM=; b=lvIr5bWK4vTgC90AqFI8T0
	sYuL5/YbovfBy75RAhpEaxm1JKHdD5SbafpGY6JD24W9IJz2rgc+wF5fpNsIw/N+
	bPoGfFl2hDt8UEXvk2+cvCgh1unQ/itN1kJEvseoaR4aFRhZEkx+IEnWLGgP7jjG
	w9J1+NJ2zKvrgBJxI05DY6z30xSdrU7OzlbiZ4KOf0rcMN2kCohWJs7RZTXdABys
	JDO6/yDLI4Y37dBR154pC1xnugbrDXD/FeQQUcxhgYNzR0DZUdxKmLhHRpmYejeC
	aQUoD277/uaw+5zFxsCp+9jG684NYgG8vY/03N/pGqrfjXidXbMdPFIBeMXqbYRQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm51fts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 06:31:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6536O5Uu020209;
	Wed, 3 Jun 2026 06:31:28 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k6w84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 06:31:28 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6536VQTL18154238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 06:31:27 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A18615803F;
	Wed,  3 Jun 2026 06:31:26 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AA2458056;
	Wed,  3 Jun 2026 06:31:20 +0000 (GMT)
Received: from [9.39.24.115] (unknown [9.39.24.115])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 06:31:19 +0000 (GMT)
Message-ID: <884dcf1b-bb4b-491e-abaf-25db66a66b52@linux.ibm.com>
Date: Wed, 3 Jun 2026 12:01:18 +0530
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] KVM: PPC: Book3S HV: Validate arch_compat against
 host compatibility mode
Content-Language: en-GB
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lkp@intel.com
References: <20260522152744.55251-1-amachhiw@linux.ibm.com>
 <20260522152744.55251-2-amachhiw@linux.ibm.com>
 <pl2g6xbz.ritesh.list@gmail.com>
 <20260529141530.fc225a67-e9-amachhiw@linux.ibm.com>
 <cxyewhx8.ritesh.list@gmail.com> <87se74z4a6.fsf@vajain21.in.ibm.com>
 <72ef4cdb-8d9e-4319-9c94-b9a46a6f6194@linux.ibm.com>
 <56c84e26-69ed-433b-baaf-7b53acc60391@linux.ibm.com>
 <bjdsw43g.ritesh.list@gmail.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <bjdsw43g.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: S5quD5hyfQTdDsfrZoeO3hioHd3LLaWm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA1NiBTYWx0ZWRfX5K7siemZgKLS
 d6GkwExqE+1zYIuBn/+MUdCSKKj79eydHtjAy9fFHs+ss8MdJNVxfQWg2+q5RJqef1FlXM0ZUz1
 WCd6/clY+xWb060Ns9bblf5o8q5b1M1lLfUTbTSWRrar2l2rX5Jwi599tQnCN2SQXwvwy5W71Mo
 fPl9B5urr2SeJH84lM46BS034hO9gkfR3BTFYrNl3dGGnAHimhKLVNBeKYPIiQ4+wySbLom3ZDT
 ztiizxd3dPZvDy35sQZOYi5cD/w5pLNTZclD0c0Dcb/c2Xbw24XsuC15KBiSsuDh3tGBhAS8BYu
 ajskxoXkj7Whucm4OLvRCEcjRQNPmYsWJBGC2DVNafHJnN2YG7WEvHylhDw02bXBEjia8RDB5o8
 6y5NDYVl7QPVarmh5SYdyQAvUm+ekc32t1Za3g/7tRvkbEz+cTw6c1g5xyM9PLdvujz4RDBX7dQ
 Tf6J8UiUA+cF4QVE+Pg==
X-Proofpoint-ORIG-GUID: mb9ElHwTvzmqrueOPOjvFKq1lMCCseAd
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a1fca42 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=-XpCkPrO0wptMrQrKwIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030056



On 03/06/26 11:35 am, Ritesh Harjani (IBM) wrote:
> Harsh Prateek Bora <harshpb@linux.ibm.com> writes:
> 
>>> amit, can you just post this alone as a separate patch, so that we could
>>> pull it for 7.2 merge?
>>>
>>
>> FWIW, b4 am -P1 <mbox> should fetch this patch alone (and not the entire
>> series), See b4 am --help for more options to select a subset of patches.
>>
> 
> I agree, however as an FYI in this case -
> I had few review comments on PATCH-1 here [1] - which along with the
> commit msg changes, also had a code change involved, so IMO, it's still
> a good idea if Amit can test and send an updated patch separately for this -
> to be pulled in for 7.2.
> 
> [1]: https://lore.kernel.org/linuxppc-dev/pl2g6xbz.ritesh.list@gmail.com/
> 
> 
> Replying to Vaibhav comment here so that we can reach to the conclusion
> at one place.
> 
>> Hence IMHO, this patch can be marked for stable tree and potential
>> candidate for 7.2 merge window. But dont see applicability of a 'fixes'
>> tag to this patch
> 
> I agree, we need not use a fixes tag then. So, we shall mark this
> with v6.10 tag then.
> 
> Cc: stable@vger.kernel.org # v6.10+
> 
> (I calculated this based on when Power11 was added:
> git tag --contains c2ed087ed35ca    | grep -E "^v" |head -1
> v6.10
> )

Thanks for help with this, Ritesh!


> 
> -ritesh
> 


