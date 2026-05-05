Return-Path: <linuxppc-dev+bounces-20462-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EEFCD3439
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 09:13:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8t973Vwkz30V4;
	Tue, 05 May 2026 19:13:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:c010:41de::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777972411;
	cv=none; b=fosJyJKaSp+8zPJwkxNKeKvF9k7jwoLa4ZYsxYx7q8VDudKcVWwgiAWeli8ORcS6o1ZwgA4mkqzKOCSN2i8QoiLuSAqMR3U5nCSzJMwGg0HTIR4MPMYV+NR172bR2CVkKL3cM2XulZqTxJNtce+CyXSkj+orGbVnKl1C4JAii3u5WvWQ0s7dZrmqx4Lk6DCX8tKjCDYBVAHX+tk/bpeoGG+but25vLnVTafpQTTSdABExMhr0sjo4hhlJPXWTtU3AgsoGC5EfgwJ2iP+zVeRr7nX918oZAtufe8Xqwgy66xx1SrbYJI/TQxhHFEq6dUze2uHilY7GDx0Vtnt1bK2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777972411; c=relaxed/relaxed;
	bh=Uu90FhK/uO8j2jtRODNuhq1HUy+DeDJ4OYd9hFPGYjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZR/ZDN+FELk9MhQHh80o4iIRNk7CRak72kPiYWrUM9bfTSu4RHqQ/NEoINetpcS/t1fmpp50gPidyd9jCao7QimxNY1OnKdi3oEDYO204tUW+LPKGu13/0HYpdrbdcJQBTb9dz7lFLzO9CzQJyLkT/F6HzmGeUDhVK3k8OArC/W8DJ7ejfhmElq0V6/2EuvAktTnhHvNYF2u1Kh7ikrhAHLrFE64FYdmd+t6g7/892nzPicQSr1t1DX94Jd/LGj6XC+p+VAw0z0Zs8p3vUbuCidoB3K/7rtB2vsoJm+TJjkV45YV7LiPrQEcyrkhBqFHWqtFGyt/1ya4JAyYkQpSmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=FOhks3pk; dkim-atps=neutral; spf=pass (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=FOhks3pk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8t941pjqz2xmV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 19:13:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777971923;
	bh=iI+v2zM5qx20jDnDNLqjiaP4ZCALKgVYw8ssU51phr8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FOhks3pkSuAan068u2UrzFyi9JQsEDgIjv34ZSsFVHJqVSf+M9lMkHDLbcwRwXefN
	 Kr4mPvuQzzcb89VMnTHnol7YQJlmZ5JPIrnRSymUvGG61NYOoRb0UE6homXaCCq5YY
	 nSuxvKf2aVU1eaBfgL7NkhG2PzPNeJuB2f42nHeI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 05 May 2026 11:05:10 +0200
Subject: [PATCH v5 06/14] module: Switch load_info::len to size_t
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
Message-Id: <20260505-module-hashes-v5-6-e174a5a49fce@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777971921; l=1545;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=iI+v2zM5qx20jDnDNLqjiaP4ZCALKgVYw8ssU51phr8=;
 b=nKBC+C6HVlaqqDqx1TU0YJ08KliDEuzosprDqqk3GExyuaX84HA5wt2KjHAaFNjSCBBzGKVKB
 tB2qsXnAO4LCSyyikeSwSVZHyHpzisots6OnVJBH4YtPeVK30OntV0b
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Switching the types will make some later changes cleaner.
size_t is also the semantically correct type for this field.

As both 'size_t' and 'unsigned long' are always the same size, this
should be risk-free.

Reviewed-by: Nicolas Schier <nsc@kernel.org>
Acked-by: Nicolas Schier <nsc@kernel.org>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/module/internal.h | 2 +-
 kernel/module/main.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 071999743341..006ada7d4e6e 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -64,7 +64,7 @@ struct load_info {
 	/* pointer to module in temporary copy, freed at end of load_module() */
 	struct module *mod;
 	Elf_Ehdr *hdr;
-	unsigned long len;
+	size_t len;
 	Elf_Shdr *sechdrs;
 	char *secstrings, *strtab;
 	unsigned long symoffs, stroffs, init_typeoffs, core_typeoffs;
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 46dd8d25a605..17a352198016 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1898,7 +1898,7 @@ static int validate_section_offset(const struct load_info *info, Elf_Shdr *shdr)
 static int elf_validity_ehdr(const struct load_info *info)
 {
 	if (info->len < sizeof(*(info->hdr))) {
-		pr_err("Invalid ELF header len %lu\n", info->len);
+		pr_err("Invalid ELF header len %zu\n", info->len);
 		return -ENOEXEC;
 	}
 	if (memcmp(info->hdr->e_ident, ELFMAG, SELFMAG) != 0) {

-- 
2.54.0


