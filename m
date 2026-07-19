Return-Path: <linuxppc-dev+bounces-24419-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01091C4450A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 19 Jul 2026 13:02:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h33hw6Pmyz307v;
	Sun, 19 Jul 2026 23:02:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784466160;
	cv=none; b=PwxzXlbpidohkbHwNMw3mk8IeLBn18acHD0e6R5lxTGMH7fmn5OfUeyZAVSkpKeXaSSaESiSV+TPsHkeBVpX0BMM4xr2IPOgDTVnZeXA2Q6B6cvzwUeYNmgo2sTbfyNIjEKo/PcfZBiuqhDk1u3ncyjALjtYNMwj0LZc8SQcLG4eunjUHkp4pFHIyVMtTX7CsccmlClB1B/bi7MT4tajg/dxsm4AjyhgmNOwsYNGYYEA2/hnye2YBQRpXeZ6qFU5Ib8ojmXFStWBePzbHe/SaGqZsWl7V3AOFuCntE6yXY4HjokNNE15HtKtC2T8PvXzbWC0r58BbjrVxUtOHn8vXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784466160; c=relaxed/relaxed;
	bh=dFy2K/Ylk9EZq5dXQZUGrgqCeqMdkBJhgs8qqL1CvgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDwd6ZbYlBYGUfgOVO06AyPSm30aTQi5O6czsrlc23HyrEDCfHV7x/dkNKrMzGS7dIXOnLJzrrA5PWSwz21nV7FuyDy2DcRiscNRLx6EsRrHI/AbugxCgU5hgAOx2idQhBImnIBB5pSAc4a9CinaCbbUMDPWp09QWQIzO6+tXhwUPJWal2qIx23SIOLMi7L+rr+J3sX4pUciBSMIMK2isZGl6fuj0Cbvuo3wmN1XAcPXuwEzP+YN7LFvH5oEIcNaQbSPZi2TEqTpJ4ZSHwBq04WY1+BsTZxMpcy4QmJpi7YJZuIkTyiHeTRmfh3Z1pyRLR72Kx9TXIsXF3slgaSraw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TNzoG+o5; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TNzoG+o5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h33hw1zzxz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2026 23:02:40 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JBBqMJ3351448;
	Sun, 19 Jul 2026 13:02:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dFy2K/Ylk9EZq5dXQ
	ZUGrgqCeqMdkBJhgs8qqL1CvgE=; b=TNzoG+o5H6e36sTDalJ/K6E/EDA3viM0Y
	uUlk3H6rXY5nMsEZerhHTyghvG4uyn9/rvZy80CaXFN4SOGCH7QjQO+zDCjNyKUg
	0nsgmrup9DFPJJbekGs2y2cdktO08K05dBxcrAZgFDv5uSfK6bjTUH74+TcSVzmQ
	IdGJoAFsPgUn+EoGf9CRjXMgWmXyvLFll5B81DrYdcjOLXn/NYjYbp0Npygt20fm
	tPZ763Ixt1yAcRngYTCWX7FPBHl9SOHAdGCz5f0ChILk5WFMIkFJR0Ruc+2RNkNz
	mEveKaRxr/njra0F+Ebwvm9Z28/AJWwKn/KX14Hal8hyABdBnedew==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ab3fwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 13:02:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66JCneqr018679;
	Sun, 19 Jul 2026 13:02:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgy1cph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 13:02:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66JD2VrI53084436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Jul 2026 13:02:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E15D20043;
	Sun, 19 Jul 2026 13:02:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F0E020040;
	Sun, 19 Jul 2026 13:02:28 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown [9.124.218.35])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Jul 2026 13:02:27 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: thuth@redhat.com
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        andrew.jones@linux.dev, sbhat@linux.ibm.com,
        Chinmay Rath <rathc@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 2/6] configure: Make arch_libdir a first-class entity
Date: Sun, 19 Jul 2026 18:30:23 +0530
Message-ID: <20260719130027.2347519-3-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719130027.2347519-1-rathc@linux.ibm.com>
References: <20260719130027.2347519-1-rathc@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDEzOSBTYWx0ZWRfX3VjLR+Cb3xp0
 hTsEZBHDV/R6lOTrbpo9MTi/GzDsZzM+5U1Du5dYaT9OBhqFmPb3maiDl7XMC0A3rWhFIPJmiZQ
 QJqM6vV31B1bfh6BJJbP9TYGJ+Z0TSEeXNEJQjvxjTh7HeegC3qa22UohNnLb1OLd7eJDNIxLdL
 UBg62YnEz60q4dKnSAdIV49tTtrVgUg+6FBHVHsoBJ5T1s5fRzkn5J1p0OqR3iFc+jPmyJzfCdj
 TCS/x6YJGqj7iR2h/eU3LJVTDLi0mVHZYl/GEcY76bw0yrgGzNNZDl/D9kgo8bGDu0gfYBbCo22
 WmGdLx9tugkkL++kHp4XAz1tMof7YMkKDheT/Yfo0Rkkouv+oItu7bodC4za0/XUarDLBbqJ0pE
 18X8iR4hJmF4a29U5hoqS5gx70YHTRSP80fxVHZgk0iQm6RLGEdsIdGfFJ33Cpu8P9r+TcHIBJX
 Q75IpZuNDQzX+DvFxDQ==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a5ccaec cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=TgLM54nR-fRGc_TkKysA:9
X-Proofpoint-ORIG-GUID: TG3L2BULA7-lTbYsYOHebE1AYQpIYrP-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDEzOSBTYWx0ZWRfX4BEcFVt4C4ID
 wcW9vczONxrqW8xOc964t1awAwdLLiR1+Y3xQDER7bnaTxOjI+QMX27xQc4c+VFc6NSLl0cejwd
 c6f/Yv5kJYEUhArs7C32NhufyeAxIG0=
X-Proofpoint-GUID: 5hd7QaE_O3Nk8Os4ZlYqMKiMbgGYXtbI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190139

From: Nicholas Piggin <npiggin@gmail.com>

arch_libdir was brought in to improve the heuristic determination of
the lib/ directory based on arch and testdir names, but it did not
entirely clean that mess up.

Remove the arch_libdir->arch->testdir heuristic and just require
everybody sets arch_libdir correctly. Fail if the lib/arch or
lib/arch/asm directories can not be found.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 Makefile  |  2 +-
 configure | 20 ++++++++++++--------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 42ef5826..8e002043 100644
--- a/Makefile
+++ b/Makefile
@@ -12,7 +12,7 @@ vpath %.s $(SRCDIR)
 vpath %.S $(SRCDIR)
 
 libdirs-get = $(shell [ -d "lib/$(1)" ] && echo "lib/$(1) lib/$(1)/asm")
-ARCH_LIBDIRS := $(call libdirs-get,$(ARCH_LIBDIR)) $(call libdirs-get,$(TEST_DIR))
+ARCH_LIBDIRS := $(call libdirs-get,$(ARCH_LIBDIR))
 OBJDIRS := $(ARCH_LIBDIRS)
 
 DESTDIR := $(PREFIX)/share/kvm-unit-tests/
diff --git a/configure b/configure
index 6d549d1e..aeb5570c 100755
--- a/configure
+++ b/configure
@@ -274,7 +274,6 @@ fi
 arch_name=$arch
 [ "$arch" = "aarch64" ] && arch="arm64"
 [ "$arch_name" = "arm64" ] && arch_name="aarch64"
-arch_libdir=$arch
 
 if [ "$arch" = "riscv" ]; then
     echo "riscv32 or riscv64 must be specified"
@@ -373,8 +372,10 @@ fi
 
 if [ "$arch" = "i386" ] || [ "$arch" = "x86_64" ]; then
     testdir=x86
+    arch_libdir=x86
 elif [ "$arch" = "arm" ] || [ "$arch" = "arm64" ]; then
     testdir=arm
+    arch_libdir=$arch
     if [ "$target" = "qemu" ]; then
         : "${uart_early_addr:=0x9000000}"
     elif [ "$target" = "kvmtool" ]; then
@@ -385,6 +386,7 @@ elif [ "$arch" = "arm" ] || [ "$arch" = "arm64" ]; then
     fi
 elif [ "$arch" = "ppc64" ]; then
     testdir=powerpc
+    arch_libdir=ppc64
     firmware="$testdir/boot_rom.bin"
     if [ "$endian" != "little" ] && [ "$endian" != "big" ]; then
         echo "You must provide endianness (big or little)!"
@@ -400,6 +402,7 @@ elif [ "$arch" = "riscv32" ] || [ "$arch" = "riscv64" ]; then
     fi
 elif [ "$arch" = "s390x" ]; then
     testdir=s390x
+    arch_libdir=s390x
 else
     echo "arch $arch is not supported!"
     arch=
@@ -409,6 +412,10 @@ if [ ! -d "$srcdir/$testdir" ]; then
     echo "$srcdir/$testdir does not exist!"
     exit 1
 fi
+if [ ! -d "$srcdir/lib/$arch_libdir" ]; then
+    echo "$srcdir/lib/$arch_libdir does not exist!"
+    exit 1
+fi
 
 if [ "$efi" = "y" ] && [ -f "$srcdir/$testdir/efi/run" ]; then
     ln -fs "$srcdir/$testdir/efi/run" $testdir-run
@@ -471,15 +478,12 @@ fi
 # link lib/asm for the architecture
 rm -f lib/asm
 asm="asm-generic"
-if [ -d "$srcdir/lib/$arch/asm" ]; then
-	asm="$srcdir/lib/$arch/asm"
-	mkdir -p "lib/$arch"
-elif [ -d "$srcdir/lib/$arch_libdir/asm" ]; then
+if [ -d "$srcdir/lib/$arch_libdir/asm" ]; then
 	asm="$srcdir/lib/$arch_libdir/asm"
 	mkdir -p "lib/$arch_libdir"
-elif [ -d "$srcdir/lib/$testdir/asm" ]; then
-	asm="$srcdir/lib/$testdir/asm"
-	mkdir -p "lib/$testdir"
+else
+	echo "$srcdir/lib/$arch_libdir/asm does not exist"
+	exit 1
 fi
 ln -sf "$asm" lib/asm
 mkdir -p lib/generated lib/libfdt
-- 
2.53.0


