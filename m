Return-Path: <linuxppc-dev+bounces-26029-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432B8C5DF87
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2026 10:57:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRHLg4mrTz2yK8;
	Fri, 21 Aug 2026 20:56:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787309819;
	cv=none; b=BpoXGy8l1iFR+JpohEJWPNfqDpkK2ltjmX+eZHQZ8mZ3XSQ/kHJ2w+T+svqktCWoncrQwNRYg2YZp0fXy8TeN3S1L89F8pHAiksXVDaLjFlEjqvLnUMuTWqZ1QgjfaivdziSUvUO7n9TuggDpjyOmpoMpx3w3G4VWFNn1Cu0wiCpXfgJHJdVnTBXjUWyZ0t/mFinpnG7HFUXdMuEKhvfahiQmtC5JSEL2OsemGdBUqVAiPLH67CPnaiLVW9sadhsUrGU3XlJd//IN7gS864F6m6+QpSz2kLRFss+cnyoS9+Ds7C2VjjW5zVsCti3I1IydzCnXCkAm0XxsxlR9g6TAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787309819; c=relaxed/relaxed;
	bh=+5biXI7Kp2tZqvlD1mk5h8DKWfP6jawz3pU35R20vGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A/j5RYL+RDFpN7RHECYAvh4xPcvxtp85eKGdh7rIh0nSdfY/cT3ZMR70iUq9OpCJeG2IGU87OCq467ElrEGzdxOGk0tkmDnOG5gbcdiE04Zb31Gx0yH4l6e8EQLoRYwtd6RpltyfwwajfvTbGeuB+jowku5UcGV4BBdoE75ADvFlrniLj6pXxb10Xa0JrPqPOUMcffWGgbgYg7NrnJVDfkOTTrnuy8aaN2jJnSTK4rD32RnncSZqGmtkWm3uyijVeXw2KZJPGbPrX6u/HBbvx+MelEZFoezBdfMdCnMmwkKM4Rk+4fPxWF/4Da3jGuJD8poKpbLqM4bvcuzmZ58xrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ERGb5wZH; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ERGb5wZH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRHLf5bTZz2yFY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2026 20:56:58 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9VfX91131344;
	Fri, 21 Aug 2026 10:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=+5biXI7Kp2tZqvlD1mk5h8DKWfP6jawz3pU35R20v
	Gg=; b=ERGb5wZHQKYnG/NUbGXWpdRYfmHHpEu/i7yZNNr395w74jxd49EbREaua
	X45MXPcNoa5/2kdj3EIu35mowKlmH7/15XP6BK4i+xBmQMwg7N7Xdl7YJgzwvGiF
	2VgHJ2uknk3CEWfmjKSlog2cYmSbru0EeDQI/Ik38IYzcRy3gY7nre5/A9FK2mlW
	4c10wlihFshk9780DlPOlG5S2LbL7vR5JiDfwhGbXHLR9s0fWIQmBgau1FZCqF9V
	bRB9fZNIMb7El0tKJg6XkfgRd5FC+UOf6cDENr06XzWWJvIVi57eCGkmqabDdKUj
	YJZ3pbrpUPWcObchf8frbd73GiDSg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4gne1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 10:56:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LAuOXC009426;
	Fri, 21 Aug 2026 10:56:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhm4p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 10:56:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LAuMHn39518718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 10:56:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E4352004D;
	Fri, 21 Aug 2026 10:56:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BA7220040;
	Fri, 21 Aug 2026 10:56:18 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 10:56:18 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>, Alexander Graf <graf@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Mike Rapoport <rppt@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] powerpc: initial support for Kexec HandOver (KHO)
Date: Fri, 21 Aug 2026 16:26:06 +0530
Message-ID: <20260821105609.983622-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
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
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a882edb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=vggBfdFIAAAA:8 a=Z4Rwk6OoAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=7ipKWUHlAAAA:8 a=JfrnYn6hAAAA:8
 a=itPyUPzOZQCiFHcQqVsA:9 a=HkZW87K1Qel5hWWM3VKY:22 a=gpc5p9EgBqZVLdJeV_V1:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: tBgUdosthgsI5jkqkI59kDQIsTYp6i8S
X-Proofpoint-GUID: kYZIQBmvG2oGwz1yYgI-96BusQj3Yuzy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA3OCBTYWx0ZWRfX5+DmDqg9LvvX
 lT6QS5/Ud5155aFWHfylCLDeWHFdHAi0i7zSayZYF0ygMAEKMK9iv511FiIlsIep0xd6K2yNDI/
 ZBjpkD31gOYUhDrPzoAvInfXZuaRUPU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA3OCBTYWx0ZWRfX5RvJ/H9s3RmN
 GbTxMJX/2kqIh+84r5Zxx17qqnTSj4iXSPwSbXhC0WproFwHOr+A56AGcqJ7K/xGsTgu1JOi2nv
 1BDjVUXhA0ApEp0MIcC5XdiOQbN0f93WjxsBzLRHt2MHDT/e9ZTqOcCjAeyptjpv5IlBC2rVzOo
 bhoSOW3+Z+vhty2GA3jQ2jLzWt9W5eb5DBA9eAI/9BzrJh4v3smM8l6KspN6rEJnvxvnmXxalwi
 jQ4CXo118VEBq/CProbt0sCTvQ4qkfzfJ5Q+mPGlPJKnl8GBhqnoZ46DQtqmmE9yi82anL7pADT
 Uzkvtxa98QEFrbA0cxFAm5rSNgUn/V3eNWfg/wIvI9aCycSuBs1PNbAYMK17wcWIm652KpV0KyT
 bjTEmrx3oY31V4hycV+3RPeFBzejOTTBiBRPOV3BMFAxIFqNm8iMZ3ywKIukznwq5nx3aUdGXUm
 M4P0x4Ey2wEWTcVBQBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210078

This series adds initial powerpc support for Kexec HandOver (KHO),
allowing state to be preserved across kexec on powerpc. Posting as RFC
because some of the patches are workarounds for issues I ran into, and
I'd like input on how best to address them.

Patch 1 is a small Kconfig fix needed to unblock patch 2. It won't be
needed once the ordering problem described under patch 2 is
addressed properly.

Patch 2 wires up ARCH_SUPPORTS_KEXEC_HANDOVER and adds the code to
retrieve the KHO FDT and scratch region from /chosen on boot. On
powerpc, crashkernel memory is reserved very early, from arch-specific
code, while KHO's scratch region is reserved later, from generic code
(kho_memory_init()). Crashkernel reservation always runs first, so by
the time KHO reserves its scratch region, not enough memory is left
and the reservation fails. Until scratch reservation can be moved
ahead of crashkernel reservation, this patch makes KHO and CRASH_DUMP
mutually exclusive on powerpc as a stopgap. The failure scenario and
the reasoning behind this restriction are described in the commit
message with an example.

Patch 3 excludes TRANSPARENT_HUGEPAGE and HUGETLB_PAGE from
ARCH_SUPPORTS_KEXEC_HANDOVER, since KHO's static_assert() on
SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES fails to build
when either is enabled -- pageblock_order isn't a compile-time
constant on powerpc in that configuration.

With all three patches applied, CONFIG_TEST_KEXEC_HANDOVER passes on
powerpc.

Open questions I'd appreciate feedback on:

 - How should KHO scratch reservation and powerpc's crashkernel
   reservation be ordered so both can be enabled together, given that
   scratch reservation currently happens in generic code
   (kho_memory_init())?

- Excluding THP/HUGETLB_PAGE is a workaround for the build failure.
  Looking for input on how to handle CMA_MIN_ALIGNMENT_BYTES when
  pageblock_order is non-constant.

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Sourabh Jain (3):
  kernel/liveupdate: make KEXEC_HANDOVER depend on KEXEC_FILE instead of
    selecting it
  powerpc: add support for Kexec HandOver (KHO)
  powerpc/kho: exclude THP and HUGETLB_PAGE

 arch/powerpc/Kconfig               |  6 ++++++
 arch/powerpc/kernel/setup-common.c | 33 ++++++++++++++++++++++++++++++
 kernel/liveupdate/Kconfig          |  2 +-
 3 files changed, 40 insertions(+), 1 deletion(-)

-- 
2.55.0


