Return-Path: <linuxppc-dev+bounces-20461-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2653ECD3430
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 09:13:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8t966mvNz30TP;
	Tue, 05 May 2026 19:13:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777972410;
	cv=none; b=UkPXEUTIFR5ctDYrA3RURvqatxJXYsD9N7eV3Ah/cFYSeJATF8Uslm+QkM7Vv23bz6n02oGL0QbjwGJroIhCBOUeCaSfC5dtZIMaESafIt1zPzdIJW6xf5Ipfzn4ybpmoB7s3VxlTWFrZ4J8B9fzBNQISS2tJvudhAc8lMN4Phwroy3tKxDkbDZFGg5LDLtE8eGwFqbB3Bx+7Jtsw4qnIyxuxgM503fP9km3938Jduk7ApP6z4ImV3saPJGWTwVVP6Ad5KQjFbEMzyzFEvRdkTbMnWOPjh8wQP2AvbA3GmCJLP6cQLVP/GU3Ca2C76YTwKnnd22GWQqN3ecIo8UHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777972410; c=relaxed/relaxed;
	bh=SBuq4vfYe3Hpqde9JKSBVoRgLBmqEml8bQoudUK8xJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f5Q2+w3m/LK4G9NhtMIgj8I4ONTs2qsJLWgsASeZuCQPwI9PkzwaYgAZm0eW0HkgbWxBvHapYMBI+RGyNlZaJOGh0AX4O3Kq7Fei/J37MZaGNzhcbsYdytVL3liftIWLdc0kudR4mGvghkuck6XLrLxKXxnvdd3E57tgfAgbfyJBv7d8CVzdCGlpiiCrLH+VO1ZtdNJYakMi/KAE4asAo2drwCFKa2j1TSZ9dFCMsfbSe/4/OyZu2OQIuav99dHiP6DRs8Yp67wyytL7P8ZN0X2IUx4g6he9pXsImWLBiImK0sCS4LfBGTkhBD+1WhCn1ud7EIx+ujnQDSAsF4vyxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=bQ5agIzB; dkim-atps=neutral; spf=pass (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=bQ5agIzB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8t941FXPz2xSF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 19:13:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777971923;
	bh=elZqxqWASNPH02Zi8B2qimxrAyck+wx1GcCTAUaTf68=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bQ5agIzBPRuFL7JWUhX7aDRNPbRhYiMMw3NdQA1wwclDcc9afVYMsG/75i/WNqhAA
	 hijo/UrDsuQnHCYS7acn94RhzsDs7Y51FfF3ckZNMmNlu5Jpy4KPF9/PiukPGcZcfg
	 X9HSI5nDm5v9ZQqJggt0rWkhUIJPYhzeHojeyMw8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 05 May 2026 11:05:18 +0200
Subject: [PATCH v5 14/14] kbuild: make CONFIG_MODULE_HASHES compatible with
 module stripping
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
Message-Id: <20260505-module-hashes-v5-14-e174a5a49fce@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777971921; l=3316;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=elZqxqWASNPH02Zi8B2qimxrAyck+wx1GcCTAUaTf68=;
 b=VL/y6lxcfMaVVCAqnHqBHAsMZQRoRMAJFmErw+a7YjNMWb7GcK//q6XoNoKQXYhMyaE3gwwLJ
 is6WW72xVPJDMy3Dd1T+JiFrphn8xBMZBZ2NTjggWulGxg5uKuR6cHw
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

CONFIG_MODULE_HASHES needs to process the modules at build time in the
exact form they will be loaded at runtime. If the modules are stripped
afterwards they will not be loadable anymore.

Also evaluate INSTALL_MOD_STRIP at build time and build the hashes based
on modules stripped this way.

If users specify inconsistent values of INSTALL_MOD_STRIP between build
and installation time, an error is reported.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 .gitignore                | 1 +
 kernel/module/Kconfig     | 5 +++++
 scripts/Makefile.modfinal | 9 +++++++++
 scripts/Makefile.modinst  | 4 ++--
 scripts/Makefile.vmlinux  | 2 +-
 5 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/.gitignore b/.gitignore
index 78cf799401e6..6ce10623c5a3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -30,6 +30,7 @@
 *.gz
 *.i
 *.ko
+*.ko.stripped
 *.lex.c
 *.ll
 *.lst
diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index acbbda58e7c8..48be498a4452 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -423,6 +423,11 @@ config MODULE_HASHES
 
 	  Also see the warning in MODULE_SIG about stripping modules.
 
+# To validate the consistency of INSTALL_MOD_STRIP for MODULE_HASHES
+config MODULE_INSTALL_STRIP
+	string
+	default "$(INSTALL_MOD_STRIP)"
+
 config MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
 	bool "Allow loading of modules with missing namespace imports"
 	help
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 44a382689a5a..9924a7bb73c5 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -64,7 +64,16 @@ ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 endif
 	+$(call cmd,check_tracepoint)
 
+%.ko.stripped: %.ko $(wildcard include/config/MODULE_INSTALL_STRIP)
+	$(call cmd,install_mod)
+	$(call cmd,strip_mod)
+
+ifneq ($(CONFIG_MODULE_INSTALL_STRIP),)
+modules.order: $(modules:%.o=%.ko.stripped)
+endif
+
 targets += $(modules:%.o=%.ko) $(modules:%.o=%.mod.o) .module-common.o
+targets += $(modules:%.o=%.ko.stripped)
 
 # Update modules.order when a module is (re-)built.
 # Allow using it as target dependency.
diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index b95f613e23c8..fd1fb89bb0bd 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -68,8 +68,8 @@ __modinst: $(install-y)
 
 ifdef CONFIG_MODULE_HASHES
 ifeq ($(KBUILD_EXTMOD),)
-ifdef INSTALL_MOD_STRIP
-$(error CONFIG_MODULE_HASHES and INSTALL_MOD_STRIP are mutually exclusive)
+ifneq ($(INSTALL_MOD_STRIP),$(CONFIG_MODULE_INSTALL_STRIP))
+$(error Inconsistent values for INSTALL_MOD_STRIP between build and installation)
 endif
 endif
 endif
diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index a0332c06bde1..a2d170241a2f 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -86,7 +86,7 @@ modules.order: vmlinux.unstripped FORCE
 	$(Q)$(MAKE) -f $(srctree)/Makefile modules
 
 quiet_cmd_modules_merkle_tree = MERKLE  $@
-      cmd_modules_merkle_tree = $< $@ .ko
+      cmd_modules_merkle_tree = $< $@ $(if $(CONFIG_MODULE_INSTALL_STRIP),.ko.stripped,.ko)
 
 targets += .tmp_module_hashes.c
 .tmp_module_hashes.c: $(objtree)/scripts/modules-merkle-tree modules.order FORCE

-- 
2.54.0


