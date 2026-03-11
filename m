Return-Path: <linuxppc-dev+bounces-17990-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C55FD88D6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 02:14:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVvSb4myTz3bTf;
	Wed, 11 Mar 2026 13:14:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773195247;
	cv=none; b=E9ScSEdOcgnhq2Dk662+pYNoaPSJoz54nWPWFodSE9TUjGTP6viilPOwxpbmjjdhbGyLlTjnz+s5Of0uD7uXO9NUTs6PWR0Bc8cPbTwstujPQ0Um7clPayiXXgHsjMC8cH4wTYMr2++IDF4ubKZ91mTtx1o+dYjglXFocucOImmkRtRux2mQZGStkhnB1WSmocq9LqZwg9gUOXvg0DEbADMQkKKhsmBkWxV/sB6+kQUTQpte0qe+LGrTl6SYFtuf3AWo/O72765Mc2kv8V+lPPaNE9eYOGc+G1V1ABqClmr/YRuzB5nNmsXaWZEQUQmGWZStv1DpMz2r/j3nUOCxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773195247; c=relaxed/relaxed;
	bh=1z4FlpSFmGRw8a1yohjCuBcwOv/JuRGUmWtBDLGRtUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4MlD7rqPh8uPrHzRewX8BX9W0UiIh6eMlfNnstjXCFAox72jOrZ48aI9fSLY/sM9Cc9cJNGLnf4lt5PVt4LH9IjGztRuelRFa8a/X3DlkHKUbpr4TRICq5FLxm0F6z9zr/QkzTAPWiMC6t/4jG7L11wdOiD4tDNv/WCBEHDzJlrLkZDIV8HnZbNoPwqTLXZa7EHDI+Bg0dy/j4QMbuGF1t4odFiZxrO9edM/fJbA8eJq9NWb/UsvUBlPrNIFdum4qW2MWEdEjRkY6E5UOgVOGAEIUogyZNb2B2QOuNb4qHq29x3n1itaKN5lcqkEEUycvBzDB8dsDpCl3Xaviyevw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NCf/r3EV; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NCf/r3EV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVvSZ3dz9z30hq
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 13:14:06 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ALe7jE1435969;
	Wed, 11 Mar 2026 02:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1z4Flp
	SFmGRw8a1yohjCuBcwOv/JuRGUmWtBDLGRtUU=; b=NCf/r3EV2wnhjiPmLQ0IWi
	a3onsVG59Ri89ANIfib3JYYDQiKem/atwZ2MA4pcaJJkE6GqZ3vzIJz+9lejr5WJ
	x8ocA/mdobmzDjK99cvvEiD9ydDaFKhGcNjls692Ybz69HpUmFDQTJXx9918yr1h
	iwXYimGquyft32fs6+I1xKK/IcrBB43mzeo6g5Q8JBZagvjSj1k0qNusHz8VHjlx
	4jE0VSAab9QZP8WEa9cTeebggHKHSeI0JzVhskJ0iYSMuYtifcZnhkp0abl7Mw82
	afg3P5+OGMx6V4WWBn6mYcMMdfrBVuW5XQk2SPY+HO92b6eWmMg8Izio4n4z40RQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcywdsdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:13:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62B0u9Ej029356;
	Wed, 11 Mar 2026 02:13:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4csp6ur8wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:13:53 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62B2DpeX56361298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 02:13:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2ADBE20067;
	Wed, 11 Mar 2026 02:13:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6AE720065;
	Wed, 11 Mar 2026 02:13:49 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.124.195])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 02:13:49 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/e500: Always use 64 bits PTE
Date: Wed, 11 Mar 2026 07:43:48 +0530
Message-ID: <177319508332.269267.5271872485641108612.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <04a658209ea78dcc0f3dbde6b2c29cf1939adfe9.1767721208.git.chleroy@kernel.org>
References: <04a658209ea78dcc0f3dbde6b2c29cf1939adfe9.1767721208.git.chleroy@kernel.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAxNiBTYWx0ZWRfXwrk7j8nIzES9
 CQNJqel0rnrbqrWth/5k5gkdQX8LLFeox2ty/RPsGdu8VJldMJJNCRdEN6IEMfV/+wnn738B5KP
 vN/VSs9ET87pyslZTgxpRk6Swe73dm6B0CsfJBEWcVhwainxeZnj4PW7Rb3eoPkSUwBjxYYTqMs
 N8Brt2yF3EwKsCVYmdTAmq45ATKCZiVPtDlFGuXYEHD6xePm/vBSYI2qQSfPZL357chkRPL/QYY
 nqQ3qeHf3Q3t6q/Vp1II290668e+YfstQDp2NIjAyyeY6EU+ij+rDRuznCUuYNBhsIuBCNaaS8w
 SfKJD5bqKlAjFGC65h/WUCNdkYNyD104ipVZiLkYmF51VYicjl5s8Rxa+o66b+D0NiKYjNEAGZJ
 N+mEDmseWdnflmfBxp6HMfF8iYhCMLhBL8wWfjRkJeO296ou84g3i1kBRovP7VzHCUAY7wk+KTh
 ZXf3HYRGxLnV6uhGC7g==
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=69b0cfe2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=luVY8FhFYmc6H-mNkRoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: L58WvVhrlRcdxMzesqaxztwoFZmDLtgt
X-Proofpoint-ORIG-GUID: Ppd-ppsUREW05az4joj-cpBIs25aPFsD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110016

On Tue, 06 Jan 2026 18:40:19 +0100, Christophe Leroy (CS GROUP) wrote:
> Today there are two PTE formats for e500:
> - The 64 bits format, used
>  - On 64 bits kernel
>  - On 32 bits kernel with 64 bits physical addresses
>  - On 32 bits kernel with support of huge pages
> - The 32 bits format, used in other cases
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/e500: Always use 64 bits PTE
      https://git.kernel.org/powerpc/c/b9e7e3ea605f23d342c67fc5bded99bcaa32d93b

cheers

