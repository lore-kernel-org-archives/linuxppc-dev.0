Return-Path: <linuxppc-dev+bounces-27208-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842BFC88E50
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2026 07:21:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjxR032nkz30gY;
	Mon, 14 Sep 2026 17:21:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789370492;
	cv=none; b=kUliDHBUm/ZuGMCtxMUE7yAeGWqJrbjyjZxENxl/ZiSgMGQaBsBF6ZNaff0BZRqvJFu8TsXzyEy0ZWRotjO44AVa6Itm5MM3LC+26dOEYZs0VKUWzizzVL1nbKVRwd1a+BGQhJOFsabgRB4RrBmQTuKHYUdBzvRy9BUwsA5/eHlv391o/3SwhroEm9f11REWSJQjkcE7NeTseeXZyDaC2I6ACWFcXI7t9RNY6zzntbE0rxz8GdHTSExruyWqi3mIdaBjCMj6au4xNJ3umaBbin4zBrhWf60mGROLB+Fn+bTSYgxfk4BtRsB6X7MpiftpmpBhOJ0S/r9SfBjRWFOkhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789370492; c=relaxed/relaxed;
	bh=lSDSyAnSTl8f/mgVYDy0xszwdfzF1C6eqPIrTJIy4mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kh5478B2FQhfbww7rQ0TTVWBQNiFVdZihf2WEmqeloGYwv2/2znrF84YEJvyN9xV1KzBcR7pCE9LM4erb5rAajpZfd+zNwC6VasM4k7S7jOhYQhDaWf2niMU0xJfAT57pIsG7EaR/Dq5yRemE4oPAkTDA6QaL9kKi24pzBZvYw0fipZBYiFR6ko3Hme4t9C5Qh2f7QP1whRlo+KFeHh0UQ2vcWQWKLKpohysmfCR2CAzdOnoAakJEkRVYJHvgzI0hbJH1r0j5h+3C2HIoPUqdMvb6z4fknJpoRu9UJ3q7S86hQEtqec4n40OcwxfsX5eaeuRkj88tnMay6J4+CAxTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=R5YqaYrY; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=R5YqaYrY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjxQz4nvpz3048
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 17:21:31 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E61mbM3528160;
	Mon, 14 Sep 2026 07:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lSDSyA
	nSTl8f/mgVYDy0xszwdfzF1C6eqPIrTJIy4mg=; b=R5YqaYrYuplUmtmN1t6YGh
	qj7bKrL7vgeqaE3MmwELrG3boCfzGMVxQuaMFdNmbr3QN7+kyQMICVS60hwUrvH7
	ZFVBGUdiIVr69Y74hqWO0Ufw8i90OelhFuVX+ZD44fBDcCvODuxX3clpCiU3LmE5
	EhW4nptKFpvog+xDtKw68YVl5ff5e2v06gvJBXfpSc0exCfJ9U9yXnnPF9yeir2n
	URCj4DyBb2FFDAPyjItz828HtJeC9A54IwNhoWAEifYtPlOMVg/nLL4+nQBDP1uE
	w8xZYTXpeFi960GZvRm/IB/fQIVxKtsGPEqIwRZhln1pEvRFwnzdVWDVO1nrGqiQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdpyrdk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 07:21:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68E5o8ev1840438;
	Mon, 14 Sep 2026 07:21:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnk9j4cjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 07:21:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68E7LIJa49480024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 07:21:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B2A12004D;
	Mon, 14 Sep 2026 07:21:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16DE220040;
	Mon, 14 Sep 2026 07:21:15 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.93.83])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Sep 2026 07:21:14 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org,
        Thibault Ferrante <thibault.ferrante@canonical.com>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, shuah@kernel.org,
        chleroy@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/powerpc/tm: Fix tcheck() reading uninitialised CR value
Date: Mon, 14 Sep 2026 12:51:13 +0530
Message-ID: <178919368037.441103.6444951061225387886.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907215420.1258678-1-thibault.ferrante@canonical.com>
References: <20260907215420.1258678-1-thibault.ferrante@canonical.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA5OCBTYWx0ZWRfXyUk1p/9/EUr7
 Doh28DW1qlrIbKDL+4874wP7mGQrUP2aCmtFI5tM6R0Buo8cSasGmtFATDFIQXwT1pn1RhlgGrn
 pEf+tAKlrS6CmIzUSiRQze4iKDEa2aR67tPyeJDCsvLkbRTUpFhqfg/sH/JrPa0JXHv9vtZju3R
 xbZCiAY1R7TfXVjVJ0YTl7JwbdNxuwDK8nf6ENHYn/s57Bg+zWI6s1DpunD8QLS8oRSweXalMtg
 KrKEN1u5Q5zwf6OH34quBd4DU5X2bf+Jmw+R+awzp3ARCIVv9+h0QhoUkTXbTnSmvhSKHzvqWHQ
 VV6BlIdR/t+lhJWtaWOXQLZ5g6Z6w3iqSI7IMZUJQp+v59cGILSutqVfaMRAmO5fZNOFNloTjrB
 GgCOHPSRj4HALASsNJSbprKV5BwmkPb9fi10TepfPGibVNmZRv84IOb6vOKzEdLKL2ChPHUkJ8C
 34xyjfJ+vwhsDMJ+7vQ==
X-Proofpoint-GUID: JU26bO4TKImk6GDrMUMLLTfp4CcF3yJM
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aa7a071 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=DzEYXQ9d-tZsiXEeliMA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: 1Y2lbqRTI3fRQBCAPXccECUwqS4GkujV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA5OCBTYWx0ZWRfX1gIHa67T9IxW
 ierwDv7afURlnHxNOxer4mJFB1WLVOu+1jcCy67zNJURm5ZjgYRafe6DcUkQZ20hXM61jTw9RqG
 1D9YszoKlvHQXG5BhwUEproHnLLu9zw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140098

On Mon, 07 Sep 2026 23:54:20 +0200, Thibault Ferrante wrote:
> tcheck() is used to check the current transaction state (active,
> suspended, doomed) via the "tcheck" instruction, which writes its
> result into CR field 0. The inline asm declared a GPR output operand
> for this result but never actually moved the CR into it.
> 
> Every caller (tcheck_doomed(), tcheck_active(), tcheck_suspended(),
> tcheck_transactional()) has effectively been testing bits of an unrelated,
> arbitrary register value since this helper was introduced.
> The "& 4" mask discards the TDOOMED and TS_lsb (suspended) bits before
> they ever reach the callers, so tcheck_doomed() and tcheck_suspended()
> can never return true, and tcheck_transactional() degrades to being
> equivalent to tcheck_active().
> 
> [...]

Applied to powerpc/fixes.

[1/1] selftests/powerpc/tm: Fix tcheck() reading uninitialised CR value
      https://git.kernel.org/powerpc/c/ed28b16eab705071d28edaace47189c2eb3aa108

cheers

