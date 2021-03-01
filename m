Return-Path: <SRS0=kNGO=H7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A983C433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Mar 2021 05:51:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BBB664E2E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Mar 2021 05:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBB664E2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DpqBB58Thz3cZ9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Mar 2021 16:50:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=anshuman.khandual@arm.com; receiver=<UNKNOWN>)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 4Dpq9r6rq7z30NL
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Mar 2021 16:50:38 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 780D21FB;
 Sun, 28 Feb 2021 21:50:34 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.66.89])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DDFEC3F70D;
 Sun, 28 Feb 2021 21:50:30 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Subject: [PATCH] mm: Generalize HUGETLB_PAGE_SIZE_VARIABLE
Date: Mon,  1 Mar 2021 11:20:53 +0530
Message-Id: <1614577853-7452-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
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
Cc: linux-ia64@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

HUGETLB_PAGE_SIZE_VARIABLE need not be defined for each individual
platform subscribing it. Instead just make it generic.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-ia64@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This change was originally suggested in an earilier discussion. This
applies on v5.12-rc1 and has been build tested on all applicable
platforms i.e ia64 and powerpc.

https://patchwork.kernel.org/project/linux-mm/patch/1613024531-19040-3-git-send-email-anshuman.khandual@arm.com/

 arch/ia64/Kconfig    | 6 +-----
 arch/powerpc/Kconfig | 6 +-----
 mm/Kconfig           | 8 ++++++++
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 2ad7a8d29fcc..6b3e3f6c29ae 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -32,6 +32,7 @@ config IA64
 	select TTY
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_VIRT_CPU_ACCOUNTING
+	select HUGETLB_PAGE_SIZE_VARIABLE
 	select VIRT_TO_BUS
 	select GENERIC_IRQ_PROBE
 	select GENERIC_PENDING_IRQ if SMP
@@ -82,11 +83,6 @@ config STACKTRACE_SUPPORT
 config GENERIC_LOCKBREAK
 	def_bool n
 
-config HUGETLB_PAGE_SIZE_VARIABLE
-	bool
-	depends on HUGETLB_PAGE
-	default y
-
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3778ad17f56a..b8565bed284f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -232,6 +232,7 @@ config PPC
 	select HAVE_HARDLOCKUP_DETECTOR_PERF	if PERF_EVENTS && HAVE_PERF_EVENTS_NMI && !HAVE_HARDLOCKUP_DETECTOR_ARCH
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HUGETLB_PAGE_SIZE_VARIABLE	if PPC_BOOK3S_64
 	select MMU_GATHER_RCU_TABLE_FREE
 	select MMU_GATHER_PAGE_SIZE
 	select HAVE_REGS_AND_STACK_ACCESS_API
@@ -416,11 +417,6 @@ config HIGHMEM
 
 source "kernel/Kconfig.hz"
 
-config HUGETLB_PAGE_SIZE_VARIABLE
-	bool
-	depends on HUGETLB_PAGE && PPC_BOOK3S_64
-	default y
-
 config MATH_EMULATION
 	bool "Math emulation"
 	depends on 4xx || PPC_8xx || PPC_MPC832x || BOOKE
diff --git a/mm/Kconfig b/mm/Kconfig
index 24c045b24b95..e604a87862a4 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -274,6 +274,14 @@ config ARCH_ENABLE_HUGEPAGE_MIGRATION
 config ARCH_ENABLE_THP_MIGRATION
 	bool
 
+config HUGETLB_PAGE_SIZE_VARIABLE
+	def_bool n
+	depends on HUGETLB_PAGE
+	help
+	  When there are multiple HugeTLB sizes available on a platform
+	  and pageblock_order could then be a dynamic value instead of
+	  standard HUGETLB_PAGE_ORDER.
+
 config CONTIG_ALLOC
 	def_bool (MEMORY_ISOLATION && COMPACTION) || CMA
 
-- 
2.20.1

