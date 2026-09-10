Return-Path: <linuxppc-dev+bounces-27048-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3331BC88E45
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 23:19:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgtt93QJ4z2y71;
	Fri, 11 Sep 2026 09:19:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789082369;
	cv=none; b=RnwaF5CgcuAD4UMyTEeZ2Na+7Z7nkI7XyFZ9Li6fLHkRjmLUVZWZ+e85jdlVyfQdF1qvGw6ImH5UPbKmMeOspYpGiGKxaItoLXeoGxnEqJQeH2rF4fQOYudprAf42KExAHksG3I/8/LfSdaJNKNNhCowkL7EIxfa5h/UsiZq9u8zn75rAdkDZvqizh3wQH6q4m52ncQeXYFJVFnQNssGROljb2C7gUvXhb1ekwaHtdtfslb9Bkq96l+GjcM1v+W2boE7Lz+txfvMZKuzHXGwdlJgHu3jpYgLapbsJ/vADLqKHPTX5o+tNBUH64jB0KJYJso1G0RwV4vIFBsyrVQYHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789082369; c=relaxed/relaxed;
	bh=U99p6JNpo0/YgiXhGsoaxr93fp5GlQc6/HMs+HzSII0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MUVgBC3P7HNRKaalQaqFI6CMrABNhDJalsc51Rq4NQxKPvKQPLShcuu3aSIKiPE8MEedbxJaoycc7FYKB/ThnO9qUzr4pVMIgbMkB4NuYMW7nI6alpkg+sKNz4NPgoQsNm4nxWeeNONs9GY4Cy+jSEo7emdzQ/aMwtVmB+KZkgpn/jNDXnlXQ4odAlSu9WWfYyR8/75JSy58lFoOEPywGphZzDS/d2DUH7aKjT/okavANAuFV7nMcFLoZeA/iH/P4cLr9KE/g5YK9rKUP6J81wRUHYUzmoffy+fL1wj6CprvfesLFOSTMq/1AkXeRIiyAOdfZUh2z/gmMZqVj4wXgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bloJPTcV; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bloJPTcV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgtt84zDHz2y25
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 09:19:28 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ALVhbE4092168;
	Thu, 10 Sep 2026 23:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=U99p6J
	Npo0/YgiXhGsoaxr93fp5GlQc6/HMs+HzSII0=; b=bloJPTcVbKa8GMust48rIL
	7pd+UlpAl0XUgwsxfFB/So93Bw44s0gqWVx72lCUp1iteXdWX40lqJoXwT5R6D/0
	w7+HnxNrJ1rkdp6W7lCkjO1RymO1J0UYLBonLVIiWoC8TpeeiCRcPg9LpXNfoynr
	ejmevrlP+wudEpQf7RPjerLQDg/J2tRA9hr5VSDB5vmoe4/llWtyu0AYOXpNQz4B
	HRzdTVavEWkQfL94rO2RgDnl1Dkjmg/bWc0Wbagx1WnHZKsFwTfjSpBuPTQDq2bZ
	A9SwuhZgIfh0brj3iKwwt+xp1bGaguNI9nK6W4TQeqdqz0YBAtX768xtCP8jiJkQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8qr3tn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 23:19:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68ALYwO7654793;
	Thu, 10 Sep 2026 23:19:18 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkvq2u628-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 23:19:18 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68ANJG7d29491732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Sep 2026 23:19:16 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8341858060;
	Thu, 10 Sep 2026 23:19:16 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 941C858056;
	Thu, 10 Sep 2026 23:19:15 +0000 (GMT)
Received: from [9.61.103.123] (unknown [9.61.103.123])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Sep 2026 23:19:15 +0000 (GMT)
Message-ID: <0d2e6821-9ebe-4155-b667-e98acf1bb2ae@linux.ibm.com>
Date: Thu, 10 Sep 2026 16:19:15 -0700
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
Subject: Re: [PATCH v8 5/9] scsi: ibmvfc: add interrupt routine for
 asynchronous sub CRQ
To: davemarq@linux.ibm.com,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <mkp@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Brian King <brking@linux.ibm.com>,
        Greg Joyce <gjoyce@linux.ibm.com>,
        Kyle Mahlkuch <kmahlkuc@linux.ibm.com>
References: <20260909-ibmvfc-fpin-support-v8-0-b27183b055af@linux.ibm.com>
 <20260909-ibmvfc-fpin-support-v8-5-b27183b055af@linux.ibm.com>
Content-Language: en-US
From: Tyrel Datwyler <tyreld@linux.ibm.com>
In-Reply-To: <20260909-ibmvfc-fpin-support-v8-5-b27183b055af@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=SpUFe/O0 c=1 sm=1 tr=0 ts=6aa33af7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=eExql_viPIbS7pE7dewA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: YRtb2prPVUSsa55k78RVvojR9Yq4kKqs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDI5MCBTYWx0ZWRfX4w9tc7J07Rie
 q8DVr2XJFKqBEMloyPJ8LqmC+QwmuyWQuxFEJ07YC9xznps8VyrHtrOsSuBqsdKT3rBic9sFGqL
 Q4jJiHavLqOBQzmGbnIDmxkCBW596uFWOFgXoqVs2yfRpY036G50lck/bRbw0cLzIJ0jKE56whE
 tHgWCLyJC7vgCzVA6bjMx+IDw7ccV0Wq4hAVl/IhfrPfL3g6cGvSUwGMfnM9UIj1+zf1hhXfdMQ
 H2Idk1Lj7xnh/a6Czfq9vtamgAXJq91aqqinB2Iy51NQDcZdZvEMWDzwJI8HfQev5v6t4P30up/
 9Bdz27vMkfgWMYrWrkk51YCI2qCV20CGlHXFBhrOZSRP/LGFMA6cSt0hPj5vjd+THTHshI7UwZT
 ueXtzIkm0wW3HR88GZ1rucoqWPWJ1d0oz0rXWWO56zsSLNvL6pmM3MwF2+lX12cRHrbiSgk2OZH
 Ebhj1TMON2nzvNVFtsA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDI5MCBTYWx0ZWRfX3ucwHxEA6Ihd
 cQbWUuECt13yulkKv0dgb/us0YpVnqPJqCDKjhLHXuvgXvDbxy2aUl4r1g70P6JYlpFZATPRooL
 H91LA0m1/lZSgw7Cb1Ptf++Deh/4mCk=
X-Proofpoint-GUID: XCB2tZ2i_fu57V9gTWsqnRJbC1EXPwmv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_07,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100290

On 9/9/26 12:08 PM, Dave Marquardt via B4 Relay wrote:
> From: Dave Marquardt <davemarq@linux.ibm.com>
> 
> Add ibmvfc_interrupt_async_subq(), an IRQ handler dedicated to
> asynchronous sub-CRQ events from the adapter. The handler disables
> the sub-CRQ IRQ and then calls ibmvfc_drain_async_subq() to consume
> all pending entries before re-enabling interrupts. The handler is
> marked as __maybe_unused until a later patch when it is used.
> 
> ibmvfc_drain_async_subq() holds the per-queue q_lock while
> processing. It loops over available CRQ entries via ibmvfc_next_scrq(),
> wrapping each in a typed struct ibmvfc_async_crq_event and dispatching
> it to ibmvfc_handle_async(), then clears the valid bit and issues a
> write barrier. After draining, it re-enables the sub-CRQ IRQ and performs
> one final check for a newly arrived entry to close the IRQ-enable race;
> if one is found it is processed before exiting the loop.
> 
> Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
> ---
Acked-by: Tyrel Datwyler <tyreld@linux.ibm.com>

