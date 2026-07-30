Return-Path: <linuxppc-dev+bounces-25061-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B30C531D0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 05:46:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9dVk52T9z2ynf;
	Thu, 30 Jul 2026 15:46:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785390398;
	cv=none; b=lRgOkRIwtDMP2E7dMLFYMGtzY8KvOubP2XseCkrUo1BRh8f+oQe8o8dNAFf70Dmt597Z1UfFMCxASwD2kKozkMVgymKZF1SOo3g7ihxOSYavvUzW5amJKztDMZa+gc9YavngwYWOkQuRpn73Wma1Uh/O6aDqzEQpBH+yMayJUvccwPOyi9+zVc2OwzeAQq3oEiczsZsOBhQo6rtF4nFiy3tIZGryMkzo4T/lf8yp/nUjKd4XFWTtx0v6AEweLNlsrXAOSZYJ/vwiJw+fGX+lLNAp2N+HmSD40mogiOIjVBCJGclslfgDbr30R8BquvbIfrf/oQyOIuxoKNEmIWOokA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785390398; c=relaxed/relaxed;
	bh=Vk8qJ46qKbE3TIZrGVczuBO0DF0zm9W1gqqH2GnOOR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dID3QsCJGmpjGp2LfuPm4wWz9uS+eg3NUfwcPOcI/DKB0gXJycaY1m9xB9/juh0Y7b8XKFINBuUz+EnvuUeLakSA3EqzFZG2u652ftCfIpPTwuo0fTlGVrLXXKodFqX8HfWOiNOF9g+7tEKNdNTIyIrPmdCfC94yMkrYtv7aWxLKimNuCiZ6O8rjunbXewZsCJdTIFAzDaWR54if1HCzxbBhUat+gGGDxO56jGMxaZmlsf6rZ5U5ZUtnUs+ycVCPtHIvF43RW49PcOjs7hs7kTafr/Xbmkdsv7t+mlkRkHYH/BTsc7A6Y5vJkxOackh62b3eRELDTWdBlChVUhjZTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lvBHY093; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lvBHY093;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9dVj6L5rz2yjw
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 15:46:37 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U3mAf21825092;
	Thu, 30 Jul 2026 05:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Vk8qJ46qKbE3TIZrGVczuBO0DF0zm9W1gqqH2GnOO
	R0=; b=lvBHY093tK1eFqAOq2NvF9ZzVHZtMT2QxLg/qSf9Q35TmJlWCz+79y4fA
	HHDHuMelCuYQsCodkdZ4eo760MVwmWxQBf/wrKpiD8BaUKTftECmv/gVDBruCUyt
	JWvUH4WEKWlxOPU1RW2ihUwZbW9KzuzK+R4f+mzUHJFNXvUbHrnTn/VOOatWD615
	IvJkStNxaRvR3HroIB3B21MR3xFv7+4cEbJ2VLcoKIdHZgI8TAnd9NTuWKNNfV7O
	Dww7RyIn93YnWyQjHKaUdInZROMaulxOIkBa6WAeUOpkkKgidnL2lWGEvmKRmNFn
	x6anDhLxDm3hY8kBH97aezubnmuyQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjdbgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:46:13 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U5fHwj024108;
	Thu, 30 Jul 2026 05:46:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwa2hn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:46:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U5k8YE7733506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 05:46:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A8E52004B;
	Thu, 30 Jul 2026 05:46:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8BBF20040;
	Thu, 30 Jul 2026 05:46:04 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.bl1-in.ibm.com (unknown [9.123.13.162])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 05:46:04 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
        memxor@gmail.com, hbathini@linux.ibm.com, chleroy@kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        skb99@linux.ibm.com
Subject: [PATCH v2 0/2] powerpc64/bpf: Fix PCREL build breaks
Date: Thu, 30 Jul 2026 11:16:01 +0530
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX0v4h06hZa1vP
 7hHOBLr1JuGxvXw/8/5EjQHEVYpYKH9MwF8QqJbKvFP2FXhSTCp7rBLRgqroHQFoegBwoE+5+o/
 C3d7j5tM27BPO3CFBYWN5xf5jc0nP7I=
X-Proofpoint-GUID: 7upmFhgn04MGLvDSNUPBL0UT8lHAZfcG
X-Proofpoint-ORIG-GUID: 68m4NMtou1aLhg9FGF8fbngmd1PnDPEf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX3nNZgSeLv4sM
 ZJrqu611mifc+2YhY8cMUKvzX7PIZ1osyz2GJp0UblXaveUE0d32OZA2od563zIA1MuWZNW+/i5
 xD+DdQ/mTbRcQ0YuL3J7BAXqoli7Xbjzot7kIimUYQb2BI4psHggJq5DyOmUZjSoz8YmnncwOnQ
 nNk0/krGcGg2t26LSUVuYtq+jqnIW01tWf2i0dhmAv5Woi3ifOlbI90eCSk/0YqfJLMSJ2v5d8R
 2PHYa7bw9lDtlj+1jn8EI/57nPFILm3uCR6j5yKwVXDgOuBi4O4+7z4jUV/bnI7qt6QYAWDaCZc
 GrG/4AEFrdgBbAjd9+Ji+IWs4Qm0GX/g5syoRzg2eT30db3Vde79uIlgs/5PRem/KjjmZPMDbL8
 Bex7Um8eBb5uuMxEiWdgbNGJffWVPi5vUBkcCwensVnzbxbjS6O83bylhzSuSpc96z5dttOPUp8
 57ta1TkacwgfpQuBoRA==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6ae525 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=uP0FO7UWW_-64gk7dT4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_01,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300033
Message-ID: <20260730054601._CalO76tlRqNJagIp7rI2hUXw2V5FueR_a40iWUsYb4@z>

This series fixes two build failures that occur when
CONFIG_PPC_KERNEL_PCREL is enabled on powerpc64.

Patch 1 fixes unused variable warnings in bpf_jit_emit_func_call_rel() by
moving variable declarations to their respective conditional blocks where
they are actually used, rather than declaring them at function scope.

Patch 2 fixes a linker error in arch_bpf_timed_may_goto() by using the
CFUNC() macro for external C function calls. The macro properly handles
the @notoc annotation required for PCREL builds, informing the linker
that TOC restoration is not needed.

Both issues were introduced by commit b55b6b9ad76c ("powerpc64/bpf: Add
powerpc64 JIT support for timed may_goto").

Changes in v2:
- Patch 1: Move variable declarations to conditional blocks instead of
  using __maybe_unused (feedback from Christophe)
- Patch 2: No changes

v1: https://lore.kernel.org/all/cover.1785339155.git.skb99@linux.ibm.com/

Madhavan Srinivasan (1):
  powerpc64/bpf: Fix build break in bpf_jit_emit_func_call_rel()

Saket Kumar Bhaskar (1):
  powerpc64/bpf: Fix build break for arch_bpf_timed_may_goto

 arch/powerpc/net/bpf_jit_comp64.c     | 2 +-
 arch/powerpc/net/bpf_timed_may_goto.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.54.0


