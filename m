Return-Path: <linuxppc-dev+bounces-21873-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF68CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 10:06:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV61T4MzKz2xdh;
	Tue, 02 Jun 2026 20:06:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780382960;
	cv=none; b=RaNLCLm4V0LKTVAK6IGFRoUGRDZs0O3kPnXhba9upg99xmc/F1TTUs0k17m12eY267KkCczdpZEVsrQVyIMagEyGkzywwmlS2IhcTJZITO0TjbHJ2WjlzxxZDtAwdXBw/5MOuL1g8fBZP4SajwsLKAwnZ1JzHWPUPlRXxKErMjcOMkHxOUqsdCRCNOmGD53HY2IoKAaV7LzGP8kj1gJvToD205Z5HwGtnwoNtd/2y7gyi6rIGOJ4bEb7Li1czIO5I2dJhYb2Vhn7scKP5wI66WxnTU+mudqVRFNW95Rqn8aSnyM83PRgW4Cu+Mb5wX+13JoB3LYtrgdVsQQ+GDR3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780382960; c=relaxed/relaxed;
	bh=nUllYI5+u3HeXtulknHhHmjqWBUkNFjskMIsZgKZ/x4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zpom7fBM3ypqEMWm95WfCLDHMPfi5k2ZEoD1mUbSWaXbRxKcU7hH3vJH1k0lRHsAi106N11AVFYeh4cWjo9F+AgRVvoo/h90yOM1AdL7ioSz47pnNotqL0hAKQyHJNvVLHJF8pJov13ZMpMeGoIsNrBwb4JLU8OwMR74V0/vZA6DS9d38FTKZmFF/FkKxzHaPviPdHWVJ/2fbQF3YpdZ4grkSFyErBS25gJXHVXx+FQi0A25UPtyt6ATcFqup+Gf9JiaWBWfnnFFR4L7ouOe/oq29KNoRRSrPrJ/TSAGjQcsjR1Acenr9wPoSiZBA4Dch7RrpeQERAzrI1XwOshFBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AH5mQ3mC; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AH5mQ3mC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV1dp24qSz2xmX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 16:49:18 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65267poZ2350781;
	Tue, 2 Jun 2026 06:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=nUllYI5+u3HeXtulknHhHmjqWBUkNFjskMIsZgKZ/
	x4=; b=AH5mQ3mCt6OsBP84h+jvGJfQUXIa1M6frpuErQ4Ws1tXI96tlQFn3EFJp
	6E2JixoPae91cW+J0MNVtRxKXkgVAMPiHbGdCmPf0taQTvMyGnvbKJSnsPpd0Lo1
	807yiRqSpkvAW5QL7ykJjqYQA1Ds+J2/YQIZ4xsVYXcxMLDp/8kfsVSJb09VvPYu
	dehXB1bN0bL1i9mfCljINmQPcuKch++eJalNxgQO6WEPqk6w9DHiJxFZWAL++CvO
	u1x6VCHUVLeuWv+eDgbmombYTEBgiGvJiEPDudEVz4NbhcCp/iQIaWCUtpzsrQt9
	PF7o21MCqZ7yq33yfsXwQn9tFnpCQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjq4jqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 06:48:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6526d7ba025968;
	Tue, 2 Jun 2026 06:48:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k1ys0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 06:48:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6526mmWC53477882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 06:48:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 035FE20040;
	Tue,  2 Jun 2026 06:48:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B89D820043;
	Tue,  2 Jun 2026 06:48:45 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.bl1-in.ibm.com (unknown [9.123.8.229])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 06:48:45 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: thuth@redhat.com
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        andrew.jones@linux.dev, sbhat@linux.ibm.com,
        Chinmay Rath <rathc@linux.ibm.com>
Subject: [kvm-unit-tests RFC PATCH 0/6] powerpc improvements
Date: Tue,  2 Jun 2026 12:18:00 +0530
Message-ID: <20260602064806.3101025-1-rathc@linux.ibm.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: wUfB_RCcDuF4y7uG61ORgGqGvmrK8zmk
X-Proofpoint-GUID: 81j_6oimU7ikccdZb6vnzd65XkAyQKly
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a1e7cd5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=p0WdMEafAAAA:8
 a=lf-NayToshnA3N9Pp-kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA1OSBTYWx0ZWRfXwtkoaVEqyeCt
 BqqNYLV6fwgWQyFjWuc6iRt7rFwmMY4qVqDovxPt/dm9xOSibdJJDpATiqsykccrjxrkLAuiNsf
 WXyZZRd1cS/XDxtsR6HvFXbfL7ZgfEPoRH2P7vSHF2YV1XEZXmgR4RASTdNbUSQMq8DMfXnI77j
 aYk4nEpS7fUUZz9Lo84NBJuSrVTswtBH8kAUdLSOG/KlEEaC3GvRnK4Ic2ChnAAtdnYdS+f0jEw
 75EUJKzK6bJJlcx0J6RZyt2uwf1Y9ASUCc4Sa4Jx/cr+x1OGsvgq/7hGfVj9pyi6OmPrfAaqq9d
 wgCIj0d6NOhPZiHqF86JiI3jZIhIE+6paoZvIDQksPtnDmje6oQpaZ+D71umjq9vBRtWxsKkzkD
 Z7NbsATMiAXRgve6AnoM4qT/OaOuMYoOOow/QPpclZwsm/YytjgalLZOYRHiBI7bnS3YiycTxbU
 K63LumgmvvCEK6D41sA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020059

This series aims to add a couple of new powerpc tests and improve the
powerpc build structure.

This is originally Nick's work. The last version (v10) of which can be seen here :
https://lore.kernel.org/linuxppc-dev/20240612052322.218726-1-npiggin@gmail.com/

Since it has been 2 years since this series was posted, I am now
posting it as a RFC. Couple of patches from the series were already merged.
Posting the rest.

I have rebased the patches to the upstream state.
For the patches which did not require any changes in the existing upstream code,
I have retained the "Reviewed-by"s and "Acked-by" (patch 3,5 & 6), and have
removed the same for the ones which required changes in the existing upstream
code during rebase (patch 2). Nick had originally introduced powernv tests as well.
Removed it for now since it was causing CI failure in the current upstream.

Link to Gitlab tree with patches :
https://gitlab.com/rathc/kvm-unit-tests/-/tree/ppc64
Link to Gitlab pipeline :
https://gitlab.com/rathc/kvm-unit-tests/-/pipelines/2569132740
Please note that the build-centos8 test is failing due to a recent
upstream change unrelated to this patch series.

Nicholas Piggin (6):
  powerpc: add pmu tests
  configure: Make arch_libdir a first-class entity
  powerpc: Remove remnants of ppc64 directory and build structure
  powerpc: gitlab CI update
  scripts/arch-run.bash: Fix run_panic() success exit status
  powerpc: Add a panic test

 .gitlab-ci.yml                             |  53 +-
 MAINTAINERS                                |   1 -
 Makefile                                   |   2 +-
 configure                                  |  21 +-
 lib/{ppc64 => powerpc}/asm-offsets.c       |   0
 lib/{ppc64 => powerpc}/asm/asm-offsets.h   |   0
 lib/{ppc64 => powerpc}/asm/atomic.h        |   0
 lib/{ppc64 => powerpc}/asm/barrier.h       |   4 +-
 lib/{ppc64 => powerpc}/asm/bitops.h        |   4 +-
 lib/{ppc64 => powerpc}/asm/io.h            |   4 +-
 lib/{ppc64 => powerpc}/asm/mmu.h           |   0
 lib/{ppc64 => powerpc}/asm/opal.h          |   4 +-
 lib/{ppc64 => powerpc}/asm/page.h          |   6 +-
 lib/{ppc64 => powerpc}/asm/pgtable-hwdef.h |   6 +-
 lib/{ppc64 => powerpc}/asm/pgtable.h       |   2 +-
 lib/powerpc/asm/processor.h                |   2 +
 lib/{ppc64 => powerpc}/asm/ptrace.h        |   6 +-
 lib/powerpc/asm/reg.h                      |   9 +
 lib/powerpc/asm/rtas.h                     |   1 +
 lib/powerpc/asm/setup.h                    |   1 +
 lib/powerpc/asm/spinlock.h                 |   6 +
 lib/powerpc/asm/stack.h                    |   3 +
 lib/{ppc64 => powerpc}/asm/vpa.h           |   0
 lib/{ppc64 => powerpc}/mmu.c               |   0
 lib/{ppc64 => powerpc}/opal-calls.S        |   0
 lib/{ppc64 => powerpc}/opal.c              |   0
 lib/powerpc/rtas.c                         |  16 +
 lib/powerpc/setup.c                        |  20 +
 lib/{ppc64 => powerpc}/stack.c             |   0
 lib/ppc64/.gitignore                       |   1 -
 lib/ppc64/asm/handlers.h                   |   1 -
 lib/ppc64/asm/hcall.h                      |   1 -
 lib/ppc64/asm/memory_areas.h               |   6 -
 lib/ppc64/asm/ppc_asm.h                    |   1 -
 lib/ppc64/asm/processor.h                  |   1 -
 lib/ppc64/asm/reg.h                        |   1 -
 lib/ppc64/asm/rtas.h                       |   1 -
 lib/ppc64/asm/setup.h                      |   1 -
 lib/ppc64/asm/smp.h                        |   1 -
 lib/ppc64/asm/spinlock.h                   |   6 -
 lib/ppc64/asm/stack.h                      |  11 -
 lib/ppc64/asm/time.h                       |   1 -
 powerpc/Makefile                           | 111 +++-
 powerpc/Makefile.common                    |  94 ----
 powerpc/Makefile.ppc64                     |  31 --
 powerpc/pmu.c                              | 567 +++++++++++++++++++++
 powerpc/run                                |   2 +-
 powerpc/selftest.c                         |  17 +-
 powerpc/unittests.cfg                      |  44 +-
 scripts/arch-run.bash                      |   1 +
 50 files changed, 830 insertions(+), 241 deletions(-)
 rename lib/{ppc64 => powerpc}/asm-offsets.c (100%)
 rename lib/{ppc64 => powerpc}/asm/asm-offsets.h (100%)
 rename lib/{ppc64 => powerpc}/asm/atomic.h (100%)
 rename lib/{ppc64 => powerpc}/asm/barrier.h (83%)
 rename lib/{ppc64 => powerpc}/asm/bitops.h (69%)
 rename lib/{ppc64 => powerpc}/asm/io.h (50%)
 rename lib/{ppc64 => powerpc}/asm/mmu.h (100%)
 rename lib/{ppc64 => powerpc}/asm/opal.h (90%)
 rename lib/{ppc64 => powerpc}/asm/page.h (94%)
 rename lib/{ppc64 => powerpc}/asm/pgtable-hwdef.h (93%)
 rename lib/{ppc64 => powerpc}/asm/pgtable.h (99%)
 rename lib/{ppc64 => powerpc}/asm/ptrace.h (89%)
 create mode 100644 lib/powerpc/asm/spinlock.h
 rename lib/{ppc64 => powerpc}/asm/vpa.h (100%)
 rename lib/{ppc64 => powerpc}/mmu.c (100%)
 rename lib/{ppc64 => powerpc}/opal-calls.S (100%)
 rename lib/{ppc64 => powerpc}/opal.c (100%)
 rename lib/{ppc64 => powerpc}/stack.c (100%)
 delete mode 100644 lib/ppc64/.gitignore
 delete mode 100644 lib/ppc64/asm/handlers.h
 delete mode 100644 lib/ppc64/asm/hcall.h
 delete mode 100644 lib/ppc64/asm/memory_areas.h
 delete mode 100644 lib/ppc64/asm/ppc_asm.h
 delete mode 100644 lib/ppc64/asm/processor.h
 delete mode 100644 lib/ppc64/asm/reg.h
 delete mode 100644 lib/ppc64/asm/rtas.h
 delete mode 100644 lib/ppc64/asm/setup.h
 delete mode 100644 lib/ppc64/asm/smp.h
 delete mode 100644 lib/ppc64/asm/spinlock.h
 delete mode 100644 lib/ppc64/asm/stack.h
 delete mode 100644 lib/ppc64/asm/time.h
 delete mode 100644 powerpc/Makefile.common
 delete mode 100644 powerpc/Makefile.ppc64
 create mode 100644 powerpc/pmu.c

-- 
2.53.0


