Return-Path: <linuxppc-dev+bounces-20459-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A46FF885A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 09:13:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8t945dL1z2yjx;
	Tue, 05 May 2026 19:13:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777972408;
	cv=none; b=Ldcum11xcRsxOk6msxJgwnuxzn9oqgGdgnQIpYBtwDpQsjgXvyLpTXNAedmppal4vM3MW54lVnNoOAQAqdwbEg3CEYFZJAgzyIb/v3sawOttrQ0tuKMZE/SCzsIHLX/jTaURKEAwsog3gd5aEDJup57Gjg3xHnt5WT2TosI2shZ/9O2zmlVmRWpU5SobztbiaAc/s9J6qPA/bCNrX6KfhF+ZbV+1Cul3A9tnqvW1C9iT7V+rPSRla92dkjmeepRkHTO48aqhxoys0zAt/zwOGTIwls52wFj77Il+EfotSeDl3LGwX9AAe7gNdjeWgbxJVrX9f00nMhjoi/n76KLAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777972408; c=relaxed/relaxed;
	bh=M9YlraDLXGZnut0H8AEZ2nTZKCSCc1DB3Jzi5uod69M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E0Fd/nPnC7OUrmkzSlQbn7WUs8g7UPsXxXwcveY/IJsz0pPccCPN2c02ZmP4TTH/c1Aj7Ms+FQIJe5cA7Q2kWf6Y55qV/3ijV7QLd1CZixweXYfgOEMWjpiv2ApMlp8MpfMWzpcPhFHVjhdcqQDI4+7PkuIYz8NgmJAedrFcV9HE6Q6ktcbH4/SS3Vx6RaMt6Cp8Oz56+NDA/3InUweRsQP06eTv8lK3QJJPQoPrEAiErfdmVw9OUDn90+Pi6v/jZEcicjXGtVIc3fQksvsIXcWdFnZ0jp3M5PUlMJot/OM8VgdgaszJgo3lWayoOPUVBh40jv92PycKN9lbDZ14UQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=KeHzGoIR; dkim-atps=neutral; spf=pass (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=KeHzGoIR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8t940jZCz2xGc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 19:13:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777971922;
	bh=urNb3wCpvLUEWBOX/KRz/AvKSgOExMhmzt3qzgx4rLs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KeHzGoIRklkebRwSn23SbznclRtjezjvd5d7dG6KMuDXtXD0JgHO4jI11/IEp/6TT
	 tj1bQriT3fPSO7EMQEFkPRv7qxmuo5y+6DIKg5nGmOTkh47yk8cRSGSNjbO58uIARW
	 aQQQ8rdk48+qNmbOyW6+LhDqdsqh1R62+FcknhqA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 05 May 2026 11:05:07 +0200
Subject: [PATCH v5 03/14] kbuild: rename the strip_relocs command
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
Message-Id: <20260505-module-hashes-v5-3-e174a5a49fce@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777971921; l=1526;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=urNb3wCpvLUEWBOX/KRz/AvKSgOExMhmzt3qzgx4rLs=;
 b=zO4+a83ARZh91UdHs8c/zFFH5RWsYxSMyvtjjkwAZh87tyFNn/XXyYS4Ur+mm7rbCt/arjCT/
 XQJfLzxEaBjBWLAWIx91HgeLuKwV16KxbtUDUGkyZZG34V7Riun6CDM
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This command is doing more than just stripping relocations.
With the introduction of CONFIG_MODULE_HASHES it will do even more.

Use a more generic name for the variable.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 scripts/Makefile.vmlinux | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index fcae1e432d9a..6cc661e5292b 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -91,13 +91,13 @@ remove-symbols := -w --strip-unneeded-symbol='__mod_device_table__*'
 
 # To avoid warnings: "empty loadable segment detected at ..." from GNU objcopy,
 # it is necessary to remove the PT_LOAD flag from the segment.
-quiet_cmd_strip_relocs = OBJCOPY $@
-      cmd_strip_relocs = $(OBJCOPY) $(patsubst %,--set-section-flags %=noload,$(remove-section-y)) $< $@; \
-                         $(OBJCOPY) $(addprefix --remove-section=,$(remove-section-y)) $(remove-symbols) $@
+quiet_cmd_objcopy_vmlinux = OBJCOPY $@
+      cmd_objcopy_vmlinux = $(OBJCOPY) $(patsubst %,--set-section-flags %=noload,$(remove-section-y)) $< $@; \
+                            $(OBJCOPY) $(addprefix --remove-section=,$(remove-section-y)) $(remove-symbols) $@
 
 targets += vmlinux
 vmlinux: vmlinux.unstripped FORCE
-	$(call if_changed,strip_relocs)
+	$(call if_changed,objcopy_vmlinux)
 
 # modules.builtin.modinfo
 # ---------------------------------------------------------------------------

-- 
2.54.0


