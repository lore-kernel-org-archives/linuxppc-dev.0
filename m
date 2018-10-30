Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43599C2BC61
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 04:25:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8066C20823
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 04:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="QMIHH3VI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8066C20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kdg22vNWzF0RC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 15:25:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="QMIHH3VI";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.76; helo=conuserg-09.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="QMIHH3VI"; 
 dkim-atps=neutral
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kdcV042lzF0RC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Oct 2018 15:23:05 +1100 (AEDT)
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id w9U4LgZK000764;
 Tue, 30 Oct 2018 13:21:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w9U4LgZK000764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1540873303;
 bh=U06X4wzGUcKfpT3rd6eTAurlLB8yHi+i7Y+oD+BqWGI=;
 h=From:To:Cc:Subject:Date:From;
 b=QMIHH3VIc22lCyApk6nAwVLVVVeGu5tpxb0dOTThkGDf2WyypYKO8jE7lypabKmVp
 beRCiYw0UDlfLYtD8ksbR2gtf6c9QSAv41ijLHfJBrWbIMt8fOYrQz8Mky5n5ypcby
 ivcuUn34IkFJxRon5eCgL0VeT0yQSGhXq7GcVlW2A9hCszA/bAxAYpKMk1F0gb1vMp
 1aFUsTYRLzRxovPIsEbJmtQLNQf/cqiDrJwp8nx9R49r8XUsJfVd8tLe3LBFBklaQg
 cgfnRry5me4+5DGjfz/Wb2LC/0QJeOzeHIqOwl6NX+hxO1tD0gmNPlDihoNO3HFpQH
 HGqmmbzoKb7og==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Subject: [PATCH 1/2] kbuild: replace cc-name test with CONFIG_CC_IS_CLANG
Date: Tue, 30 Oct 2018 13:21:32 +0900
Message-Id: <1540873293-29817-1-git-send-email-yamada.masahiro@socionext.com>
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
Cc: linux-mips@linux-mips.org, Michal Marek <michal.lkml@markovi.net>,
 James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Paul Burton <paul.burton@mips.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Evaluating cc-name invokes the compiler every time even when you are
not compiling anything, like 'make help'. This is not efficient.

The compiler type has been already detected in the Kconfig stage.
Use CONFIG_CC_IS_CLANG, instead.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile                   | 2 +-
 arch/mips/Makefile         | 2 +-
 arch/mips/vdso/Makefile    | 2 +-
 arch/powerpc/Makefile      | 4 ++--
 scripts/Makefile.extrawarn | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 0a42d06..bd93bc3 100644
--- a/Makefile
+++ b/Makefile
@@ -707,7 +707,7 @@ stackp-flags-$(CONFIG_STACKPROTECTOR_STRONG)      := -fstack-protector-strong
 
 KBUILD_CFLAGS += $(stackp-flags-y)
 
-ifeq ($(cc-name),clang)
+ifeq ($(CONFIG_CC_IS_CLANG),y)
 KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 15a84cf..ad1c418 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -128,7 +128,7 @@ cflags-y += -ffreestanding
 # clang's output will be based upon the build machine. So for clang we simply
 # unconditionally specify -EB or -EL as appropriate.
 #
-ifeq ($(cc-name),clang)
+ifeq ($(CONFIG_CC_IS_CLANG),y)
 cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= -EB
 cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -EL
 else
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 34605ca..e2b055e 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -10,7 +10,7 @@ ccflags-vdso := \
 	$(filter -march=%,$(KBUILD_CFLAGS)) \
 	-D__VDSO__
 
-ifeq ($(cc-name),clang)
+ifeq ($(CONFIG_CC_IS_CLANG),y)
 ccflags-vdso += $(filter --target=%,$(KBUILD_CFLAGS))
 endif
 
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 17be664..338e827 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -96,7 +96,7 @@ aflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mabi=elfv1)
 aflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mabi=elfv2
 endif
 
-ifneq ($(cc-name),clang)
+ifneq ($(CONFIG_CC_IS_CLANG),y)
   cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mno-strict-align
 endif
 
@@ -175,7 +175,7 @@ endif
 # Work around gcc code-gen bugs with -pg / -fno-omit-frame-pointer in gcc <= 4.8
 # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44199
 # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=52828
-ifneq ($(cc-name),clang)
+ifneq ($(CONFIG_CC_IS_CLANG),y)
 CC_FLAGS_FTRACE	+= $(call cc-ifversion, -lt, 0409, -mno-sched-epilog)
 endif
 endif
diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 24b2fb1..88129e5 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -64,7 +64,7 @@ endif
 KBUILD_CFLAGS += $(warning)
 else
 
-ifeq ($(cc-name),clang)
+ifeq ($(CONFIG_CC_IS_CLANG),y)
 KBUILD_CFLAGS += $(call cc-disable-warning, initializer-overrides)
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-value)
 KBUILD_CFLAGS += $(call cc-disable-warning, format)
-- 
2.7.4

