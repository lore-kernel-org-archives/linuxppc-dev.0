Return-Path: <linuxppc-dev+bounces-20467-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF7B8FF885A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 09:14:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8t9G3N4rz3bf4;
	Tue, 05 May 2026 19:13:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777972418;
	cv=none; b=F2nTq9KuG7IO2qBpxfLM31cwmnp6SYiy+diO0VwYZGMK1scAPKGEuXsRU8Xbh+y9RqG4jVVaQTjD/lOfPOiVu3M//R28jUq2VMa2SdRLeUV2IPTRKMdFnvIBDE2MrwNMWJ7EJ0B8Kw+127B6sh/8wkSNXQ2ZcqIw9EYkfqY72YWFedNoax16CSU4f9NWScVkFXvFLw6rn2fvgWz2m8iihMk1lzlUEg3NMkMTYR1DjX5JI4/sVUkjCHyeQs5T0zvDtc6nHj7zvM8hTyNQFwlfo+xbfeC16z5g7hK4wmLqwyYjNsyM335zXbcleN9AD9TlxJHRXjQXG2t7OZWNyH8lPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777972418; c=relaxed/relaxed;
	bh=TkDHL5U0u/T5Z96xyaJQHYwioSwZv4c3cl6dutAOr78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iSROAyWK7QIGG0htO1pQwiPlmCWbO650s/fj/LlFjYQ58E03vG3EI5Pvfo9avtUVrDkDN2nqayD6UnTT6FZuQ2kGkBz9j/8YuqFcJ+NndOTGc+8E93TR7ODRPTDCY/K6OE36WXqz1zjVoz7PEzTVN9dej4gnz3PRXGlspVtcZbBreLVnkcdGXkPgnqaRHdJR038Q6tQ1Uz/Q1A2hCneYvmxTsEXuhDzkmBXUB+0wuq+qHgdvKVmJ+jeCN8h7CA5uWdTyEy5sQemD8yfYPVjlg2XaQCu7BKYNRAUwEVwXiCttvLGsDuManmQ4c0vlIHHftgepCZ6Z8Ab0n66PQ+DAKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=uSjcE3/7; dkim-atps=neutral; spf=pass (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=uSjcE3/7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8t993Pxnz30Wh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 19:13:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777971923;
	bh=chCyrFKTgdh3bqAx/mQ6lIysEIJoVqpFJGF/rlIkqi4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uSjcE3/7RPzqVxYeknvP09UES2PQcOS9VkYVVqueNpzecmFvo1an3XpkguzW1D0Bg
	 nFEHj3iswoLhusE/F96Ei5XojOmHw/x30HPACKMdW35EThCzDfqEd2VucH5aOjSyPt
	 ZadmbkICr/8be6TA7uVP9y8q16Xm891dDk9OoxpA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 05 May 2026 11:05:14 +0200
Subject: [PATCH v5 10/14] module: Prepare for additional module
 authentication mechanisms
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
Message-Id: <20260505-module-hashes-v5-10-e174a5a49fce@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777971921; l=2563;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=chCyrFKTgdh3bqAx/mQ6lIysEIJoVqpFJGF/rlIkqi4=;
 b=AghgISpSvC9jFLJMASwIQ2fl2y7giwEV7IIPQJiNe92PMZ8lKZf0qC99jV/SdHmNA1NchS945
 I53O1yr0Ve6Cw+2TVu7rpkv9iMeNkP/+D4AMPAnvVv3dujuIZnIrT4f
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Reorganize the code to make it easier to add the new hash-based module
authentication.

Also drop the now unnecessary stub for module_sig_check().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/module/auth.c     | 17 ++++++++++++++---
 kernel/module/internal.h |  8 --------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/kernel/module/auth.c b/kernel/module/auth.c
index 21e49eb4967c..2ee512d26790 100644
--- a/kernel/module/auth.c
+++ b/kernel/module/auth.c
@@ -37,6 +37,14 @@ void set_module_sig_enforced(void)
 	sig_enforce = true;
 }
 
+static __always_inline bool mod_sig_type_valid(enum module_signature_type id_type)
+{
+	if (id_type == MODULE_SIGNATURE_TYPE_PKCS7 && IS_ENABLED(CONFIG_MODULE_SIG))
+		return true;
+
+	return false;
+}
+
 static int mod_verify_sig(const void *mod, struct load_info *info)
 {
 	struct module_signature ms;
@@ -48,8 +56,8 @@ static int mod_verify_sig(const void *mod, struct load_info *info)
 
 	memcpy(&ms, mod + (modlen - sizeof(ms)), sizeof(ms));
 
-	if (ms.id_type != MODULE_SIGNATURE_TYPE_PKCS7) {
-		pr_err("module: not signed with expected PKCS#7 message\n");
+	if (!mod_sig_type_valid(ms.id_type)) {
+		pr_err("module: not signed with expected signature\n");
 		return -ENOPKG;
 	}
 
@@ -61,7 +69,10 @@ static int mod_verify_sig(const void *mod, struct load_info *info)
 	modlen -= sig_len + sizeof(ms);
 	info->len = modlen;
 
-	return module_sig_check(mod, modlen, mod + modlen, sig_len);
+	if (ms.id_type == MODULE_SIGNATURE_TYPE_PKCS7 && IS_ENABLED(CONFIG_MODULE_SIG))
+		return module_sig_check(mod, modlen, mod + modlen, sig_len);
+
+	return 0;
 }
 
 int module_auth_check(struct load_info *info, int flags)
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index d923e31a5d8e..aabe7f8e1af4 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -335,15 +335,7 @@ int module_enforce_rwx_sections(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
 void module_mark_ro_after_init(const Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 			       const char *secstrings);
 
-#ifdef CONFIG_MODULE_SIG
 int module_sig_check(const void *mod, size_t mod_len, const void *sig, size_t sig_len);
-#else /* !CONFIG_MODULE_SIG */
-static inline int module_sig_check(const void *mod, size_t mod_len,
-				   const void *sig, size_t sig_len)
-{
-	return 0;
-}
-#endif /* !CONFIG_MODULE_SIG */
 
 #ifdef CONFIG_MODULE_AUTH
 int module_auth_check(struct load_info *info, int flags);

-- 
2.54.0


