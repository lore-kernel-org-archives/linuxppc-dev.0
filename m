Return-Path: <linuxppc-dev+bounces-21055-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9F1CD343F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 05:43:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJmv0650Hz3byF;
	Mon, 18 May 2026 15:43:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779083020;
	cv=none; b=DfmMhsipPi3NZ+rRml9v5yuotDJW/vwBaYpkJ5F29F1KwH2gfa4Hua/3H5T50YOwN9f8HyhkqpjUTJ6GD3XBtA/pIXfV8WO/Re5BoXc9NgM3uVwRH3aM9El8JJ/mCz0D3gcau7zhhDkPopAD+naAHNnR6fvlpNFQs7QTbTCUCYEr4G5HDGAGyt6VN/r05Yr2gcQhXd3P44gFUpytxfM990/6L7iA5UZnvNW0iO0PBFWdsiL9eCEXRJhh5HYl76Q5GdUDoxk66Eh8hC7tQGTliPRzlXSKwsoxZEKzJOFwjcC7l6zfmJiwVgx0sgfkg8K49GXe7cyqpAA2U8FIRglmQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779083020; c=relaxed/relaxed;
	bh=Zpuslg7HJ22OiTm8BCn7dBzLqcFkaY6keRbNGx3FUBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=flR5yjqZueqWATh9iV/mtaLDe5jlJz1LPX1znB7fsYgOLPAH2Ldd850lOZOMsAdZkj9sJdoacb4a+9ncRpr9cU29+j+FbxPfhxI2/egmQsH1GT9aAJAYkXI2XJoitINIRwsPzMOHwfuYrHbI681MpKbDZF6LojWeYDPPDd0QdMFb0D3WGuLnKVM/NW+hvbCaN4VhwgxlrUw84+Loe0IVOV1J9EMDAr8MKvi00XU7Q/VCwQQJ8vFPaAGRu7aKJXcXiD1y42HyO7T6MjEOK27By6NWgpf33m9X7TLd8I9cSLVI7YshgoxFLqpoxtgKUaSrO+JXod5V0FNzJn/jWVBnXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o3Ceiull; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o3Ceiull;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJmv00z7tz3by8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 15:43:39 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64H7QbOg470901;
	Mon, 18 May 2026 05:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Zpuslg
	7HJ22OiTm8BCn7dBzLqcFkaY6keRbNGx3FUBU=; b=o3CeiulltZtw2113E41yKi
	jNkAcYyQN21uLFgb1doneG/lkoe9cSdkirdEH5tlNSHlmKDyvz0Z1NqkCkl2ij3t
	et8hi824zjGtbwqeR4VsE2raDftmLD3DCoTzP/miXbG/nUz9wrCWY+T9RZAd3vsu
	zBno/91eeFn+OHpthU1G0gTjq8JoBrDAXV1YiAOC19N7vwKQ36OnP3Z4BPbZnREg
	rGRg+dwmVcMsAv9/eP+UcFaMp9rTAoqYQ28nzfTQ4xO2MQS0qTWKn7r4i/PGy77g
	tjhGFaYfjuj6v0UqshlN+HjzkyurhJnfS+9lzs7INg5QPBOaBUTIz1/Vj+vBtApg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h885xmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 05:43:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64I5d8ff024840;
	Mon, 18 May 2026 05:43:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kxv3jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 05:43:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64I5hQHw57082268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 05:43:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74A6420043;
	Mon, 18 May 2026 05:43:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0F5420040;
	Mon, 18 May 2026 05:43:23 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.43.25])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 05:43:23 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Christophe Leroy <chleroy@kernel.org>, Ally Heev <allyheev@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v2] powerpc: 82xx: fix uninitialized pointers with free attribute
Date: Mon, 18 May 2026 11:13:22 +0530
Message-ID: <177908291158.287704.7799754252880043230.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20251116-aheev-uninitialized-free-attr-km82xx-v2-1-4307e2b5300d@gmail.com>
References: <20251116-aheev-uninitialized-free-attr-km82xx-v2-1-4307e2b5300d@gmail.com>
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
X-Proofpoint-ORIG-GUID: Twr3TuRTyCWtCDhfdoGGrXH7hNQNh_0T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA1MSBTYWx0ZWRfX5UkdETdax0Az
 Po+sa+iTKidbHFSNzm/c0bEsVDCvFGp1rbgaZviswKE8jFJf6JHKV4mHft6vdXeB6+S6E1oJy10
 oMERCPIRE5qN90FN12/nMK0KRF/bMQzgtn2t+awsKVScql22YqWRc/YP++JHux/Wq5PVFnA+0O0
 cCFwWs5iDxNM33ap7RL8WxcSxrMXOzIQ/LxKbuUpTZhaMjPSK7x4lDDCtNQmR4YIP77lOIm+uHd
 iDLSXX9ZqHUPTZpL8qZTPyTzmewFQWV+j7MCtmnAWm2tcULzZWRYb+zkOSep8tzkjhF/ANnLW/5
 QttAX5uCQYnIgzgHslRoYrrKVsHwOT8wWtWGnCDeTrWVkcg6g72D/xG6r6BkY3lqiI0viwIl1S/
 wgqYxJ3le8zib32TM4Sx4GRLqq2Ie+cpWANUIaZ4410II5KeTqhBjs2EiBeeu4MWhy8+izbUPBA
 Da90uCjHwP/4spojnNA==
X-Proofpoint-GUID: OGxQCvjKnC04SM7iJw7gWjzDHS0EpEdB
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0aa701 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=nmQVRDJ0vG_dgf1MR7AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180051

On Sun, 16 Nov 2025 19:55:44 +0530, Ally Heev wrote:
> Uninitialized pointers with `__free` attribute can cause undefined
> behavior as the memory allocated to the pointer is freed automatically
> when the pointer goes out of scope.
> 
> powerpc/km82xx doesn't have any bugs related to this as of now, but,
> it is better to initialize and assign pointers with `__free` attribute
> in one statement to ensure proper scope-based cleanup
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc: 82xx: fix uninitialized pointers with free attribute
      https://git.kernel.org/powerpc/c/acd1e47db03d4b528fd5efb8565dd0de1c79f62a

cheers

