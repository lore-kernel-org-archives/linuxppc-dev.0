Return-Path: <linuxppc-dev+bounces-19478-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B9BFD5F6F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 04:31:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr97w107Gz2ypV;
	Wed, 08 Apr 2026 14:29:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775622572;
	cv=none; b=jShzJAieETLo68VYgRQIIDT64GBgz4bhSFhI6hUAWBLdv2nBd3aofzmf6F7Tpu2kpNlXEEHpbnFW6mppz5wp7telbIzUzhHOY5T+qrlUkdRepUYFQCp/jnJFJUsjbezCKDojdJf4fze2INZxf3wvBIP1kp4OQfd33tbt/k9ZMMF6ux32H6fGnEQlmjXEM5y1424KCievtrCfOS48+j+prUgmg3Yw15iLexrFq28pSecbf7VkH/Bir3+ASHlSWD+Ivc/I0TpJGJE3gL65Cf/lblIT5YK3fgaBa+ic8mXc7/As/rN8BjX692kPUgOmYPv4P0kbqGKc1rcVAcjNv/ylsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775622572; c=relaxed/relaxed;
	bh=ZzDmJTFzJTuN3EbYgctXBLkQ/i1M9nLiknZx0fFoO50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wot5W6aTJ5jLWuOmpddAhnoRPHudXPToPKxQGpwgqHlBJAZ7zZtbWgNF5qSil9TxqDFQKq1vyTIQ0Hvwpjyvgjo/j58eJAaHpT15o2yDzcfSuM1LFgdlRj1O6U1NA/cEoZBYYVvp/W7CAuoWmxYllvEtF1cVKnBo9lLqHQtZ2AAVu5rKb/4JZCXijv/+xl8gE8Z3mMJf1ymURewSIxn8ynwli1A9LRtijY9rEKxZFoOIjuT8TVDRVbWvAJPfGPZoNPgKbMA58NjVCALCa8RcrMRVM7n9mlckthGvL1FMoITiNwqDEZzEGewGUu1mVsCphKuwKNv1eERFwBahCNrv4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XGMn2iLt; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XGMn2iLt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr97v3F8dz2xm5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 14:29:31 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63824wnt2594998;
	Wed, 8 Apr 2026 04:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZzDmJT
	FzJTuN3EbYgctXBLkQ/i1M9nLiknZx0fFoO50=; b=XGMn2iLtbKSsRPaajLGv1f
	PN4NEvxA1RYvOGl6ORexeeAJX7uJljC8umfKZ619tAMG84uBInkJI+Gj7rJC/IAI
	Ir1O+g27BR9ZkPoXJ+411ZdoyuR7Yp2b9PaID847IlE5Q4bGRqYd5Q+lIiHYCKde
	gSrjgKuw9fSe/1p3FRfXKIkccE25lRuk2XQ2qM6FmFb4Dbe3qQILl6amOgWevgtH
	4jazKBGBeUDQj9rt8wDz5X8NFa5JFNPxAST7lw1uY6TFT7ERNHQXs303zdXFWOYS
	uhGianp7FsUmw1w9v4zE5Qq3GMINLq76QvWc8AGccPnnBGtbD2FCY+QCZ4kkf5rA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2e67v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:29:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63800PoM013855;
	Wed, 8 Apr 2026 04:29:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf4607c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:29:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384T5bI43057452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:29:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E03C02004B;
	Wed,  8 Apr 2026 04:29:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6548B20040;
	Wed,  8 Apr 2026 04:29:04 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:29:04 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: Re: [PATCH v2] powerpc/ps3: fix ps3.h kernel-doc warnings
Date: Wed,  8 Apr 2026 09:59:03 +0530
Message-ID: <177562236427.1381144.2379690132417590689.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20251129183636.1893634-1-rdunlap@infradead.org>
References: <20251129183636.1893634-1-rdunlap@infradead.org>
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
X-Proofpoint-ORIG-GUID: 4_u8m3LUoOL00Us68i-qG4r0QAfmsQqA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX2f8/DVxTIT/r
 FnpL4x8HsaEOtZ78nTUE9UhFJhBnNfrQyOhBpKajeDhWPtOjOaSHlDpuu5zarYTMiJa2XOCFbB2
 liov8otH0qa2TMZH6UC3yLsERSbDpszOwexYTDJo1tn8UBX3MAenxAo7XMW51bMOdX8aEWs721+
 5sYosx8cMB+EGxVWaRhLsRoTxpBgFiwCRcTusSXYc8VpU98PtlokFkrDufmv8Q1M0FkAt7mmZ14
 w//xXh0r3FuhnCsOMAfjabRZBUJkH+n4GGtOA+SaHbpjKmUjBZyku6Xjj4Dyiu7YAZ3IP7Uw86b
 6VuEqnvSSMt1eW2Lumucyp/LcU80RxOdQZxpbVCSxKgspkiReBUU0xgePBsE3QdZ2uAWQ21cQO4
 s61aH+OVPbIu6v9L38JMyJ3d/F11kI9ExdXSIEn8XbCSLSk7rH41gT2sSB5Ev4TxiDgMew52CMy
 RUDIQX+YJ5L9CjYvtVA==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d5d995 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=MK7sQ00UDUXlA-M2kfUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nGsrIhN5GmUeXiASLBB5i05BhMSIlKcU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036

On Sat, 29 Nov 2025 10:36:36 -0800, Randy Dunlap wrote:
> Fix some kernel-doc warnings in ps3.h:
> 
> - add @dev to struct ps3_dma_region
> - don't mark a function as "struct"
> - add Returns: description for one function
> - add a short description for ps3_system_bus_set_drvdata()
> - correct an enum @name
> - move intervening "struct ps3_system_bus_device;" from between
>   kernel-doc for ps3_dma_region_init() and the function declaration
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/ps3: fix ps3.h kernel-doc warnings
      https://git.kernel.org/powerpc/c/d1e6f90d6befb970dd6eb7fb5922c8690bf12623

cheers

