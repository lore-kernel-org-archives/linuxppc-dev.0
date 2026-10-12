Return-Path: <linuxppc-dev+bounces-29206-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB895CA9EBB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 03:31:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j330m6sQLz2yDc;
	Mon, 12 Oct 2026 14:31:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791775896;
	cv=none; b=bpJx2iq+nfIgf/wOcUhZHIrYxfyStsRgPqO2eC7hQoBaWe04r7bPKjNLvbXKXkcMqErulAeVaY8jyi6TjMoElhJCQYOJf5OMXc+LASKWt1mi6Y+S8JbKc5JSAnxTtAsYTyofnbSkBX3RXi750TLxTpw7KYYhuTv4fdbqOtwoeSwSbak55Ltf2YG8fXWM3EdLw2zg7k37RSg6Hk8YzbQnYj1peAK5CPaYSWD8ogrK2yRr7skqbDNsgy4p7shcG8EQRZBh/e9kBNcnbaQD03fpa66ftJnKabBNyDmzeXiyD7A/0f+KCxBnMNEJ5H6By957/iei8JUN7ja6/4Cz0H6I1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791775896; c=relaxed/relaxed;
	bh=VqZgLT/p0HvP2whlNv0dK2wQEJYb90iYnCq/iDafbcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JtkadVJ/tmGjabL8Gi/2e3sowGeR8rFPB8jMquOm6RYVajhNvvwxNK3lAhEao9AWb/NEahSKMPKzmaZG5SUpweyoLIBmnG8B1Z8tnx+yE2ZAbyPmFL01N/i+jUItkWqvOAYskIMm4nquPdJyEvjT/dp9Lp5hK8wlCSTc4Ba1JGdI/MY2i9iqpyWk4ZCFneqleY2jGW5NTjpS3yRfl+2giIlWpGxZr8GrWYlFL10dp1hmxesB5nCU2tU51aRjNdd5IH1efGDhWvH7EKn6tSHRlblfBSeX7kpoOIkhx4lF4bkMxOFuW//eIyDKevEPE+9FbF+XY8Z4CTTulqijz0y1TQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Nq8qzAvm; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Nq8qzAvm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j330l1yzjz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 14:31:34 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C2FBeX2914388;
	Mon, 12 Oct 2026 03:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VqZgLT
	/p0HvP2whlNv0dK2wQEJYb90iYnCq/iDafbcQ=; b=Nq8qzAvmxNE7ygP0kok9jH
	Nli1z5ti7PmdoVtMYdyQ803fu63ao+DjoWVrM2nv/oS2fsU8fBiM5eze4eA01H1I
	B07MeEaHYKhU2dPWf1vuO2B1pysKcC6Ri1KqR9+rJkA0UV7DBeLv4xoXErD+Ca5E
	IkLkxtKIfBzTKeit/HXdAlBCc11fXtzfAdxf0ToIBxind0GrTJOFsFKehr98xdL/
	HaiNBWOjf04KjqxkPtNtFZ4lK2faWtQ7oWiV5Yk7KJAv1A7G1Ii/SMJHivuAXYt4
	k/SCPt8rdno/pnvUkBSwb0GkTBy3jAMOkA5PsYr10ajyUfZGWbWorvJ7R8ZJq6eg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhpqhe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 03:31:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C1o18Z550890;
	Mon, 12 Oct 2026 03:31:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h7yppkpkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 03:31:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C3VRrN41877926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 03:31:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED1D62004B;
	Mon, 12 Oct 2026 03:31:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E031220040;
	Mon, 12 Oct 2026 03:31:24 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.8.83])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 03:31:24 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Gaurav Batra <gbatra@linux.ibm.com>
Cc: sbhat@linux.ibm.com, ritesh.list@gmail.com, harshpb@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, donettom@linux.ibm.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v5] powerpc/pseries/iommu: Add TCEs for 16GB pages when RAM is pre-mapped
Date: Mon, 12 Oct 2026 09:01:23 +0530
Message-ID: <179177344616.763259.7668514275381836849.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806205027.86428-1-gbatra@linux.ibm.com>
References: <20260806205027.86428-1-gbatra@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxMiBTYWx0ZWRfX/yqNh2KnRfB3
 UQITprzL9cQjtlrFgdlhvHtmnCfY+slpU5fhpJtCgE8KTz3C+5rurBBtycwx09MMzopDrB08b3P
 zs3VsBKFkW4B16SWWxuzp4Oodkt2mDHmo0xLWwez6Be2g6RhY2TpX8Wa2gB+IH4GopvpA0cvcXi
 LtYGnuWsAuCwVeDu4OIAmPo39s/E2hPUlWavYqzzhOPA1VKr1Y9vAF/Cr1x4unQVukXvZvH6+Lb
 OuOEo25Dg1XRDCOHoc31dG0FICXvdAEPvzzFQbyLtCV7FlKc6S5ycOYrrFaPjDXHoO7WYr/lHP2
 5jj/RFPoE42WLYapUe48NR4TthRx8eqh1+EHlNl22twI88yKbccAw/ERET4mqz+oMSITu6ToznL
 hmAN6aD2aqkCdytt0I8vEevUYuDr5bzkYcDyntXFxjqSa4FtnjODF5ZOaUKQUBpkQ/S8703e3bg
 QJl1H6/yiU8YpnFKBFQ==
X-Proofpoint-GUID: xiEe8FS_HU9aHpc8zEUy9EzFC7FuhwJP
X-Proofpoint-ORIG-GUID: NsDL-Sa-V4fsSBUe9dSIK3MKTKC6BBqP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxMiBTYWx0ZWRfXwIxN6vc/87Kf
 grtSXEyzrPrxqhRbOBpZbFZoaS/G8S61Mp2J8XCTJalRpmlWN6gfGpqhk/ObYNgUtpnCCzLedRU
 g2dsY+kDMLMKhMCe1uhqYmHXf66Mmys=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6acc5493 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=6idpN5dNp59oT6l_L2AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120012

On Thu, 06 Aug 2026 15:50:27 -0500, Gaurav Batra wrote:
> In powerPC, if Dynamic DMA Window is big enough, RAM is pre-mapped. To
> determine the size of RAM, a PAPR+ property "ibm,lrdr-capacity" is used.
> This OF property dictates what is the max size of RAM an LPAR can have,
> including DR added memory.
> 
> In PowerPC, 16GB pages can be allocated at machine level and then
> assigned to LPARs. These 16GB pages are added to LPAR memory at the time
> of boot. The address range for these 16GB pages is above MAX RAM an LPAR
> can have (ibm,lrdr-capacity). In the current implementation, these 16GB
> pages are being excluded from pre-mapped TCEs. A driver can have DMA
> buffers allocated from 16GB pages. This results in platform to raise an
> EEH when DMA is attempted on buffers in 16GB memory range.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/pseries/iommu: Add TCEs for 16GB pages when RAM is pre-mapped
      https://git.kernel.org/powerpc/c/0b8b0c17a8998709ecb2852d56442ea981102941

cheers

