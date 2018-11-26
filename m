Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15BBC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 09:21:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39D6B20663
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 09:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D6B20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433Lyd0CyfzDqQx
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 20:21:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433LwP3GWKzDqQg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 20:19:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 433LwP1gNbz9s3C; Mon, 26 Nov 2018 20:19:49 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 433LwP0wLLz9s3q; Mon, 26 Nov 2018 20:19:48 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc/configs: Remove unnecessary ftrace symbols
Date: Mon, 26 Nov 2018 20:19:43 +1100
Message-Id: <20181126091944.21893-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.17.2
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In commit 539df7fcb303 ("powerpc/configs: Enable function trace by
default") we added:

  CONFIG_FTRACE=y
  CONFIG_FUNCTION_TRACER=y
  CONFIG_FUNCTION_GRAPH_TRACER=y

To ppc64_defconfig, powernv_defconfig and pseries_defconfig.

But only CONFIG_FUNCTION_TRACER=y is required, CONFIG_FTRACE is
default y if DEBUG_KERNEL is enabled, which we have. And then
CONFIG_FUNCTION_GRAPH_TRACER is default y when CONFIG_FUNCTION_TRACER
is enabled.

The extra symbols were already removed from powernv_defconfig in
commit 9a018fb1e147 ("powerpc/config: powernv_defconfig updates").

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/ppc64_defconfig   | 2 --
 arch/powerpc/configs/pseries_defconfig | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index f2515674a1e2..6cdf034e8625 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -331,9 +331,7 @@ CONFIG_SOFTLOCKUP_DETECTOR=y
 CONFIG_HARDLOCKUP_DETECTOR=y
 CONFIG_DEBUG_MUTEXES=y
 CONFIG_LATENCYTOP=y
-CONFIG_FTRACE=y
 CONFIG_FUNCTION_TRACER=y
-CONFIG_FUNCTION_GRAPH_TRACER=y
 CONFIG_SCHED_TRACER=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_CODE_PATCHING_SELFTEST=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 5e09a40cbcbf..ea79c519863d 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -290,9 +290,7 @@ CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
 CONFIG_HARDLOCKUP_DETECTOR=y
 CONFIG_LATENCYTOP=y
-CONFIG_FTRACE=y
 CONFIG_FUNCTION_TRACER=y
-CONFIG_FUNCTION_GRAPH_TRACER=y
 CONFIG_SCHED_TRACER=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_CODE_PATCHING_SELFTEST=y
-- 
2.17.2

