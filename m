Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4863C433EF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Apr 2022 14:16:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KZ3Mg38Nzz3bh9
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Apr 2022 00:16:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=VcCtVRbq;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KZ3Lz0lz6z2xsc
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Apr 2022 00:15:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=VcCtVRbq; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4KZ3Lt0lGHz4xZ3;
 Fri,  8 Apr 2022 00:15:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1649340934;
 bh=mARuJ2rMIvnW6hXg490ixJcRzru5t0ZHDaXEtUnRsbQ=;
 h=From:To:Cc:Subject:Date:From;
 b=VcCtVRbqm3radmf9QWnHrMwulvhJNyYFBi+cNzfq7zq3XZFaudmhxebOzN1SM0rRK
 CHlJyw7qN5NFEkZwGy+i2+Lr7P00WOJmw3+BpPNxSCjJ7W0EO6LLj+At8UnHb5ZyV9
 ijUnCKj2s5xIGOK5dRQFD5+k76glJKeVW0Dx6aTCRZjjUC5dMelCFOYhHXiVBOiun3
 yY2n+boMhivqyEZQC3HkVjLExT2DxDOugwlad5RClyjOR/qeRBLrnEQ/dnuHdLOHZ4
 wNEykoqASc8ngrGH5qK0dlLm5ENWb0vethUXyrr2IZ23/STNGn+K287QgWCXuVPjW/
 fKJoW9wHeF6dg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc: Mark arch_get_ima_policy() and
 is_ppc_trustedboot_enabled() as __init
Date: Fri,  8 Apr 2022 00:15:20 +1000
Message-Id: <20220407141520.733735-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: nayna@linux.ibm.com, zohar@linux.ibm.com, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We can mark arch_get_ima_policy() as __init because it's only caller
ima_init_arch_policy() is __init. We can then mark
is_ppc_trustedboot_enabled() __init because its only caller is
arch_get_ima_policy().

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/ima_arch.c    | 2 +-
 arch/powerpc/kernel/secure_boot.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/ima_arch.c b/arch/powerpc/kernel/ima_arch.c
index 957abd592075..accd228ddc3d 100644
--- a/arch/powerpc/kernel/ima_arch.c
+++ b/arch/powerpc/kernel/ima_arch.c
@@ -60,7 +60,7 @@ static const char *const secure_and_trusted_rules[] = {
  * Returns the relevant IMA arch-specific policies based on the system secure
  * boot state.
  */
-const char *const *arch_get_ima_policy(void)
+const char *const * __init arch_get_ima_policy(void)
 {
 	if (is_ppc_secureboot_enabled()) {
 		if (IS_ENABLED(CONFIG_MODULE_SIG))
diff --git a/arch/powerpc/kernel/secure_boot.c b/arch/powerpc/kernel/secure_boot.c
index f9af305d9579..0adf0f61d3b2 100644
--- a/arch/powerpc/kernel/secure_boot.c
+++ b/arch/powerpc/kernel/secure_boot.c
@@ -41,7 +41,7 @@ bool is_ppc_secureboot_enabled(void)
 	return enabled;
 }
 
-bool is_ppc_trustedboot_enabled(void)
+bool __init is_ppc_trustedboot_enabled(void)
 {
 	struct device_node *node;
 	bool enabled = false;
-- 
2.34.1

