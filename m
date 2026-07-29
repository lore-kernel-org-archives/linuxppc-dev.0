Return-Path: <linuxppc-dev+bounces-25026-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB273C53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 16:04:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9HG55z91z2xwP;
	Thu, 30 Jul 2026 02:04:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785341069;
	cv=none; b=HsYE/gO9oqa1Q8n2ic0sw01n0vcndajoPNpLOCEpxKfKo1+ekbwiE2b5Kiwr2RA4Z5WkzQGyleyf5yOB/r5mucq93IE4U0sQC9YMEYG8LvL7HW1rUDfnsPJiYDsaGb4vNVeTOI2soGH0aXfVu6fO5TFRuh2rB4eIMs1vi7YZcHpf6nYQMMVcw+qgg9edo4Wn5aF2I9ifhVymPmF/x8mj/CI837Nc3Rh7UO1p45BhM3Zs1B5xo7HmxJ1UJFcfOxBz4yR1JT97ZS59QWkasgKd/v5KVgBQjL4TEL+A5lK2SQfVz35dYF57ozCgDNytrlv6LI7OunGlr3WpuJx7fTgbew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785341069; c=relaxed/relaxed;
	bh=5b8JNaBuKbt2ObAGBsa6xLbzhMT8FxebnmoXKTqGIfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fq1ZnsBCQNsJAL4zsmjTS7Gmip5+gDgo9CqB1l5DXCOxOHt+P/BDQwEPYJS93eKYQgvoig3HzAl/LLll3ftfXRmKNR0u8XEs21gGXyykp3ZlqpvwysK1/gKLaftFCeuhKp3NdPSObqhkz8qElS65m2IFnHfUXtvz3KyqgvafoVRZ1hvzDmzIaorNR/gPe1TqWX6JG0MN/Rl8LpOVWxQc+uBtVXVc4IAagt9K7zneb+YTuqNp6VdVT9R5q54IgQNXUBuW6URCudFQgJYo10kbLe2gUkOTYi0LtluSW1ik4nc/0qJRGLyKfhIXW1wVoT68e3L1EltG+/zKjOJ0LcSzBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QUYNu5zp; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QUYNu5zp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9HG42xdWz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 02:04:27 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFHjiL278592;
	Wed, 29 Jul 2026 16:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5b8JNaBuKbt2ObAGBsa6xLbzhMT8FxebnmoXKTqGI
	fE=; b=QUYNu5zpe3Zd34kOicOgjfalykSxk4QSxfS05U51UsPycPAYDLirvDu1h
	SuPvaHivuXg2z7wN8fIczq9QlFFDna5CYHpm93BndMwb2fdz17O6n/Qrjf9Di9To
	d5l23uG82yqXu/qrzEZHENbTsjN1gf3765Y05nghlWFjYwF1EDKaUJYpT6X83rCh
	X5/QRNMNC2PESFOOGdtpVWPxAwcIVwfcR1H3q8aFLpL4Qa2LIrfYY3lh1zqpu4j2
	uPm1JHCKY0MAqCnqAFGFdTccVzPLJVNl2e1kUVUZsOlXI6i3cV7Ry8++Q6DpuJYO
	aQYOlInLDgCaozjyr925BQ1GUqwlA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjar8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 16:04:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFuNND031383;
	Wed, 29 Jul 2026 16:03:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhfa4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 16:03:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TG3tY130146930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 16:03:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DED12004B;
	Wed, 29 Jul 2026 16:03:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 589E820040;
	Wed, 29 Jul 2026 16:03:51 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.39.22.107])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 16:03:51 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
        memxor@gmail.com, hbathini@linux.ibm.com, chleroy@kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        skb99@linux.ibm.com
Subject: [PATCH 0/2] powerpc64/bpf: Fix PCREL build breaks
Date: Wed, 29 Jul 2026 21:33:48 +0530
Message-ID: <cover.1785339155.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNiBTYWx0ZWRfXwK8vh4bFkf/V
 lxEsJhMFzXQWuCVQXyqwEZY356lckummUJ4Y4PrGqbJnuABzEUFtvty/kUYcUPFuo8LovTnFyzo
 t1NVFMVzS5pbOoi/nP2vBAMHTBOzWD0=
X-Proofpoint-GUID: GblyN_BnGJO498Az21cJ_tydLi02Vvod
X-Proofpoint-ORIG-GUID: yWN0ZcMvnXd32UR99hM0DQ4ZTeKE-Kqu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNiBTYWx0ZWRfXyrHZaDobh3Ye
 FHiYlgykWtico/c6+0SpODiKqA2YLyloWTKf83+szUG7kNZnBCNQenEJdaxiVyx3bTLo/3Wz3Z8
 i3rrOTV2Qe6Vz+uLtkaBscPRBuMc+qT8Oz8GsjY/9WRO83aDg95Vx1ENUN+E5OzhG1tNOzjmJ9Q
 QQayUl7kR2oLR/V6S9aTmdEIPZeHX1qE8yTGvuPPUs02UmFlJCj6si5pImVhewBSdZnWpos123r
 dPTn9TnbGgLeF+h0D8mE7XtdL3a7PynnYqguymg9qFdHMaHW91kNBYqZjvz/jeZtJj9FU1opID/
 CUe2n+w5XMuo4LuNb0MF1szbVwupgKtDoXZ4+9jeNiERPa2+CPD0Q3rpdyd2LSdQtk+C35xu9oE
 XS5aPfjtvCLovMosJ35cpSs762orXu4zX5y22TMuLWGqWzTewgRMN+3pK404xI5LK89BEgGNVdY
 CGw73N5l4cJ72xHfWow==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6a2470 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=V9aS72HiZkO_OSrc0EwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290126

This series fixes two build failures that occur when
CONFIG_PPC_KERNEL_PCREL is enabled on powerpc64.

Patch 1 fixes an unused variable warning in bpf_jit_emit_func_call_rel()
by marking the variable as __maybe_unused, since it's only used in the
non-PCREL code path.

Patch 2 fixes a linker error in arch_bpf_timed_may_goto() by using the
CFUNC() macro for external C function calls. The macro properly handles
the @notoc annotation required for PCREL builds, informing the linker
that TOC restoration is not needed.

Both issues were introduced by commit b55b6b9ad76c ("powerpc64/bpf: Add
powerpc64 JIT support for timed may_goto").

Madhavan Srinivasan (1):
  powerpc64/bpf: Fix build break in bpf_jit_emit_func_call_rel()

Saket Kumar Bhaskar (1):
  powerpc64/bpf: Fix build break for arch_bpf_timed_may_goto

 arch/powerpc/net/bpf_jit_comp64.c     | 2 +-
 arch/powerpc/net/bpf_timed_may_goto.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.54.0


