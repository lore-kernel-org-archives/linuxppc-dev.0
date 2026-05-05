Return-Path: <linuxppc-dev+bounces-20463-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578DDFF885A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 09:13:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8t976815z30VQ;
	Tue, 05 May 2026 19:13:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:c010:41de::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777972411;
	cv=none; b=fXf9tHHOFlmX88SdQD4iCm4HbB9eH7qW0rHi/Ut+PDiN+gJWb0tmV4abc4f56+qAcniYr4jwNVkvEp5mZpXsfxOVUSJKvoiCpfQuAypKtrscxco9iHxqFJyOxeHGU60qSbvYMTeWv0dr1MkbmwVgUGDs/Y8S/8z2IETe0fzqZpww495H+lwr2ZxtKEPaFEvzBE8RQoQ8u/ksaiDtywAgsWKsC/QBmztpGi5DUoug0b1l1sMG+Xcuc1cXliengsv6C488Dkz30+QP0w7m2xifJ4+jilEq8Z8WW/friYNQK4BbSKpluViiDPWRN4U8VohXblCT6oWqKxipXd+ld9nFFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777972411; c=relaxed/relaxed;
	bh=Y82T8VMzylTmcLrsO8ACfzTx56zhANVi7d0v+73LV5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nZh0tZhNFNJ47k+21xZcSGdzNkgFeaV75yAS5jdJXIOjCtnp/dFNpXB4741DEGkRZ8u/w+AJF0ApgEjvtEU3BpUDXmlQ7UVF+zI+lyoHuYSEBT3eNOW0Ozz7F3YS7SPwy/hbWptyMF79qR6mHNcjaUM7Fz047/6RHQ00trJtwNFOYPByP+YmXH7YZV7fdBJc6BN+7qyU+IBk+k+v8YTmlV511MIAm194azzojyHHkOC8AgT8gwRGGUaYFGlGI0EO+GUYyZjwcV9ekmFPSoeG2cMMkwhlFPtNUAzwukbvzWol7eZcQUw9yLtFFbOpYjH3iQ21S4j2vG/hz4cgKEtXKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=l1HQpg72; dkim-atps=neutral; spf=pass (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=l1HQpg72;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8t942bw4z2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 19:13:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777971922;
	bh=vw8mmyBT43HvPMolq0TpHePOUuR7RTOx6Ud0LgA5MD4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l1HQpg727ayyAew6zE/8+4KeSD9/eY176fqNOl8FGSd4QoDzY74lG9Zoama5m7BhX
	 5EtXnyLwL1UVaosAa/7pPCSfFDE1zsNRTeOdiXhXg+IHBcSwltBhO7xw0NiiW59OkQ
	 lXncKpkeqmo/DBlCAVoem3iKRfqI7XoOEL7pTwyk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 05 May 2026 11:05:05 +0200
Subject: [PATCH v5 01/14] kbuild: generate module BTF based on
 vmlinux.unstripped
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
Message-Id: <20260505-module-hashes-v5-1-e174a5a49fce@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777971921; l=2327;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=vw8mmyBT43HvPMolq0TpHePOUuR7RTOx6Ud0LgA5MD4=;
 b=uljsY9SHiTroukbScuvpJIHxWmUOPKF1Li5N+qi4PForcgFzxPQa9CcWjxWCEGeyur3gDIlFc
 Z0W8p94VZLqAoErAJy3AInjAguaLaf4rBiEebO3HJ/wS/1lChYp5oMo
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The upcoming module hashes functionality will build the modules in
between the generation of the BTF data and the final link of vmlinux.
At this point vmlinux is not yet built and therefore can't be used for
module BTF generation. vmlinux.unstripped however is usable and
sufficient for BTF generation.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Nicolas Schier <nsc@kernel.org>
---
 scripts/Makefile.modfinal | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index adcbcde16a07..b09040ccddd2 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -38,12 +38,14 @@ quiet_cmd_ld_ko_o = LD [M]  $@
 		$(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)		\
 		-T $(objtree)/scripts/module.lds -o $@ $(filter %.o, $^)
 
+btf-vmlinux := $(if $(KBUILD_EXTMOD),vmlinux,vmlinux.unstripped)
+
 quiet_cmd_btf_ko = BTF [M] $@
       cmd_btf_ko = 							\
-	if [ ! -f $(objtree)/vmlinux ]; then				\
-		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
+	if [ ! -f $(objtree)/$(btf-vmlinux) ]; then				\
+		printf "Skipping BTF generation for %s due to unavailability of $(btf-vmlinux)\n" $@ 1>&2; \
 	else	\
-		$(CONFIG_SHELL) $(srctree)/scripts/gen-btf.sh --btf_base $(objtree)/vmlinux $@; \
+		$(CONFIG_SHELL) $(srctree)/scripts/gen-btf.sh --btf_base $(objtree)/$(btf-vmlinux) $@; \
 	fi;
 
 # Same as newer-prereqs, but allows to exclude specified extra dependencies
@@ -55,8 +57,8 @@ if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
 	printf '%s\n' 'savedcmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
 
 # Re-generate module BTFs if either module's .ko or vmlinux changed
-%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/vmlinux) FORCE
-	+$(call if_changed_except,ld_ko_o,$(objtree)/vmlinux)
+%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/$(btf-vmlinux)) FORCE
+	+$(call if_changed_except,ld_ko_o,$(objtree)/$(btf-vmlinux))
 ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	+$(if $(newer-prereqs),$(call cmd,btf_ko))
 endif

-- 
2.54.0


