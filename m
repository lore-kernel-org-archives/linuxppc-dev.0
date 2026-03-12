Return-Path: <linuxppc-dev+bounces-18158-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AF1106ACEE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 22:46:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fX2mP2F67z3cHH;
	Fri, 13 Mar 2026 09:46:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773355605;
	cv=none; b=bl8TS8bafWwRDHNWWQEPRtbBa+nSlx6GiPcHDHBJMTKE5byf769kUw9xpfSQbjah1nlyYl93f6KP0WWDUS2fsIpiMx4ZG/Q0WYzs7KSWYiw2jyZigKS5duVzRttPVR4kjf+nPWAT0UVkQPx30xPLZYmq2zp1+8KtMaIzTjDbS+H9dy53Vska3vNaseLAvXuOHtKsplN06seCfrHwCmkm7bwyN6+9EVI482ZB8fmxGQxGy7JBqdSUMvyJcYwutpKD0u1zy891l0zlC0cXEhFdSEbiejWxyAn4ScIeRGSCwXfwU94mAPE8gmIw+W0l3OhLu/HALomCWi+y0XaJzuRi+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773355605; c=relaxed/relaxed;
	bh=D8zOmmY8eeeaXFLebTpNVG/LsQlaEOKJAHWnrIeNJVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvYlLOlmYzLUrqHefAsIiQn2WEP3XhH3Qbk1SDKlPpmQ3Cpem1zSuPOuXTSbUO8ctdPgK+eZ8Hw0yAUY+Kc4lyDtDDCSCFkxEa8ByTRQoauwQkoLKVo6Umf8JS+SwuKfVTODKKGdA6gsmGDzMy07YhZVmEan4zh98EyWPkXouAGLgFwBvKgEk/8IYEhl6RH1Q/HnnWTbNX9ku977Jk3qPYkhVfA4I+QWeIhyUPavHknClxQgeyQ1RHtxvE4W/90NiFLcjLhxQjSVunmwmhBg1TAUVRfn3sqjbTuxs0JRY5qElSSaWSiD971sII0bgvAllWY1KpMZqdrrL9KgTqy+LQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=d5n+sU79; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gor@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=d5n+sU79;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gor@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fX2mN4DwCz3cGM
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 09:46:44 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62CDgn1g2259751;
	Thu, 12 Mar 2026 22:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=D8zOmmY8eeeaXFLebTpNVG/LsQlaEO
	KJAHWnrIeNJVA=; b=d5n+sU79eoOn9F5TNsG+WjiggtWrEcbsRVXkeBYiV5vWYm
	ivMwqxRtuuKxHBJLTmN0R/EqcQKgePNMaxtoFO/195J0uARNgOoPFezHGAkG79Gb
	tnIL4WjD+hjdGThr2+ba0V1/7vl0opoBJ8EpxzsOcustk/WNZ9IiGR5jekM04X2M
	X3SY1v3FwdqCrjDcUcaePqQc6Uy9a6NrXfEvRVJp3bjvg5L4B6paFgbVwJSrz05M
	wFsopL+3T8BfZuZN/7q/6aPP6SOL9qSDoFDPzWQDVaNcRJ/y/UFkdI4+tt9KHvUd
	Fw9mNp3mxrlnWGv8acyW3h8aS65PyJpXirrQulfA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh92d53m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 22:46:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62CITFZx025686;
	Thu, 12 Mar 2026 22:46:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha8capw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 22:46:28 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62CMkPHL16449894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Mar 2026 22:46:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B0192004F;
	Thu, 12 Mar 2026 22:46:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 279A32004E;
	Thu, 12 Mar 2026 22:46:24 +0000 (GMT)
Received: from localhost (unknown [9.111.83.60])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Mar 2026 22:46:24 +0000 (GMT)
Date: Thu, 12 Mar 2026 23:46:22 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: mm/pgtable: Support for page table check on s390
Message-ID: <ttbt5xa@ub.hpns>
References: <cover.1772812343.git.agordeev@linux.ibm.com>
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
In-Reply-To: <cover.1772812343.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XSb0EpCLqP-VvERd6yxhMyLpIuUmwWro
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDE4MSBTYWx0ZWRfX1dmLEh8veiIG
 JPH+TX+SKowHwqfzMq52we/QWAIDL+ZWYZX2jNbNGdZowW55EvpX8g/DRRACVzpVxsDhn+zENCd
 kt+vKYAw/S0oFGmt301uYKsD8hvRqZ8fzz7zhkSDwM+JaLyyhRiAgeGOnJ3hPl8tMmJ3cimrUTc
 QxD42P4vOhD0rEmJgmsyoBM6UnZ2cuDggfUF1CvtrrM+0LTZMLXqib5gODqi8G5g5/v7TOrtO19
 BcefUJ3xyGScJjhjkOzB/bUvD0msMt3gV9bVz0N7NvXQvpjkMyIFQG1IzgLmoPzrwhMTNoxMVFn
 Y0+8Amm8ExMPHkvoKIs8uraV6X8nzMyL0sT+rQUB8TJBgiVffvSrLfCwlAF1YfotN+3Js3OLFLS
 gs6mYwnnXZwsfG731r2xvnOUuIsc631T935DNRics0rmn4wCRiCXWx3KSKEofuyW7vZfthOAG16
 0tM/zg+0I6iru1bvr5w==
X-Proofpoint-GUID: XSb0EpCLqP-VvERd6yxhMyLpIuUmwWro
X-Authority-Analysis: v=2.4 cv=XNk9iAhE c=1 sm=1 tr=0 ts=69b34245 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=euGEXw6tGDjZIu8w7pwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_03,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120181

On Fri, Mar 06, 2026 at 05:16:29PM +0100, Alexander Gordeev wrote:
> Hi All,
> 
> In v7.0-rc1 page table check support for PPC was added, which
> conflicted with this series v1. Thus the only change in v2 is
> PPC headers update, which still is NOP for non-s390.
> 
> I only did compile test for PPC.
> 
> Thanks!
> 
> Alexander Gordeev (2):
>   s390/pgtable: Use set_pmd_bit() to invalidate PMD entry
>   s390: Enable page table check for debug_defconfig
> 
> Tobias Huschle (2):
>   mm/page_table_check: Pass mm_struct to pxx_user_accessible_page()
>   s390/pgtable: Add s390 support for page table check
> 
>  arch/arm64/include/asm/pgtable.h             |  6 +-
>  arch/powerpc/include/asm/book3s/32/pgtable.h |  2 +-
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 10 ++--
>  arch/powerpc/include/asm/nohash/pgtable.h    |  2 +-
>  arch/powerpc/include/asm/pgtable.h           |  4 +-
>  arch/riscv/include/asm/pgtable.h             |  6 +-
>  arch/s390/Kconfig                            |  1 +
>  arch/s390/configs/debug_defconfig            |  2 +
>  arch/s390/include/asm/pgtable.h              | 60 +++++++++++++++++---
>  arch/x86/include/asm/pgtable.h               |  6 +-
>  mm/page_table_check.c                        | 15 ++---
>  11 files changed, 80 insertions(+), 34 deletions(-)

Applied to the s390 tree, thank you!

