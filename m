Return-Path: <linuxppc-dev+bounces-25236-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375C2C55175
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 06:57:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD6v05lMCz308Y;
	Mon, 03 Aug 2026 16:57:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785740268;
	cv=none; b=fKjS7DisX0JSUC03FLwTW5HrX1d5GgAKYx1Ytf3dAwjoU7W3Pq4BRx5fI8XyxzBvRVln0kJdn6YkO+0PVGP5u9tN7DpV2NSepGq2JYFr51k8XRf2BJX0uVhMBzW++XoyKYNjpJ/c3xdLq4y1hMZeZvoZ4qauJbb9B9KKRXse0o4cbkboHTdtBdfeGkkCPDbwHUGBC0rmfzL5QnKsxLv/oOZ38fFfwlFBbj7lcTU4fe30CCetkouN1XQGE4s4pcUpzsT43JHyxELwd8bCqAQQLKkHN0VNoc/Aj8Fzdbueb78SpcH19fPA5Zqhxo+hTYRuZWH+4Ixu/GShesvBaV1afw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785740268; c=relaxed/relaxed;
	bh=j2AseMafgnJkxtq6YA924Cq9yNDwuRwlIMl4lLXqy84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QtnZaAN1EpIooGZ3n9avoBQI2HPOrFhq9Pc/FlGlyTUkn8CzYhtdbkz7dabBK3GZ1D7WX2AFQ82KeZ9SNcC7BSbaIBSTbTHyN49PQSTsK584AQABAnbUys6Bh9g2WFFR1W1zazTTUl/MCpeXTE9ZjHAm5GIlztnXViCW6guCyr4CRvEZO1jaTo20EORAgk8xmliO8X93Y5Nhd5i7Zs5+JGYFAgYrt7LBTG+JimEP0c74cFbNj7t7rQsi+HdFZBNu31oYym45cm8mVUzCvIjYqr0c8xRsPjiGl01a3RnS6qtaiSczsXHIIBOuWxmzccx4tpNBxbS2EyobTmaRRaZwMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GfIm35oI; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GfIm35oI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD6v00Jn9z2yfD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 16:57:47 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LlcLt222914;
	Mon, 3 Aug 2026 06:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=j2AseM
	afgnJkxtq6YA924Cq9yNDwuRwlIMl4lLXqy84=; b=GfIm35oIRV5vaakJbSnYbf
	1wdlXBToCh7s+P80cnZR5stmvBYNdcLoXWBnMM/XG76J9WS/3O0GDFOHwkAcmwki
	HDfXKtpzdtQxz9LppsQ1ekUJ0E4fiSeGY0KbGNcD0sDPhWIv0a8UWf0qgZmsnBoh
	pnFmXE+54ZPZJyqvUeaIRh1SLnCJakpMOZ+CFbVXiYvu+j3d4dAI4I+xbDzvFSiq
	EnWARugmYu8wblOiVpECeMPWVa0nu69uBBpsZP3kE38dCs9PrsZ40oNXH8/9Snep
	Y+5aHT122Zt7uDAy5QppfscaBbCquJdGqIN0FN1hhvhT/Et4WL0+T7+kmRGsQwTg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3qa5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:57:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6736uJZq001022;
	Mon, 3 Aug 2026 06:57:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh4310-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:57:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6736vWJK33161474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 06:57:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83A6420040;
	Mon,  3 Aug 2026 06:57:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E32720043;
	Mon,  3 Aug 2026 06:57:31 +0000 (GMT)
Received: from Linuxdev.j9d-in.ibm.com (unknown [9.123.86.85])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 06:57:30 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] powerpc/powernv: Avoid strlen() in pnv_restart()
Date: Mon,  3 Aug 2026 12:27:29 +0530
Message-ID: <178574013464.29744.18255161960948806219.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721155346.121975-3-thorsten.blum@linux.dev>
References: <20260721155346.121975-3-thorsten.blum@linux.dev>
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
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a703be0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=MAXqqy5doE5b9Zzl4eEA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: HvyFAjoFkInce2RT0pJQPnlHoLqiKr13
X-Proofpoint-GUID: wmzL3u5RTuh0Cr5Mqwmfg_WIbf92CWJJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfX7xSdcrgXbzQc
 lxtioGGEfXfOk5+3+vsY0oBLvFOnHlMnP63XVUxxfCdQKcDE9SZRL97yY2U37VkazIDLnMoUQ0W
 wSGt0xhWFI0fBI/zcTn1/Zq2A/2suVk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfX2D3H8wWkVs3F
 YJmSRaRieRc6ENZVZWr7d1J+BSQV9+bObcljK/w6v5aCXwxB/6DcvVNLuX/XXD2NcqhQ7sUqFZh
 HMl0X/6DWxSfauYah/ujjTw4GplqM7Xf6tvCcIH894ElyeeERhsomUvAwrFRjcCcjhFmP+rtUNy
 tnvzDQkilOjAT5YLYrupH+NOn9hLlicBsRMgEkY8IXQZsZRtx22vZlwpZnyKT+lQwpFDH6KOLiO
 +PTzBTQJ9hVY4HiuTwMCDLsrQYZEZwgIFoZxUPOHw1Tbjh0nezWpDb689aE0HCglBqAfKEmYqJM
 PTRJY3fVuox4M2OpH2Sh8BY1pFcta2Gw8fvP7RSvEMLe9Od4qW6BMSSXnUVQDFBTOpHjovWn2Y6
 mpMjss+j/+kE3hCYddRX8Av4wiynJXjSZkHQbQfwrAimDmQxaeMNK435UYdgITYAvEN+EqB4zDB
 31Fga5HgmiiMHaS4ctA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030058

On Tue, 21 Jul 2026 17:53:45 +0200, Thorsten Blum wrote:
> Check only the first byte instead of scanning the entire string with
> strlen().
> 
> 

Applied to powerpc/next.

[1/2] powerpc/powernv: Avoid strlen() in pnv_restart()
      https://git.kernel.org/powerpc/c/86bb4d74da626064136d30367d1b35372b8320fb
[2/2] powerpc/pseries: Avoid strlen() in do_{remove,update}_property()
      https://git.kernel.org/powerpc/c/903cc6e45401d7f3821758901f229b0b59e4f27c

cheers

