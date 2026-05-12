Return-Path: <linuxppc-dev+bounces-20796-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748F3CD343F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 18:04:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFPcM0vdbz2xjQ;
	Wed, 13 May 2026 04:04:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778609059;
	cv=none; b=KVKbWDfWr8WUqbMulY/8y/apY4pq2uHX2DJsPAwXLaiakQsEnLugtj5E15/Twun9FJU6VULGzZJ8HW+JSJFd1ZGtnVFkO06Hw9armsvSYEpZZr3XShbm8HvM0s4jeZrh2ZMnaxkt4VDWRR7ihDEetNKxzv0mUfdrqSdAGqFaLiNEJy961r5AmjNjIJ5wIig2qvamMWSd2ZG3PUK8jnUDYmlPsqKGNm80vt/uDGktIH4YrT/B77LLVKTWkp/77ShHxnSgl1h00gr++DS8PP2mBH7E76GmXArn2hdgTuO+31GC+FjV63yP5bdLsas06DGB9yiLvy5o9lXabomihqXG2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778609059; c=relaxed/relaxed;
	bh=JOzF+CLcPWwWhcbX5+RE5fGkEATJlbY1giR5YKcZ2RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Su2y1sMa7CYPCtzifcs3keI6/3JClIyIR/I2MYudgl+TgZgsPueitiRWAjSJH6AojmhoKaLPvCWUhrsgn9SS4AJPnuEoicyoy/ioSUEihbziLba27QB2XeoG+Z5PlU8nCUK7i+30Ww5kXj5vUBKXy4Ho74iy/O+vVJMnAhM5fq1HzXWx1CivpvtkskLXT+v/fhTt8kZY2N29O1+19ly41uK8g+vhE1v5Z6RL8/ynWqrAm2gRwuISZgcf5eS3Qv4W/6aCZTmHAaqb8mG+FJ+OrkDTcQz4NsOmeCyR/u0ibHz69jhkKgNIZho6Gcsy4Yv0abQNK+8R3ITLZEun4a8JYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nTP96Lcq; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nTP96Lcq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFPcL2xQhz2xb3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 04:04:17 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CCcmh12608405;
	Tue, 12 May 2026 18:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=JOzF+CLcPWwWhcbX5+RE5fGkEATJlb
	Y1giR5YKcZ2RY=; b=nTP96LcqOCWysvpptx9ixggH276iGqEX2OFx6mkMBDeMAE
	pNfLiqy3MBNc5d8XHI+8uGbml5MdpoNmqUnLq+hPyNSuKbOOsWdpSuO/J8eTeFI8
	k/rAU5u1vHanPwymqALu3VDjxa+gnuaUfqbGu0TjfNHeqj6ne0DuqNVd6EwjtFak
	U1xG1LmvTmXrxbvLZ5cUzI8Ba9G/GtiHOeO6NMaTwx6d+Pw/umsMKJK2cOq9RWjn
	l073ghbszp+v7lSPjc4DP76pHUmJNZS7+V+SUOroi574Pc5RW5lso+ijy3ywkgna
	X9lfOxJpdBbZvqdWod0enAXdwk+ACWPwHnSLAbrA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv54dk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 18:04:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CHsPoQ007798;
	Tue, 12 May 2026 18:04:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgm9r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 18:04:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CI43Y216384292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 18:04:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 932AE20043;
	Tue, 12 May 2026 18:04:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84E3220040;
	Tue, 12 May 2026 18:04:01 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.124.209.236])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 12 May 2026 18:04:01 +0000 (GMT)
Date: Tue, 12 May 2026 23:33:57 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Gautam Menghani <Gautam.Menghani@ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/64s: Fix the vector number in comments for
 h_facility_unavailable
Message-ID: <20260512233145.9fea4380-a7-amachhiw@linux.ibm.com>
Mail-Followup-To: Gautam Menghani <Gautam.Menghani@ibm.com>, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260511080412.50722-1-Gautam.Menghani@ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511080412.50722-1-Gautam.Menghani@ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE4MyBTYWx0ZWRfX9/O1wjr/n+aN
 edRh3zs5zzgHvVKyvoPsPXGpE3pxYWcrw1amFBW0ncfMEx/t6P+YddHOkQ9suR01iWG7+Tgp4we
 cV76Gh51ABEFWiUE72yk47JXg580JlZpGyAqd/SllhDJBA6vUrnh7jBIH+NfzVk1PVWNYNbtk+S
 uo9O8v0OEqt7VOv//5FP04lYF/KJ3F9ysHFf5dPSKr/5HtD9TyOrbNf52+3FaH1OtEGNRBEWR0G
 MeBVEDuSK2m7tp8hnUsGeP3AwOeMbcQuTObA2gPxeK/EPE77ChBWpU/gJwiO6zTJPEdNIRWiMvI
 WGmjEhg725ZzYwcqu2LGvCKYQr9ZygllxEqzJymoRIfwtgHztMHZHVNvncD8F/RAZCqExawHUsA
 yX+oEJIS/NaQdGjIkg68+T2k24pmwwEIMracfnSEApA3ZJIkCLK8L+o2pqd2J0VN06GOvhScVJ8
 vaz74BP2he6Z+mWUkRw==
X-Proofpoint-ORIG-GUID: aa1cPjyMiHijy4Gid_KN5xIXOts7hlrR
X-Authority-Analysis: v=2.4 cv=Jc6Ma0KV c=1 sm=1 tr=0 ts=6a036b99 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=KsF5BuLE4_TF5G8aTxwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: hCwXTA0y8Vmrr6sQKE2InSVSvMglJ4hW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120183

On 2026/05/11 01:34 PM, Gautam Menghani wrote:
> From: Gautam Menghani <gautam@linux.ibm.com>
> 
> The comments explaining the h_facility_unavailable interrupt have mentioned
> the vector number as 0xf60 instead of 0xf80. Fix this typo.
> 
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
>  arch/powerpc/kernel/exceptions-64s.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

> 
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index b7229430ca94..2696fbbca3b6 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -2498,7 +2498,7 @@ EXC_COMMON_BEGIN(facility_unavailable_common)
>  
>  
>  /**
> - * Interrupt 0xf60 - Hypervisor Facility Unavailable Interrupt.
> + * Interrupt 0xf80 - Hypervisor Facility Unavailable Interrupt.
>   * This is a synchronous interrupt in response to
>   * executing an instruction without access to the facility that can only
>   * be resolved in HV mode (e.g., HFSCR).
> -- 
> 2.53.0
> 
> 

