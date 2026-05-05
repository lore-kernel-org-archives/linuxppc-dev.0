Return-Path: <linuxppc-dev+bounces-20466-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88BDCD3430
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 09:14:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8t9G0TRRz3bdQ;
	Tue, 05 May 2026 19:13:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:c010:41de::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777972417;
	cv=none; b=in2lTdSL4X3bUh7bZOZ572W8uosRGyRRgsEkqhrsYjuQJ9h5qVY+Mo/G6u6Qs+mDV40yEeuYfHkSL3fCiyXdu+0KBYtYFcALs+0lzU/avChj1eNKHv10U45z3XydkCEiu4Ouj0eZlCMnK9d98yQVYl3+pKq9vlHnZZP+t4rTkOeEwjJTtYfQCXCi/cD7GOIjFTKwcxwhIBIjO5MOooIvKTTl7EVOJB4/Uub0RnkObg0+y50s6KbhmSMZ2Eb6f3Nnzn/o2opL7N1IjbcKRsSfHSwPDgj2/mtalsxzWmBeRgc9AKSxG6LMsh6B6p7bB30CJaG6aX/s2//H+GmWO2oivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777972417; c=relaxed/relaxed;
	bh=Abhtj+9SI37F9FeMRWtutGCRFmcMTCSOWYrV9CKCXZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IBXYcdxrHkFUn5tr4vdkQ9nRRh0SiviUUoqkw+yJqm3IKPGdEjnDa0P8S4/EMH+bEYgUR2zPv1XwbzRkF35cNA/0MgWthYNomKHKvP63Mf67vRcvvfdSDNFRmAo3Fr17KdzvgAhvKDZQr9nDlOkQdsYfq+B+AmY3lk36qhj3HnEIKqFHPz3FxlW2+vMqRs+Iu5YIc17oRefCTPyORteSjOkp35tvBTGQVTwg6XcmqwjhfbxPvPDQOylrmj1YKEl4v/6FI1jxtol6RRIC5pCEm6hVKAGqz3MnjZyUhcBkhD/sx0DVYyqdjyxP/5iZmHGYgxwTTQ6IZxBZDWX+iq4LIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=g4Fknziw; dkim-atps=neutral; spf=pass (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=g4Fknziw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8t991cyDz30WQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 19:13:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777971923;
	bh=QGuEjahQSX5KIR3mv9uZyKkgUGxQh5zTTSgnqh/jiis=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g4Fknziwd96fLN+TTNQAV/fMHOhd/dIN0idNYLfwkjvob2sS26e2GZhdQjmJKGBg2
	 1Wuj9kttFMh09utr0/SaRmtgS+EoGk8Ji0s7efvwWTViHA7Eic1XoFHkeNankvLZGH
	 d2Dvf/IQdZzsPGC4AF+nGave4W25BM2Rl2cxHXow=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 05 May 2026 11:05:09 +0200
Subject: [PATCH v5 05/14] module: Make mod_verify_sig() static
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
Message-Id: <20260505-module-hashes-v5-5-e174a5a49fce@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777971921; l=1372;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=QGuEjahQSX5KIR3mv9uZyKkgUGxQh5zTTSgnqh/jiis=;
 b=YPbhooCs8Z4p5xzEA8Bou2VKPPahpzMZhKoMk8D4SPl0woEZ2hjUdTCq/NfLfVDVlfTISZ3Ax
 2PKz7Hagg7xC31UJ4xI2NezkX4xUOqNSMisfL91GfGeptv87RApuP5L
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

It is not used outside of signing.c.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Reviewed-by: Nicolas Schier <nsc@kernel.org>
Reviewed-by: Eric Biggers <ebiggers@kernel.org>
---
 kernel/module/internal.h | 1 -
 kernel/module/signing.c  | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 061161cc79d9..071999743341 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -117,7 +117,6 @@ struct module_use {
 	struct module *source, *target;
 };
 
-int mod_verify_sig(const void *mod, struct load_info *info);
 int try_to_force_load(struct module *mod, const char *reason);
 bool find_symbol(struct find_symbol_arg *fsa);
 struct module *find_module_all(const char *name, size_t len, bool even_unformed);
diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index 4a5e4eef250d..69d4b1758540 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -40,7 +40,7 @@ void set_module_sig_enforced(void)
 /*
  * Verify the signature on a module.
  */
-int mod_verify_sig(const void *mod, struct load_info *info)
+static int mod_verify_sig(const void *mod, struct load_info *info)
 {
 	struct module_signature ms;
 	size_t sig_len, modlen = info->len;

-- 
2.54.0


