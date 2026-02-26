Return-Path: <linuxppc-dev+bounces-17233-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70853FC5903
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Feb 2026 07:20:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fM2t863Zkz2yFm;
	Thu, 26 Feb 2026 18:20:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772090432;
	cv=none; b=m98YcmYmAkmyI1W26yOlJuCRbVKfQxnuZ4vqKfGrf9j779olheUii1dOVs6fvJZwR/LC2nVseveJ25x6isA/bNWbZCfUF4BDqAnoWbKDkJLfxcLp4VHb6JSnGQKTUyx1ZUOOTWr6p6mtdIArfNhU6DrLAPIy9GwskkqpeYC/qKw8/8WDemS4rwwe3GkyAcygkdoeNz1X/YbfLM0H+2bNW5eDwwO0qth6P1ZJxfCFAqCQsHdXtIeuDXm0DkhA8aSFbaWnaPQrDwPv9J3laqkBPFs8nkfpkIqMCWI5QIh4g1ydEGPS3Nwidh4EZXAAruvEGK3kIyFPseIHbiy0fyiG2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772090432; c=relaxed/relaxed;
	bh=TUkHjQlUChF1W8po6LjKL50eL093iDAdQ3dORybLS90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dB/run2URhPk74yxiK/xVz5E6qgcbCDl42zTzxCS3+aKSB00SYURH2I5v2aVVnu3C4tdwFAJ8XfuByF9RBF65Jb0E8V2V2dLEhQl4iXM0AMqpQIZObms8T0gysCqlQVn8vbtWwLR1ObhEM4dEd3ES/1zkPAfbSoxZmulB9MfE7Ulor6qODWh0FQ6GtcW2Rul/Bz8p0lZk0kfaGn3IPp/Top7nDac4ZNRDweq9BsA8CMYV3wEOv+fGD4ZsRhOo1K/I/ZkgbRUG6iyi34Ot9MM2DLYBeKhRAlW/6da1j4R8mkNr6yiqBb3nBDVaxTV2kTy0okYtifwPgio7NH2/76syA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=ok3Ub7un; dkim-atps=neutral; spf=pass (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=ok3Ub7un;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fM2t63bPDz2yFc
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2026 18:20:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1772090423;
	bh=hGVXNH283Vz12qyYtbmn+Cp6jluvfJ2jA9ujNd1m+MM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ok3Ub7un4nVRc77yXyUtPQlm2mrep2h8nZA/ZGeNPePQ8CkRmwLhbw8s0BAds4Z0u
	 zbj26mSFuo/d5TWj0IpyP36rn8f5eGiKZj7eeEVlggl7H7l6qqN818GO8nzoYSIyoO
	 XDKg10Du5Q9bCVEAd/ctQ9crDqMrB09PO5TuYijg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 26 Feb 2026 08:20:13 +0100
Subject: [PATCH 2/2] powerpc/ima: Drop unnecessary check for
 CONFIG_MODULE_SIG
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
Message-Id: <20260226-ima-ifdef-v1-2-8b9613edbbdb@weissschuh.net>
References: <20260226-ima-ifdef-v1-0-8b9613edbbdb@weissschuh.net>
In-Reply-To: <20260226-ima-ifdef-v1-0-8b9613edbbdb@weissschuh.net>
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Aaron Tomlin <atomlin@atomlin.com>, Nicolas Schier <nsc@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772090423; l=974;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=hGVXNH283Vz12qyYtbmn+Cp6jluvfJ2jA9ujNd1m+MM=;
 b=G/Yhhszig1FESswrq2MsfL5TAZFn0WCOohRmn3HPMOhnbyqu9YUz3c9FlB4SOit5T+vJ4YC8I
 t1lqaIGPIDPBZFHzXvicJ/TgrCUa8y5xYNyWNbicaLYV8WsOpPoTa9J
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

When CONFIG_MODULE_SIG is disabled set_module_sig_enforced() is defined
as an empty stub, so the check is unnecessary.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Reviewed-by: Nicolas Schier <nsc@kernel.org>
---
 arch/powerpc/kernel/ima_arch.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/ima_arch.c b/arch/powerpc/kernel/ima_arch.c
index b7029beed847..690263bf4265 100644
--- a/arch/powerpc/kernel/ima_arch.c
+++ b/arch/powerpc/kernel/ima_arch.c
@@ -63,8 +63,7 @@ static const char *const secure_and_trusted_rules[] = {
 const char *const *arch_get_ima_policy(void)
 {
 	if (is_ppc_secureboot_enabled()) {
-		if (IS_ENABLED(CONFIG_MODULE_SIG))
-			set_module_sig_enforced();
+		set_module_sig_enforced();
 
 		if (is_ppc_trustedboot_enabled())
 			return secure_and_trusted_rules;

-- 
2.53.0


