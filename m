Return-Path: <linuxppc-dev+bounces-24893-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789FCC531D0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 12:35:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7yjZ5V27z2yhD;
	Mon, 27 Jul 2026 22:35:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785155714;
	cv=none; b=L5GAIFvnfd6yMmjuKhnbCD/ovBNqKcgMFGh9hJ8vm65r/tyE2kzRVIPiztsMaINiIfUMHapckrvSw8mQz+bPCwdmqnyQZmcXDt1oJLP54RB7RYojtk0IKsFbo7HQhK/63/6HN9Xvyt1khKI/mpSgbw+lLwwm0Wluv1A6fnyyWXnjVE4DgP8TT8O/jgHNu1KW4kzZlT/suQIIHN2g9oo3+JXOO6XeAqTrRyYWW2HGw3dugXvYI7cdAQYlYHCD70KYU8BFk2e6Y+j8DpZCEuUyKtqAgLoAuwjYR1R5UiCVFyLgX6WlM4b5IJUieKESaHh3SYapRGCYe7T/TXqwsdZoWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785155714; c=relaxed/relaxed;
	bh=MgnlKX50LSSQ+/R87Lv5pPbnottNJiw0TagRCgS+K6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0vB7ENvoZelRBuFcaj1OCpN3BeKBxkGBtqh9DeqnDub1UuvPlfPMKNMBT94VJ9uhRLo2SGnpGbWYyeJbuy6sDwF8EKLpvl/WIeOIH1fD/Hqr2ax922cQEuUodrrmMttvNbEbvB20ZrOXBfdJqhtShAd0pE8X53g2hNSYXwRyc9lEi8pT6uHjGMc5EbmORnoFCdHm7ZqIQWhb5U+3OF5r4wus0mQHpKg1rttaUyErEdkJlAgji6iWBOYj4WCWkA+NO+UEjnwVMxp88sawmq+TKjS7LqMMrmwPbh1C/YpMYLIVYRN8in3Vi91Wv7y9vlFJaDLl+NbFRYagQ48HiFyRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WlEgcBb7; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WlEgcBb7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7yjY6TnRz2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 22:35:13 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RAId3b1844687;
	Mon, 27 Jul 2026 12:34:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MgnlKX
	50LSSQ+/R87Lv5pPbnottNJiw0TagRCgS+K6s=; b=WlEgcBb7dKzfhUONdLdaJf
	rD/HAY2VYg/OVtqQr8rsnp22CPhjEhaBJiwMs2DdxyB44Yi0mU4N5Oo4QKR6ja10
	mTFkQw0X2LoRiSeu8p2GZl+eI19OAuJD/KpiGM9xl+fg+8ErTSsfm4Fo1mh4pDEV
	qfS1xtnZ+oG3ebsgjZ0U1Z36PBN/MENud7xMf7etds/lBdJ+wXcfwaTh7hp12qGq
	nt16cKkyo4d/rDs9mKa44DD0Gp+P4WCmIgYeCW/rZAGQ8QvP0aCkF4ZxlHo3TTks
	9Owr3R4rW7J6Ddut15TppbeJhl0Wqp6LRyoCNsN20JgJixmln6+YCMTnFX4TtAIQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyhyjt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 12:34:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RCQODN026361;
	Mon, 27 Jul 2026 12:34:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yh59pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 12:34:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RCYsGb29098690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 12:34:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E9B62004B;
	Mon, 27 Jul 2026 12:34:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F18F820043;
	Mon, 27 Jul 2026 12:34:51 +0000 (GMT)
Received: from [9.39.23.10] (unknown [9.39.23.10])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 12:34:51 +0000 (GMT)
Message-ID: <e74ac6d4-6ea5-4600-9e01-2ab215235ffa@linux.ibm.com>
Date: Mon, 27 Jul 2026 18:04:50 +0530
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
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
To: Jirka Hladky <jhladky@redhat.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        christophe.leroy@csgroup.eu, mpe@ellerman.id.au, npiggin@gmail.com,
        bigeasy@linutronix.de, will@kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <20250210184334.567383-1-sshegde@linux.ibm.com>
 <20250210184334.567383-2-sshegde@linux.ibm.com>
 <CAE4VaGBwMp3Ke1+Bt11-v6CCE0h=mPm8k_Cf8DazFSQNT9Mz8g@mail.gmail.com>
 <c0f51eda-21c4-4e9d-95e9-75b2740c3f43@linux.ibm.com>
 <CAE4VaGB-W9i0nNzH=VN9GJr6Dy9R46NtMC3V3ELUxdDhypj8bw@mail.gmail.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <CAE4VaGB-W9i0nNzH=VN9GJr6Dy9R46NtMC3V3ELUxdDhypj8bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEyMSBTYWx0ZWRfXzqcdGh8wJ7aK
 QKnCimFmMmMgRP/2U+kxUGlK2kQOVvsqlGcnB5hHUS+DRSfVKLk2QYyOabq+Cf5akXIJ1hNFUAS
 CRvhAozK+6CF1yVSo/IfH44hLwsQkqs=
X-Proofpoint-GUID: kR5ROri9_fWMJ06e-V6ADGUcf-bK-yxD
X-Proofpoint-ORIG-GUID: hXVCyYMYnPpl5N29rHGVv3p728s_BDX6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEyMSBTYWx0ZWRfX6EmXcXQaSX90
 S/6P7fuOPODp3Dqt33trySAwCJIo1zi9/F/8djW/ieMLOL9rwVtLpUkckevQietie3ptShCm4X8
 u5ZrDeL0ablChCga4hUyRR5Wus7oz3jrIsBFvCGbkSkRNhg2g2tXHjN0J0rjxqlXGx+u1fL/hK3
 5btgSj7TEfCPkLLRDrWWZI++COXce9whm0yNtgn7Cct81UhVmpUUpIxPLwrpahrfRY7D3fCjCLU
 90mEU7Z05lNTYScyyzOSr+prANr6LVQVemNQFVEi3fIlhdZZ6jADkcyTPpW9nV92SCZvoba84d3
 eszKI63TghjWspJ2NdQzKI6i2Y+GxlmQ7wEI9b6qCysLjl0IZyX53P3cw/bD33JKG8I5B22hig3
 rsAuLuMSF/LYc/i+Lbz+ofpTgsn2004AJrY/n9B6rptLX7u/vNt4AQGqHeKFS3dRAGRPPBZezn5
 geaFe9aNxxhQsXwELmA==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a675071 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=B82HNqIHFhr-WlQjP_4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270121



On 7/27/26 3:43 PM, Jirka Hladky wrote:
> Hi Shrikanth,
> 

[...]

> 
> The real question is: why does enabling PREEMPT_RCU cost ~33% on
> ppc64le but only ~3% on x86_64? The answer is that x86_64's TSO
> memory model makes the barriers in __rcu_read_lock/__rcu_read_unlock
> essentially free, while ppc64le's weak ordering requires explicit
> lwsync/isync instructions, which are expensive when called thousands
> of times per second in the SELinux AVC hot path.
> 

Ensure when comparing the preemption modes are same or not.
x86 has dynamic preemption since long time. It might be possible in your
testing when you compared for x86, preemption modes were same, whereas in
case of powerpc you are comparing between voluntary vs lazy.

If it is voluntary vs lazy, this would simplify where to concentrate.
(You can easily do this with CONFIG_PREEMPT_DYNAMIC=n on a kernel before 7.0)


