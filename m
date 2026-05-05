Return-Path: <linuxppc-dev+bounces-20457-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C991FF885A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 09:10:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8t606rg2z30FF;
	Tue, 05 May 2026 19:10:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777972248;
	cv=none; b=EeAalT9kIMhMYUZxdCyqJp0cdBXb8cpdt85eBmwMT0eNzKz+20WZ3m9yC4vMA1KQWtpxOjrMpNeExpVQ9xynr1eoUc3Bjr2RHVvtyn+JJgNHYV7ls9iESeJK46fdmHW/Poq6JcLIOsQaGMedct6EXykk9gF4vmLZ780+MxwUfB0b26Oi2bSppZRlcMvtiFzQywjHStCGK6p6P3thM/zWwPMCNrITpf3Tbaub7VNByjXryGfGgGy8NqiWXO4puE1o5u8oqC1plx4hsfy2fdd4Xw/IpP5b3u/9Q4lxew/9kLXzu8QalDNFYwXNQ4PhZwQjN9Xvt9bd7/tSe4+4FFOC9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777972248; c=relaxed/relaxed;
	bh=PP3c5YZeKOBMoqk1o/M/E4neeovwaXXQ8syBGspPfls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Inx55qKRbE+ut33A95YidRpZbw9SvOX9KSWG1Szg864eXbP46ax2TXFJC2xsHjE1pQDR2/pQoTtKW0YwsqLMlQELpW/Ef0YlH5wDG5ysnC1pFMV+9aGYrvxAiOhbY16m56HQluMFFa3MzjYIZ7O4n95lCIaz0UmTenPOK8UUUfjetAq3612gBBumh2235FjA20FJsTxPMuuAVf64deYnk6MOdR0p9no+ahecCECwxOlccNtK4EDVRo38Ey5a7t4R6djBTm2S/xGaQ08076ulIXykQdfmHombd7zkHHhXupSCiFXgQ0szVibrMdGCWEe3GOi+V8b2bi1GO41TvqICQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=XYlaUPL2; dkim-atps=neutral; spf=pass (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=XYlaUPL2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 317 seconds by postgrey-1.37 at boromir; Tue, 05 May 2026 19:10:45 AEST
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8t5x3kWqz2xGc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 19:10:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1777972242;
	bh=OjVEQENALnBrLz41nWZb6yT3a4erxpjD/nxLglpoCvs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XYlaUPL2+1keZjN6BW3dcVpUl1RE38eQ/mlaVVvGmo2i9QCzRFbU331m2UYsSbCld
	 hta5KOZvDq0W86hZIs2n1rYUwCZ+NdnAkIxcW5Y5qHrZWxaytUG2jOyjEHymCGLDmA
	 Xja87gSXTb9+q0HubyhjmtkQGlwGOrsIzkE2RZwc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 05 May 2026 11:05:15 +0200
Subject: [PATCH v5 11/14] module: update timestamp of modules.order after
 modules are built
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
Message-Id: <20260505-module-hashes-v5-11-e174a5a49fce@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777971921; l=973;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=OjVEQENALnBrLz41nWZb6yT3a4erxpjD/nxLglpoCvs=;
 b=uffap1Yp7A9oUyxJAg/JMqLbZ7j2qeL8SXGije4OWjL3Lmqea939UF78GetZTKRZdUELCxw7k
 wcm9ivOs6zTCvQInib7BHj9Xe5zk405K6/DXSFSlvx+rY7B0KYo+1yw
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Make sure that modules.order is always newer than the module .ko files.
Other rules can then use modules.order as a prerequisite and rerun if
any module is (re-)built.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 scripts/Makefile.modfinal | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index b09040ccddd2..44a382689a5a 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -66,6 +66,13 @@ endif
 
 targets += $(modules:%.o=%.ko) $(modules:%.o=%.mod.o) .module-common.o
 
+# Update modules.order when a module is (re-)built.
+# Allow using it as target dependency.
+targets += modules.order
+__modfinal: modules.order
+modules.order: $(modules:%.o=%.ko)
+	@touch $@
+
 # Add FORCE to the prerequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
 

-- 
2.54.0


