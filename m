Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D1EC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 05:15:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB2B420644
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 05:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB2B420644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VMjs1Zc6zF2Dy
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 16:15:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VMgt1vYVzF09n
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 16:13:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42VMgt1C7fz9sB7; Wed, 10 Oct 2018 16:13:30 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42VMgt0y7Dz9sBk; Wed, 10 Oct 2018 16:13:30 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4] powerpc: Move core kernel logic into arch/powerpc/Kbuild
Date: Wed, 10 Oct 2018 16:13:05 +1100
Message-Id: <20181010051308.25422-1-mpe@ellerman.id.au>
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
Cc: maddy@linux.ibm.com, keescook@chromium.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is a nice cleanup, arch/powerpc/Makefile is long and messy so
moving this out helps a little.

It also allows us to do:

  $ make arch/powerpc

Which can be helpful if you just want to compile test some changes to
arch code and not link everything.

Finally it also gives us a single place to do subdir-cc-flags
assignments which affect the whole of arch/powerpc, which we will do
in a future patch.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kbuild   | 14 ++++++++++++++
 arch/powerpc/Makefile | 14 ++------------
 2 files changed, 16 insertions(+), 12 deletions(-)
 create mode 100644 arch/powerpc/Kbuild

diff --git a/arch/powerpc/Kbuild b/arch/powerpc/Kbuild
new file mode 100644
index 000000000000..690a498da050
--- /dev/null
+++ b/arch/powerpc/Kbuild
@@ -0,0 +1,14 @@
+obj-y += kernel/
+obj-y += mm/
+obj-y += lib/
+obj-y += sysdev/
+obj-y += platforms/
+obj-y += math-emu/
+obj-y += crypto/
+obj-y += net/
+
+obj-$(CONFIG_XMON) += xmon/
+obj-$(CONFIG_KVM)  += kvm/
+
+obj-$(CONFIG_PERF_EVENTS) += perf/
+obj-$(CONFIG_KEXEC_FILE)  += purgatory/
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 974103254aed..e623abaa573e 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -269,18 +269,8 @@ head-$(CONFIG_PPC_FPU)		+= arch/powerpc/kernel/fpu.o
 head-$(CONFIG_ALTIVEC)		+= arch/powerpc/kernel/vector.o
 head-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE)  += arch/powerpc/kernel/prom_init.o
 
-core-y				+= arch/powerpc/kernel/ \
-				   arch/powerpc/mm/ \
-				   arch/powerpc/lib/ \
-				   arch/powerpc/sysdev/ \
-				   arch/powerpc/platforms/ \
-				   arch/powerpc/math-emu/ \
-				   arch/powerpc/crypto/ \
-				   arch/powerpc/net/
-core-$(CONFIG_XMON)		+= arch/powerpc/xmon/
-core-$(CONFIG_KVM) 		+= arch/powerpc/kvm/
-core-$(CONFIG_PERF_EVENTS)	+= arch/powerpc/perf/
-core-$(CONFIG_KEXEC_FILE)	+= arch/powerpc/purgatory/
+# See arch/powerpc/Kbuild for content of core part of the kernel
+core-y += arch/powerpc/
 
 drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
 
-- 
2.17.1

