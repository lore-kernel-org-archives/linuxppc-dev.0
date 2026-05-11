Return-Path: <linuxppc-dev+bounces-20668-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE3FCD3427
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 02:29:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDNvd4MyZz2xlh;
	Mon, 11 May 2026 12:29:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778466541;
	cv=none; b=bUusXLNbTUAenL71rd5HKejVuVv/ElExe8i633KOma4brCOsOppT8aZpYQcaOEXhN2zyUY+tEaHHgl3+pSCAR2U1HITd+G2UNjBedEH4Nz8yfQ/18xO66valk8RqlLsrKgQoqbMNX4MlJqY3Zxd4hDreyLTu6oWVvra6qkOaOH4XfAhdsLIwILueSCWrKmfcFo15SgP7rvCJ5ezWKVjrpekWx/L9mTQx/b7H8ULB1QToofWI4+83FavCVmc1dcm/NdluZaFa4G+MWVbw74mXjglxC1fYyFiIOHUs9aMpFbq53obxQ516P2k8zEcLNKi4pqFquRsaFcChDRi5S8cAtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778466541; c=relaxed/relaxed;
	bh=iurtmcLtaZJFUSqOgT6anEv6T7eeiE2+HUT1ypbyQGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TlDYVY3PMjQE64qCEktLHDOz3lzFZZKn9SVZckRSOYnvau6LuUL1IdPk0yjnN9MTsZe/rcw4mG5ToE/ABqmE2zihtev4dtkdrDE3FFBntrCg9jfBvM63YoiS/QILILxuAeM5uU3P2SdAqcTAELQldkBB1RVVqMVxEnf3O0FXFt9zeaeykO5HFWPZgXvJfb1hGBXSmzs79K5zZ/QaflAvoE2pstdIeOuQyR/ce1RJiLoTA80sa9Y8gKi6bkQnRp4OwI/KL63SGX047su1D6ApthxQbRg3AOD7GOjT0JFuO0FtXyheRUKx2qpRMkmNK2PsxznF7vWA8DOy6iIiuH7q9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=L1PI8sMd; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=L1PI8sMd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDNvc5sktz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 12:29:00 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64AKnZO8173686;
	Mon, 11 May 2026 02:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iurtmc
	LtaZJFUSqOgT6anEv6T7eeiE2+HUT1ypbyQGA=; b=L1PI8sMdWHmQA5rpWVZrtr
	tebri4DmWfYW4/Gk1oPBbbwAN51Y4EI6l1sHCbnRmBcpnpS1HS78jhGAp8LzBfmY
	UmRKDNDM5zUvC1a8mjkrlZ7JwDfVZ4U+iHF4FQ90eF3QUmXxNBbNECg90Ui5Xft4
	p3dcHyNqBK28Py8RTjX0w1xuaRaGMxWNM9+HhlZZVouOV0EbweXpMmOr9+46MmkF
	CxmiQ8o+QfTGZlJLz+j7fAmQbm0Xp3puhFZmCesIzvJWJ6t6Zaux6/1lziTs7Ae+
	8RMTbKyRDD1QC8+ZmQThx/rjx2cC6Z9TOVqtXW1zT/vuBQx9i3wImqU5+Q6ZbNoQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1tbhp223-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 02:28:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64B2OdPC009371;
	Mon, 11 May 2026 02:28:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2g8jucug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 02:28:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64B2Sfgw48103818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 02:28:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B9D320043;
	Mon, 11 May 2026 02:28:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2140520040;
	Mon, 11 May 2026 02:28:40 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.2.213])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 02:28:39 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/8xx: Fix interrupt mask in cpm1_gpiochip_add16()
Date: Mon, 11 May 2026 07:58:39 +0530
Message-ID: <177846637463.1289230.55843667518542090.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <bb0b6d6c4543238c38d5d29a776d0674a8c0c180.1776752750.git.chleroy@kernel.org>
References: <bb0b6d6c4543238c38d5d29a776d0674a8c0c180.1776752750.git.chleroy@kernel.org>
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
X-Authority-Analysis: v=2.4 cv=ZdQt8MVA c=1 sm=1 tr=0 ts=6a013edc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=ir8JqTZ4OjIKqbsmZ2oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: kc2Oi0Q3aWQx62jRYN4he-Jl3rlWIgXl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDAyMiBTYWx0ZWRfX0v4efoOPYybC
 DpOtqo6B0ym2+P2c9pKv+gRjvgfgPWlNDz1MydqdQf97YpjHrMFvrbnX74dG9azKsWGWoB/uIXU
 Jb7d+Di68Cl6g2jPDvsG7Spwe2udIpu8la+p+852UWoYOt+pdhbBVZpflWW2uBPNB8AyJ2fnFnV
 4/ItKoKAYfYSDvQmPdSx59valuKW8col8W0T/fuRajsCbioMYeEnOK/Zn+aFb4jciY1MXT+OkKr
 1fY8fPCjh2tD1rasn8mLIIPBuxcbgtNIh5dd3RCsfaCxFrBGv1mgNyH8v8hEGSTKUVFPu56yBFO
 myc70EjP6oP16e+IfciiFjuVR4yZ7p6Ul0hp7nWWtGrO56whLPrEBD1Tguga3dY4qeYc/YMwsqu
 /P2DAqwfXwIkNVPW2EUmpUjE/1gZJ11gwYmrH0ELm+jh+HhAEywS8VgGoxZ9/ZVfQK6/LcRL2DL
 GdSg8gT0ZikOOy5Oznw==
X-Proofpoint-GUID: l8u9fwi17DSD5K2RsQVq042yypRwiZ0c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110022

On Tue, 21 Apr 2026 08:26:08 +0200, Christophe Leroy (CS GROUP) wrote:
> Allthough fsl,cpm1-gpio-irq-mask always contains a 16 bits value,
> it is a standard u32 OF property as documented in
> Documentation/devicetree/bindings/soc/fsl/cpm_qe/gpio.txt
> 
> The driver erroneously uses of_property_read_u16() leading to a
> mask which is always 0.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/8xx: Fix interrupt mask in cpm1_gpiochip_add16()
      https://git.kernel.org/powerpc/c/da107152c43915211e1fc0319b9526f4241abca2

cheers

