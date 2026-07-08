Return-Path: <linuxppc-dev+bounces-23810-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12736C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 10:52:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwFKL4QGVz2yft;
	Wed, 08 Jul 2026 20:52:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783507926;
	cv=none; b=dMNP4tSEUaatzgTc3NnHlCR/n5tp5jSDn2m9MkDBr38MQn99w7wd1kGItpnLdPVAlnwfceMQLhhSC03N5DcWF8LAG9JHVybE5eFQIurLc7J35KN0OYimaRpclo+wje4PHAMzNolNiY1JMrkFdU7FBsP0rGLq9N4EGaj7gI12iqcdS2w/XX60GrPafMcLDE99PQuf6p8QxTnD9XAbJivy0UTbkcJjZwm77ekWZWuj5s2h3k3X+XFxBhQIOL7Rx+EKPtF3crUA0PXGuLHe+yyFFC/CmIKR5nd5qQupboSzIR8haJd6A948Xq5AiASeFvUnKZiva6Ew9NFzCuJVgZCx0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783507926; c=relaxed/relaxed;
	bh=m98+91nLrm+JwEABuVAIx0eQc9cNiKKAlM1GtDxEC4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COcP2J12yy8IGlT7VRnFGLJIDmRVL6j7Z8i3pSzUk3oJFdv1ZqBOmKVboUPb3f333G2kbh8azOitWp2epATiK3Du65exWQLJmUbTROpahOz8OflHinjAHf81WvCeyn1pbSu+f5kqwbCEIRemd3XRIubj2J7pObN78SuOr8R9gZlm03/kLzoE9cj/qIW+/MgJf2iuj9BSv55CjyPcZvjGkcHnsYBxLxcnZr8weQoJgwMf0eCmZqTAHK2Aj4CnZUd3XkglxBi1TbAq+UXqDM715qTuvE/LNmkrW4O7uFwvyWnGuyXnGSLIHpQyHtv1nVOEI6ksdYRSkNHr8ZFMD+/spg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GlbahiSU; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GlbahiSU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwFKK2qFCz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 20:52:05 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6688II1j3243561;
	Wed, 8 Jul 2026 10:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=m98+91nLrm+JwEABu
	VAIx0eQc9cNiKKAlM1GtDxEC4w=; b=GlbahiSUiIrxecxlpmgNBmEkfR0BKgjj0
	IcdDztRt1DtP42QWyA5R/Bg9ym2IbynyMJ0PRAB/OUJr92creEZ8JZEroLCLxmz7
	0PeadKL4tsl2mn/ifK7DHvwQTyGwJRWr1tUaoVf6IPhbnAf0otMWF1zei11B/KEl
	ICVw5/ZPxNFcpQkbZmtiQwXEUrxQPWko/nK/0Ptl1UfQlQw+eSHI7Jvn4fEWuxA6
	zyetHP1L3J7TQcMAOWstuEo6fxAGqZcEY1Sadptz1k7jdgOIImwJg5kEy1M5OPLQ
	y6giVDg+2VyX8NoAggdJ0AHF0gaqQzBsYkrGs2GI1VdycLXbP1X5Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suquqj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 10:52:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668Anid8005866;
	Wed, 8 Jul 2026 10:51:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hfhq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 10:51:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 668Aptjr61014518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 10:51:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 543BC20040;
	Wed,  8 Jul 2026 10:51:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B24372004B;
	Wed,  8 Jul 2026 10:51:51 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown [9.39.26.49])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jul 2026 10:51:51 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: thuth@redhat.com
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        andrew.jones@linux.dev, sbhat@linux.ibm.com,
        Chinmay Rath <rathc@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 3/6] powerpc: Remove remnants of ppc64 directory and build structure
Date: Wed,  8 Jul 2026 16:21:19 +0530
Message-ID: <20260708105122.1177210-4-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708105122.1177210-1-rathc@linux.ibm.com>
References: <20260708105122.1177210-1-rathc@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEwNSBTYWx0ZWRfX/mPM9A0PXcLL
 zzHAmUniV4cuCUwEevBqTZNEAsUILSOr+mikylWJxg0YKkujzDnx8uCX9EmmtfPpS88Vr1uxo8Z
 A7u662J94lsxwoDDpi7belyFCkkpKhE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEwNSBTYWx0ZWRfX6qilRgo2Tbzg
 mcMfBcXtDZIaylUkK/3pVUaw1PaBtUo2dQytr2mJkSwI+qHbKh+w6OjmqjTKkh3Mb968i+Y24+W
 khXYjH+0OyGhTKpMzRMNu/RbOA9EOvQVf9U5/xB/9HJIR4QiTp0X2mnHONaXCTBHhuE1oYtuaNG
 bZ10hwbgec/wlQj70jSTzIe3+HHea3pA8pitpFwAmTHYl4YQX6qDEwxnaEvCl8bvXGl49946JBk
 fsyUIYGqKXz8V6L4eqGR81s4YwWknytW+b3VAIGEXV8m6CKeODdEzYvGJnXsoXH2tYWbCHIxWIb
 OR9nE2vKNdhQ8DQ/UR3pKH7WmMJDFZD41i4k69/1EWJghsNjGMarMK3bjraplGe3noFt+snegqQ
 7BYwddUd/JFhhh4hqzzl/6LWopwVs8N/ADqv+Ddr/ql7yVtvbxFfdA0fzuVFYWkEnc7+aOia8EU
 o/CFvt4F9eXIqdIUrOw==
X-Proofpoint-GUID: 4Tvno41gWX4Umcdjg-sQS2VrIc-drXVA
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4e2bd0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=voM4FWlXAAAA:8 a=kYg7tm8ngJF9dZZkgQIA:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-ORIG-GUID: zAnCXGqOMU17YguwfDxQBzwRJ4kufPT8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080105

From: Nicholas Piggin <npiggin@gmail.com>

This moves merges ppc64 directories and files into powerpc, and
merges the 3 makefiles into one.

The configure --arch=powerpc option is aliased to ppc64 for
good measure.

Acked-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 MAINTAINERS                                |   1 -
 configure                                  |   3 +-
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
 lib/{ppc64 => powerpc}/asm/ptrace.h        |   6 +-
 lib/powerpc/asm/spinlock.h                 |   6 ++
 lib/powerpc/asm/stack.h                    |   3 +
 lib/{ppc64 => powerpc}/asm/vpa.h           |   0
 lib/{ppc64 => powerpc}/mmu.c               |   0
 lib/{ppc64 => powerpc}/opal-calls.S        |   0
 lib/{ppc64 => powerpc}/opal.c              |   0
 lib/{ppc64 => powerpc}/stack.c             |   0
 lib/ppc64/.gitignore                       |   1 -
 lib/ppc64/asm/handlers.h                   |   1 -
 lib/ppc64/asm/hcall.h                      |   1 -
 lib/ppc64/asm/memory_areas.h               |   6 --
 lib/ppc64/asm/ppc_asm.h                    |   1 -
 lib/ppc64/asm/processor.h                  |   1 -
 lib/ppc64/asm/reg.h                        |   1 -
 lib/ppc64/asm/rtas.h                       |   1 -
 lib/ppc64/asm/setup.h                      |   1 -
 lib/ppc64/asm/smp.h                        |   1 -
 lib/ppc64/asm/spinlock.h                   |   6 --
 lib/ppc64/asm/stack.h                      |  11 --
 lib/ppc64/asm/time.h                       |   1 -
 powerpc/Makefile                           | 111 ++++++++++++++++++++-
 powerpc/Makefile.common                    |  95 ------------------
 powerpc/Makefile.ppc64                     |  31 ------
 37 files changed, 139 insertions(+), 180 deletions(-)
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

diff --git a/MAINTAINERS b/MAINTAINERS
index b5562e99..00d7d90b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -92,7 +92,6 @@ S: Maintained
 L: linuxppc-dev@lists.ozlabs.org
 F: powerpc/
 F: lib/powerpc/
-F: lib/ppc64/
 
 RISCV
 M: Andrew Jones <andrew.jones@linux.dev>
diff --git a/configure b/configure
index aeb5570c..974ef4b4 100755
--- a/configure
+++ b/configure
@@ -273,6 +273,7 @@ fi
 
 arch_name=$arch
 [ "$arch" = "aarch64" ] && arch="arm64"
+[ "$arch" = "powerpc" ] && arch="ppc64"
 [ "$arch_name" = "arm64" ] && arch_name="aarch64"
 
 if [ "$arch" = "riscv" ]; then
@@ -386,7 +387,7 @@ elif [ "$arch" = "arm" ] || [ "$arch" = "arm64" ]; then
     fi
 elif [ "$arch" = "ppc64" ]; then
     testdir=powerpc
-    arch_libdir=ppc64
+    arch_libdir=powerpc
     firmware="$testdir/boot_rom.bin"
     if [ "$endian" != "little" ] && [ "$endian" != "big" ]; then
         echo "You must provide endianness (big or little)!"
diff --git a/lib/ppc64/asm-offsets.c b/lib/powerpc/asm-offsets.c
similarity index 100%
rename from lib/ppc64/asm-offsets.c
rename to lib/powerpc/asm-offsets.c
diff --git a/lib/ppc64/asm/asm-offsets.h b/lib/powerpc/asm/asm-offsets.h
similarity index 100%
rename from lib/ppc64/asm/asm-offsets.h
rename to lib/powerpc/asm/asm-offsets.h
diff --git a/lib/ppc64/asm/atomic.h b/lib/powerpc/asm/atomic.h
similarity index 100%
rename from lib/ppc64/asm/atomic.h
rename to lib/powerpc/asm/atomic.h
diff --git a/lib/ppc64/asm/barrier.h b/lib/powerpc/asm/barrier.h
similarity index 83%
rename from lib/ppc64/asm/barrier.h
rename to lib/powerpc/asm/barrier.h
index 475434b6..22349d69 100644
--- a/lib/ppc64/asm/barrier.h
+++ b/lib/powerpc/asm/barrier.h
@@ -1,5 +1,5 @@
-#ifndef _ASMPPC64_BARRIER_H_
-#define _ASMPPC64_BARRIER_H_
+#ifndef _ASMPOWERPC_BARRIER_H_
+#define _ASMPOWERPC_BARRIER_H_
 
 #define cpu_relax() asm volatile("or 1,1,1 ; or 2,2,2" ::: "memory")
 #define pause_short() asm volatile(".long 0x7c40003c" ::: "memory")
diff --git a/lib/ppc64/asm/bitops.h b/lib/powerpc/asm/bitops.h
similarity index 69%
rename from lib/ppc64/asm/bitops.h
rename to lib/powerpc/asm/bitops.h
index c93d64bb..dc1b8cd3 100644
--- a/lib/ppc64/asm/bitops.h
+++ b/lib/powerpc/asm/bitops.h
@@ -1,5 +1,5 @@
-#ifndef _ASMPPC64_BITOPS_H_
-#define _ASMPPC64_BITOPS_H_
+#ifndef _ASMPOWERPC_BITOPS_H_
+#define _ASMPOWERPC_BITOPS_H_
 
 #ifndef _BITOPS_H_
 #error only <bitops.h> can be included directly
diff --git a/lib/ppc64/asm/io.h b/lib/powerpc/asm/io.h
similarity index 50%
rename from lib/ppc64/asm/io.h
rename to lib/powerpc/asm/io.h
index 08d7297c..cfe099f0 100644
--- a/lib/ppc64/asm/io.h
+++ b/lib/powerpc/asm/io.h
@@ -1,5 +1,5 @@
-#ifndef _ASMPPC64_IO_H_
-#define _ASMPPC64_IO_H_
+#ifndef _ASMPOWERPC_IO_H_
+#define _ASMPOWERPC_IO_H_
 
 #define __iomem
 
diff --git a/lib/ppc64/asm/mmu.h b/lib/powerpc/asm/mmu.h
similarity index 100%
rename from lib/ppc64/asm/mmu.h
rename to lib/powerpc/asm/mmu.h
diff --git a/lib/ppc64/asm/opal.h b/lib/powerpc/asm/opal.h
similarity index 90%
rename from lib/ppc64/asm/opal.h
rename to lib/powerpc/asm/opal.h
index 6c3e9ffe..44e62d80 100644
--- a/lib/ppc64/asm/opal.h
+++ b/lib/powerpc/asm/opal.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-#ifndef _ASMPPC64_OPAL_H_
-#define _ASMPPC64_OPAL_H_
+#ifndef _ASMPOWERPC_OPAL_H_
+#define _ASMPOWERPC_OPAL_H_
 
 #include <stdint.h>
 
diff --git a/lib/ppc64/asm/page.h b/lib/powerpc/asm/page.h
similarity index 94%
rename from lib/ppc64/asm/page.h
rename to lib/powerpc/asm/page.h
index 4a7ac9ec..21886c32 100644
--- a/lib/ppc64/asm/page.h
+++ b/lib/powerpc/asm/page.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-#ifndef _ASMPPC64_PAGE_H_
-#define _ASMPPC64_PAGE_H_
+#ifndef _ASMPOWERPC_PAGE_H_
+#define _ASMPOWERPC_PAGE_H_
 /*
  * Adapted from
  *   lib/arm64/asm/page.h and Linux kernel defines.
@@ -62,4 +62,4 @@ extern unsigned long __phys_to_virt(phys_addr_t addr);
 extern void *__ioremap(phys_addr_t phys_addr, size_t size);
 
 #endif /* !__ASSEMBLER__ */
-#endif /* _ASMPPC64_PAGE_H_ */
+#endif /* _ASMPOWERPC_PAGE_H_ */
diff --git a/lib/ppc64/asm/pgtable-hwdef.h b/lib/powerpc/asm/pgtable-hwdef.h
similarity index 93%
rename from lib/ppc64/asm/pgtable-hwdef.h
rename to lib/powerpc/asm/pgtable-hwdef.h
index 0f4b1068..3f8c6fe3 100644
--- a/lib/ppc64/asm/pgtable-hwdef.h
+++ b/lib/powerpc/asm/pgtable-hwdef.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-#ifndef _ASMPPC64_PGTABLE_HWDEF_H_
-#define _ASMPPC64_PGTABLE_HWDEF_H_
+#ifndef _ASMPOWERPC_PGTABLE_HWDEF_H_
+#define _ASMPOWERPC_PGTABLE_HWDEF_H_
 /*
  * Copyright (C) 2024, IBM Inc, Nicholas Piggin <npiggin@gmail.com>
  *
@@ -63,4 +63,4 @@
 #define PHYS_MASK_SHIFT		(48)
 #define PHYS_MASK		((UL(1) << PHYS_MASK_SHIFT) - 1)
 
-#endif /* _ASMPPC64_PGTABLE_HWDEF_H_ */
+#endif /* _ASMPOWERPC_PGTABLE_HWDEF_H_ */
diff --git a/lib/ppc64/asm/pgtable.h b/lib/powerpc/asm/pgtable.h
similarity index 99%
rename from lib/ppc64/asm/pgtable.h
rename to lib/powerpc/asm/pgtable.h
index a6ee0d4c..d4f2c826 100644
--- a/lib/ppc64/asm/pgtable.h
+++ b/lib/powerpc/asm/pgtable.h
@@ -122,4 +122,4 @@ static inline pte_t *pte_alloc(pmd_t *pmd, unsigned long addr)
 	return pte_offset(pmd, addr);
 }
 
-#endif /* _ASMPPC64_PGTABLE_H_ */
+#endif /* _ASMPOWERPC_PGTABLE_H_ */
diff --git a/lib/ppc64/asm/ptrace.h b/lib/powerpc/asm/ptrace.h
similarity index 89%
rename from lib/ppc64/asm/ptrace.h
rename to lib/powerpc/asm/ptrace.h
index 133ad2f9..4d5fc59c 100644
--- a/lib/ppc64/asm/ptrace.h
+++ b/lib/powerpc/asm/ptrace.h
@@ -1,5 +1,5 @@
-#ifndef _ASMPPC64_PTRACE_H_
-#define _ASMPPC64_PTRACE_H_
+#ifndef _ASMPOWERPC_PTRACE_H_
+#define _ASMPOWERPC_PTRACE_H_
 
 #define KERNEL_REDZONE_SIZE	288
 #define STACK_FRAME_OVERHEAD    112     /* size of minimum stack frame */
@@ -38,4 +38,4 @@ static inline void regs_advance_insn(struct pt_regs *regs)
 
 #endif /* __ASSEMBLER__ */
 
-#endif /* _ASMPPC64_PTRACE_H_ */
+#endif /* _ASMPOWERPC_PTRACE_H_ */
diff --git a/lib/powerpc/asm/spinlock.h b/lib/powerpc/asm/spinlock.h
new file mode 100644
index 00000000..da259ff4
--- /dev/null
+++ b/lib/powerpc/asm/spinlock.h
@@ -0,0 +1,6 @@
+#ifndef _ASMPOWERPC_SPINLOCK_H_
+#define _ASMPOWERPC_SPINLOCK_H_
+
+#include <asm-generic/spinlock.h>
+
+#endif /* _ASMPOWERPC_SPINLOCK_H_ */
diff --git a/lib/powerpc/asm/stack.h b/lib/powerpc/asm/stack.h
index e1c46ee0..eea139a4 100644
--- a/lib/powerpc/asm/stack.h
+++ b/lib/powerpc/asm/stack.h
@@ -5,4 +5,7 @@
 #error Do not directly include <asm/stack.h>. Just use <stack.h>.
 #endif
 
+#define HAVE_ARCH_BACKTRACE
+#define HAVE_ARCH_BACKTRACE_FRAME
+
 #endif
diff --git a/lib/ppc64/asm/vpa.h b/lib/powerpc/asm/vpa.h
similarity index 100%
rename from lib/ppc64/asm/vpa.h
rename to lib/powerpc/asm/vpa.h
diff --git a/lib/ppc64/mmu.c b/lib/powerpc/mmu.c
similarity index 100%
rename from lib/ppc64/mmu.c
rename to lib/powerpc/mmu.c
diff --git a/lib/ppc64/opal-calls.S b/lib/powerpc/opal-calls.S
similarity index 100%
rename from lib/ppc64/opal-calls.S
rename to lib/powerpc/opal-calls.S
diff --git a/lib/ppc64/opal.c b/lib/powerpc/opal.c
similarity index 100%
rename from lib/ppc64/opal.c
rename to lib/powerpc/opal.c
diff --git a/lib/ppc64/stack.c b/lib/powerpc/stack.c
similarity index 100%
rename from lib/ppc64/stack.c
rename to lib/powerpc/stack.c
diff --git a/lib/ppc64/.gitignore b/lib/ppc64/.gitignore
deleted file mode 100644
index 84872bf1..00000000
--- a/lib/ppc64/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-asm-offsets.[hs]
diff --git a/lib/ppc64/asm/handlers.h b/lib/ppc64/asm/handlers.h
deleted file mode 100644
index 92e6fb24..00000000
--- a/lib/ppc64/asm/handlers.h
+++ /dev/null
@@ -1 +0,0 @@
-#include "../../powerpc/asm/handlers.h"
diff --git a/lib/ppc64/asm/hcall.h b/lib/ppc64/asm/hcall.h
deleted file mode 100644
index daabaca5..00000000
--- a/lib/ppc64/asm/hcall.h
+++ /dev/null
@@ -1 +0,0 @@
-#include "../../powerpc/asm/hcall.h"
diff --git a/lib/ppc64/asm/memory_areas.h b/lib/ppc64/asm/memory_areas.h
deleted file mode 100644
index b9fd46b9..00000000
--- a/lib/ppc64/asm/memory_areas.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _ASMPPC64_MEMORY_AREAS_H_
-#define _ASMPPC64_MEMORY_AREAS_H_
-
-#include <asm-generic/memory_areas.h>
-
-#endif
diff --git a/lib/ppc64/asm/ppc_asm.h b/lib/ppc64/asm/ppc_asm.h
deleted file mode 100644
index e3929eee..00000000
--- a/lib/ppc64/asm/ppc_asm.h
+++ /dev/null
@@ -1 +0,0 @@
-#include "../../powerpc/asm/ppc_asm.h"
diff --git a/lib/ppc64/asm/processor.h b/lib/ppc64/asm/processor.h
deleted file mode 100644
index 066a51a0..00000000
--- a/lib/ppc64/asm/processor.h
+++ /dev/null
@@ -1 +0,0 @@
-#include "../../powerpc/asm/processor.h"
diff --git a/lib/ppc64/asm/reg.h b/lib/ppc64/asm/reg.h
deleted file mode 100644
index bc407b55..00000000
--- a/lib/ppc64/asm/reg.h
+++ /dev/null
@@ -1 +0,0 @@
-#include "../../powerpc/asm/reg.h"
diff --git a/lib/ppc64/asm/rtas.h b/lib/ppc64/asm/rtas.h
deleted file mode 100644
index fe77f635..00000000
--- a/lib/ppc64/asm/rtas.h
+++ /dev/null
@@ -1 +0,0 @@
-#include "../../powerpc/asm/rtas.h"
diff --git a/lib/ppc64/asm/setup.h b/lib/ppc64/asm/setup.h
deleted file mode 100644
index 20192985..00000000
--- a/lib/ppc64/asm/setup.h
+++ /dev/null
@@ -1 +0,0 @@
-#include "../../powerpc/asm/setup.h"
diff --git a/lib/ppc64/asm/smp.h b/lib/ppc64/asm/smp.h
deleted file mode 100644
index 67ced756..00000000
--- a/lib/ppc64/asm/smp.h
+++ /dev/null
@@ -1 +0,0 @@
-#include "../../powerpc/asm/smp.h"
diff --git a/lib/ppc64/asm/spinlock.h b/lib/ppc64/asm/spinlock.h
deleted file mode 100644
index f59eed19..00000000
--- a/lib/ppc64/asm/spinlock.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _ASMPPC64_SPINLOCK_H_
-#define _ASMPPC64_SPINLOCK_H_
-
-#include <asm-generic/spinlock.h>
-
-#endif /* _ASMPPC64_SPINLOCK_H_ */
diff --git a/lib/ppc64/asm/stack.h b/lib/ppc64/asm/stack.h
deleted file mode 100644
index 94fd1021..00000000
--- a/lib/ppc64/asm/stack.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef _ASMPPC64_STACK_H_
-#define _ASMPPC64_STACK_H_
-
-#ifndef _STACK_H_
-#error Do not directly include <asm/stack.h>. Just use <stack.h>.
-#endif
-
-#define HAVE_ARCH_BACKTRACE
-#define HAVE_ARCH_BACKTRACE_FRAME
-
-#endif
diff --git a/lib/ppc64/asm/time.h b/lib/ppc64/asm/time.h
deleted file mode 100644
index 326d2887..00000000
--- a/lib/ppc64/asm/time.h
+++ /dev/null
@@ -1 +0,0 @@
-#include "../../powerpc/asm/time.h"
diff --git a/powerpc/Makefile b/powerpc/Makefile
index 8a007ab5..41e752b0 100644
--- a/powerpc/Makefile
+++ b/powerpc/Makefile
@@ -1 +1,110 @@
-include $(SRCDIR)/$(TEST_DIR)/Makefile.$(ARCH)
+#
+# powerpc makefile
+#
+# Authors: Andrew Jones <drjones@redhat.com>
+#
+tests = \
+	$(TEST_DIR)/selftest.elf \
+	$(TEST_DIR)/selftest-migration.elf \
+	$(TEST_DIR)/memory-verify.elf \
+	$(TEST_DIR)/sieve.elf \
+	$(TEST_DIR)/spapr_vpa.elf \
+	$(TEST_DIR)/spapr_hcall.elf \
+	$(TEST_DIR)/rtas.elf \
+	$(TEST_DIR)/emulator.elf \
+	$(TEST_DIR)/atomics.elf \
+	$(TEST_DIR)/tm.elf \
+	$(TEST_DIR)/smp.elf \
+	$(TEST_DIR)/sprs.elf \
+	$(TEST_DIR)/timebase.elf \
+	$(TEST_DIR)/interrupts.elf \
+	$(TEST_DIR)/mmu.elf \
+	$(TEST_DIR)/pmu.elf
+
+all: directories $(TEST_DIR)/boot_rom.bin $(tests)
+
+cstart.o = $(TEST_DIR)/cstart64.o
+reloc.o  = $(TEST_DIR)/reloc64.o
+
+OBJDIRS += lib/powerpc
+cflatobjs += lib/powerpc/stack.o
+cflatobjs += lib/powerpc/mmu.o
+cflatobjs += lib/powerpc/opal.o
+cflatobjs += lib/powerpc/opal-calls.o
+cflatobjs += lib/util.o
+cflatobjs += lib/getchar.o
+cflatobjs += lib/alloc_phys.o
+cflatobjs += lib/alloc.o
+cflatobjs += lib/alloc_page.o
+cflatobjs += lib/vmalloc.o
+cflatobjs += lib/devicetree.o
+cflatobjs += lib/migrate.o
+cflatobjs += lib/powerpc/io.o
+cflatobjs += lib/powerpc/hcall.o
+cflatobjs += lib/powerpc/setup.o
+cflatobjs += lib/powerpc/rtas.o
+cflatobjs += lib/powerpc/processor.o
+cflatobjs += lib/powerpc/handlers.o
+cflatobjs += lib/powerpc/smp.o
+
+##################################################################
+
+bits = 64
+
+ifeq ($(ENDIAN),little)
+    arch_CFLAGS = -mlittle-endian
+    arch_LDFLAGS = -EL
+else
+    arch_CFLAGS = -mbig-endian
+    arch_LDFLAGS = -EB
+endif
+
+mabi_no_altivec := $(call cc-option,-mabi=no-altivec,"")
+
+CFLAGS += -std=gnu99
+CFLAGS += -ffreestanding
+CFLAGS += -O2 -msoft-float -mno-altivec $(mabi_no_altivec)
+CFLAGS += -I $(SRCDIR)/lib -I $(SRCDIR)/lib/libfdt -I lib
+CFLAGS += -Wa,-mregnames
+
+# We want to keep intermediate files
+.PRECIOUS: %.o
+
+asm-offsets = lib/powerpc/asm-offsets.h
+include $(SRCDIR)/scripts/asm-offsets.mak
+
+%.aux.o: $(SRCDIR)/lib/auxinfo.c
+	$(CC) $(CFLAGS) -c -o $@ $< -DPROGNAME=\"$(@:.aux.o=.elf)\"
+
+FLATLIBS = $(libcflat) $(LIBFDT_archive)
+%.elf: CFLAGS += $(arch_CFLAGS)
+%.elf: LDFLAGS += $(arch_LDFLAGS) -pie -n
+%.elf: %.o $(FLATLIBS) $(SRCDIR)/powerpc/flat.lds $(cstart.o) $(reloc.o) %.aux.o
+	$(LD) $(LDFLAGS) -o $@ \
+		-T $(SRCDIR)/powerpc/flat.lds --build-id=none \
+		$(filter %.o, $^) $(FLATLIBS)
+	@chmod a-x $@
+	@echo -n Checking $@ for unsupported reloc types...
+	@if $(OBJDUMP) -R $@ | grep R_ | grep -v R_PPC64_RELATIVE; then	\
+		false;							\
+	else								\
+		echo " looks good.";					\
+	fi
+
+$(TEST_DIR)/boot_rom.bin: $(TEST_DIR)/boot_rom.elf
+	dd if=/dev/zero of=$@ bs=256 count=1
+	$(OBJCOPY) -O binary $^ $@.tmp
+	cat $@.tmp >> $@
+	$(RM) $@.tmp
+
+$(TEST_DIR)/boot_rom.elf: CFLAGS = -mbig-endian
+$(TEST_DIR)/boot_rom.elf: $(TEST_DIR)/boot_rom.o
+	$(LD) -EB -nostdlib -Ttext=0x100 --entry=start --build-id=none -o $@ $<
+	@chmod a-x $@
+
+arch_clean: asm_offsets_clean
+	$(RM) $(TEST_DIR)/*.{o,elf} $(TEST_DIR)/boot_rom.bin \
+		  $(TEST_DIR)/.*.d lib/powerpc/.*.d
+
+generated-files = $(asm-offsets)
+$(tests:.elf=.o) $(cstart.o) $(cflatobjs): $(generated-files)
diff --git a/powerpc/Makefile.common b/powerpc/Makefile.common
deleted file mode 100644
index 3b357982..00000000
--- a/powerpc/Makefile.common
+++ /dev/null
@@ -1,95 +0,0 @@
-#
-# powerpc common makefile
-#
-# Authors: Andrew Jones <drjones@redhat.com>
-#
-
-tests-common = \
-	$(TEST_DIR)/selftest.elf \
-	$(TEST_DIR)/selftest-migration.elf \
-	$(TEST_DIR)/memory-verify.elf \
-	$(TEST_DIR)/sieve.elf \
-	$(TEST_DIR)/spapr_hcall.elf \
-	$(TEST_DIR)/rtas.elf \
-	$(TEST_DIR)/emulator.elf \
-	$(TEST_DIR)/atomics.elf \
-	$(TEST_DIR)/tm.elf \
-	$(TEST_DIR)/smp.elf \
-	$(TEST_DIR)/sprs.elf \
-	$(TEST_DIR)/timebase.elf \
-	$(TEST_DIR)/interrupts.elf \
-	$(TEST_DIR)/mmu.elf \
-	$(TEST_DIR)/pmu.elf
-
-tests-all = $(tests-common) $(tests)
-all: directories $(TEST_DIR)/boot_rom.bin $(tests-all)
-
-##################################################################
-
-mabi_no_altivec := $(call cc-option,-mabi=no-altivec,"")
-
-CFLAGS += -std=gnu99
-CFLAGS += -ffreestanding
-CFLAGS += -O2 -msoft-float -mno-altivec $(mabi_no_altivec)
-CFLAGS += -I $(SRCDIR)/lib -I $(SRCDIR)/lib/libfdt -I lib
-CFLAGS += -Wa,-mregnames
-
-# We want to keep intermediate files
-.PRECIOUS: %.o
-
-asm-offsets = lib/$(ARCH)/asm-offsets.h
-include $(SRCDIR)/scripts/asm-offsets.mak
-
-cflatobjs += lib/util.o
-cflatobjs += lib/getchar.o
-cflatobjs += lib/alloc_phys.o
-cflatobjs += lib/alloc.o
-cflatobjs += lib/alloc_page.o
-cflatobjs += lib/vmalloc.o
-cflatobjs += lib/devicetree.o
-cflatobjs += lib/migrate.o
-cflatobjs += lib/powerpc/io.o
-cflatobjs += lib/powerpc/hcall.o
-cflatobjs += lib/powerpc/setup.o
-cflatobjs += lib/powerpc/rtas.o
-cflatobjs += lib/powerpc/processor.o
-cflatobjs += lib/powerpc/handlers.o
-cflatobjs += lib/powerpc/smp.o
-
-OBJDIRS += lib/powerpc
-
-%.aux.o: $(SRCDIR)/lib/auxinfo.c
-	$(CC) $(CFLAGS) -c -o $@ $< -DPROGNAME=\"$(@:.aux.o=.elf)\"
-
-FLATLIBS = $(libcflat) $(LIBFDT_archive)
-%.elf: CFLAGS += $(arch_CFLAGS)
-%.elf: LDFLAGS += $(arch_LDFLAGS) -pie -n
-%.elf: %.o $(FLATLIBS) $(SRCDIR)/powerpc/flat.lds $(cstart.o) $(reloc.o) %.aux.o
-	$(LD) $(LDFLAGS) -o $@ \
-		-T $(SRCDIR)/powerpc/flat.lds --build-id=none \
-		$(filter %.o, $^) $(FLATLIBS)
-	@chmod a-x $@
-	@echo -n Checking $@ for unsupported reloc types...
-	@if $(OBJDUMP) -R $@ | grep R_ | grep -v R_PPC64_RELATIVE; then	\
-		false;							\
-	else								\
-		echo " looks good.";					\
-	fi
-
-$(TEST_DIR)/boot_rom.bin: $(TEST_DIR)/boot_rom.elf
-	dd if=/dev/zero of=$@ bs=256 count=1
-	$(OBJCOPY) -O binary $^ $@.tmp
-	cat $@.tmp >> $@
-	$(RM) $@.tmp
-
-$(TEST_DIR)/boot_rom.elf: CFLAGS = -mbig-endian
-$(TEST_DIR)/boot_rom.elf: $(TEST_DIR)/boot_rom.o
-	$(LD) -EB -nostdlib -Ttext=0x100 --entry=start --build-id=none -o $@ $<
-	@chmod a-x $@
-
-powerpc_clean: asm_offsets_clean
-	$(RM) $(TEST_DIR)/*.{o,elf} $(TEST_DIR)/boot_rom.bin \
-	      $(TEST_DIR)/.*.d lib/powerpc/.*.d
-
-generated-files = $(asm-offsets)
-$(tests-all:.elf=.o) $(cstart.o) $(cflatobjs): $(generated-files)
diff --git a/powerpc/Makefile.ppc64 b/powerpc/Makefile.ppc64
deleted file mode 100644
index 2466471f..00000000
--- a/powerpc/Makefile.ppc64
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-# ppc64 makefile
-#
-# Authors: Andrew Jones <drjones@redhat.com>
-#
-bits = 64
-
-ifeq ($(ENDIAN),little)
-    arch_CFLAGS = -mlittle-endian
-    arch_LDFLAGS = -EL
-else
-    arch_CFLAGS = -mbig-endian
-    arch_LDFLAGS = -EB
-endif
-
-cstart.o = $(TEST_DIR)/cstart64.o
-reloc.o  = $(TEST_DIR)/reloc64.o
-
-OBJDIRS += lib/ppc64
-cflatobjs += lib/ppc64/stack.o
-cflatobjs += lib/ppc64/mmu.o
-cflatobjs += lib/ppc64/opal.o
-cflatobjs += lib/ppc64/opal-calls.o
-
-# ppc64 specific tests
-tests = $(TEST_DIR)/spapr_vpa.elf
-
-include $(SRCDIR)/$(TEST_DIR)/Makefile.common
-
-arch_clean: powerpc_clean
-	$(RM) lib/ppc64/.*.d
-- 
2.53.0


