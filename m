Return-Path: <linuxppc-dev+bounces-22840-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444D9CD98F6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 22:01:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghs3d2XT7z3c7n;
	Sat, 20 Jun 2026 08:00:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781906445;
	cv=none; b=fXR4P4ifXZm7GxUHy6mLxH8pOVhLJVSGGbPOwjT0Gc2PyTe0iaYaQDWRFyp54eWpiRFXZQetyqvFFYAE9oBLDZWdYxAEMvXU3tAVOTenPA6DRUQTZfaB7yuiCrd7vIngiPqMwrn3bUv/J6WR4NTP7RsmW/5foRG1M6ejERI1jt/d421MQvxaFxJqFJu+13ZzZz83ua65NUy7g+aEvnDywZfqRSuswTjHLvi7yMPGK65QS2OtLpftthqnmlZoahtMMf8Sa0PvHnbHTQwRoeEq3YFaa80MUrB1Ixkv0BaJC1Mf1o3x1plIfVo0UcYrf4sN4EROfmoywhu/8izFuAwlAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781906445; c=relaxed/relaxed;
	bh=Ht6JIOsKw7Uy93wE1dtWt8hxgethA5gLawPgNtN8nkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FB/lW1Pt3bUSGrXK2LUzsyr3LY3q6jmWFY6am3YH0/3srxIyirWEQY9dBQ2PQriGt/Wl4U13+FSq37rnr3nDu5jNXvkNiFXyZtdi9Gw0UttRfW3iktEr0vOcq0pEGGbWQlrU7zBP0cGgFgD2sQIwlNQb5f6DtzmangwwBNL2froQsSk33R20FCMmCZGiL5OE6r84no3GZ81SzvZ7Qhz35lLoBaXHyjecdiHB1rVy3tAHQuXfP31Yq67Rv2Zy3GoZOQeK/bqLesLP5TQgLxyYFb7z+wyGxz8468saqxSMJIkdRn/rRbeBBturPvCM1ws85OwYCSDlfPLgeASTqYF+lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fGdEuEIJ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fGdEuEIJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghs3c42Pdz2ySS
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2026 08:00:44 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JLmB6I3445089;
	Fri, 19 Jun 2026 22:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ht6JIO
	sKw7Uy93wE1dtWt8hxgethA5gLawPgNtN8nkw=; b=fGdEuEIJ3uAyaQuJZ/ZSde
	LGM98MUMLUSvYp9bqIK6/+HMMfcBryGQh2QCBWB2OdprcRG+4WdoIYGLMSAQlS+y
	akisNfKjglxdGMgONwViqFrviV2xjtj7YeGF6UA1U63Cn4DQ60qdl6iMo6MIF4w2
	WKGTsUPx8SqTDzA3zLA0236bTsAnI3ZhU7XJZDPh3qSRIrfc7hQ0sxB8U+0fVW6J
	XQv0HlUt/05vLkuM3ptoQ2qng7+aSu+r/D6NeT6r42LNc1fvKchotjYHwzpkYdn3
	CC1ZeCPCnWVYFzHVf2AJ2aivx0u0gZ+utoqnR65emCu3wvlBLkUOs5YV0QINMPVQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqw7rvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 22:00:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JLnp7j014097;
	Fri, 19 Jun 2026 22:00:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172jrsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 22:00:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JM0G3K50069912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 22:00:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAAC020040;
	Fri, 19 Jun 2026 22:00:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EB532004E;
	Fri, 19 Jun 2026 22:00:11 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.77.5])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 22:00:11 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        chleroy@kernel.org, mpe@ellerman.id.au
Subject: Re: [PATCH v3] powerpc64/bpf: Add powerpc64 JIT support for timed may_goto
Date: Sat, 20 Jun 2026 03:29:52 +0530
Message-ID: <178190618787.653308.8944417251993496249.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260403105016.74775-1-skb99@linux.ibm.com>
References: <20260403105016.74775-1-skb99@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX6pm6MLiMiXth
 F9MJBBjkgMZPm1E3VDVKzVvdlOCgoK/7LqNiAkguLvKqZwiWkFTYxKi5Gc0PyU7ajkAzmBTRRJA
 F53+ZtzG9YrvKDFC+B64LypSLUVUEng=
X-Proofpoint-GUID: QnzBP-CKFwzx4-ZDOKoScJQDS6xC6vN8
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a35bbf5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=wfb-qDaINPFKIjLEY4oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4pYGxRfDI7dfBn_bQLyDjXW6yPNzbEKz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX6yMMTmPobo5q
 F/0sklDVI+q3cHKan5JPo2JPhXh2bZmLNlhvA6n73mzfLkYt5KQhJ688BjIbhNgcNfD+syhmgF9
 RD3AZKCfRlwoG0pf+M3zxANkkuP14Rk9XoXp1VY25PWKxyOgC/6Hoc42uDTup3hXaBSpZi0BQha
 dDNRqwbYVxvZGYsqHVNvr+l27Au4p/iMP23KV40jtr5Z/JMUG5hwNWh5Lt6cQdLUIjxUYDCV6B6
 llN69vM0Oq6NcbIdzDRkuizOvBP09PfLVWOPNC2o/bSzM94/XMNEjpIMnirkT32g4tVYQcpiiYu
 KDe1D+duM/dAuJQTHiVHhZR1wCQkemsJJ0/MHIlp60YMYfUGIHH88sKvQhZYPjDzdvW+LhccQYc
 XZb4YceHLGbyqd0z/UiBTiJJ1nwfkizODeu16Pf+pixsithO8Q/iQpdKN/0vKzv8gyw6PqEyKjQ
 7ATli5rBrg21IGRqNVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190210

On Fri, 03 Apr 2026 16:20:16 +0530, Saket Kumar Bhaskar wrote:
> When verifier sees a timed may_goto instruction, it emits a call to
> arch_bpf_timed_may_goto() with a stack offset in BPF_REG_AX
> (powerpc64 R12) and expects the refreshed count value to be returned
> in the same register. The verifier doesn't save or restore any registers
> before emitting this call.
> 
> arch_bpf_timed_may_goto() should act as a trampoline to call
> bpf_check_timed_may_goto() with powerpc64 ELF ABI calling convention.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc64/bpf: Add powerpc64 JIT support for timed may_goto
      https://git.kernel.org/powerpc/c/b55b6b9ad76cdb82123c62a15c6a4ebe4abb8bfa

cheers

