Return-Path: <linuxppc-dev+bounces-18121-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24F41067040
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 15:03:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWrTQ6kYlz3cFN;
	Fri, 13 Mar 2026 02:03:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773327786;
	cv=none; b=nbDDOKZBtx2MOZtM9dy5pgQKhkXif3NBw90z1+vnabvM1GrkEDW1OIxkjJy8aUTkVUvKVXINehl2Fz0Nwp8qQZ4fmu+Bg3oPwqsn0MyeFk8u+ak0l+r82fucbYXSsdb5Y+isfaFzKxlBx/9Vb8EyVrVt/18QyV1XG7taOWBHv6qWY7JLtZog6lzYwcndi21ml4oVvOr8q6kGoNNdvhTCTYW6VyUNPePHryZLqDcUuoK1Zu5LeX4fP87dAY9D4XgjI8HScHz4ma+eu5Ork+WFDp4EDRF98emyUszUr6agZBJJiKaJE3FKUA3ijOD5pVvmTHJ4fQoQ1wmfn+xa1R6U2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773327786; c=relaxed/relaxed;
	bh=9yQLPhF/8tvYIDT5F8gEZIM1Lj5cCvoGcEOmMxBZOxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUoiqqnvhXo5/lwzTWT334evz8UGTCKtpDH1GyGtAT/0OjCaXKWlnB9o3lMW4cvunUgnHUeC0XzqnahVojMp/XbT3wOzUkaBsA25AhLeUteMeSz65J0wkak0oczl3Q4GBBG+Tv3mILrN2e9M04vVHz8jMYQUWl79SljVZK8ETUgYwRtPebmmD47CUlwvcbQhaKzlb8wADr+X/FT51i/4336a+zvKfyp9WpmJ2RXXEtgCp//3E84QHK2KnKk8g4s0+Kyhb+/7//XDwgPy7GrfjIFUv2Cdq1tvMkdPoRoAFWE9cs3JavDqY94NAdMoKDfXeA20UwOq5XxGlZlAN8UEKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MC0pt+Pe; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gor@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MC0pt+Pe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gor@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWrTP54g0z3cCJ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 02:03:05 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62CEYoAI2256683;
	Thu, 12 Mar 2026 15:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=9yQLPhF/8tvYIDT5F8gEZIM1Lj5cCv
	oGcEOmMxBZOxo=; b=MC0pt+PeqJ/Fx0rQPpGYhy4twD3b2Kc3SyGf6uydq7veOf
	8wSyVumxfYcS/RzLsLeDh8kl9tD8R4upozst/SCAgDPTqUvZAmWAxmio9y7OUnuT
	z+9VkyVr2PtgAtjQ0Lx8hCSh12XXatgaPxqxwMvKJXGxkJkYajZHeGG8FFjLWuwt
	A8sSjHM0AL5l7/rGDzvXX3n/TnC1GNUMHMp8KZgOej48GZLIJZLI1hfjuva/1XP4
	1J3vzIqfnclM5Nt7mo5XR2o0alAXT63fVux788NDDz7JkbrDWVUnoTDzw6dMHvhx
	oQjkY8po5xcP4wjIRBxqWDT9CJV+bVyXkR6qLRFw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh92b9bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 15:02:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62CEN16g025674;
	Thu, 12 Mar 2026 15:02:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha8as0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 15:02:47 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62CF2hgt59965898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 15:02:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 613C32004E;
	Thu, 12 Mar 2026 15:02:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80C7120043;
	Thu, 12 Mar 2026 15:02:42 +0000 (GMT)
Received: from localhost (unknown [9.111.83.60])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Mar 2026 15:02:42 +0000 (GMT)
Date: Thu, 12 Mar 2026 16:02:40 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 1/4] mm/page_table_check: Pass mm_struct to
 pxx_user_accessible_page()
Message-ID: <ttbskgg@ub.hpns>
References: <cover.1772812343.git.agordeev@linux.ibm.com>
 <ca77f3489453c2fe01b25e50e53b778929e0dfc5.1772812343.git.agordeev@linux.ibm.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca77f3489453c2fe01b25e50e53b778929e0dfc5.1772812343.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1KsyIx1BDwTPWaT_bYuVWvLadqDOw4WH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDEyMSBTYWx0ZWRfX9FVH7vrUmovR
 J4ljyZrodPGRPdSk7n1B/Cu0G49IAvTOnb9rnFhx7k/ZMkrjauFEAfl9mgAdqYFQ5AIeON+I65L
 aBHB+xoH0lQifsBvM+fDapqU7iShTN1mwz6wfd4HDoQHyRNUuL3SE4S+xE7l9cxyu/+VssBqPe8
 FtomLZUnwBdwc6mhzgyI+QBRIj0VvjIIMzoW/dhIAaRL2RNh8URukhOHG2aIpg3TrvdODgERw94
 bu/MNsCRkWPsIKbo7rlefYFNmgpmKQz9p4ndZ+DRs20cVYl1l6HF2M4uoujYP0HyT7PBzGeqfT+
 8NU/fKpq9pAf5Ac3EfQsegHyszKU98eJp54aJoGeN2WHCSsZHn/zujIQWl+iQTzwRz4TdtyIETZ
 5GC2PliLsfoRSNNNxjHHjgzxZZUP16hgpTMMKnK5UhAY3UAhROBg9q4VyPk1g6GDwAdF7Qhb7JE
 ektOqp8PyzdLfyWK8Og==
X-Proofpoint-GUID: 1KsyIx1BDwTPWaT_bYuVWvLadqDOw4WH
X-Authority-Analysis: v=2.4 cv=XNk9iAhE c=1 sm=1 tr=0 ts=69b2d598 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=Z4Rwk6OoAAAA:8 a=qw9MI_8u0g6XvTY13mQA:9 a=QEXdDO2ut3YA:10
 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120121

On Fri, Mar 06, 2026 at 05:16:30PM +0100, Alexander Gordeev wrote:
> From: Tobias Huschle <huschle@linux.ibm.com>
> 
> Unlike other architectures, s390 does not have means to
> distinguish kernel vs user page table entries - neither
> an entry itself, nor the address could be used for that.
> It is only the mm_struct that indicates whether an entry
> in question is mapped to a user space. So pass mm_struct
> to pxx_user_accessible_page() callbacks.
> 
> [agordeev@linux.ibm.com: rephrased commit message, removed braces]
> 
> Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Tobias Huschle <huschle@linux.ibm.com>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/arm64/include/asm/pgtable.h             |  6 +++---
>  arch/powerpc/include/asm/book3s/32/pgtable.h |  2 +-
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 10 +++++-----
>  arch/powerpc/include/asm/nohash/pgtable.h    |  2 +-
>  arch/powerpc/include/asm/pgtable.h           |  4 ++--
>  arch/riscv/include/asm/pgtable.h             |  6 +++---
>  arch/x86/include/asm/pgtable.h               |  6 +++---
>  mm/page_table_check.c                        | 15 ++++++---------
>  8 files changed, 24 insertions(+), 27 deletions(-)

Andrew, may I get your Reviewed-by or Ack-by for v2 so I can take it
via the s390 tree as well?

Thank you.

