Return-Path: <linuxppc-dev+bounces-22845-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF08CD98F6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 22:01:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghs405PMwz3btT;
	Sat, 20 Jun 2026 08:01:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781906464;
	cv=none; b=JujmCQW98dMI70rtGFSmiwVlyOkAjbIqLz2BpkdyLeK3em4oR/qROBFKswCq3vi0R4iRf1DBzu6vc1LQ2U4kl3qTF/LCpxkkqF000q462PzMxFz2ROGpEpLHYK76rXHDtYuQs03uXj+ueQyFgWcooTmMNJnx3/z6GrF547deDmxf6CNis6z6268EFye197J2Yfb8qZu5mo+7uHkaO2DN4ZBk3x3bn49+O652WuaOA8dB9PHGltW0znCtYwM7N6rhxfOo5SCpvqm4bE8n2z9a0nWftWpspbKLaDWL+rkttcDIL/qj0RsPJsLhWLWhPphDfxnLcoGZbzJxNa2OVH0qeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781906464; c=relaxed/relaxed;
	bh=kaqHRpJQndw9z7wGZFL8X2Ni3N0gGYNiiMaWxPkc8vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDnIyBG+Q48PBMSYbXuKFDJdcTHW5F3CkUWr1x90E2nhfQrS+BLSLjOyvv4M8DRNDACn/p/xNlRveE+3rk92E2hOJ6hF4MjC6zUmkWxBv6H0bZQ7lwZVY9xsplY2pZEmrNVvxQrnhoZZmsHUo2n7xIqvlggC1EfQZWKmSY4aRLBQofn1X4dk+xbzw4O/7IG92tDagRW3FFyj7uwlwvSqNvWEWYFlDbxPKtKom6g3mhtePbsVlQavwPSY6eXu6YEd/lAwYVD9oOzUK/oLLkh67deXkt1Qy6MYgPFrbZPdJ3xYC1TlwkmZnWfdO8JWLu6wahYtZOvTKPUkc2tUTngscQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HX3OeAI1; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HX3OeAI1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghs400P0Nz3btR
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2026 08:01:03 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JLmDaX3483299;
	Fri, 19 Jun 2026 22:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kaqHRp
	JQndw9z7wGZFL8X2Ni3N0gGYNiiMaWxPkc8vw=; b=HX3OeAI1DYdM7xoJlzUuQY
	kpOG9nGQF9fJioe8AZbNkL18dwvOTOLAxTZnJEAm3gPBIvlSzbfyzON83JRXnz/K
	GdDTSgVdHkY5U5EQM2mqldtpnei2z2AOVxCV9x/9aFsx0Y3WFIn6LJ5NBBgi8doU
	G4qU8AjFAbukqu6h9m3/43gnGHOKgD2tt/o8YCw1Gy+uwLO70L7GTDCRy9X8MYFK
	ACdYO96StwmGFzeBc8BNjuI/TolOwHY222ji/0hXNWwn/o/3waaNygHnwejhRFkH
	zBIpru2P+emtnL/RKoef6zSvxg8Wo2i7odnp198Mu8+eJMQV7bj9DYxAzWVsfTig
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqtytf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 22:00:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JLnePG007534;
	Fri, 19 Jun 2026 22:00:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172jrqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 22:00:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JM0bgv38797602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 22:00:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F216C20043;
	Fri, 19 Jun 2026 22:00:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEBB82004B;
	Fri, 19 Jun 2026 22:00:34 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.77.5])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 22:00:34 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Geoff Levand <geoff@infradead.org>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: use sysfs_emit{_at} in sysfs show functions
Date: Sat, 20 Jun 2026 03:30:16 +0530
Message-ID: <178190618798.653308.13261722398674527580.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260524130002.793476-2-thorsten.blum@linux.dev>
References: <20260524130002.793476-2-thorsten.blum@linux.dev>
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
X-Proofpoint-ORIG-GUID: VhOEdsjNStAnIQFUhr_DEj99w7pWHdK_
X-Proofpoint-GUID: YxPomug4NRQiyvNsTWC6u65f0jABBb8r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX9oukSWMCT3z+
 eHo7VdAoQ6dSxYQ2he8sGQi/vISi2bfcQXbBRm0aI6xxWMT57Rc+rWCPp6mZbLvzm9sJI4X2Gdu
 ILKbjJpew9wPAAF7Ot0qFIoJ0Q6aclgHXeKjP7ckawirx2OwEtQgDO4sazRQ9XTO5R8dC8LrhDK
 mQfE11aDFXOK+6jWrH9w6SdrgPATycdDesgAhw1YQm0bXkIna12OZcTVE3X2XhLHsV+irweVrXB
 lSPZqRPraoCWcJgggtyZzr2UeyLN0STqpDYracrBYKSkVy1RgQhmwr12QTZHwHpTWylVNf7LN6Z
 azKXITghGP4jDZDd6V0If/thZi5bRj3PPXJcdKfdZLz7VpyTCgIdb5HqjlgBCqLVw0dvQ1abmiC
 PtXWBYabr0EvGJNCb5ptZbCSzRq/Uu6/Ppz+N8eAJsnbo3kDSF9G3NYIqR6p8N+qS1Ss0Ruq1yc
 VdTmcpRd/lWkYbVazFQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfXz534EsGUxy+B
 eYn76zcDBrNK/dJ99ZL0EEwZv+PM2h3+6yddXtl2Yi0/+BFYsyYfdokWdWh9OliUcxEx0PN21cx
 alT+lQZHkgwtO/UUeWUnuvlGQnKp+QE=
X-Authority-Analysis: v=2.4 cv=B4KJFutM c=1 sm=1 tr=0 ts=6a35bc08 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=LU0MwxnAT0ZH56fzUpkA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190210

On Sun, 24 May 2026 15:00:03 +0200, Thorsten Blum wrote:
> Replace sprintf() with sysfs_emit() and sysfs_emit_at() in sysfs show
> functions, which are preferred for formatting sysfs output because they
> provide safer bounds checking.
> 
> While the current code only emits strings that fit easily within
> PAGE_SIZE, use sysfs_emit() and sysfs_emit_at() to follow secure coding
> best practices.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: use sysfs_emit{_at} in sysfs show functions
      https://git.kernel.org/powerpc/c/ea8b474b5550d353a02f25a5813cb1682509d5e6

cheers

