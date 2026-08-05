Return-Path: <linuxppc-dev+bounces-25445-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E34C55174
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 14:08:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFXML518Mz2ySW;
	Thu, 06 Aug 2026 00:08:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785938926;
	cv=none; b=Z4SXqe1Ba5Akw2BTEy3/qsrODjSKOk9GzYXUqH+pt3/sol9GGslSvE4Q3+T9SJ4E4X87uKzVkVkhdMFOH9JE9dBfn/CWiiHFTCczyhuX77XL6MZT49NoRuXKNzKUJuOUnuSNnaiC77qs4tQc1FxnPS6UQYkpWT/XpZ0XTZyuPTidXZl4wYqnZobiRbRK3WQ+Am7VAjSqC+cf8XROsb2iJs9lw8u7BrEQzYUnAVeeQoQppj2hbpv0M2nn7PkIfk9oL4vGtCqg9nvrbZjYXkGREAHLMMB2dTijem55qF9gEeSXtnlBTphpu8r9qwmtYdQfP9AEdsnfDRhoGzrDTjmErw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785938926; c=relaxed/relaxed;
	bh=hTWAcS+Xg5SFfiyrnIhP0u26//9BaJmDtO+IEotyUSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYxUHsw1QzRl4uhcOSdkeEEs/WXgfRzWL33ZMHpd+OPSmnYEEjI1PZdULaxHhLXuX9HniqXv2E7XeerxAxtLapOiqObYjGvd0hIKh6u0HbRi/zl0mJz+F6SSDMPWeIjuDv5wVlBmbI+v3kVcySS+9mlyCkOIM4+cikhlxYDLfgeQxlPfoMp+/3w1wuUlL1y5xxHXwEN8+IJbhKKsQJL7d73Y7n5+4iv0Keqk8IN+PE7hEAIBi4sfZc1x02G/sjQn/0KdExcvervVtj1MfBjCChDdzit1fiOU8w53jQ4zb2gNGSIuNMJFTuGYYa/lJzJjylU43J/LsZ5DfemDtNFHOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Jm7fTTa7; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Jm7fTTa7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFXMJ6nV3z2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 00:08:43 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675CHdbl3725273
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Aug 2026 14:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=hTWAcS+Xg5SFfiyrnIhP0u26//9BaJ
	mDtO+IEotyUSg=; b=Jm7fTTa7xj8DARo7YTjFo4yVl/SUukQM+ERbIYGwEqbDmy
	cMSWpj5LUSH6ty1UhwFCUIlf0RAMmx84Xz6vK8vxF9ntDikF4ybvAxHHKFpWUYnm
	qXWvXgyrJhpe5y36kcoUSYkpv4+hIRuZ0Wpey6DKUf0KX9ZqSRiv6+28VSI09cUS
	AAd2KL4ImwnEHzkYEcdPcCT5WzWkvQUfRIevGifsmPFnurJg1EgA6n77Zzujrgyb
	P8LMYlPVwQr02sqZmnOlL2kwulKkoGzXBc2M06vgPDzrGKQ4XrBBjN9vbKlH0cLv
	uvy4hYG841GXaR+HBS0nbNNbhP5H5DF2aGVxWLcg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hu5wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 14:08:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675DuJvH014218
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Aug 2026 14:08:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtypmgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 14:08:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675E8Zi349283416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 14:08:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0B122004E;
	Wed,  5 Aug 2026 14:08:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB16120040;
	Wed,  5 Aug 2026 14:08:34 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  5 Aug 2026 14:08:34 +0000 (GMT)
Date: Wed, 5 Aug 2026 19:39:21 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Praveen K Pandey <praveen@linux.ibm.com>
Subject: Re: [PATCH v3 1/4] powerpc/pseries: Limit PVR list to 16 entries for
 CAS negotiation
Message-ID: <20260805193834.b80d421d-21-amachhiw@linux.ibm.com>
Mail-Followup-To: Mahesh Salgaonkar <mahesh@linux.ibm.com>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Praveen K Pandey <praveen@linux.ibm.com>
References: <20260805110924.3853410-1-mahesh@linux.ibm.com>
 <20260805110924.3853410-2-mahesh@linux.ibm.com>
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
In-Reply-To: <20260805110924.3853410-2-mahesh@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDExMSBTYWx0ZWRfX5xrW44weivTp
 HRi5fCQDWwHE3ouL66Y+EDw6anEK7GXuAcqOGly5NZQfXRO5pwkTcTb+YU6hxkYwORVPBiwo8eC
 ezhELw//UjWBY/oOrtw8SJ2H2yJpgG0=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a7343e8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=waFTADb7J0t9_3MocwUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDExMSBTYWx0ZWRfX6UEBhg7rSvEi
 YGtAVYL7LW4teyERidJUb0knGqMqsvC+pjWXobalnUP95WIwKSy7DL53O4NWWtCE0M3vIZ4a79l
 FSNDdvvAmTr9RjTL/lvIWUjOYgz9J5bPQCqPjGEWEX8ca7WV9vQqbyIRUnqcs652HX3q1BAgdJT
 aQzPv4qMktPu11utQfj2DV7WJ6WNyuAJIgykywLvZt3tOVfuUNF8pyocG+JCiKIiEhLxmwGKRug
 INXgrnYaDSR/xiK3jRT4r6+3aunwrx0dDrnuDIARAfE1WtEg1BvVIWGPlPTeN4klO3CW1qLi5Wl
 cOPFydwDfL6a60eBOADdrtTHo2QBh/jysum8p8GJaWKP1wPB7hMm4/ssl4A5hKHjXRLwTekA/H5
 aNSlsnouLMfJ8IRg2REKF6qIQyaiBVaU6fwrymNPN+PxDFFwZ/zbS/FJMNTIEVpTTDfk8G4qDQY
 24w5+tM8j6EW/JNxSpA==
X-Proofpoint-ORIG-GUID: 40kGVjkrw4eFiBFhaASE3-HkHdbkeOim
X-Proofpoint-GUID: 40kGVjkrw4eFiBFhaASE3-HkHdbkeOim
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050111

On 2026/08/05 04:39 PM, Mahesh Salgaonkar wrote:
> Current Power system firmware caps the PVR list array size at 16 entries
> during CAS (Client Architecture Support) negotiation. Passing more than
> capped size to older firmware could cause an undefined behaviour and
> breaks compatibility.
> 
> Future Power system firmware releases will lift this restriction and
> support greater than 16 array entries.
> 
> Ensure that when running on Power11 or below hardware, the number
> of PVR entries passed during CAS negotiation does not exceed the
> firmware-imposed limit of 16.
> 
> In prom_send_capabilities(), compute start_index to skip the oldest
> leading pvrs[] entries when running on Power11 or below hardware, so
> that the pointer passed to ibm,client-architecture-support points to
> ibm_architecture_vec.pvrs[start_index], presenting exactly 16 entries to
> firmware.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Tested-by: Praveen K Pandey <praveen@linux.ibm.com>
> ---
> Change in v3:
> - Remove unintentional whitespace change.
> 
> Change in v2:
> - Define a named macro CAS_MAX_PVR_ENTRIES
> ---
>  arch/powerpc/kernel/prom_init.c | 34 +++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

~Amit

