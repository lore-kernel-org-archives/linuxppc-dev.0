Return-Path: <linuxppc-dev+bounces-20464-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0CFFF885A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 09:13:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8t994S74z30YZ;
	Tue, 05 May 2026 19:13:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777972413;
	cv=none; b=lmJUM10MbigI6rRcCa1rXNW6bnXJqGUu3QwITT6R5tZPXom3QcwspRLMyxk0j4Mq+yT1eUe1gQtbYPugEd2B4dFET8ta1E10dPQK62XICXl2oyTDAwQEOui2N4wzUJNJJXHJBS9z68Aof36Jp/KO4mIhpwLXp/ZtRm/TWSp3uVL9yteyvEgc/KD8SMLzV/1MSNqJqKAauowsFDEKjxoaY2co4QqmP7XHHdNIpFLFNZ9+zJS9gpmDHf9YJiZFPDt2zXV36fRuOo/eDj2Y9sVeiLWlILwwwD0ysIOoicHZVedFIB2MUKZPbMTeS5XOWmZgSpRUsh8PWOADjqaGqDdxTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777972413; c=relaxed/relaxed;
	bh=1WlkrShLo1yPcOfxX9RV3+PqPx5qMwryzEJF9TCtnhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iDg3LCE8+vEe5ecofEfseK4/SCqsyU+QIk4Hhh+BHREE2vw8m2pKKpBtaLi/nXYlurBQlazdgML5L/mMt92ij60Q88EdqlJbIuJpT0xJXTOwo18KPPnWDjR98rsSPvcYW7Q/lAOSx3nzGhKAzoPIYqzzHMjzw9bfYiNwkLdcX43KohkMhznIBmj37r66XEqSi3RDf/xC7XZRmBiG6hWIq3JYQJUbkgeqtvW6eLuqLwuWUz6jckBBhy4c1Le199KJvsggvZTQmQT8//tBTxuYmRdi9V/msOA2Vapxipp1hi0EGjTi3EHR1AHuVYddzKAWe2VUXVpoSCVObJZp6ni96g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=owjODUEx; dkim-atps=neutral; spf=pass (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=owjODUEx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8t973zXKz30VL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 19:13:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777971923;
	bh=6VJvYnOHZshtQlmEnWd/K1udWrIwe9dejx/5mZI/Wtg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=owjODUExCCypec6TKWlnIwzT8DVnXMsfb+ZaEjU0MoKmKL+u/Hgk0XMLanRHlOS5p
	 MNeyeJ7VYX8n6e4baZNE/ejhPU8IePBOA5zatZB7qfpcaHAbaVKcUT7fN5vxhMYVdb
	 T5d4nFyczBMUPklVRaKpvkmaSNX/c9tzIRq1bRpM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 05 May 2026 11:05:13 +0200
Subject: [PATCH v5 09/14] module: Move signature type check out of
 mod_check_sig()
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
Message-Id: <20260505-module-hashes-v5-9-e174a5a49fce@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777971921; l=2558;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=6VJvYnOHZshtQlmEnWd/K1udWrIwe9dejx/5mZI/Wtg=;
 b=CMdNpxTCGkVu3CYbUQ//Xh1Da5BfQXG6erPbBdP2NTFne3QRqh52DC/9CSjILoKbNrS8gBQHS
 8rcJfdzG3nTABuTlKzuzZV5cQk7a/PkWY+ZZAqFMl0YgtXmFbCISOTR
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Additional signature types are about to be added.
As each caller of mod_check_sig() can have different support for these,
move the type validation into the callers.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/module/auth.c                | 5 +++++
 kernel/module_signature.c           | 8 +-------
 security/integrity/ima/ima_modsig.c | 5 +++++
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/module/auth.c b/kernel/module/auth.c
index 831a13eb0c9b..21e49eb4967c 100644
--- a/kernel/module/auth.c
+++ b/kernel/module/auth.c
@@ -48,6 +48,11 @@ static int mod_verify_sig(const void *mod, struct load_info *info)
 
 	memcpy(&ms, mod + (modlen - sizeof(ms)), sizeof(ms));
 
+	if (ms.id_type != MODULE_SIGNATURE_TYPE_PKCS7) {
+		pr_err("module: not signed with expected PKCS#7 message\n");
+		return -ENOPKG;
+	}
+
 	ret = mod_check_sig(&ms, modlen, "module");
 	if (ret)
 		return ret;
diff --git a/kernel/module_signature.c b/kernel/module_signature.c
index a0eee2fe4368..4d0476bcdb72 100644
--- a/kernel/module_signature.c
+++ b/kernel/module_signature.c
@@ -24,12 +24,6 @@ int mod_check_sig(const struct module_signature *ms, size_t file_len,
 	if (be32_to_cpu(ms->sig_len) >= file_len - sizeof(*ms))
 		return -EBADMSG;
 
-	if (ms->id_type != MODULE_SIGNATURE_TYPE_PKCS7) {
-		pr_err("%s: not signed with expected PKCS#7 message\n",
-		       name);
-		return -ENOPKG;
-	}
-
 	if (ms->algo != 0 ||
 	    ms->hash != 0 ||
 	    ms->signer_len != 0 ||
@@ -37,7 +31,7 @@ int mod_check_sig(const struct module_signature *ms, size_t file_len,
 	    ms->__pad[0] != 0 ||
 	    ms->__pad[1] != 0 ||
 	    ms->__pad[2] != 0) {
-		pr_err("%s: PKCS#7 signature info has unexpected non-zero params\n",
+		pr_err("%s: signature info has unexpected non-zero params\n",
 		       name);
 		return -EBADMSG;
 	}
diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index 632c746fd81e..ebfcdd368a2a 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -57,6 +57,11 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 	buf_len -= marker_len;
 	sig = (const struct module_signature *)(p - sizeof(*sig));
 
+	if (sig->id_type != MODULE_SIGNATURE_TYPE_PKCS7) {
+		pr_err("%s: not signed with expected PKCS#7 message\n", func_tokens[func]);
+		return -ENOPKG;
+	}
+
 	rc = mod_check_sig(sig, buf_len, func_tokens[func]);
 	if (rc)
 		return rc;

-- 
2.54.0


