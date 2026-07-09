Return-Path: <linuxppc-dev+bounces-23891-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A321C44503
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 05:19:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwjtx2HzKz3c9q;
	Thu, 09 Jul 2026 15:19:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783574361;
	cv=none; b=PWjXqZJOuhmeV3LrqrmxP7hKaYqiVmSzDQ9vu3fyAKHbhIPTk7qmrfRIeNbbBq6Qs8JkVDrmM5fJUTQkiQdbDBJYo06ygyYTaXWOISHTwrkrLsTwp1rjfYNGTqkqZu0s+3U/13T2eFNHKWzaA2HMy/AIMflg4O2lgj4Wl/4Ex5b0bp66RaLCHkOSzZALsYlaV4S1QZ/OSEpTDYnTT/DXn0RATYqKLqFVrx1PMJ8v++sSx3dvXJxqtNHDRc9Jy1BvUzRaefHKE9RhunVjwSCORatZ5nLM6N4Id7qvkvmaTxaEg4ejrTN7QRGl/lPrdshw5g5+Hul9H/ooEeMJVDlD3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783574361; c=relaxed/relaxed;
	bh=9q5uYXvkIacgb7S2FdyDVdQgon79PVVuDsN+BNjDKOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hIipDgORUwHNnwcPg9cK9/WdL1SwLAqhMsxpzYDXVkMWH06peGXyC4QQL5IM4osKc3yYdwWfOTcIry9tTQrlUsgciEXBNz90E2fde9i8/LZ+RJALlSKSJ0b2Qmh74WD45hHsw5Sl+slDcFkWEuKawt/UEJipfucdlxSKFMCiryCVcrRVxIRYHO9EUuXVqBKg7p7C4aJKIdFJFwigHKKtN+d160DCwXcMycyso4qauQewyEh84lzhbYOJs1O/cAMYgu4C0ymvOAnrFvawdYnSOuiE1sGoSQ/kx4KSN98GUQ1BZ5nP4HYaYBl0SoxSgWmSRbwBIjAuYu31Xfzbn2rIZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tKDbPA9P; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tKDbPA9P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwjtw1q5Cz3byl
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 15:19:19 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668NImlG4076768;
	Thu, 9 Jul 2026 05:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9q5uYX
	vkIacgb7S2FdyDVdQgon79PVVuDsN+BNjDKOA=; b=tKDbPA9P2U6u6DDv21bmon
	Lnd6W6go3fr1v43sF7Ea3zE4hblE0+oXZtkqllkSZB0dlFWZOV0p6oUolvD2lZLI
	9G0M8/sNw4q73JfXKpIQlKSjLBXdNmW1esqN4Ss8sIDUbuLSBlpqiiOdHDIEQs0z
	RnQTZeUFwG6KgfHazJAwZxVVL+oe8NlUXncWS72nCwgNqwgW2pXWomCK/5flxhLk
	1I2vvVpqCU1uWo1d34Vd9IMxMVDs51XGeMxy+j8h1oiCcOmNkMw6+lRzwmGKPzKX
	KO8+qAbNUBqxJM1TCS1fT79wfrH0d8cf8ddYQqnLvKmsXi0ZlhELzQylMiiLFMcA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rke0gsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 05:18:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66954d2a031077;
	Thu, 9 Jul 2026 05:18:56 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgqbw0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 05:18:56 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6695ItAR15008430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 05:18:55 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBF7B5805C;
	Thu,  9 Jul 2026 05:18:55 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1B3B58051;
	Thu,  9 Jul 2026 05:18:53 +0000 (GMT)
Received: from [9.43.70.67] (unknown [9.43.70.67])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 05:18:53 +0000 (GMT)
Message-ID: <6c191068-22c4-4aaf-9feb-7782fa3ce40b@linux.ibm.com>
Date: Thu, 9 Jul 2026 10:48:52 +0530
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
Subject: Re: [PATCH] MAINTAINERS: Demote myself to reviewer
To: Michael Ellerman <mpe@ellerman.id.au>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
References: <87y0hspx0u.fsf@mpe.ellerman.id.au>
 <7bpasqtq.ritesh.list@gmail.com>
 <2847c36f-aba7-4458-8767-7617e13058bf@ellerman.id.au>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <2847c36f-aba7-4458-8767-7617e13058bf@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4f2f41 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=M0VemPwJcwODWTKMbVMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA0NyBTYWx0ZWRfX1NHi9Dd68DpN
 YlEDs9nyiPM6k6DaiSpmv14pT3GM8L3Bwpkj/DIld0tXm0iGrfA/YCiutZqDPtrcCllA3Sn1shZ
 vstLb8U0CdfqJZavZdu08JOjhgyIVoWfhgJOa7BjGbXmD5c11VI3zCfIP8BwY8Cvv0jkIou6J2y
 6cFdRfKvzk/n/qmfv6ra6RvJN3JtJN29BbpAfY1e989Y+K9EPoMb69wp5/YOEx3oBtlefmFP6aQ
 efGWr1/9fn3FCcJk5P9e3XOJVGTKwLIIFrsYB2XZUVewK1PZtmmS3kHbB5ar4d1HS9N/wHI9oSx
 +EqdYAYItUBoo0EvOgKsTodRC3V1ySrcZfApoZBDaRCDbUnobigc22xVQbQ5InRMoXpSifXGExO
 n67av0UcnU51kHFV97+OkSJMpXoSZwvnoOccNZUHU2qrwuvHT2qd4L5/F0HHVcG9kJCoQ8uG757
 clxKluJlvJbXMZdZTKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA0NyBTYWx0ZWRfXz1D/rAWMwvIX
 tmJ/5e9lAcJbtcYx+ZPwfsD4BvkxZKkpqrP9Cx+L1d9OWZ/39IYm73fLtzuVP0e9X6aXu1LpCEW
 oSkuqZLqa8wDNluNcXpomoM6q7uLOh8=
X-Proofpoint-GUID: IKXnAkEc-j56bf_yD76SxXuO14TldPJg
X-Proofpoint-ORIG-GUID: oDI1QnyuCuqGLkdKsd_t9Pc-KXbnG4Fa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090047


On 6/24/26 12:48 PM, Michael Ellerman wrote:
> On 11/5/26 11:00 am, Ritesh Harjani (IBM) wrote:
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>>   LINUX FOR POWERPC (32-BIT AND 64-BIT)
>>>   M:    Madhavan Srinivasan <maddy@linux.ibm.com>
>>> -M:    Michael Ellerman <mpe@ellerman.id.au>
>>
>> Thanks for more than a decade of maintainership of Linux on PowerPC tree
>> :)
>
> Thanks Ritesh.
>
> Maddy can you pick this one up please :)

Sure will do
Maddy


>
> cheers

