Return-Path: <linuxppc-dev+bounces-20469-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BCACD343B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 09:14:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8t9G5Xzlz3bfV;
	Tue, 05 May 2026 19:13:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777972418;
	cv=none; b=cB6lgLYctAF/5jtD6t36yUtIZi8aWXkAlxiDWSyJXgcO0MjhMgPiJ4cmI5Z6UrQuNxH3Kxsg0oRZDvsVEMk3mOhOaF1Lk9kz634aeyvhznvgsNeRd9ZiqfLy29Nhjprq7SkWd755VZNJllq/wZRFi8G3l6J3kF5aYe+KJiFvFTKRshKhveVMjPa/4aT/sxwoT7nPVPxme7TnmO7XCm809VdfjN+2x4yYP1yM2uLC9eOR38kM0o16mPh9mrerV0/Jjmg2vk3uAg7cPY4Emf/3UaK29xRmZeZOwwjlAsfRAtwUUWw4e6LvjTA/+7z6YRXOpgxHQZSTsp4cRNiUkRqbJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777972418; c=relaxed/relaxed;
	bh=9bmQ2ruHNr87UVEJ0C+PU03EHlif5gmif7GE+uatzrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VPvy8VpQjR/ftbm+ALTDs6Pz+QBgSjHaf8qDkJwvShv0DEVEVzfqikXntXI9U0Dm0mSH+lWIGlv4lUKhOQYkaceR9S8cLZB20HU8R6QeDD4HZmG3SsSsdfwclpKVXEzXKCftEsMChEKnncU7rxp/dqwsg7uzKj8BD+/iyukiJKzX7sL+pG/QZzGXr3898qSOJGDVZwt8t1tKHvkxkRcWc72Z650sHAEb6Z20Ipibxb9l20flgOQBtJUKuim4IwuxsUaAWzQQAY3txRsRUjQc6XLJGqaIGaKV7E+FngzZrCHBcNLhvqH4a3Ff52hJS+KwYvTU7VJBUv0rs1ChsCAFuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=ONiJCd1X; dkim-atps=neutral; spf=pass (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=ONiJCd1X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8t9C6R3Gz3bVW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 19:13:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777971922;
	bh=XIA5YFBwc6Ej9VZmFF9JGp6ZBIHakQDs8PjcS5hpne4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ONiJCd1Xjufi3qfX4PXYJk52Ans3Ce5JZoXSHJpZRM9GcvQ4b9Mv9AZkVK3SSkBDb
	 uU34oNf0ltXz9UDGVNxNmTfz5eGAMR8ag9Kkbs+QXSzZwgehn2cJbjY0WL19iK1chP
	 f9RRPhi1y40plE2CjJKV+XStQYmpjxANqKYPwWBQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 05 May 2026 11:05:08 +0200
Subject: [PATCH v5 04/14] module: Drop pointless debugging message
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
Message-Id: <20260505-module-hashes-v5-4-e174a5a49fce@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777971921; l=660;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=XIA5YFBwc6Ej9VZmFF9JGp6ZBIHakQDs8PjcS5hpne4=;
 b=Ee+VM+f9ivEIue9ulRLTnR7A7RxGy6esDrOUiYWXgYjcohrPW0vgCLL+otaNguQ4yU33rNoC0
 E/xUSCAFfC8Dq68rIFE+RjjVdNuj1MSQsJK7czkKKBhaEAT8wIUs2W8
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This is the only instance of pr_devel() in the whole module subsystem
and essentially useless.

Drop it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/module/signing.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index 590ba29c85ab..4a5e4eef250d 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -46,8 +46,6 @@ int mod_verify_sig(const void *mod, struct load_info *info)
 	size_t sig_len, modlen = info->len;
 	int ret;
 
-	pr_devel("==>%s(,%zu)\n", __func__, modlen);
-
 	if (modlen <= sizeof(ms))
 		return -EBADMSG;
 

-- 
2.54.0


