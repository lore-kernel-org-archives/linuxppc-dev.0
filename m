Return-Path: <linuxppc-dev+bounces-23707-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F71C43602
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 14:06:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvjh15vhLz2xpn;
	Wed, 08 Jul 2026 00:06:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783433185;
	cv=none; b=SibNaeioJohLEX1UwwHanz6zGZwE2M/xuWK0jLejXT8Lb83bPZ50sXvPR7XMafakbtSLWQGmp9T6IzgecnyqZRiFCwG5qep9G0FFumyKh4Wppt2GktnF1ebIRi+F2pZ6tPB1BwRq0sHe/m7+Vr3w1T9Z+HN9cxaCGoI9MA+6LEHhWs+btPF5okrMY6nHXZYlHulWS34IzX7bUF6yh6tF8Cq/FKGCWfAIHFo8j+xBx7dyocBcTYERe920yuTRLocfJ2FutYBbo68hJZNDNZbzgKWOnG2UKl+Y6W8Qsnzuf6RDLNDddXbruGW/bxly4k4yYSGHRVoQnQWdluiHNX+eaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783433185; c=relaxed/relaxed;
	bh=6KtcuCaZCrFhh+5omzAMd1MeDNFDqYZa9RHaEjNKk70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XuYwLLuwnJ1SlFyldJFm68O9nGAWiQdJNjWu4CcCk8ORD9CAXJHOo8VnN3r0Gdq0BkbzQn6WAaaS2USymN6vb8rPVdGLX/wLkt0Kbiv2zme+qfZ+3pt97FwreXQ/3a2QzLSWrQV/oKzJpgNWgw1dCvv5n/oWyjF3zVrjn4/qTqniGPnkWV5CY16rzKRVsN/yn1UZaH6KLHaX8i/1Xc2qaWvEW7ga/EeqBoITOmhgFgFVHi45jt9uhh3MbRmPdNTrv8zCdBQc1PtPskyQoC0TfBKqPFoFCvhus9LmQ/qPtcSPxDZaTMx4prsmZIPBHi8Rm5EOpEa8jVogdnsg0iCtPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tLcUsPfj; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tLcUsPfj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvjh03L7Zz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 00:06:24 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667CIYcr2878033;
	Tue, 7 Jul 2026 14:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6KtcuC
	aZCrFhh+5omzAMd1MeDNFDqYZa9RHaEjNKk70=; b=tLcUsPfjEYwTpPJ/PV+WtI
	rinL1Tv05npH2G5qOE5aqdBXhpYzkc0+L3O+aUAJxTN7kmr5Umswnc14v0QaVWvQ
	02G/1kmE76f3FdABT0/wxoMRBH0qtayS+6EollQUbtcrPwRvS/OTUb+E73U07pmD
	D1NRV7izW2vuqwgjYo62xC6thfoxe3JWYlReB8F6A7HVZJz3lkFsz9TGVMFIYYR6
	Oq1VJ04alYCQiJSASWto3fB/dNpjLqcMdPDBBT2Gfs27Ak7YlRe9TShOMhzjRuig
	zdrnvjBNcJLaAPjUiiaAnZE7iMBWwbiUWC/tatCVUOa4iqWcJUwVEggkEWkadNRw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsr086-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 14:06:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667E4cqM023305;
	Tue, 7 Jul 2026 14:06:17 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgk355y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 14:06:17 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 667E6Eim24118010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 14:06:14 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55BF65805C;
	Tue,  7 Jul 2026 14:06:14 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB02F58054;
	Tue,  7 Jul 2026 14:06:07 +0000 (GMT)
Received: from [9.124.215.22] (unknown [9.124.215.22])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 14:06:07 +0000 (GMT)
Message-ID: <845be1b6-8e56-46fa-a258-5b0033fac474@linux.ibm.com>
Date: Tue, 7 Jul 2026 19:36:06 +0530
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
Subject: Re: [PATCH] perf data convert json: Fix trace_seq memory leak in
 process_sample_event()
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, jolsa@kernel.org,
        adrian.hunter@intel.com, vmolnaro@redhat.com, mpetlan@redhat.com,
        tmricht@linux.ibm.com, maddy@linux.ibm.com, irogers@google.com,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
References: <20260604065519.112101-1-tshah@linux.ibm.com>
 <aiHuIBAIgv3L6TI7@x1> <f6937d04-6346-443b-8054-6f8a801a4fd8@linux.ibm.com>
 <akWEgMBK7Y39sgc8@google.com>
 <bf12f3d6-7410-44da-b4c4-32dc21244a12@linux.ibm.com>
 <akhM9-d-tNjZzb-A@google.com>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <akhM9-d-tNjZzb-A@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: nB5U9hR-u8yzJycKfzRSap7QFOwsSnQw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEzNSBTYWx0ZWRfX7FiRu1JkaPOe
 7MK2SJ06daNCgLxJpJrk+Q7AR3R37fIfzEUBdXZvqJASHN+OPNPbjXhH16Z4vzQ3ZJK7j0HVCj9
 HxzADVLH1h+IDyr5pCk9Apej99IC958=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4d07da cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=o4hZjVMRaevxAcUiKF0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: NMAtJI_chZxFyfkxZqXWZz-aZioMA2sG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEzNSBTYWx0ZWRfXwvHqUaUwBlmF
 agQZWSkww7SgyScMQGILs7b5FsWfuYsI2Dmxsgl1R2qcGaAb2PcXx4gXHSyKKAagdYbcWpcVlA4
 SOTd03Df+ORHPYycvgFujX57++vrhLhSAQDvkGrCaYgHUtXPls32kMckllGrsQrWVaUgcvGMArB
 oLUYoMwvM1Aoqgf2swKNk2970FjSNWcycTTlxCYROzFadlcRJ3a0gyiyc+3pSun7k4pVhpm/ZHP
 wZAiVDez961kX4hMi5wfE2s3Tonw1LKLTIyZb9D8RSTtDuHJfRqOLPSZ9LWEBhg2Jn2csrJesWf
 nwlsX9ycTPIiKCkiFTfpp3LPK111cMStND0gPLmtL1SySLZ8qFWECOsCM35tXjI1xP0DM2Sa0od
 Zk/HbhW4NpjQ/mgm6+XQQg1zYwkvIbZuEXUMmoJ1Ie/4A4C72UcZxzNvT1ElD3OU2wfTEqHqwd+
 7cnylrE/71tyGnoba6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070135

Hi Namhyung,
The only change I had planned for v2 was the fix for the pre-existing 
issue, which has now already been merged separately upstream.

https://github.com/torvalds/linux/commit/2857a5dca750ea989c6fb70b4c14e801e4b7b4ad

Please let me know if there is any additional change you would like me 
to include in v2.

On 04/07/26 05:29, Namhyung Kim wrote:
> On Thu, Jul 02, 2026 at 12:46:54PM +0530, Tanushree Shah wrote:
>> Hi Namhyung,
>>
>> Yes, I was planning to send a v2 based on the review comments to fix the
>> pre-existing issue.
>>
>> However, Arnaldo mentioned that the original patch had already been merged
>> before I got to send a v2, so I addressed the pre-existing issue in a
>> separate patch instead. The patch is available here:
>>
>> https://lore.kernel.org/linux-perf-users/20260606121528.406919-2-tshah@linux.ibm.com/
>>
>> That said, although Arnaldo mentioned that this patch had been merged, I
>> don't see it in perf-tools-next yet either. I'll wait for him to clarify its
>> current status.
> 
> It's not in the perf-tools-next, and no plan to add it.  Please send v2.
> 
> Thanks,
> Namhyung
> 
> 
Thanks
Tanushree Shah

