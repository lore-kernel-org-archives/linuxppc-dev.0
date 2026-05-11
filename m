Return-Path: <linuxppc-dev+bounces-20673-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6812FCD3427
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 02:29:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDNvx58VFz2yjq;
	Mon, 11 May 2026 12:29:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778466557;
	cv=none; b=HKZI0rRCzEVkKACLQfN3zamrYcME0UfW+m/aRXwBTwFmh7eiHJ72YsGghbsZ0G7KCdKbpEzbx10+xZDzxInMK1DaoQGfPrf9Eu5ApivOqY50YiQwNL/UkXMypd7ysE+kzpajJKi9/fBPa5fHNsPDxsR08mvpQ6yjFwaYxxB6LLHPSJtDzle+aB9tRL4lnbMW/QE+vCqcZjcClU95Yr25HAibeqj7j+SvbRpFM2TuIVUvf6vo77ESSCEeTY5GNjj3AgE7XjNfRhki36C0ofrk2Lz8Fylazg1Iz5iYw7zw8h6hw/gH/1KH52MsoZopPclMpQgjh3+XcWh2KxJA+suH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778466557; c=relaxed/relaxed;
	bh=JaNBEo9yOFNTImFACi/pzR4hXEB/XugUdAugkmty2LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJACP15mLaIcsAmxNESZ3Mh2c9aBr8Y4cGSA724xbwprZ6/gYYuht2bhr+hBKQcH0guhyR1ufbwTzjdu6OXp7J7DrLb4kO7m+q/qe2MKsJOm/L0Uf1EypZJwgT0p5GJlZbARwPOSsqvIyY2GWmTur7vnjhNTipE4oSlnwbNkXtDSxjxwebId2405+HYN9ECMY7bcONRRbBh5z3mTZhcTrVboH2+AYoZcifLMD+99N13R4rO0ZxVRoZv8XNXSm/HQ6QdBK1o26A/E82w0ZYH4uizfSw/Q9LkCI53tbzgB31DVu87+/N3QkUD7OEhtO+egN8Z2RyAN5yhg7RAGTd4CJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dkvxLR0r; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dkvxLR0r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDNvw6fBkz2y8m
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 12:29:16 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64AJU0SX3808688;
	Mon, 11 May 2026 02:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JaNBEo
	9yOFNTImFACi/pzR4hXEB/XugUdAugkmty2LY=; b=dkvxLR0rJKxVtS2PBQwaxd
	HiIzHn0Gn9wLJOBJuxf5ysZyKAV3KlGQROPxnjQJwgkwyzikXIjuvTTrKWmpoJQa
	GfC2K0+vxcUEahFQ7+BnblybjASX2j3qmsePN+7RQxxnFFzj7t2W0vV4PYHGNb9V
	6qhtBKrgpsgoxbdfCtxR0rHzEiu1Diiob7DB0uNRQEi0k8rCiFFZTWWzCUT+8qod
	C8t0d/DekITYUOomOJ0qG+qvLxcHuySJkrfKeQYDZ8vw9Kdzlf7OWz38lDATp/Ro
	T4WHme6AMLVQfSoE/z7VZVIBK3pA3Z7v5KS5Ohq9+FDi28oy0T0bsSGsx86DWqYw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vju5rs9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 02:29:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64B2OSqt009137;
	Mon, 11 May 2026 02:29:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2g8jucv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 02:29:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64B2T22g48103796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 02:29:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5759420043;
	Mon, 11 May 2026 02:29:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95E6D20040;
	Mon, 11 May 2026 02:29:00 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.2.213])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 02:29:00 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, arnd@arndb.de,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/powerpc: Drop CONFIG_FIRMWARE_EDID from defconfig files
Date: Mon, 11 May 2026 07:58:59 +0530
Message-ID: <177846637464.1289230.17065872586506800821.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260401083023.214426-1-tzimmermann@suse.de>
References: <20260401083023.214426-1-tzimmermann@suse.de>
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
X-Authority-Analysis: v=2.4 cv=cYbiaHDM c=1 sm=1 tr=0 ts=6a013ef1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=ByusM5G8_MlsREnFDVUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: tozOzUWKU78jy1ImyfakVhJPyZVYz8HO
X-Proofpoint-ORIG-GUID: ce16qY7JmMYaDHq6eaksqe5VmU0GRohM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDAyMiBTYWx0ZWRfX7hoYI9OET14B
 MrpcIy6tA3YTBlotEqZYxij5bSzF+y1OwQKKaLwKSEka/ZGTex5OzLt9xzahp3MKKDQnCyE5Q+S
 lPdCZhBs5Ufe0ra13f7DqliKY7FppgtCd7kUq4eiJNNWv7fJvdKtOvfIfMnbLVymq25RVIfQPFf
 3gjAJjFz5fzuZyvbBdxGwyDsbAYnRx5Ojk6VKl3HpbPVIetAwfdiqu22/ho6Z0/P9BPD/q68Lrc
 lGL4/z2brq+dYvkv63/Hhq5xWhEy2ridsnl/8PUjHNiZyhIRrUbgVfo67IGhJvUohfDJkGGJMyc
 vnD0uLHtonrPvXBxdyTuHuvrJBk+Rx1k5aGjqLKTwsHbdUEouOVJL+kAGzEMtYWw5/dA7AAHeTI
 xuBkOaPf8ZrjMi5KLb96iCNgZO1j8nlJb+sstqvdpM9WtZlEWxc/sDfMqgL83V73mlIw0MBL7tz
 0nn2voiixT4PAkCXoqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110022

On Wed, 01 Apr 2026 10:30:03 +0200, Thomas Zimmermann wrote:
> CONFIG_FIRMWARE_EDID=y depends on X86 or EFI_GENERIC_STUB. Neither is
> true here, so drop the lines from the defconfig files.
> 
> 

Applied to powerpc/fixes.

[1/1] arch/powerpc: Drop CONFIG_FIRMWARE_EDID from defconfig files
      https://git.kernel.org/powerpc/c/4052b932041614675fa2dbf48f725557c23ebf05

cheers

