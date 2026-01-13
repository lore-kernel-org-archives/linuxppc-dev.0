Return-Path: <linuxppc-dev+bounces-15631-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0700D2D0E8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Jan 2026 12:39:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dr82M1sSsz2yFK;
	Tue, 13 Jan 2026 23:39:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768307963;
	cv=none; b=i9vnjm4m+X5SsKaI8o7WNnObr8Sy725UnkX9QgMgv6gyvSKOPdl6iy5HxJd2clPCyk1Y+X/KLOh+gCLVJLx8kzeI5trqACMKcQcIOJWDHObjb9pdx3/lQRC9VxT08/Nwi4EZq94pY6wONguH7NgIUhMmCbBP9RWBviwYNhgxa4gRo1ZcZI4elySv7S+R82D8tHjqm7RAZiVU1LobfNe3Tpw4cwY/YZBDHEbrY3NEIV1dVGr0A6h4hbASCXfTIg0KwQhWcz9rtgNg1PivLn4w8vGvDSiz7ABnbpYRCIUtQOLgYvelXPCxAiZNcI73Xj708Yt70p3cDzb1wq/JIwYJWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768307963; c=relaxed/relaxed;
	bh=oQQonewcZ52jJ8YlJZmAIUFBKIoH7DJ4pVXHwsY1lUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KNuJiVeMFlCs2yWIpk26RUR1dYNpnynBVESxJEVXjE126k5ZJM9fNwLc5tPhHHgRef9FLtUMc/z6kY/jmUxbWtDcylgXHmbXBr98pempjlE/gBrH4FaJMVkKwGIq4wENGuKzTdNu5gZqIIr9AVi/IZ/15KaODQp5FV+7Z/6Hr42E0Xcvlk4p0NO1D4f+1adpegvGeDpiQrexImULOeWHzNEqhE4UjrsdK7iktKaCiRsGvU/ZbbyCcbdI77rPtcChtYI6jdzkCQKafOdPu8BgJWkhw/E4cuX2R48E3PHIE3aTtglK130x9Ms0aa52j50mTGFZk5lW0/HPyXA/u2KLKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=l9994pIG; dkim-atps=neutral; spf=pass (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=l9994pIG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dr82L594zz2xjb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2026 23:39:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1768307860;
	bh=JwM9XO7r7ZwPZmNYUvzPqz3+qo59nyUUWymAQNZfvpo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l9994pIGKwmExvE4gCFwYJW8YrkjrNZSltVWgoZ9dwmLszngXobPMLnFy4MM+XzKw
	 oZ4dkOSX7fmw7biNWd8XPq82MZT9vnWWdszYXSYPq4h1aPT8NbRBIc6A3k3LRWNAW5
	 4J3J4GA0Fp4GIdhYnyAHXqWxjgGyzj+Kq+0uzvx0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 13 Jan 2026 13:28:51 +0100
Subject: [PATCH v4 07/17] kbuild: generate module BTF based on
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
Message-Id: <20260113-module-hashes-v4-7-0b932db9b56b@weissschuh.net>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
In-Reply-To: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
To: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
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
 Nicolas Schier <nsc@kernel.org>, 
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
 Xiu Jianfeng <xiujianfeng@huawei.com>, Nicolas Schier <nsc@kernel.org>, 
 Christophe Leroy <chleroy@kernel.org>
Cc: =?utf-8?q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>, 
 kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>, 
 =?utf-8?q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768307859; l=1527;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=JwM9XO7r7ZwPZmNYUvzPqz3+qo59nyUUWymAQNZfvpo=;
 b=g6Ey3pXzp3Z5/IG+TMiYkH+ibJrOnrhRN1yTqeSUxErPazBTG67wvilm9r1m2g0DvKyRqsGVX
 +0CeXumvNPNCwwSRSpBSpnfmI9vv05PLlcldegrpKZHEQFBGXa5BnO1
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The upcoming module hashes functionality will build the modules in
between the generation of the BTF data and the final link of vmlinux.
At this point vmlinux is not yet built and therefore can't be used for
module BTF generation. vmlinux.unstripped however is usable and
sufficient for BTF generation.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 scripts/Makefile.modfinal | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index adfef1e002a9..930db0524a0a 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -40,11 +40,11 @@ quiet_cmd_ld_ko_o = LD [M]  $@
 
 quiet_cmd_btf_ko = BTF [M] $@
       cmd_btf_ko = 							\
-	if [ ! -f $(objtree)/vmlinux ]; then				\
-		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
+	if [ ! -f $(objtree)/vmlinux.unstripped ]; then			\
+		printf "Skipping BTF generation for %s due to unavailability of vmlinux.unstripped\n" $@ 1>&2; \
 	else								\
-		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_PAHOLE_FLAGS) --btf_base $(objtree)/vmlinux $@; \
-		$(RESOLVE_BTFIDS) -b $(objtree)/vmlinux $@;		\
+		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_PAHOLE_FLAGS) --btf_base $(objtree)/vmlinux.unstripped $@; \
+		$(RESOLVE_BTFIDS) -b $(objtree)/vmlinux.unstripped $@;	\
 	fi;
 
 # Same as newer-prereqs, but allows to exclude specified extra dependencies

-- 
2.52.0


