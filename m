Return-Path: <linuxppc-dev+bounces-16979-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7E5C54F5D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Feb 2026 06:39:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fHLG56Xbvz30GV;
	Fri, 20 Feb 2026 17:39:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771569597;
	cv=none; b=dz0SGUbo+d9LQBFs4MGr2FpNdpixUlOoxgRUVhpBZDXutDfTP+HZT4QPB+guWmQntG60IEHiZUu7HLaWxnHD/UPd1udXMSXzlLcx+QimWCr7r3xAIvE92emN3CH2Z93/fCGbFWTlyr8QoUoyj3OiTEVTc940+KghxKmtNqwUapGDO6wZ2GtJ3pLRvUtrnwy02LedSqf52ioA/OPjpUYydHBXue8p9SDB5iOpG8GNZpumFMgmG9UELRLO9qxt65uzWf5lRsLNLGkC2MqOH+C6sxYrWXcGlvEaw5JsjgOmiJQJLwMaHi6umUCpxRN3/TM0KxiYmDNRDhQo6OprxGapBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771569597; c=relaxed/relaxed;
	bh=29qfjcnNBM005rcFcRM9Mlnqau4pUDoC+BuBV+nTMUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=klWmxzHpFAWusDLxZv9f48WfXGBrRL3PLtTzLmOCnUyZiIzTlON/7L+Y4wbO9MK7Xd/4Y9QPEKZkWwIzayq7CgRwJ8LMFTD5Gg0fB4K/qah2JY4/rcs/cRURc0hnbLJntGgCIE3gFDPdgGcHSxITjOsWMlAQ56XY0WCqFoL1qKSExWgH9aJ2BGDq48lJCT2UALvv+xFF58yqeFh+WyudTG7RXoEQSX7V1k+iZW6nq0EVZ2o9J4//FAYn/ozYRImNN3cMtTcLBBFLHP2NTA+YITkOEg3+g6Vn8K1brlX0VlL0qChfLAJoQDYHAepZzaBpeWl03J0STFmvitAze1wQOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rOJ476mx; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rOJ476mx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fHLG451Vrz2yrl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2026 17:39:56 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JL3N4S1368445;
	Fri, 20 Feb 2026 06:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=29qfjcnNBM005rcFcRM9Mlnqau4pUDoC+BuBV+nTM
	Uc=; b=rOJ476mx8ZF7GGfKluUbSOzcCoiNxXf0H1dWinmIL6HROCmUoIj/24sFH
	ZHTyD2hmAGGeJVycdmjmCBbDaZU9z0Xp2tbL3I+xH3/8N36QdxdYjrCWjK7gVTYS
	mR8mYqF0rgz/bd9FOIyCEEDkvKODNFYYvXS/7hgutN9mu+g5yG2d7aWZnNZk/jf1
	lH2lHlIzQzo2F7h3BP8IwbINHCqbdnwkeznjgavFnwqQScFkyGi0LM5MqdAZWg+b
	RyU73uTBo5IyvqDfhHR/AeEhA0vqWhxlf0WuXzvrJNcwbH7a+9YDAJU+wiNthPAw
	kLPwhyyG3hko2W5rbjDniX1GWUYCA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcjrcfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 06:39:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61K48c2T030217;
	Fri, 20 Feb 2026 06:39:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb45fc3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 06:39:40 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61K6dbEi58720516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 06:39:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 102F320040;
	Fri, 20 Feb 2026 06:39:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF80F20043;
	Fri, 20 Feb 2026 06:39:34 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.64.63])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Feb 2026 06:39:34 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: bpf@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Abhishek Dubey <adubey@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH v2 0/5] powerpc64/bpf: various fixes
Date: Fri, 20 Feb 2026 12:09:28 +0530
Message-ID: <20260220063933.196141-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
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
X-Proofpoint-ORIG-GUID: YpvBFMoqO0EH8mHwcZsgfW9HCDNU-Jnr
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=699801ad cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=6UyuRm9t2VcF-Ioa368A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDA1MiBTYWx0ZWRfX/XfwhNLPk7Sm
 oPTOmVEFARAT/3eLG8INHRxw7cdMG6nGDnW8pg/3nWERWrLPtXRJI5InW1ymk3wiczo3gNer/V4
 skwUXf4+XgHODElCg5m8x0/5uvGBRA2ZVz+1lYOqiW1DO15FR9Mft1dTGPG2qDMNjuoU1vDevY/
 AbyYwu7jcXAsm26rFljZk1zxNFAuFnKEI2K40/NmB0VI8PVJ/g27urdRnVIM1fYN4rQ+SxSULud
 cjTDAGNKspChkiRXaxOGRbhsFZFbyoaAmAdyNe68bqOFSZ47+8D9ciGjhn8aHU+co8jgdLC07q8
 KCz2LwGaGwFHaodfMfAWZrEchLhIOnG5GccyV0IzqAVLsO16Aab6bgeKQtTjmITVWhFD7w8lvhf
 VZvAEgnGbfv0noA9AHENTNRjSk1xNauACJfiR0ag65eEIUCEnDHCR7wnzDjFUKPKHPLrhbYSXro
 furllbhDZb50wgb3CqA==
X-Proofpoint-GUID: YpvBFMoqO0EH8mHwcZsgfW9HCDNU-Jnr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_06,2026-02-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200052

List of fixes for powerpc64 BPF JIT:
- Patches 1 & 2 fix issues with existing powerpc64 JIT and are tagged
  for -stable.
- Patches 3 & 4 resolve issues with bpf2bpf tailcall support added
  recently.
- Patch 5 resolves an issue reported by bot+bpf-ci@kernel.org while
  adding exceptions support on powerpc64 BPF JIT.

Changes since v1:
- Addressed couple of review comments from bot+bpf-ci@kernel.org
  in patch 3 & 5.


Hari Bathini (5):
  powerpc64/bpf: do not increment tailcall count when prog is NULL
  powerpc64/bpf: fix the address returned by bpf_get_func_ip
  powerpc64/bpf: use consistent tailcall offset in trampoline
  powerpc64/bpf: remove BPF redzone protection in trampoline stack
  powerpc64/bpf: fix handling of BPF stack in exception callback

 arch/powerpc/net/bpf_jit.h        |   5 --
 arch/powerpc/net/bpf_jit_comp.c   | 118 +++++++++++++-----------------
 arch/powerpc/net/bpf_jit_comp64.c |  74 ++++++++++++-------
 3 files changed, 96 insertions(+), 101 deletions(-)

-- 
2.53.0


