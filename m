Return-Path: <linuxppc-dev+bounces-17234-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1410BFC5904
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Feb 2026 07:20:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fM2t86RHrz2yL8;
	Thu, 26 Feb 2026 18:20:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:c010:41de::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772090432;
	cv=none; b=gFXnw37o85JctlLor8N9ZniV7G8WLagcC2OfuwD87xz+EODxvanmOJY/fg2kyJSGEsnHfbiMEDebioQ//KwdUnmkfbqiuxc8AQc9tGaNvbvd0m0Y0Ipud4r9e7VHQVUOMrpy0CPCC8cnRArYDAf9cxLy/eqick0feZAMPNPyNf3uxfIOqgAUjE7TVBvVo4A9UrpchkAl7P69ei64vBiKMwBSPK1ljrqHakewVKNoDCEabzfEKQtCnt80JInVck1Hs3Intl0Ba+0sYAYmFUnYoWYqZ0iGW951pL5dbY2GpQY9cjVwG5kP6i1hqV3/u1wrB/6yRbL+r4F80nBgG1Y7Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772090432; c=relaxed/relaxed;
	bh=cZHAXx/W3VseODjj0gBW7px+iZGdj5Ily8iw1Xk8O5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eJfUNl2hdSgZITaBnWsWDsDgVmGElMqkCwnz81VaDd5T3OBM91+5f5Ntdg7xuYyusXz70bHZifJFHR5R+zrs5FAEXAOAZi5hWUwDXT243ONKMSJQx1ptI2+dM5KxxpAHYGkWF/u3206E30vq7akjdxBbPPSLoHQ2/plCf/wwdCaxmlik5+7auUxEKSbQela+Mu3Suk9Sdv63yOBxgPjunOr+qVUmJn/IQwIKxtS1queBVACRXTmneMfRgjP211OmauwaIcSCPLAxDWG1CVKg8/Rn5dd/37JPx8Ou8TJds7vQeF4uEq/jdHZVduZ2EyvDDQ8rM3BjRgkcTCIIlP7vfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=jT8yfCz3; dkim-atps=neutral; spf=pass (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=jT8yfCz3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=2a01:4f8:c010:41de::1; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fM2t63YkDz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2026 18:20:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1772090423;
	bh=LFqBpkOHHrz0+82+lCKyk++cLTVpgpMp3m07f0lNCgQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jT8yfCz3TIppnkqYmB8/TpSvxEhN4jrG2cAyDul0n15YBJ8ggCQjwtQPbiOOLJyG5
	 z2bxbSx07vjL/gfWaSw/nLHKjCYxrM7c8vXm9bNjbMWZwr5Uexaz49LnvE/I14mg/Z
	 jNC1mgH9K2B321H2bxFGFcA1h7hhGe45PNcWwXR4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 26 Feb 2026 08:20:12 +0100
Subject: [PATCH 1/2] ima: efi: Drop unnecessary check for
 CONFIG_MODULE_SIG/CONFIG_KEXEC_SIG
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
Message-Id: <20260226-ima-ifdef-v1-1-8b9613edbbdb@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772090423; l=1084;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=LFqBpkOHHrz0+82+lCKyk++cLTVpgpMp3m07f0lNCgQ=;
 b=nAGuJZ+hD7tATfpRDB+PXn1L2Sppj9pwxenqRNLuGBmFSNYr51V69W6Utwz9lEKLgATOQDLvH
 kfewoqnvE0QCWYsxgMnFHPoexywWkeZBnHkIf3srxtygU9BxU3+Ur4Z
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

When configuration settings are disabled the guarded functions are
defined as empty stubs, so the check is unnecessary.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Reviewed-by: Nicolas Schier <nsc@kernel.org>
---
 security/integrity/ima/ima_efi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/ima_efi.c
index 138029bfcce1..a35dd166ad47 100644
--- a/security/integrity/ima/ima_efi.c
+++ b/security/integrity/ima/ima_efi.c
@@ -68,10 +68,8 @@ static const char * const sb_arch_rules[] = {
 const char * const *arch_get_ima_policy(void)
 {
 	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
-		if (IS_ENABLED(CONFIG_MODULE_SIG))
-			set_module_sig_enforced();
-		if (IS_ENABLED(CONFIG_KEXEC_SIG))
-			set_kexec_sig_enforced();
+		set_module_sig_enforced();
+		set_kexec_sig_enforced();
 		return sb_arch_rules;
 	}
 	return NULL;

-- 
2.53.0


