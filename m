Return-Path: <linuxppc-dev+bounces-24581-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D73EC4451C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 08:15:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h49Ds3mGMz2xlb;
	Tue, 21 Jul 2026 18:15:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784621741;
	cv=none; b=WsWQa+inZOW7OEqDj2NN4r/OCl1B/KTwb63bdAJHAMaYWQd+F0Q7LaJS4ljZwCKhE3GyYqbLztTZjotaSZ6ed9oFrqGjIvDSLJihvcj4sIB4OdcsMYKIdYdnK1n0O1BG0S61S0XCzKzXP0xzfe9Z6wCQG5u6j1g0Yty7eOEQYt9B2dTJA9hibf5g2AYl4eMKyauTR/aMK0IA3oYzlSbcfKW0e5yrFLFNSrb19K90LCFOF8nNvMg/ez6qAwoylZqlpmk3heJUFH7LrOgSPjb8XkuMg7cHcceGyu5ZdCs28T/ERu+Qf12Q/XUskhINeZNlsUzzhYPpK9R29Qe0+ju0Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784621741; c=relaxed/relaxed;
	bh=F70kyBctfVYKO4Lf5A5/F90+zjATHA6JYsGkkxtvG5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UnktOr8qysZvn3dj0ZFx5KXuysdrDeFd9VMzz2GPzfKbZDAem6HkYfwFpSkKxuVDfIw88CBnNNDmjY8GBSw1WWc3PWemhL/l1Cw8vzSIGi7A12t7Y1KpseuGOe2fOkMvNLFiF0S8pRMVGKHGJ1UqObWdcwB9AMMKDb+xkkwFJ3WNEFsp3NrID3wcps3n2vu4WGmHgicNzj2bJ+h+3F+VTUDcg2eg0/74uQJmOtyhlcFw4BJjLdJFmTMTC7Hs8ONT9H+xgCaxltvKJpyKk6Hi8hg3bCZQ9hjJK+B3cXjnlg6NmrbiYO/4qwmqP6sY5PVBqAy2W5IMTiIkzis4l7B8eA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TCmHIqAS; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TCmHIqAS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h49Dr59P0z2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 18:15:40 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNDZ1r3560230;
	Tue, 21 Jul 2026 08:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=F70kyB
	ctfVYKO4Lf5A5/F90+zjATHA6JYsGkkxtvG5k=; b=TCmHIqASwV7TTgRkV8w5qw
	RpRNqVfkHeJsCCy8ZAcVxxf6ipJ6xKO+tQAO6BkIr9Mc5IK363cVvMA8I+QTj5MD
	MXAtnrdHDbC2RNdwCVAIcOwDgBGYgny0mKQHKis6VOxHuu8nMmw3r072+dhiaA0N
	XvlnQtJ1b4pCn7FTcg6+rF8JZ7u9ihGXUwTeKhUxES8I+vLhge0IWiT+jD8jKuz/
	vKYvcIy6To3hbTR3DgqJsFNMP+FAo7fNOr+JSshMC6+BGlmsYElwib77RTAuMAH3
	L+1s6u6MiSdpirp8/GvwBXo5r74pOgIpEevHKM8meIpZ79AbQOQCthiA9orl/s9Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ah36x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 08:15:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66L84dbg013964;
	Tue, 21 Jul 2026 08:15:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgy94am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 08:15:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66L8FN6s24183084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 08:15:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88A4920040;
	Tue, 21 Jul 2026 08:15:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 319C920043;
	Tue, 21 Jul 2026 08:15:21 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.5.176])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jul 2026 08:15:20 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Pratik R. Sampat" <psampat@linux.ibm.com>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries: fix memory leak on krealloc failure in papr_init
Date: Tue, 21 Jul 2026 13:45:20 +0530
Message-ID: <178462153940.1974055.8113813222024917054.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260614142356.658212-2-thorsten.blum@linux.dev>
References: <20260614142356.658212-2-thorsten.blum@linux.dev>
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
X-Proofpoint-ORIG-GUID: rrEshY317-BZh5KwPmuNcttFlUxINT1B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA4NSBTYWx0ZWRfX7gUHnNFy1aJC
 VpMp1uO4o41CeU7huqd0OKq6b6Q6Q2cOTpFyR/bPQpDyoNDrImgprYvyrn9n0mTgqbsb/UicGq0
 vSbEghnXOlPXSvcyupeGJODHL+t2aTZYfUZ7tOpyv8RM1rCfizLc6hC1FCAUShXLV+AXLUcYSNL
 DCD/DGR/dYQ6LbM4cE5Zzi0CiOSA8H5PLI07SiAmvNaAWaI9FAOIdDuJfIwUD8Sq9AOaRxPTDe+
 OGrhu3Z/DuL8XKzR2A0xBFrqof+4mC0UK7XTpCw6kdD8YEN6XIAXYUnyc1SdMS/nqlFayZ7Czqt
 xmoRrQdoEb80sXVUCMv2X4tagzXq1Flryi9YbAHZyKhc0Ym5jiqvjRcwHhZCA79i1t1d9H8xWaX
 XS8HKlumOwzOsxQ+2Nj1iS1zB/arPFI5JX5mncv/qBc68K40LNUMV3oVPx5tFKxcwIywqZhqQiH
 rLqPNidmf2xajCNJh9A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA4NSBTYWx0ZWRfXzC9uLrVhI+NT
 6PGWz3h/9HGWLNzTyztmRX1RFYLgJWUCpAeoxQxdlBEo4+IZj96yJJhEYQh33CQxkkC+s6Y2y+R
 ZdoiOltRcseeOJ41hcWJpWzWxio7hVc=
X-Proofpoint-GUID: DSQnKxNtjYMrz4O3uPWlw_biJFDRwg7c
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a5f2a9f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=CC3r_jQr0_LCWo4q_HgA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210085

On Sun, 14 Jun 2026 16:23:56 +0200, Thorsten Blum wrote:
> When krealloc() fails, free the original esi_buf before returning to
> avoid a memory leak.
> 
> 

Applied to powerpc/fixes.

[1/1] powerpc/pseries: fix memory leak on krealloc failure in papr_init
      https://git.kernel.org/powerpc/c/bd83c98b988d2c560531084e296dbfb530aff829

cheers

