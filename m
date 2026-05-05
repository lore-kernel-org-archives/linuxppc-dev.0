Return-Path: <linuxppc-dev+bounces-20456-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF83FF885A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 09:10:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8t6004jKz2xmV;
	Tue, 05 May 2026 19:10:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:c010:41de::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777972247;
	cv=none; b=kircKfZT3DhFduBBbSWo7ZF+E9L6gIpjqkgD7mMGWXGii7gQZ4t+ILbpJXXBJxDfYzWnVTFXjl5m+AdjpQPysrm1Oj89VFE/J5Wl6aUvOQUnfVGmXMxlo2Z1oq5I3ocO8vJaToHRDCnAmSJNLCPDvpJ6cyg2Ab6RmuKnzu1jAaLBFQ3SaQYk5ISr8pHrzvcuiKTaZlJsbGcxl0mp0iZ78BR1rIjCI+mFRgdu2M2XTOhJ7tcLsrEbHBczETfNZU2LfFQCaraj6dih+sogYaabrQSZKEskVQdEKA190ZtMPZ6dIYOHSVKR7GY0wvyMlLgAPXiY0bBCnhgZrkbqmZP9ag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777972247; c=relaxed/relaxed;
	bh=FPhlEOdbjaNnDHfMW3do6+nuibrLXktIt9R7lAS6R10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LjQEnE0KYFQCHKFUD3TCr5oJreNRtDd8i7XI2sijPZ7HFFb4Vv3C1YsiBlamgrOV/6rZJeMtpFLqtPmuhjw2O/tucIOelJEl4ttp7DJv7oG97WuLIJoZtkKxDj7JGLN2aP4M+/FTvCvKWQWv6S9gS05lBPVigfuMxhXWi9ACUA9YUyRuoUCfZIC8pQdjTTsSLPZHjJ/qgWVaqujM2h9uUUrprM8zRBHpTrX5piKps3J+S8RrIs/dFpdaqALrhCqikC85z6l5U7egJMoVCoSygeQBDCtDYqJknD1TW4YOa8Z2O4i8xZHLzl9ECjuvbuDYxKQ5DAvIYvZx7BTzL7U+cw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=Up2Yt+/i; dkim-atps=neutral; spf=pass (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=Up2Yt+/i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 317 seconds by postgrey-1.37 at boromir; Tue, 05 May 2026 19:10:46 AEST
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8t5y4XPPz2xSF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 19:10:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777972242;
	bh=4sym237a3wzjHBQDzN72ZtH7iFNxSpm8gXdzQ0UrWmw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Up2Yt+/iewqFT4CdTJtEHClfccc2bXaZkDpSUGByup4Vjop5SUh30Qw8cs4enAqE3
	 ezzRxbNnLJYJrCGV+ryDaz+xSLJTy627+iEeBG9M2YPm1ZbEn/3tJi93kE1vSEhuZG
	 GHsrlN1CEma0J6DFPiAPBGPBIuHEuzWSdyzkEtF0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 05 May 2026 11:05:17 +0200
Subject: [PATCH v5 13/14] kbuild: move handling of module stripping to
 Makefile.lib
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260505-module-hashes-v5-13-e174a5a49fce@weissschuh.net>
References: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>
In-Reply-To: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
 Xiu Jianfeng <xiujianfeng@huawei.com>, 
 Christophe Leroy <chleroy@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 bpf@vger.kernel.org, 
 =?utf-8?q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>, 
 kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>, 
 =?utf-8?q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>, 
 Eric Biggers <ebiggers@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org, 
 debian-kernel@lists.debian.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777971921; l=3531;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=4sym237a3wzjHBQDzN72ZtH7iFNxSpm8gXdzQ0UrWmw=;
 b=yK767BHsapJV15dUfHNe8idRaS/QEQT7THkpmPRTFTWVR8JNmIEaIi786mZC/3G3QxzBTTSEr
 ElIP5qYLNiJD4Y2+AainUiunn1D7qpG9VUvSrTlTN7McIL/cM3ZvgES
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

To allow CONFIG_MODULE_HASHES in combination with INSTALL_MOD_STRIP,
this logc will also be used by Makefile.modfinal.

Move it to a shared location to enable reuse.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 scripts/Makefile.lib     | 32 ++++++++++++++++++++++++++++++++
 scripts/Makefile.modinst | 37 +++++--------------------------------
 2 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 0718e39cedda..bb713a1a11be 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -484,6 +484,38 @@ define sed-offsets
 	s:->::; p;}'
 endef
 
+#
+# Module Installation
+#
+quiet_cmd_install_mod = INSTALL $@
+      cmd_install_mod = cp $< $@
+
+# Module Strip
+# ---------------------------------------------------------------------------
+#
+# INSTALL_MOD_STRIP, if defined, will cause modules to be stripped after they
+# are installed. If INSTALL_MOD_STRIP is '1', then the default option
+# --strip-debug will be used. Otherwise, INSTALL_MOD_STRIP value will be used
+# as the options to the strip command.
+ifeq ($(INSTALL_MOD_STRIP),1)
+mod-strip-option := --strip-debug
+else
+mod-strip-option := $(INSTALL_MOD_STRIP)
+endif
+
+# Strip
+ifdef INSTALL_MOD_STRIP
+
+quiet_cmd_strip_mod = STRIP   $@
+      cmd_strip_mod = $(STRIP) $(mod-strip-option) $@
+
+else
+
+quiet_cmd_strip_mod =
+      cmd_strip_mod = :
+
+endif
+
 # Use filechk to avoid rebuilds when a header changes, but the resulting file
 # does not
 define filechk_offsets
diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index 68708a039a62..b95f613e23c8 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -8,6 +8,7 @@ __modinst:
 
 include $(objtree)/include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
+include $(srctree)/scripts/Makefile.lib
 
 install-y :=
 
@@ -36,7 +37,7 @@ install-y += $(addprefix $(MODLIB)/, modules.builtin modules.builtin.modinfo)
 install-$(CONFIG_BUILTIN_MODULE_RANGES) += $(MODLIB)/modules.builtin.ranges
 
 $(addprefix $(MODLIB)/, modules.builtin modules.builtin.modinfo modules.builtin.ranges): $(MODLIB)/%: % FORCE
-	$(call cmd,install)
+	$(call cmd,install_mod)
 
 endif
 
@@ -65,40 +66,12 @@ install-$(CONFIG_MODULES) += $(modules)
 __modinst: $(install-y)
 	@:
 
-#
-# Installation
-#
-quiet_cmd_install = INSTALL $@
-      cmd_install = cp $< $@
-
-# Strip
-#
-# INSTALL_MOD_STRIP, if defined, will cause modules to be stripped after they
-# are installed. If INSTALL_MOD_STRIP is '1', then the default option
-# --strip-debug will be used. Otherwise, INSTALL_MOD_STRIP value will be used
-# as the options to the strip command.
-ifdef INSTALL_MOD_STRIP
-
 ifdef CONFIG_MODULE_HASHES
 ifeq ($(KBUILD_EXTMOD),)
+ifdef INSTALL_MOD_STRIP
 $(error CONFIG_MODULE_HASHES and INSTALL_MOD_STRIP are mutually exclusive)
 endif
 endif
-
-ifeq ($(INSTALL_MOD_STRIP),1)
-strip-option := --strip-debug
-else
-strip-option := $(INSTALL_MOD_STRIP)
-endif
-
-quiet_cmd_strip = STRIP   $@
-      cmd_strip = $(STRIP) $(strip-option) $@
-
-else
-
-quiet_cmd_strip =
-      cmd_strip = :
-
 endif
 
 #
@@ -131,8 +104,8 @@ endif
 $(foreach dir, $(sort $(dir $(install-y))), $(shell mkdir -p $(dir)))
 
 $(dst)/%.ko: %.ko FORCE
-	$(call cmd,install)
-	$(call cmd,strip)
+	$(call cmd,install_mod)
+	$(call cmd,strip_mod)
 	$(call cmd,sign)
 
 ifdef CONFIG_MODULES

-- 
2.54.0


