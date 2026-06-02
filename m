Return-Path: <linuxppc-dev+bounces-21860-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC73CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 08:47:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV4Fg1H27z3bsY;
	Tue, 02 Jun 2026 18:47:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780390023;
	cv=none; b=AjFt+n8EctEQYcr3MFHZqXUdA/WDUKfgwvFNP1gfd1DwNrkHxT+M5S5VlNvM/gJeARlcYPN4f6WPxFA/1qB4AbOsyLfEkSHii3Rd3LlC2yVz4Tbxlo++zDu45dKLP82t8M40sNOMEaL5PVxkDftFt2VsrKhtg6wAR1vTDYEqD9jLwnlQzqd4rJ8Tc5wzvk1V/bI8nZFrxEI8I5O+3X+VxDrWYpzlLlzuEr9XAmn3rgiuikre0QfbP5Ts4zbxQXZheuNL1uaYo9Ac3/8LmVc0ez5/DKtJvRwAVSY+vVgdAoRwfg89/CnyQbHWhG52o5M9Mq3FOZphGSSktnn4HgEarQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780390023; c=relaxed/relaxed;
	bh=sMG/2rxZYMjEPPBvwv4bSmWW/2cnEvqzHzFFMwcW/54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dADmLkFSa9dXg/ZUeV8tbZPHarF98Jzs1qk+S7XHfcaq6HkAnqj1nGJdeOEvzjOvOJOdT16CZsZzXDieYOzfD74DB2momMzF/z8ZL1QNqvNtuc2iue067Z9RJifldbxgB2UHrRKWw6mYX3E970VcW0tDuNT3cvARt8bk0dXr5uUn6fpyjvKb5s1g2ITL4BP3nvH8QiEr4FsvxMIYBnplloOLfHSMFWw+D84zhMcbl2lCB8UPr6XfDsmziK4QTUotGOchME+nYghqluCtj4YDY51c1X1eKPXk0h7tNn/s9EViMf2JXjN4m1L9uq9xBa32TDBJzhkCZM9clK/pGw+6/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TChqJwKI; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TChqJwKI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV4Ff3wT0z2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 18:47:02 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F3B6A60123;
	Tue,  2 Jun 2026 08:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0548C1F00893;
	Tue,  2 Jun 2026 08:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780390019;
	bh=sMG/2rxZYMjEPPBvwv4bSmWW/2cnEvqzHzFFMwcW/54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TChqJwKIsLx5o6EZivYMTNC1TWMC37L1gx+GW4rJSYfwykZvJLBT292S+1X5NFTGs
	 Jk+fnS19J99iQz90W7a3/bu+hXZfrC2OQRaufm6xSbl6KTRE7p/3NISpX4LPfW5cpb
	 zXnY1Siy9WKZ7ZF37CqJoaGttxRAatkV/JsLG1DguyIkmJhB5W9dHvQHgDujWI4vXo
	 fmH/ry14vvn58H5bDSEv2KxtUgAQawzZh+GvlZbequNj+JaXTH11ogN1SYPUvpiRBS
	 1jXoi283PCVIfOgExKJXItUZSV4MLA0B4adS9zGUV1UO3zAiAvWM3i8X/0/JRD69Qp
	 Ymm4HYO5tzXnw==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 4/8] powerpc/signal64: Access function descriptor with scoped user access
Date: Tue,  2 Jun 2026 10:46:33 +0200
Message-ID: <6492f5d9ace4ae9dd39ce45b509cd3790285b44a.1780389863.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780389863.git.chleroy@kernel.org>
References: <cover.1780389863.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1246; i=chleroy@kernel.org; h=from:subject:message-id; bh=4aksLooy4XCvM5n/sIPCKsUfuKkAa5e7DCDqbcxCFz4=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTJzcid6Fsj7a7J5Jpve0L/UfWq71tnJbrOWsWzb4HsQ 6fZi/4XdZSyMIhxMciKKbIc/8+9a0bXl9T8qbv0YeawMoEMYeDiFICJGEow/E/q8Jn7Oqq6nd89 L8xl1yMRz1lZb4o55u4XOP1i1+4jU34xMvy80rVfp/C+0csds/ZL6b9s8DF5I9WTcbfy08OHG5y cLjMBAA==
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Access the function descriptor of the handler within a scoped
user access block.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/powerpc/kernel/signal_64.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 4ff8ad5d60d0..d23a980b32a8 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -932,8 +932,10 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 		struct func_desc __user *ptr =
 			(struct func_desc __user *)ksig->ka.sa.sa_handler;
 
-		err |= get_user(regs->ctr, &ptr->addr);
-		err |= get_user(regs->gpr[2], &ptr->toc);
+		scoped_user_read_access(ptr, badfunc) {
+			unsafe_get_user(regs->ctr, &ptr->addr, badfunc);
+			unsafe_get_user(regs->gpr[2], &ptr->toc, badfunc);
+		}
 	}
 
 	/* enter the signal handler in native-endian mode */
@@ -956,5 +958,10 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 badframe:
 	signal_fault(current, regs, "handle_rt_signal64", frame);
 
+	return 1;
+
+badfunc:
+	signal_fault(current, regs, __func__, (void __user *)ksig->ka.sa.sa_handler);
+
 	return 1;
 }
-- 
2.54.0


