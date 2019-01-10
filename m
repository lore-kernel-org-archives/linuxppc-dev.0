Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A574C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 05:44:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75AE4206B7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 05:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75AE4206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Zw0g1TRLzDq6W
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 16:44:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 43Zvyt3VYwzDqYV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 16:42:29 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id A4F2FAE8001E;
 Thu, 10 Jan 2019 00:42:23 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH kernel] powerpc/stack_protector: Fix external modules
 building
Date: Thu, 10 Jan 2019 16:42:16 +1100
Message-Id: <20190110054216.74248-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

c3ff2a519 "powerpc/32: add stack protector support" addes stack protector
support so now powerpc's "prepare" target depends on prepare0 (via
stack_protector_prepare target).

It works fine until we try build an external module where it fails with:
Run: 'make -j128 SYSSRC=/home/aik/p/kernel SYSOUT=/home/aik/pbuild/kernel-le-pseries/ ARCH=powerpc'
make[1]: Entering directory '/home/aik/p/kernel'
make[2]: Entering directory '/home/aik/pbuild/kernel-le-pseries'
make[2]: *** No rule to make target 'prepare0', needed by 'stack_protector_prepare'.  Stop.

The reason for that is that the main Linux Makefile defines "prepare0"
only if KBUILD_EXTMOD=="".

This hacks powerpc's Makefile to make external modules build again.

Fixes: c3ff2a519 "powerpc/32: add stack protector support"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---


It has been suggested that there is a better way of fixing this hence RFC.


---
 arch/powerpc/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 488c9ed..0492f62 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -419,7 +419,11 @@ archheaders:
 ifdef CONFIG_STACKPROTECTOR
 prepare: stack_protector_prepare
 
+ifeq ($(KBUILD_EXTMOD),)
 stack_protector_prepare: prepare0
+else
+stack_protector_prepare:
+endif
 ifdef CONFIG_PPC64
 	$(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "PACA_CANARY") print $$3;}' include/generated/asm-offsets.h))
 else
-- 
2.17.1

