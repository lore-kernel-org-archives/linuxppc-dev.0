Return-Path: <linuxppc-dev+bounces-25232-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C484EC55162
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 06:14:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD5x31q4Hz2yhP;
	Mon, 03 Aug 2026 16:14:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785737671;
	cv=none; b=LuQno0V4rxJj8dSumsirTbhA4IaIpdMwe1qDxCSzYUH7CvtmHG3H7JpEgozrXIcWmSNhe4NEOYYA9AKmBPSWqyT4MrnTZRQd1ZwLbFWTFdnCR7KsrC8kDKyJbiQ6h5TREnhgMgtvYONLRGHqXHHFB2NoKuFG4vk9v1GdwYVlMcgdVypJWqZc5xsSOlL82IdbMHrjfcK2ydW47rKZsExLmTjbQ7+Cr5qvjX0Ztmq5EcxypjPm3tuFOBXUONEQHj3e3fGpXZkGeNLodfHy/n0TCykZlFam6l9PTkqOoxE5AwkUmCRzp5fugHF1sktyD7jNqxe2Sh0UGF4b1rLqslCQLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785737671; c=relaxed/relaxed;
	bh=RwrlXWkMqtP45620t80upwELGxSveWepoweJxHsoIQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXHgvi2L7/5LWfaQMc8ZS/ie1z8e87QCVNSm0rXVRo1Wsy0TYRFOC7PuJlOHZ3R74cwtxsHNhMCdPC0kJ7IpajcEzwtTmYcUJfOrBU30IRuORD3Cbb/0cbK7lFoaT0NGxCqvnbo4a/NgBLe/A3ioNyTX96/xiQPVkyepd+55s+sxtPsDGP1lBMvF4uTtiwAasPXtwdl/JNYE3s3aYvdmCVn67I7EwdlBqIXR+OA6J8VrBaQD2Tw/aDPKhOCXlqNvsM7h1zKFNk8sbs7FCBQcMMyPlNOHfHZRmX9PwkXY7hFGbPcBa8btvw6ynAiKPdcf4IEVClmIym9MDPTbjzscFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=td8DbyqY; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=td8DbyqY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD5x210sqz2y7Y
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 16:14:29 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LlkIa167350
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 06:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=RwrlXWkMqtP45620t80up
	wELGxSveWepoweJxHsoIQM=; b=td8DbyqYh7c2FVqUgAqO/GcL/CyFDiKhScoC4
	uxqXyh4CQTwICp4RQOXpLtXsMCkyW6y2ELRpW+wrzMqGp+DlpaDjuDus0Nxvh/Wi
	J+kt6HH7fEgwyWrf01hSBCz7EE4YUPdvyLBBLj9a6WdVG/R4cxG9cHP+fY3Rad3u
	0Um9fBnl9F0vsELGLGDxm1Njv5u+1L18kF341x0YoONPoUMl1mQLmc/KGzZHd+84
	y3zVIZW85N0lbY1JeVC4dRe6hOfYgrqr4f6nOWeuu36BwlOiD0dOAnprrkaiTyPY
	LpjI8MOseRwxf/TpuH2RyW1XVheEp1eodFQLMiPOKUKJZqPXw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77fy19e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 06:14:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6736BELG000599
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 06:14:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtybs15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 06:14:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6736EMrK28312062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 06:14:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4F1F2004B;
	Mon,  3 Aug 2026 06:14:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB63A20043;
	Mon,  3 Aug 2026 06:14:21 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.27.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  3 Aug 2026 06:14:21 +0000 (GMT)
Date: Mon, 3 Aug 2026 11:44:19 +0530
From: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/4] powerpc: Add Power12 architected mode
Message-ID: <anAxLf1YncCCXzNM@linux.ibm.com>
Reply-To: mahesh@linux.ibm.com
References: <20260729145405.3230272-1-mahesh@linux.ibm.com>
 <20260729145405.3230272-4-mahesh@linux.ibm.com>
 <aba0e4a7-9364-40cc-a2b1-d03fbe5b51db@linux.ibm.com>
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
In-Reply-To: <aba0e4a7-9364-40cc-a2b1-d03fbe5b51db@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA0OSBTYWx0ZWRfXwz9F0g+LMXoL
 MFB90RJ34MDMRPYdN69PeiWEYFgrC7V/PEbU3GUS17/XTue5n71giNZVP2iP5RHh2H3Mjt1gbv0
 Ytlmx1TSnhQDMDdS9WBLiOQI+t6KbffryKgRO/l3FwsHtmfR2GktsBg4todnHQU12BxmBitUZpV
 /Nb3jkkiVt8xCvNiH8CeQLzx/PrSbzZkfmsudVNA98EOjn503gh+WB6aZ57eSZPbdCpZQAc0o4o
 J/Kx3ip5A08W6DMpUM07kNhFxc8EFrRAcj+eAwETaWON0ZJL2XYmRb1EXkFrkA3wgCr970yMfcl
 SvQEZ2OzHi3egVpI5qPz3G7WYq9G3bwTbWi7UVLvFtlyi4h4x43ydib/3rwyqgXQqWZ81UI46+j
 hFcwudcDB0qocqqlweZF3YPmr/k0WMEWW3MmNb8KVCFoyBvNQ6MqtlrzEeRHOEPZ0IAvgM9Nc1/
 lEldPG7unDBRQerXHhw==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a7031c3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=ISrO1AqZKzUsj_xttGgA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: DSfW9ryGWslBmUHEMFGMPS3rPXY-5BV3
X-Proofpoint-ORIG-GUID: DSfW9ryGWslBmUHEMFGMPS3rPXY-5BV3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA0OSBTYWx0ZWRfX34fIEbJP4xph
 1Im1TvZrEgJ2jb7R5ox3R8ZC3FCfjWNEYObB3iYL1tROrw/B0OB5LDWzWzH9F3HTQyV8uotmoLg
 pRlr8ujghh5AgetvVFLToyuPE+cRcQo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030049

On 2026-08-03 11:06:21 Mon, Nikhil Kumar Singh wrote:
> 
> 
> On 29/07/26 20:24, Mahesh Salgaonkar wrote:
> 
> > +#define PPC_FEATURE2_DMF		0x00008000 /* Dense Math Facility */
> 
> Hi Ritesh and Mahesh,
> 
> PPC_FEATURE2_DMF is added to the uapi header but never set anywhere in
> this series. Would it be better to drop the #define here and add it in
> the series that actually enables Dense Math Facility?

This bit is defined for future use.

Thanks,
-Mahesh.

> 
> Thanks,
> 
> ~ Nikhil
> 

-- 
Mahesh J Salgaonkar

