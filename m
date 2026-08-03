Return-Path: <linuxppc-dev+bounces-25218-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFDEC55162
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 03:27:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD2Dl5g9Gz3090;
	Mon, 03 Aug 2026 13:27:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785727671;
	cv=none; b=PmfQKuzAnoK6kNyD6fDBRF4ZVhxxqRDtKDKU2qvSUbq0eGtHVJWck9E26hB+QdXxMVdivdJVvtEjPQKulBoSLteB0poBHKHsYiPYJq6puMqoUQCVfwdqCjneiqqLgupLRKpjZrEuWZ0DgHgHihexV+8qI5qHpcdVbTV5Bi3lbVlIiRP6VGYUqm4Buy2uBve85f8XGkKt1mWH0HTIH1HDSUBi2b0OUl03mr7mhGoNnVtpDEy1B9Sznki8pxxhkbFIhOtWogVXW+y8VBOaTlkpwNIUwEClGY/zAdoIuP/mVeKPT5+sCXLJptT76UqQSNM5UtYRdOS2xbraAaNpvEO+Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785727671; c=relaxed/relaxed;
	bh=p7njFPdwdleDfUkwQ8cZgB1y18BH+1J8R0V+0+GvmjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LheAUWNVy4lDZXLQQaoqqLkXm2pzGD6tha6+x7rvNAp19DgH3SAq1wPocSR2w3AmdcFrgp0G9Ja8weMRf4eB6aVbsqdu7un+0D0ERJWWJcEEqzfTtKzbvBcnUMRzZv6FEiwOZtFOtkpkbV/bi4npap5g66ASyQSBhWaEyTUHVZXVErahn6qEW86v8baoRLLDwGJaJ1HbIz58fo2gy0WQkXvGl4seioO8hwhtJuOKaek0kBEXhTa5SW+a9oVj+7w8MnV1d1iuCAHdGsux3ok8zxxOUQS4lUZ7TGH2+gyj+Zl2X3fUB6uxFQi7VNrr1NFsdihUoT+VmA3k6RW5yxWy2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VPRiqW39; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VPRiqW39;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nikhilks@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD2Dk5fpVz308Y
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 13:27:50 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Lm7Qr160772
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 03:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p7njFP
	dwdleDfUkwQ8cZgB1y18BH+1J8R0V+0+GvmjE=; b=VPRiqW39C3KhCT6o6lNZwl
	7LmtqNRlnen44H0Gikroetf49986m6jcNVSk0E1Aw68kzGssOmTMvPw60lWN989b
	O29iHpqBFbLfJYpHk5RPzsf0mUmDnLWpsK97fQlA0po6s1PVdXeb8oHXXcMv/BjS
	/JiNv0RctvdcQOS730Gs+Yxgun8Ap+KW2ny3sUDd3izkZ0TUt3fDcpWQdimc3rXs
	TqPTr0Xq/TYBOwhV9Pdetzm9e0G63E8diWoslWJVhPAi8Pt5WhLrbGiT1XgSSKJ2
	fug7Wwg3AllSK4klC51npP17qLOQqlvMFb8h9RTND5GVKnQJsqtN/uRTlvpb79cQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hemws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 03:27:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6733QIN8005781
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 03:27:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyb9wd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 03:27:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6733RjUh27132346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 03:27:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05ADD2004F
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2026 03:27:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F68A2004D
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2026 03:27:44 +0000 (GMT)
Received: from [9.67.71.90] (unknown [9.67.71.90])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2026 03:27:43 +0000 (GMT)
Message-ID: <e64a2a08-52b2-4767-81b1-f400c0d05364@linux.ibm.com>
Date: Mon, 3 Aug 2026 08:57:42 +0530
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
Subject: Re: [PATCH 2/4] powerpc: Add Power12 raw mode
To: linuxppc-dev@lists.ozlabs.org
References: <20260729145405.3230272-1-mahesh@linux.ibm.com>
 <20260729145405.3230272-3-mahesh@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <20260729145405.3230272-3-mahesh@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDAyNSBTYWx0ZWRfX1JV1B0c/pHUq
 FMDIk8as++7E9agPWQnB7fiQSI0M3C7DW/md9NBYfRTJejkTECYgap08xdbl4IHGERvebtHBC/1
 LHyv0vMgD3zWsn9oUA/J9SKkz3EpG18=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a700ab3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=OTtu3KHVWy19j3GCJuoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDAyNSBTYWx0ZWRfX/mHCJemAGrje
 GNVdjspk2DLejg11Y+K2AKgvOeBOM5oTTDshXoa9S0jrDtaDozV7SsjSCKXeB4371GDoIEM0kzV
 cLOVMRImmodxF7vSOvIl/GD25yuw8RF89KItgai42kG4CKVQGcQ9bTufF2KL99dwdM0tZzkUbo3
 sNTrKyHAi25f2knyxDoUZXZaASzqUz7+UxvhawWcdlIaj1LUmKQLgU3CaZ8TlLYxyd63/GDaSsK
 TL9+M8SIjxQIiO0AmFyvIDjEG48s6WkvVEjz5dMyl0M8p+P46ZUgjtxhVHhZswS5lwPBHb62m3k
 gbeXbI9Rml3uEMtrTrO9uNbPYgHCKhg9rRuAxZ4suWjIucZX7/rdmuRuhmXjYcsIU0qUWdD6nm5
 hN2FXIuHkoyYP9deBn3oFT88I7pE5lH6XW1gqZeVQlpTxd7p5RHcJb+NjSGc4bRIkLaoOEO+i1P
 6eGlE6MJyL8HRR0gH1w==
X-Proofpoint-ORIG-GUID: 542aXOGkvSvp9H8Wro6w4kxhvCBHZ1Jk
X-Proofpoint-GUID: 542aXOGkvSvp9H8Wro6w4kxhvCBHZ1Jk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030025



On 29/07/26 20:24, Mahesh Salgaonkar wrote:


Looks good overall.

Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>

Thanks,
~ Nikhil


