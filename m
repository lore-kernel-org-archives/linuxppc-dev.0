Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB05606A320
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2026 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lokwR7G9
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXdQg4Ly7z2y7p;
	Mon, 23 Nov 2026 05:49:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795373355;
	cv=none; b=fGf8ppZdXlDCyNqDcxuRJBZDo/0KLlkVJELS0PDkMUS+fWbuKw6f8sebPqchleHYveXp3S5yHj3HUoDLMoPOTOzjgr1asmsobGpDlv8orgGegStEQRtFSUEvlln/oaoZq7gtGAHHUKMxMVfDrvgIsDp3BYJTR1MABT+KDSMTO7zevfTjTu0X1wDlfShr8TCNtEQZHWng4O7g6nOK5m5YNe4w0OjE873NrspktVs/mHEvyV877AM9Vf477N0cPNfBdcesnRpOhPoEz0Vf8o1Crz79P5aaT/yAty6KXkPMvl5b40oOB1XFm9CwH+ELTRR72I3IEfBIghwiy88nkTNsFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795373355; c=relaxed/relaxed;
	bh=Hp6O46SJ40Hw4uZlski03c8cfisBylNnJX3dNYz0nGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YWXkOtU/G2jJQNAcvO/1FFOsqJ+2LTTeWrkCEKTUqe8x5SqHgO9jmaPxfPD82+owu0HtETdVHJT7rdFjpkOaP9QDR4M7jR7VgXCu7pRtnU8KGSc21XeP9EwCu8Qq1CsD+rZkaTSeRJxaMXPXprm+OIphTWcJni/mtHrgiYdwtPzok6d3upC/m0m2F3Yl+kcMYB33v+6ROpszh3d3AmWE9ErIUL/xg4SKjdfHRAMkcIiHf3tAq7xfsP6cBoCg4gLOVDkZ0wHi4K73grmL2b9CgVHx3UPe7ngspSmh49eIkuil3t4syaUX7qhhr698e3bVPGViZ5dbaaD/XanbPqeAAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lokwR7G9; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lokwR7G9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXdQf65cxz2xLh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 05:49:14 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 036DA40B53;
	Sun, 22 Nov 2026 18:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E12B1F000C0;
	Sun, 22 Nov 2026 18:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795373351;
	bh=Hp6O46SJ40Hw4uZlski03c8cfisBylNnJX3dNYz0nGs=;
	h=From:To:Cc:Subject:Date;
	b=lokwR7G93/6rOSVJ//bRmDa5AiO7EYprGptcZlLdOcQajvtD/j+OmbWkOAafSMNcu
	 dbBtLffdS7Ij+RSyNPElc/d6880hc8Jdhddz9Ob/c1xU0Y1uOQdnX237WZ4qoXvRXA
	 le1zlRce1zHNDMo86uVsW7r6l91HItLoWsmaL+MTU+cPCw9hnSMuviDleuF1GR2VZr
	 xy+91ka42N88h7e6l9LpjF7d8b2P9xRx3cM5Emz7acpx2e3QJvmM2QK5rWNae07agX
	 N4y1f6cEKvmnf+SGRmGRHSiyPfMKu0rxuMxb7ckhidTekQV1NdLtJCs5IZNEe1FjVl
	 c60yN8eV5HQMA==
From: Thorsten Blum <blum@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Yury Norov <ynorov@nvidia.com>
Cc: Thorsten Blum <blum@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/64s/hash: Remove redundant 0x prefixes in htab_initialize()
Date: Sun, 22 Nov 2026 19:48:53 +0100
Message-ID: <20261122184854.24251-2-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002; i=blum@kernel.org; h=from:subject; bh=gDyf+ZqlwrLrK9a9BoPLTU/kZrwVgwQIdu1KUSF7DWc=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDNnMlmICaxT9DgWsv37o79Z701553dTmY1HvW3mxrGDRl EkRkhvzO0pZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAiOlsYGS71KeWdfnJW/8Cf vnl67z+LXmef+ll11bOPN268yuHMFNrOyPC36U3J/ReCR05aRX/doCTZG27re1fp7ar1ou1sa0V kGjkA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The %pa format specifier already includes the 0x prefix. Remove the
redundant prefixes to avoid printing 0x0x.

Fixes: 178dd2ee2b72 ("powerpc/64s/hash: Fix phys_addr_t printf format in htab_initialize()")
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/powerpc/mm/book3s64/hash_utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index e4fcf929cb33..555d79ba18cc 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -1405,8 +1405,8 @@ static void __init htab_initialize(void)
 		size = end - base;
 		base = (unsigned long)__va(base);
 
-		pr_debug("creating mapping for region: 0x%pa..0x%pa (prot: %lx)\n",
-				&base, &size, prot);
+		pr_debug("creating mapping for region: %pa..%pa (prot: %lx)\n",
+			 &base, &size, prot);
 
 		if ((base + size) >= H_VMALLOC_START) {
 			pr_warn("Outside the supported range\n");

