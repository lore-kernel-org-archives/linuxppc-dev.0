Return-Path: <linuxppc-dev+bounces-25235-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151E2C55162
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 06:57:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD6tr4xjpz2yhP;
	Mon, 03 Aug 2026 16:57:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785740260;
	cv=none; b=WmxcH9lHmi7FctF/qqUy75Tk9ykpdHLLDoJ8MnPUQnj22qtt4stlKwbEbAMxd6Wxo6mqPmUiIc+p5d3uVVjAgKlgFGBlm+DuYOD2Ij6cnYlWxWfKbuYfLP21lkRFNie7+pEoBrb7jQJGhYUJnN/siZlal+pBsOUSOoo7j0/I4D87o8/+msGXb/L3SsjLPP2hPT5Nv6SmXOvWYX/IKsUuSrC+x1KxIMl4pFd+gqODQXYkRJPyTnkZfj7nHAtj+KixCdPrfDH9jnhSSIGZL1BVH2dazQeiU/t4QVIUMjW+K99gpcDChTZYaRoYUW68ZoddgyCsCZcmKe5gRnJNkfFpfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785740260; c=relaxed/relaxed;
	bh=+IibAi4Rv5SW2NxVhMLxuxTkAsmC74CZWph/nibbPAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q3pnnC+grGtILeBosXoCmOYWPrWkPHCAGUVnMi4JVawGjm6OEIp/TjWiHB3YmQ+mBIZyCZ4zM6sWRcA3gskYEaX9mT/OSDUx3dhnddq/Y3WRmzaFftDZYapnbFsaEBc1PgDMdBGVhCTNYDxUHGe1QwcL9e1l3OybvZF/UTLKTquC7vYYJf1HHZ4KGgRUwkKPp/GPd2fqk/rc6UQAXW7TK+C9VLrJkemnoEUIIiVi2Ynx+PU33Jv69MmEqSnsM4y3DgLcxeRRdb1DnG8rr6rOU/x8T55xgtLqNtAxTCW7ruxadr+LogQsmBRl0Fu2kverzVUegiDTQd8iW1DUPDDemw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NqGqOnMB; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NqGqOnMB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD6tq5FMxz2yfD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 16:57:39 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672MsmWd372701;
	Mon, 3 Aug 2026 06:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+IibAi
	4Rv5SW2NxVhMLxuxTkAsmC74CZWph/nibbPAs=; b=NqGqOnMBmafcOuXLLtzyh6
	vqf6ytTSrXfseSH4UrtfhT2s3K+/q90d0tAcois61OvjcrvN4DD/B8kMOnQArIC4
	QIVz8Ib28wyc2yU0nAjNd5Ve9kILC248mrtpk7QOeUxmJG9wkgKx98nhpWfMRTFe
	sLSJVS0YlxSPSIyKxxF7bNoKxeCs5it6NcK1i5Kp8n4U1482gPgjs36h9mWEGEoq
	C+TOEEER61OLtzxu0UPFhcF7O/Pj5aCfonDinwxzs0c7FBlABKt0bxDpu28Ks8XX
	yaEOMLoMeVQdtFWpAPRyRieHiVQQQkRmKLgsEY8WrO2TbbHV/65TucxbDcbLs5AQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4q96c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:57:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6736fKlP002558;
	Mon, 3 Aug 2026 06:57:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4jv4wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:57:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6736vPfW28901886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 06:57:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C4242004B;
	Mon,  3 Aug 2026 06:57:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C006520049;
	Mon,  3 Aug 2026 06:57:23 +0000 (GMT)
Received: from Linuxdev.j9d-in.ibm.com (unknown [9.123.86.85])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 06:57:23 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Rosen Penev <rosenp@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Linus Walleij <linusw@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] powerpc/44x: Set GPIO chip parent
Date: Mon,  3 Aug 2026 12:27:22 +0530
Message-ID: <178574013467.29744.713828042285217121.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260517063754.21819-1-rosenp@gmail.com>
References: <20260517063754.21819-1-rosenp@gmail.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfXzs5/2ducEUjw
 RpgjOXaFRpYQMeR5L3itZBmBvKSY9RPP/aIGtp09n+1rfP/td0T9MVc7Llu/IUb4Q6Botopv2KS
 zR/PfgMSMaPS7ys4scw3A8jDTxK3oiA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfX34b+402AxGGC
 eCIDNV7OYQiuJ7PgLKMjV6Pe3IwFOWbryTmJqTldu7Yrl5IGn88/NbcjH92edu1i15k+IDvzL9A
 NnmV4z7u+dBI6puqpWH+Y7EkuGjZudwlEwzXgti1TRHutavHlXzlWWlkrlRMnppcdEkFocSG4MT
 n4rLzrveJivGO07u+Xn5acKCjJfaKlLU4G7E0YP37aM/YyAQTqMxZ/tDQkShzmW8R3cZXaFHDdT
 rR29jQqbRqRU44iOjM3+f9s0Y8GML/WJr+4BSo6gtzkxe664KJePGYG2aa0pQcXC1VuuLAZu0+B
 RyIEnFYnVOrqxMCaB0d3tqzJJGSenrOWTm3f4SS+6UTeDBVOnvwEycHeoHIB1vwUUWj6Ra9PbzK
 WcED/MfRLKpPu7dAoInpVeLeTNe4kFgl2GPsLJEZtEAfuiyLwyyiWONBmDYPSyC9TjYM595Xxza
 gb79p67vyvfmUOmt4LA==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a703bd9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=3R4AFHvaBG5agptWhI4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: WP4tkYApWUuMRJMj5Gdjr8BJpJkJ9POC
X-Proofpoint-GUID: 409AIne-lEzkuJCUdquV5kAQ9oNV6QXm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030058

On Sat, 16 May 2026 23:37:54 -0700, Rosen Penev wrote:
> The PPC4xx GPIO driver stopped assigning an explicit parent
> to the gpio_chip when it moved away from of_mm_gpiochip_add_data().
> 
> Restore that association from the platform device so OF GPIO lookup
> can match phandles to the registered gpiochip.
> 
> Tested on: Cisco MX60W. No more probe deferral.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/44x: Set GPIO chip parent
      https://git.kernel.org/powerpc/c/b9254d222d0b38cc6f7b73119fad6316f65278be

cheers

