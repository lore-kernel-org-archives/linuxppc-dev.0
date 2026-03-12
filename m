Return-Path: <linuxppc-dev+bounces-18093-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADA1103E302
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 10:44:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWkkw6SMtz3cFN;
	Thu, 12 Mar 2026 21:44:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773312264;
	cv=none; b=XskJvm2Luaq6h1EB2tEXFPVpH/Glpcf3Hc6l6OnGE6aGoJB6QO8yeKDdfevWjldlHupSz4ur26oDnA8NxoEmpPH16cY+MvRgWGr+t84/hfQvIpG1t1kKEc2iy8t35rpidAisHut0L4afUQ54GPoMaoqoj8gf+bQL//GLPXRJAwbNlVJYjehYaXQUzx/fLo+D6FPLkdDtY7TQrZzMf5O0kac/sDrTYE/7LtfbU5WohyfXqZPWdrHbIOI16qBqphoMMrTTXt/0KE7Rk0PAS92BSm+NpwBSRCjO7zRvPMC83mhqog5iQIYgcHTAvp6KpJehxU9908qsXIVtreciu/9JEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773312264; c=relaxed/relaxed;
	bh=ZIk1u1+PGsswnTzj4NHzJSBJEXkoeOKWDZlGd/YfKnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G5t1feM5pFHKiFGMPd8gGvD7xQjDGfdxAp9s+DNaeGSWKaTjQE7kBJs6snM8UviFAtDheX5XyiV1vGmR3FgyMyE0eVZh6Xt1V/qVDYsJuvzR+M+tbCanD6y+Y7SNukcm4HJyTu3yzhBJ5Nx3fOWEJ8XxGAMeWbcZxkPwjGMhIRB1Mon4HzofXVPU9RXDdiqe1jFYdtPp3K35sLcQYAnskY2wZW2z+p68FDBW9belw3Ltua3jvuceCEwAgt6WA9MtWEQHcNWS7H3ApiPHG+GwfJjl7ahJTZRPp3BeeDex18H6ToiMlIu/Xj48dVn6HBoDIuSqGpP8+j17Rx04AceNuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=htP2a+8I; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=htP2a+8I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWkkv5h24z3cCJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 21:44:22 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BMWYsX2206309;
	Thu, 12 Mar 2026 10:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZIk1u1
	+PGsswnTzj4NHzJSBJEXkoeOKWDZlGd/YfKnA=; b=htP2a+8IqD3h94ioeDhoEP
	W/mSu2uuucj6lP0FunWNyPnGDZh0jr3ICh/MnEAhtCcBBWtryHcrjzRyc64Xk2S9
	w2ZaLtcOkXZnuVuVLlYxeH3VAJeBLwjm2vCqljPC3/qOknpgU3LVMGtW6BgiXyqu
	opUKzALmeKDv2zrlWTuGJvcEnB+W4lUQuIvRLf1oIF5DOiG57yEtteegJiXopaDh
	985mclPWfMldISybr48FYmEYDnD0EyIQZR0OrEXaasjkF0abOc4Wniwqhgvu4un7
	GKFKBmC26mu71OAvkS5pHVmujf9OBy2ZTCI54QmpsToV1D07Z7ZPU7WSzYqjHlZA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh98a4d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 10:44:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62C9eO7m006036;
	Thu, 12 Mar 2026 10:44:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha9hyb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 10:44:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62CAi9fP30015866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 10:44:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C1B32006A;
	Thu, 12 Mar 2026 10:44:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D805720063;
	Thu, 12 Mar 2026 10:44:07 +0000 (GMT)
Received: from [9.109.204.116] (unknown [9.109.204.116])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Mar 2026 10:44:07 +0000 (GMT)
Message-ID: <09ad3753-76c3-4f08-b62a-de2f911c7635@linux.ibm.com>
Date: Thu, 12 Mar 2026 16:14:06 +0530
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
Subject: Re: [PATCH v3 1/2] powerpc/crash: fix backup region offset update to
 elfcorehdr
To: Hari Bathini <hbathini@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>
References: <20260312083051.1935737-1-sourabhjain@linux.ibm.com>
 <20260312083051.1935737-2-sourabhjain@linux.ibm.com>
 <37e21f51-5872-4498-aed6-6db4dd874b11@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <37e21f51-5872-4498-aed6-6db4dd874b11@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M+pA6iws c=1 sm=1 tr=0 ts=69b298fe cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=WCuK3GOqNBlAgzNa_eUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: THfNYA28gvF_5xiDuZWQG813eDdNxy9q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA4MiBTYWx0ZWRfX5l2WSPV/ajGc
 i/YP8JjjJshPs7S8/P4T0e/T6hKrPXH+cLFC9acKypmAwKoxFXuK0WlVCoQsByQWKeqRx1bVzUG
 jBue+1pWwNgDXRv+1dcXBiIOt9IbxzUloFpX+EJCYk61k9sDzvLAKyxB1Q5cL10wStiFfSiDrHD
 LcAZcMQJJep1X3moPI6q+yWBr0eHmmhk57zK25YnFemMphZzbtWjASRANwsufs51sB9QUTEJ8TR
 G33dkAGXujv5Vg/ygqWEdcAKloBTRLc3dWvesFI37tDhSCp0p5jnUXYVrusOFmmVXtF7JmrBhC8
 xPcrj7pa6eudIFuyTzV9Fn2h8rY+CZdfHHgThBxRinrH24+0kDdz0QgquLPZd0+SvvWpzOAkPVS
 48+VvqIeHXFciSOSXnrX9nzd4b9RcWOg+VVsCVstPcmbQ6+ERcd8qaghevT+EJq9GQ1Q4RvH9RX
 tE88VNmR5MAo1NUSe/A==
X-Proofpoint-ORIG-GUID: XyACPrHT_XbyLLXpJuJkBkJhGSE4amY6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603120082



On 12/03/26 14:06, Hari Bathini wrote:
>
>
> On 12/03/26 2:00 pm, Sourabh Jain wrote:
>> update_backup_region_phdr() in file_load_64.c iterates over all the
>> program headers in the kdump kernel’s elfcorehdr and updates the
>> p_offset of the program header whose physical address starts at 0.
>>
>> However, the loop logic is incorrect because the program header pointer
>> is not updated during iteration. Since elfcorehdr typically contains
>> PT_NOTE entries first, the PT_LOAD program header with physical address
>> 0 is never reached. As a result, its p_offset is not updated to point to
>> the backup region.
>>
>> Because of this behavior, the capture kernel exports the first 64 KB of
>> the crashed kernel’s memory at offset 0, even though that memory
>> actually lives in the backup region. When a crash happens, purgatory
>> copies the first 64 KB of the crashed kernel’s memory into the backup
>> region so the capture kernel can safely use it.
>>
>> This has not caused problems so far because the first 64 KB is usually
>> identical in both the crashed and capture kernels. However, this is
>> just an assumption and is not guaranteed to always hold true.
>>
>> Fix update_backup_region_phdr() to correctly update the p_offset of the
>> program header with a starting physical address of 0 by correcting the
>> logic used to iterate over the program headers.
>>
>
> Thanks for fixing this.
> Looks good to me.
>
> Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>

Thanks for the review Hari.

- Sourabh Jain

