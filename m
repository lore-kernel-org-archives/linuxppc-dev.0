Return-Path: <linuxppc-dev+bounces-26141-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B359AC61DC2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2026 07:09:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVt1y1XWpz2xdb;
	Thu, 27 Aug 2026 17:09:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787814598;
	cv=none; b=EiijHLvuK+0JIbhrUCnuOsF9JKlHJKYgmDwQFqeJ2CFhxSfNCNQ6X7WOBAQGTZHiVwZUPiFo4xz1OZFe5HG4Z/R1ScuJ/TZOA+iTHFUda391in7QRwpJjNjFPO7KTFQT4AGLWD77YETj7Q+NkCN9U+OfE1gZQ+De1jr0WGpCA3SozndUa/qHwoZeL8eOItZ37FO72vdjNlqftgmckjNlNko5krGXRo/HRhqGOlLUbsWvcnpzfUoiBebdD87LnqUY7LFblawfhlfhSoPDWj5wxouFbcztVqNlMGy5IghTdutr9z0fWUsIHfPr+EiN5eU7lME0NMSo97u+KFemzBhQHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787814598; c=relaxed/relaxed;
	bh=otjiHE/ALxd0WQQGUzZepzGe33+eZ8p10IspGrscHgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bcsVAql7yeDczdKzrRPCJOOT1cBRY6YroSwTF9FmGJ+unwTgParw0W0Vo3Dqbsz5nVUjW0zLgb7zBrkiwgbn4rdFl3aIII1QfxftDd9WrgcwS0pBrvM3Cd+09yD3ajpYzFPtR9gVSbV0VTSWD8m3KLDg52IW1pZvxfZBybjicxeMgq4fALFx+sXfNimojNv0VUbxCkOM+5zfNT16huPn+XgUwQ3mCpqfE2fwpCj2bjUapHgboy1HJ89PbSFqVjkSOOHW8BLk1q6QFdrue7GyZXMFmbelrPNcvnsah4H6FmtMn3VB38Qkxpx5tWdAX1Wu1VUBLXF1z5dRjdN7AkeWLg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nni1pEqo; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nni1pEqo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVt1x19vyz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2026 17:09:56 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6VdG01082064;
	Thu, 27 Aug 2026 07:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=otjiHE
	/ALxd0WQQGUzZepzGe33+eZ8p10IspGrscHgI=; b=nni1pEqoVHrmpKiBr5bo0o
	oyus+ruOYk4xc6qTGJS5sPtcgefmv9BbB1irt3YKFSugjo48mHpAxreHXXyYCa4J
	jkEVuC0QiGZU8Hxml+oady7G18L5fjx2AZEZqgL7IXGkLbzYL18uxgCbfahnzJSP
	Ya09n/DRTBq2rR1yHvr4cD1lmEb/xQWOiBWmfMkKLXNTzv04FUSY6KpUII8kehdy
	ZoHoCV5K/HRP/wGKiHOlqorRnvL826qG9vw1Kb6+e7l0zvafhO4DFWKddxP3sdrs
	8nHBn/Khr3RmnhJbXVngRFdutexEi7843aziNk7FYLgPbHWqv0ZXVeYIAu0HpOLg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726euq5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 07:09:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67R6uK2A024191;
	Thu, 27 Aug 2026 07:09:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfweshf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 07:09:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67R79dfR42795394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 07:09:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B04B520043;
	Thu, 27 Aug 2026 07:09:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DD812004E;
	Thu, 27 Aug 2026 07:09:35 +0000 (GMT)
Received: from [9.67.147.197] (unknown [9.67.147.197])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 07:09:34 +0000 (GMT)
Message-ID: <04f38671-f894-40ef-94b2-f24e2bd42474@linux.ibm.com>
Date: Thu, 27 Aug 2026 12:39:33 +0530
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
Subject: Re: [PATCH v2] ppc/fadump: collect dump if the collected size is
 lesser than reserved
To: Shivang Upadhyay <shivangu@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: adityag@linux.ibm.com, adri.vero.dev@gmail.com,
        anushree.mathur@linux.vnet.ibm.com, chleroy@kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com
References: <20260826125626.2108771-1-shivangu@linux.ibm.com>
 <1a0a3a16-b92e-47ec-8545-035022583de7@linux.ibm.com>
 <7ed10640c0b27403d7e9ef9807b957cff59eba60.camel@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <7ed10640c0b27403d7e9ef9807b957cff59eba60.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8fe2b9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=5vD7ezWpz5V1CiZQhYcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA1NiBTYWx0ZWRfX+Loab30cce3G
 lPTklQ1tYVhXnZ1ZcSOhUmV/pyNDH61NnGV/FPpIe5MujzY7y737A/aEbVyp8YVDuQroo3+q4QT
 yNsuNT9+h+ckEC8zCzzkdq26LCjuwik=
X-Proofpoint-GUID: 7aKIp31cxkHQE5qmDpFzf8ewqZ8jTyeU
X-Proofpoint-ORIG-GUID: ZSktznSnj5VpQkVey1pmz34mzZNHfiT_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA1NiBTYWx0ZWRfXzvVhD3S+P9Bd
 otwH6IyKZFKTSLS2l33uWpZgf2QCK48iie6YM388h8pRZySv5/TPSNS+p98VLXMtmiN/loQ+QGI
 1JOtkz0qcpMcbigmljMGCFmv97baVWPuXeIZ20IUlkUSRhd6TUwcPnNvPhZ165MGy8NJCdj1Iw7
 uGNWmr4EdEcVgFH7hWy+fWl1LNKcpcsggjE40vcCjjUpimQ6NyECW7pAHKgzUVM+BNhMEBu8j2S
 hRjmSyjR0xZsL/DenClWkNvjvyExYZV3xVHaG/crqqxQyXFFgPHHOqCthwqUT+sTp12S+79hcx0
 onZUeOwKOiTcL3btJ2SLt44y9bSmBgFMsFXm6u304L7ndgVMRccZ593HE3pOkxoveG955Xyb6/k
 imJadv8ZKFyGukG7MvU9las2v7CLSjcKhvg5m9U+SKvrcEdjhbtg563CS2nz8qAgXt5n38Jg/QA
 xCAITEsKl6uGaU5PlwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270056



On 27/08/26 12:06, Shivang Upadhyay wrote:
> On Thu, 2026-08-27 at 11:05 +0530, Sourabh Jain wrote:
>>> bytes_dumped <= source_len));
>> Do we really need region_collected variable? Can't we manage with rc
>> only?
>>
>> Is bytes_dumped < source_len is good enough instead of <=. There are
>> a
>> couple of warnings/errors reported by the checkpatch script.
>> Please address them in the next version.
>>
>> - Sourabh Jain
>>
> Hi Sourabh,
>
> bytes_dumped < source_len should also be correct, but "<=" is more
> expressive. Why not leave such optimizations to compiler.
>
> For the region_collected, RC should be used to manage the return code,
> so I as per me it is more appropriate to use new variable here. Or
> maybe, type the condition in the bracket itself(?).

Yes this also works.

- Sourabh Jain

>
> Thanks for pointing out the checkpatch bugs, I'll send a revision soon.
>
> ~Shivang.


