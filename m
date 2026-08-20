Return-Path: <linuxppc-dev+bounces-26015-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E1FC5DF81
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Aug 2026 08:19:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQbv02VkTz2xGZ;
	Thu, 20 Aug 2026 18:19:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787213948;
	cv=none; b=HsvoLHYRFRUbMYVJ0/epO580l7ZBhw0n3IIWEJzmWUwwi54fI17rWq8P5v1ceC/u5mI1H0urd17Wo7zjeHhZpV8PV/7wtCAI67WnIzBkhqE3DV56Q10gteWFf9Z+fRc4CCYnhRZ/ZNgyLlSHAgKqFDDHlUibfehrHqMe25ks5GLkHWXrllimUVL1evrtYlZEFJI0m1rmH8ypxaa9sbHkuZyXuer6SnUg13B83fjsgsidYkHNPW6VTwKi5rFKOJGCL+YiaqfDyRvDY/mX8XGhfClS9JkGuXw6G595Lk9SanIFJQyrgnb2jK0gUhao6tlYZaaapAWI6QQ/2ICpTnzElA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787213948; c=relaxed/relaxed;
	bh=AAirpN0qrffHgItZ8eiG0du83ZgLdPSt0/OHp9BOnsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UybeUJooBqsR9EdWwxkzkBNoaBVjem7LwHBjaWF5xsZyICoU+2eQ6IUq+FQlQycAzIFBmLszlfh0MrBpkg7pNulLYS7sUlBs9UrvFN2KE03DjdvNNrnwXxMylv9eLG/sNsEaguzWMMdGYj+bld2TqYfNMwtzpxxjdYYhHjkNBOM34FJgZHI5BLgt3Lv/LkakoZ5eTHtCxzewibSb7G58wVZxXi0bTQxj0RCUilxF+cpkrMIEya/aVhWYbBQaOjMfUEziGydedprWm9RTqNwkS3ldXAwBc9XqIdEjPOA16WcZ8GdGrJYIPTTzVHPaGbLnYRr2OCefdcWDKyPVbvul3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oAgg37at; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oAgg37at;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQbtz31qJz2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 18:19:06 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JLW6HE504701;
	Thu, 20 Aug 2026 08:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AAirpN
	0qrffHgItZ8eiG0du83ZgLdPSt0/OHp9BOnsg=; b=oAgg37atM2AP7WO0aqmTCD
	2AhbYOMn8J6uvfUKvXjvX//IkMC/oKTmo0tqpmPO7MlSrO7+QFPmxSrvVV4oNIpr
	ppn9FBeprfS0Wcvt0sTwquxhdWKfQhIQQ4b+ivyTlkAsZF19SG67Yf4zcmst87KU
	wz6SOZJqH94MHkngw4TeWeLsh/FR9JmgaBnovsN5EtDCFVAVmWPdaK0QksSxY/yO
	bCunQjru/9eaV512z2s2Z7OXu2MSyXwFhR1B/bS6G5iSt/uHfN7MvIgeXudxODCK
	KC+esXW1CrNMZlf/byUhMRqvR/bAFMJ/6Wq2HgnNNSZZAq6vJX/DmF9n0Xo4CVGw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu48tqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 08:19:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67K8BIkc001107;
	Thu, 20 Aug 2026 08:19:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqdjh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 08:19:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67K8Ix6x30540142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 08:18:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0868120043;
	Thu, 20 Aug 2026 08:18:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA3F020040;
	Thu, 20 Aug 2026 08:18:57 +0000 (GMT)
Received: from [9.123.12.89] (unknown [9.123.12.89])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 08:18:57 +0000 (GMT)
Message-ID: <b41dd1f4-43d7-4dff-8066-2b38261498ef@linux.ibm.com>
Date: Thu, 20 Aug 2026 13:48:57 +0530
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
Subject: Re: [PATCH] MAINTAINERS : Add myself as reviewer for PPC KVM
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com,
        npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20251103094243.57593-1-gautam@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <20251103094243.57593-1-gautam@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a86b878 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=voM4FWlXAAAA:8 a=VwQbUJbxAAAA:8 a=Yn5BDKwI8ay2HT2g_hIA:9
 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-ORIG-GUID: IYmNwJTOqnt86Fy4kVZdAQAFpu8cePTW
X-Proofpoint-GUID: PhKdlGYM84CUX6omwl1QKnIy-1nwkDCU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA1NyBTYWx0ZWRfX7WIvhHdWHHf9
 OV2PzIUIFXBnaKd669lrkS4k3q6A16NJ/laP/yqvbiT91VKVzLnayvO/bkybhCBAZmt6w9DCny3
 N6PuWl4sr77Qyxwnq2gFLBEklkiNe6o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA1NyBTYWx0ZWRfX9P/zcep+z1EN
 pA3U/Fa2wPurZiKN7MG+SNRnIvT1652VRiqVLGFWCsHkyzb3c8+Q42nZqGjnJcVgQKA0yi/zMe/
 6lTfSkW3hnvl+BOtFcNIX8AuhI+i0NLvdmgVp+FIvweOfEtXNiTsKwYrMrr0TA8KyxCcGWNJyH3
 xR0H/cHadxIx2dRR1pjLKFq6w4lRdHiQ/pTduRWxqD8rIf9z6J9try6EQj6b1MgY7Lrr25fNDSM
 YVoy92FCEVoicZDcp9x6CCD4dxcfKM/445TTvCREaaIC6smB9kSqyM3b/7wlgDU5nqnMQ851XYT
 cVHFu1qQh7+0oftziOl4rcQalJyn52z8vC8gr3XvRw0nH0XTd6w0Y4F1FFUa4SxE6QM3VoSf+SP
 QeIMjVVT5Dr7CV6gu67Mpzl8VQ4j6Gdof3otY3u0zlZtCcpnwxg4311fP0tcujk6ULngK10ckyv
 A4SOE6YeWzfsJB0ZG4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200057

On 03/11/25 3:12 PM, Gautam Menghani wrote:
> I have been contributing to PPC KVM for sometime now and would like to get
> notified of incoming changes to help with code reviews as well.
> 
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 46bd8e033042..3f2f60486222 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13701,6 +13701,7 @@ F:	arch/mips/kvm/
>   KERNEL VIRTUAL MACHINE FOR POWERPC (KVM/powerpc)
>   M:	Madhavan Srinivasan <maddy@linux.ibm.com>
>   R:	Nicholas Piggin <npiggin@gmail.com>
> +R:	Gautam Menghani <gautam@linux.ibm.com>
>   L:	linuxppc-dev@lists.ozlabs.org
>   L:	kvm@vger.kernel.org
>   S:	Maintained (Book3S 64-bit HV)

Reviewed-by: Narayana Murty N <nnmlinux@linux.ibm.com>

