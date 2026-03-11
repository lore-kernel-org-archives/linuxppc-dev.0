Return-Path: <linuxppc-dev+bounces-17993-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9D4FD88D8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 02:14:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVvT15B2Pz3cGK;
	Wed, 11 Mar 2026 13:14:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773195269;
	cv=none; b=KflO4V/tHRAReJXClD9kl6rbf7+jxdwC2+0H9hHy/hwJTFUaZaVcOYf6ZhfpmINPFCKheDs7UjXzPiXHzcz0qLGbQQMq/JDKgspl+Id87Q+/PVEYqG9Sxc5p0UgoP/MinKWjb58eI9FvKHiPJx9u/pd4LZMidbpyGpVyQY3WZuzz/hAidtp7DsVyWYQiMSPKHDEhxuue8V0xUgkQ6rmpUzO4RHQVpaW5pU7NRnbpo9kAIZSKFjalmuOocY2FeEp32UANI68X6R5n74ga530egUSMr0/7LSGFwgu/+y0+K07+yCadbbmomFPOc/IAVRRNPZAAnbYoh197EYc0/o07Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773195269; c=relaxed/relaxed;
	bh=QxlgsBLoTOXgjMgElrk0FX+FYMCUr7/CYKx2P3Gdfgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L6AyNQB8QeKq0ZizSBvysJaSyvO0gHMtpvaDZ8Kv+cK0V8bEF58Xlj0pgvg2Qg+uGpLb5tW0fgQKrhnscQfqwAhReD3hew52Tfd9iqaBTOFi2hzdM+Ep2cNduTH1D1wTmfDiANFEoCx5FT9mG9TkLKBHdgKvBJmLAAbOrmBjIGEKcTbt0UV4VWynRP4uvDcawJSR0/gIp+kiTmW4+RnGErWE1jTSbLQt4456RepHOZTVOeGgxajm4CsiXcX6BeMjO8uyPp6jR8LMw/hBBax4ahbcM9WOO/MtH8KxnobYPcLGVxB5braOqruqt+uxv1ZJTd3xeo/13PpWOOplkmvJ1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TFCaENz2; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TFCaENz2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVvT10lwPz3cBP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 13:14:28 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B18wOn1913204;
	Wed, 11 Mar 2026 02:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QxlgsB
	LoTOXgjMgElrk0FX+FYMCUr7/CYKx2P3Gdfgc=; b=TFCaENz2rcw4pvbBU98IiR
	e18PFsA9k3Oz+fI9r515TTd+j8Q0LcEeICZPS+umj1jVwSHjAVWPQh/kJIezD3bN
	JN0ikMyE7WT9XPMKB4EgJ9upgnNUbdRnTVWIQRP1PJvdcSvC2BcbFBFgZF5B6pmh
	XazA7m9T4CaqOHcdZ33InuBFJBIQ4Z6h0qbB5GFg0XCG+37KaJgsYuieeTpTemjp
	C5WVZE2LZbkbiu/LzWtx8Mc0LVuD5Fs5mDGPOv5qaPiVw5kemTUd/RcfdygF//30
	PpnZOBpyL35k4SqDFEIYRZW619QIwwHjjUiu80DOlym6EuRoNYJ/Dh/jvrT7batg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcundbpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:14:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62B1U5fi015652;
	Wed, 11 Mar 2026 02:14:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4crybnbnsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:14:16 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62B2EFXE47907184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 02:14:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E92D92006C;
	Wed, 11 Mar 2026 02:14:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E14E42006A;
	Wed, 11 Mar 2026 02:14:11 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.124.195])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 02:14:11 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        =?UTF-8?q?J=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 0/5] PowerPC: A few cleanups in MPC83xx devicetrees
Date: Wed, 11 Mar 2026 07:44:10 +0530
Message-ID: <177319508348.269267.12330802792769782760.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303-mpc83xx-cleanup-v2-0-187d3a13effa@posteo.net>
References: <20260303-mpc83xx-cleanup-v2-0-187d3a13effa@posteo.net>
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
X-Proofpoint-GUID: PDLZ7PoE4Jt8kmoe2LsDOJBuwINp8bog
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69b0cffa cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=vWnL5tEXQ0y9T7uwRXoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAxNiBTYWx0ZWRfX9GXSwvCB9pvB
 0A0TStl07WHfGtKT2U1KCU7rV7IM7lH7MFMnuL4JUgfAO8U8jF2rvBm+3bdk95fXXWfeVTHQap+
 3rTzXYEauqRhbtysRdvQQIaWk+7g1qo8wddfDU39RjSbM+dFML/7azlyu37Pco/2QLqQ7vQot2i
 7jBg3ZSylsMSn1+14r5KstNrsV2thBBf1Ezyick/c1mYPBB5BVt0sHQpGPlrd93n2wj8cTvdVSc
 OifU7Qy2J/Kw/YUEwVIP0HvSaSafPvpATNBEVW8fdHSwNZnOl4+VumG+pu2emU657Y0+CGJfRS3
 GGJxfvPJMcymnRR5kNqihWLRXkC5GvOOeoRu8X0iOigA9hqPqBf5Ntfl9VtVN5izG8b/g4hrErc
 tyXlGph7IWQQ7n6lIB0Va3hzpLNtHLsvIdgFP7J3piTF30EgWLiY9VD+WmSI8aIarWVuYz2LH3w
 eaRw+ga2hqwglZKPc3g==
X-Proofpoint-ORIG-GUID: 1u0CU42RUsnQI6-7sfA6GGzoNS5Awuc-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110016

On Tue, 03 Mar 2026 16:50:50 +0100, J. Neuschäfer wrote:
> This series contains a few cleanups for mpc8315erdb.dts and other
> PowerPC devicetrees, which are hopefully uncontroversial.
> 
> Some of the patches were previously part of another, larger series,
> titled "powerpc: MPC83xx cleanup and LANCOM NWAPP2 board", but that
> series became too unwieldy to carry on. For this reason, this series
> starts at version 2.
> 
> [...]

Applied to powerpc/fixes.

[1/5] powerpc: dts: mpc8313erdb: Use IRQ_TYPE_* macros
      https://git.kernel.org/powerpc/c/38ce944d47b717cac6b5f2bae9dd247f87f21ac7
[2/5] powerpc: dts: mpc8315erdb: Use IRQ_TYPE_* macros
      https://git.kernel.org/powerpc/c/4f439747811977d05a87da65c1ae11246d4f4dee
[3/5] powerpc: dts: mpc8315erdb: Rename LED nodes to comply with schema
      https://git.kernel.org/powerpc/c/31618e0e21c4633c365b26e6d45cae2084f4245b
[4/5] powerpc: dts: mpc8315erdb: Add missing #cells properties to SPI bus
      https://git.kernel.org/powerpc/c/fde54f1a4dc7bfd83908380c0b4b6a830a0f9e01
[5/5] powerpc: dts: mpc83xx: Add unit addresses to /memory
      https://git.kernel.org/powerpc/c/6373a2b5c878e920341d7bda84ac1126f72e6a68

cheers

