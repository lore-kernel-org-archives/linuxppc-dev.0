Return-Path: <linuxppc-dev+bounces-21381-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4433BCD5BB0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 09:57:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMLKH6pvXz3bsn;
	Fri, 22 May 2026 19:56:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779443811;
	cv=none; b=PrkwS0GLTeM722V3hyk4l5CAbYdsKcbW5GWl1IQgJGtBWJ2+p5y2J431VjW3VZPVO9Y5jau3C/+SV1N1T3QztuPZCQNQA7FjGTBJw0mXpfkgJTyqVBZzNbB3J8D0kjoDV4B0JSOBn0qX1GYz4zfpLp9qV1+kxU9MiMCuGxoFmKshtdhixDLg/fb7c6wYZr6Ik94UztZepVA+J/Bl/E0y9PYVjhjiNJ3hsv+fNpTbVyhxacNrJdI5PYR/wX1UJM5bt23bH9Hm4z5B5TPN2KeRD0pycZk8l7ittqcz9avUNIiYidpyehjgrZkqJXSS+tw7rMxSF7vLnqdRuTR1GiE9rw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779443811; c=relaxed/relaxed;
	bh=8vN/NoLezPEDsyDS+onUAQhVhhGZl3+ewdKbIEUAKPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J077i1L0Lk6W/pKvI7MNcgN7No8/YxDDStPSwD9a6IYsM06d56Zq6NdVdHdypjE/4dcy6tJitNtzH/+FV7++RdgWcZFF4krb10uzmYVsXBZyvIOf+/WULHX+zd5aRNlDRFmAxPTPUTY28ZoTuAsTuJ+OMd8XUmqfYS4DLA+/+guDw/8s6I0bSODvBCLWMaosSTKoY3pa44wl9/iGCJBB5eVRoTGHReMwA6Ud+WVqljLenygJQ7n08JaUmfDgeHU9DIr/523K52y/0f1UZ6rDci4hHBz+VEMPPheuBAKRtVQOe8bgG7BdZKkhjA2RpqnsMlO0ZRWgxkzRFk/Xdv+kpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DaL4UJRY; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DaL4UJRY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMLKH3Pdyz3bps
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 19:56:51 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 71B8C40105;
	Fri, 22 May 2026 09:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17D51F00A3D;
	Fri, 22 May 2026 09:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779443809;
	bh=8vN/NoLezPEDsyDS+onUAQhVhhGZl3+ewdKbIEUAKPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DaL4UJRYwHkj/GX5iunjonDR90BGEe/s2tZteURXKh9dnWNBeiNFQJ5SCTQFlKWc1
	 IoaN/VFqllJIOmXFbYD/My1O0WPky09e88AD6UxjVLilQ74X2qsQf8eSwcHofKxqkp
	 x2fdFtCWVg8CEvDVsWKDR1hbk9aG9JxRgeryG4+OFZJudEgZXJDz/DG0Ncb/Z/L3Zl
	 FcyQtSxoRElzlt8LBUbY+7CjFGmxm00rqV2ad1H3MH+/t2d29/BxTspVyKkJZnZXjx
	 BTHvomF/B5ZoCQD727ef7OuEQR53uXXLGpyfYaf52Dg9gQr95KnaA15gWPQ4303Td0
	 pe0/usVMBo6WQ==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 4/8] powerpc/signal64: Access function descriptor with scoped user access
Date: Fri, 22 May 2026 11:56:04 +0200
Message-ID: <fb1ae719648dcf0039e23c50122357a96d36ace5.1779441786.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1779441786.git.chleroy@kernel.org>
References: <cover.1779441786.git.chleroy@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1246; i=chleroy@kernel.org; h=from:subject:message-id; bh=9S3bhpCCSnE4Jl8KeXsH0H6BKtYWsCDOtF5KfH9qYcE=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWQJaNhVMD3/0x8wLWxBudhz28rPhauPvNqj3X9PZ4W+l Hj+ncMuHaUsDGJcDLJiiizH/3PvmtH1JTV/6i59mDmsTCBDGLg4BWAiQu8Y/nvO2p3Dviv4nkrW Hr49bW41toeaP0a0/17yU6Sz7/Sn50IMv5i7EjR8fPbPWj1R6bs3V/eFjd8bt1TN59eUOq9n5td eyw4A
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Access the function descriptor of the handler within a scoped
user access block.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/powerpc/kernel/signal_64.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index ee8166fd83dc..bf7fc579d572 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -928,8 +928,10 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
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
@@ -952,5 +954,10 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
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


