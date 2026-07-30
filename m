Return-Path: <linuxppc-dev+bounces-25058-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B45C531D0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 05:42:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9dPY2pFKz2yxB;
	Thu, 30 Jul 2026 15:42:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785390129;
	cv=none; b=WvngZ7RqSHnX1LuPRx8sc9GrTxirxGL++A2TujY9f7fSAWIsFk4QDfpJ0C1tyeUeV0FAVenhKbk9qhVcE40enWfTG01O1Ps8igycWS6dXckRTYyjfdXXUQZbj5T5v9Rr43TclUkfQP8cspjZy+TB5N9Z9U719v7ayM1atmfpUeDHqenU0Ylww67a3OK1Q/KFKPauQwsSbcaXlyZTCVaipnSTa6JdzyaQfhnL/6w/P5zK7Mq321BXGYr/AxzdK9DZQ4Ogw/TOw0AjT4U9JEEjG7KaGBAgNTcftmHRo5MEJ8FWECa1Jyujm+IRqtBsqxIrwgp8b5vV7y6IPUOfftMLAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785390129; c=relaxed/relaxed;
	bh=sTtMqArJG4JpnUjhsN41gYysOstkNID3B74E2DDZ7/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WWkcIDhoDh7FSt8qtRdnhKlJmX9fYynqSJyLZ4hpI1+p8PWsvbVABfljqHj1Xflp2b4/pJDeSPF3egKsLP1/e8URfvCM5pkAUQQJ3MzfjhLZvdNBKpZ6gqk6UEDkytQdv13JSdsxwvbCF2SehedOIz48ulkGDpie3dadTGf2PGO3izs06JxtN9OuCV8N2C+7MtgWUUv+c3FLD8877rgu0aSP+iUPXYHKC90+WIt1hb3kh70DbFS7s51CfBJx0/wZF57WWUS010nDiG2faqNe31yR1hmYlncvzD2ZX3Mzy/u2jZkbKysHc2FVLfGKVmYqjjICswojZnuSQRhwKKAiOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AtqUUV+V; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AtqUUV+V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9dPX5wl3z2yvX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 15:42:08 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U3mOnO1934610;
	Thu, 30 Jul 2026 05:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sTtMqA
	rJG4JpnUjhsN41gYysOstkNID3B74E2DDZ7/A=; b=AtqUUV+VZsMu/hMUivQu/t
	nCP1xixrFUGH0GBhU9vRDYBdbftSG8DvAge5AH0oG9oNMW2Q4bu8gMXOU50MVnrA
	hG6VD0U7ztd0UovFAbaoMHECC6DUj32ATcWmALy6Nxw+46PknBKhSK73SFm7d7Ae
	fYRnihnt3jbGt5kQeq3Px0Z2B/cQZjLCNtCRXflVB4JU5PL7VmBuvPvnMAl7bK0n
	4L22HgTNliA7E+QN17+L8mJ9qf8fLaY0djDQo+gIa8J+jXeF6lcaAEK+ZmM3Qvnf
	R9nXOq/v84vtq/xBPmwo6BDmTk/ClQEaKlJQR07ysW+qvLB5d95vIj+sVrrwUAWA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xx7c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:41:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U5fNps002059;
	Thu, 30 Jul 2026 05:41:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pghrs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:41:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U5ffqo28901746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 05:41:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1D1320049;
	Thu, 30 Jul 2026 05:41:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDCCF20040;
	Thu, 30 Jul 2026 05:41:37 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.85.187])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 05:41:37 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        MOKUNO Masakazu <mokuno@sm.sony.co.jp>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: stable@vger.kernel.org, Geoff Levand <geoffrey.levand@am.sony.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ps3: Fix map failure path in dma_ioc0_map_pages()
Date: Thu, 30 Jul 2026 11:11:36 +0530
Message-ID: <178538948395.1278583.8213797923163532794.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260711130931.740719-3-thorsten.blum@linux.dev>
References: <20260711130931.740719-3-thorsten.blum@linux.dev>
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
X-Proofpoint-GUID: SZv8Z9hwvPsPhzrn_mTgndZOnQM9W773
X-Proofpoint-ORIG-GUID: 2dffHeDNnxgAaMRWEhZdI8H9_XSXN9ad
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX9XO+BktGQgFa
 iymJ6sfCiSTyZd6azB0lymWRN+5q//SKOy0Z5BaKNCtpv8SBVH8ydRDBEjf1o1uWWfET953lBoF
 AWTjuxPbWvJ/2LepTcaBX7oais/LGUw=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6ae419 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=IW7kSglj8ZqiZljJpVIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX7y9hP7rYLMDH
 ntBcXV8t9yVf2tbz8RJG5oSoLMtjORS0kqJTO23GAkjwq1EFyn4H2TXXWpqixyeV7oZGvTVMY/O
 oi39JAOPYUtxAfp69zJXvqQ9+VXJvw5zrVC1eNRmKV4yi/UtOambB+/8QiRdQ4VUvpVP7IRna2U
 Gkqzx41XR1JDMKCVPaxOdCPjinEvjaOmjBAP5kZFIZeLk6HvRY5HOkmTrceWkbnfBDhiTeMwnRe
 tLu2igwRZjTujAxncP+gKeW9iLyJFKfFuYDpjFGYvNZbP09/SeYpP9/FawRJ1JS3Ak4xfM5VOLB
 gjR+dTGSCifZULdSrIYVKBgaSBSLvN6MQPIvIdg79OZu58LdWvtVUy3wVjzqqeaM9GBgzDMYHGC
 aIZGWbzEfeMFOM5gKGfeucQtkOMgm36Vuo0W3t6k/VP1ZYc5bJFJUhSF5uCWe8Si8EPF2Y29h3n
 8FZQDNykKPgwKAfzdDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_01,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1011 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300033

On Sat, 11 Jul 2026 15:09:32 +0200, Thorsten Blum wrote:
> If lv1_put_iopte() fails in dma_ioc0_map_pages(), the error path
> decrements iopage but keeps using the failed mapping's offset. As a
> result, it repeatedly tries to invalidate the failed IOPTE slot and
> leaves the already installed IOPTEs valid.
> 
> Recompute offset and invalidate the installed IOPTEs instead.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/ps3: Fix map failure path in dma_ioc0_map_pages()
      https://git.kernel.org/powerpc/c/0bb024f11d120abff3e8db9144a585b9d7fb8459

cheers

