Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33137C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 05:36:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABFEE218D3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 05:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABFEE218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w6WF3QS5zDqMb
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 16:36:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=au1.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=andrew.donnellan@au1.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w6Rl6MKKzDqPR
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 16:33:39 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x175UTOJ075540
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Feb 2019 00:33:36 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qgcu3bmqc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Feb 2019 00:33:36 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 7 Feb 2019 05:33:34 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 7 Feb 2019 05:33:32 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x175XVZA27197536
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Feb 2019 05:33:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23A2F52051;
 Thu,  7 Feb 2019 05:33:31 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5400B5204F;
 Thu,  7 Feb 2019 05:33:30 +0000 (GMT)
Received: from intelligence.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id D9E3BA0276;
 Thu,  7 Feb 2019 16:33:28 +1100 (AEDT)
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc: Enable kcov
Date: Thu,  7 Feb 2019 16:33:24 +1100
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190207053324.17541-1-andrew.donnellan@au1.ibm.com>
References: <20190207053324.17541-1-andrew.donnellan@au1.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19020705-0012-0000-0000-000002F2B572
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020705-0013-0000-0000-0000212A1926
Message-Id: <20190207053324.17541-2-andrew.donnellan@au1.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-07_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=552 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902070042
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: syzkaller@googlegroups.com, dvyukov@google.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

kcov provides kernel coverage data that's useful for fuzzing tools like
syzkaller.

Wire up kcov support on powerpc. Disable kcov instrumentation on the same
files where we currently disable gcov and UBSan instrumentation.

Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
---
 arch/powerpc/Kconfig                | 1 +
 arch/powerpc/kernel/Makefile        | 7 ++++++-
 arch/powerpc/kernel/trace/Makefile  | 3 ++-
 arch/powerpc/kernel/vdso32/Makefile | 1 +
 arch/powerpc/kernel/vdso64/Makefile | 1 +
 arch/powerpc/xmon/Makefile          | 1 +
 6 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2890d36eb531..d3698dae0e60 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -134,6 +134,7 @@ config PPC
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_KCOV
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_PMEM_API                if PPC64
 	select ARCH_HAS_PTE_SPECIAL
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index cb7f0bb9ee71..961f44eabb65 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -142,16 +142,21 @@ endif
 obj-$(CONFIG_EPAPR_PARAVIRT)	+= epapr_paravirt.o epapr_hcalls.o
 obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvm_emul.o
 
-# Disable GCOV & sanitizers in odd or sensitive code
+# Disable GCOV, KCOV & sanitizers in odd or sensitive code
 GCOV_PROFILE_prom_init.o := n
+KCOV_INSTRUMENT_prom_init.o := n
 UBSAN_SANITIZE_prom_init.o := n
 GCOV_PROFILE_machine_kexec_64.o := n
+KCOV_INSTRUMENT_machine_kexec_64.o := n
 UBSAN_SANITIZE_machine_kexec_64.o := n
 GCOV_PROFILE_machine_kexec_32.o := n
+KCOV_INSTRUMENT_machine_kexec_32.o := n
 UBSAN_SANITIZE_machine_kexec_32.o := n
 GCOV_PROFILE_kprobes.o := n
+KCOV_INSTRUMENT_kprobes.o := n
 UBSAN_SANITIZE_kprobes.o := n
 GCOV_PROFILE_kprobes-ftrace.o := n
+KCOV_INSTRUMENT_kprobes-ftrace.o := n
 UBSAN_SANITIZE_kprobes-ftrace.o := n
 UBSAN_SANITIZE_vdso.o := n
 
diff --git a/arch/powerpc/kernel/trace/Makefile b/arch/powerpc/kernel/trace/Makefile
index b1725ad3e13d..858503775c58 100644
--- a/arch/powerpc/kernel/trace/Makefile
+++ b/arch/powerpc/kernel/trace/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_TRACING)			+= trace_clock.o
 obj-$(CONFIG_PPC64)			+= $(obj64-y)
 obj-$(CONFIG_PPC32)			+= $(obj32-y)
 
-# Disable GCOV & sanitizers in odd or sensitive code
+# Disable GCOV, KCOV & sanitizers in odd or sensitive code
 GCOV_PROFILE_ftrace.o := n
+KCOV_INSTRUMENT_ftrace.o := n
 UBSAN_SANITIZE_ftrace.o := n
diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/vdso32/Makefile
index 50112d4473bb..ce199f6e4256 100644
--- a/arch/powerpc/kernel/vdso32/Makefile
+++ b/arch/powerpc/kernel/vdso32/Makefile
@@ -23,6 +23,7 @@ targets := $(obj-vdso32) vdso32.so vdso32.so.dbg
 obj-vdso32 := $(addprefix $(obj)/, $(obj-vdso32))
 
 GCOV_PROFILE := n
+KCOV_INSTRUMENT := n
 UBSAN_SANITIZE := n
 
 ccflags-y := -shared -fno-common -fno-builtin
diff --git a/arch/powerpc/kernel/vdso64/Makefile b/arch/powerpc/kernel/vdso64/Makefile
index 69cecb346269..28e7d112aa2f 100644
--- a/arch/powerpc/kernel/vdso64/Makefile
+++ b/arch/powerpc/kernel/vdso64/Makefile
@@ -9,6 +9,7 @@ targets := $(obj-vdso64) vdso64.so vdso64.so.dbg
 obj-vdso64 := $(addprefix $(obj)/, $(obj-vdso64))
 
 GCOV_PROFILE := n
+KCOV_INSTRUMENT := n
 UBSAN_SANITIZE := n
 
 ccflags-y := -shared -fno-common -fno-builtin
diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
index 878f9c1d3615..3050f9323254 100644
--- a/arch/powerpc/xmon/Makefile
+++ b/arch/powerpc/xmon/Makefile
@@ -5,6 +5,7 @@
 subdir-ccflags-y := $(call cc-disable-warning, builtin-requires-header)
 
 GCOV_PROFILE := n
+KCOV_INSTRUMENT := n
 UBSAN_SANITIZE := n
 
 # Disable ftrace for the entire directory
-- 
2.11.0

