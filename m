Return-Path: <linuxppc-dev+bounces-23809-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A8EC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 10:52:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwFKF4J1jz2xpn;
	Wed, 08 Jul 2026 20:52:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783507921;
	cv=none; b=oRQqzT62YVApjTu+UQNzQJTFYCc9ZSFfzo2QoFhAo8L2fVVyl72AgO4a8xNIWzEvi1D0d5FVibuVIpZ35G/KNfohwSTgKK7Stj88KMzR0s5xTnGIIR5u3LVUt0qPJUm2U7lcwZDmjMmJHTCQ5rE/Vc3GOKLUzJZWGpa3dQ+mMGUl5bd0f3yGzF6o2lnjCQ56/9PDJIt3ZoPaiCV6XBohiIIAHPmjsW13xeitCRFljaVlinvuE4Ep/M/PFdVvT/bpHSeKKSGDAMCgKlYQDFCcqQHI32qA3YQr5C8l8cx0qVNjqf/vpCawxeG3wLlE+10SPm2jKN5a3LvUb4YMqcs1hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783507921; c=relaxed/relaxed;
	bh=dFy2K/Ylk9EZq5dXQZUGrgqCeqMdkBJhgs8qqL1CvgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9J7He3XYsDg07XQNOXhgnrcze0BtrlormAOVsA3VewQdHxPdsL1oh2wo95l5yzXLua5BUJTcprCExxMSqgRz2AUGZpll74+eddCykvXPbI39dFPCnfU9uaTI4Yr07A42d5qlqyzsbsqIRGao1RNA1302xb9zeowXv7NtIvt/5YlxMcNaIRMmKoPPeD0P8L7IrH5S2BKMjx/4Lq7OddLBTmwGRX98D46t9RpRbBKiOTPMtiU+pABcR0ZnjOT0LRxmBehjoHCyVZaZU96meKmJaOpOqJKmvZXQV/lIMjHODlidvjI7l+e0H8tTg1H8AtHsmv32aKFxiJ08guE7ucV3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AgQjKPuD; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AgQjKPuD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwFKD6fPbz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 20:52:00 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6688IKBK2501587;
	Wed, 8 Jul 2026 10:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dFy2K/Ylk9EZq5dXQ
	ZUGrgqCeqMdkBJhgs8qqL1CvgE=; b=AgQjKPuDwoxtKbTBphr50kjhpHv/KWvMP
	ziUH6AmpTK371eWP7uqO91AiAvzb5A7JJ5+mbvxHuAGSZqGGuzLMOxcCSPKyMpbk
	Waog2G1evq/rLjDW/6cNPOe1xCYxjppeYMl3vr4oOAkQT/vaxduJeYwbLxWr937I
	wZqPnYXkyuw4lxkvCJepN2GczwWj8GmzW+pj8OyEXaU7MiSKUSlEq3/UoBzOJWbi
	6s0PuNXBCLvTcT7VslXGuOJRDowje0SmDwgeXAxUzms/V2QdsB8tD8QEr0qA+H8m
	BOgOJdNhUmLPI1PvzMlaeU5y9nZEeyjGi6gnkVmTPVjrCiukmaBQA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4v060-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 10:51:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668AndlK011258;
	Wed, 8 Jul 2026 10:51:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvw7t8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 10:51:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 668AppYH51052880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 10:51:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2036D2004B;
	Wed,  8 Jul 2026 10:51:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 010D620043;
	Wed,  8 Jul 2026 10:51:48 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown [9.39.26.49])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jul 2026 10:51:47 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: thuth@redhat.com
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        andrew.jones@linux.dev, sbhat@linux.ibm.com,
        Chinmay Rath <rathc@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 2/6] configure: Make arch_libdir a first-class entity
Date: Wed,  8 Jul 2026 16:21:18 +0530
Message-ID: <20260708105122.1177210-3-rathc@linux.ibm.com>
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
X-Proofpoint-GUID: ocbAyFv0NfBIyjuVGm7dmvNT2bgZYCCW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEwNSBTYWx0ZWRfX3Oi4J89+1XnI
 +Mdt0K2lVT5r0wRJdUOWB1Y92ohmyZItdXwD/HzILuZutfYPlMg+J28BeqjR7dY1Yf2aetq5Rid
 Sc0HJ/pSDhQvo/KWjI7e3W4a8TDYjIPXervf65VTwETeXvxIfVBuqS9k4hohygZs4PMgrqiw9cI
 c8V1ZDw5yxwMbb1t5uyDytXPCuZ9+DFAP8V8FbI6dDLPOE0E1FUUtkALnFe4x4hZnO1q72DPJ/T
 P5kSeZLatU4e9ffYtPV1c3mlubqyKSYXyqit8zVIK8MHHDp/gdoSPX4xxQ5ZaKGsapYAu5VagzP
 oGkosl8pr91KKSme9HBNoHcc6vGexW41TCBYg0+66cGPIf+GSLdRy01M5BlsKxrI7f3Oq+CpzwS
 Tgjo5y+uqeq86ptLALi9dQ32CSc3RcVgsHNoDC8CltRKYhh/2EKDuMAK9uGFJNYgim1GvrksLe4
 HQdIwtY+uUtN8pHpYyA==
X-Proofpoint-ORIG-GUID: cleThC47aVcKO8lkbS5hJiMfGzsknu6c
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4e2bcc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=TgLM54nR-fRGc_TkKysA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEwNSBTYWx0ZWRfX2qnhtqn7pXkG
 b2hKH/l5kR39ft5to38p/V/VYD6P9EN57CudrgVamIbkID/+GJLuqDD6V7hZHK7ddcPnVIFFCul
 GdtMLjq6r7m3z6uu9vBYbRdGivtAsrs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080105

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


