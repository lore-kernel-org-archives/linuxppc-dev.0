Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4240E609EE79
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SlUqjVrA
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFzx4M0gz3f1n;
	Tue, 03 Nov 2026 02:31:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793633501;
	cv=none; b=g5K8htEIiAK7DICYuq8oXGPpdgEw1igbsO1b5DvBkbCS7SCTCpzTOdIMtH3ldrTb1K1blJtk2Vm/M77V0Jn/Uz2Y1UHU5JYtzR73mkAQhMNQACfzrv1vKHNOHnmXtTeXP2MPtACPFKdEvLLUPqR4AmzrB/xF0XSfmhK2j6aajJoAg7sdyXDpdmRdWh+8BVraCsLP4HQEtrV0k5/mIu3c8/uKIjNb/SavUzIe8LiYQhEZ7bQKHT6KPBux5keJ5qJ9IuMkhMA/rMO1acB/Iw8JRy9ccOsjvzCELQN8CBwAp0frvSGjiFgmpKJZKjeFxV/22lQnjO96dh+/iL01V/tcMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793633501; c=relaxed/relaxed;
	bh=wMmkvcLfb2UIq3+22jdhBuPkivhdUr84mYH6JRb1Wjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5BQkPHV94V6O9AbJOqdrawI4bdPoOQfxUUSGXpvxJN8Ee8pHitlIWWM5hFqrAqDjmCFhJVyKC0h0fP4jvwSx23bEPfwglvIXUnF7LLOSXmrHzTU8PgBE29vP8UJ7U1RtsqnRmbPPr6f0l1WNBkvIKqSuUMHRs62LPIoPKWEhh5i7fvBj7jCdNAYfvHW+QpwMY6hiHEp2Xdtb6VWt4e0ELl4tOzU8OuO1wsSZubgoUbWYhBV2DKHsRB9VU3rMaUQqsT9n2/NDaRPvU8RCKGzhqw2Fne3ixwZJhzieBRI/BxeCh5vdxMouPchIJ/ths/kP1SisJ46XT1ceD5XO19D/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SlUqjVrA; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SlUqjVrA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFzx0JL7z3f1k
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:31:41 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 87F1243FDE;
	Mon,  2 Nov 2026 15:31:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3341F00A1A;
	Mon,  2 Nov 2026 15:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633499;
	bh=wMmkvcLfb2UIq3+22jdhBuPkivhdUr84mYH6JRb1Wjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SlUqjVrA+DuKvupx3wAphp3gFFQ1mrU0rIN1cS5VeiopSFgFzbaCbx8B8tbqqU5Y8
	 /MViur4ItkeFOLeQus+QJlg0zNT0u5UkF/0/9x5zPhO9DbWslwVQi5bBOmQLVuN4pF
	 fqR2gtklf2czJ6PgV2DrXnm9s0zE0FDBRLXrUEixp5V4U7KVgbJg1SrZ9WFT6D0scY
	 BE99zX8iqO8NSiVbbq5uk3HwBuySEZD6so1cMSVs2xaSKDcGXVhpQej1WAyQHlCKKq
	 arYx65H5hmXYMxPTGKqKxQYItCkyQZLs8UeH2vG6w2X8JmDk3tOqP8x3Gcg9j+V1S1
	 cvbkPCbeYywZA==
From: Thorsten Blum <blum@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Scott Wood <scottwood@freescale.com>,
	Stephen Chivers <schivers@mandarin.aust.csc.com>
Cc: devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <blum@kernel.org>
Subject: [PATCH 4/6] powerpc/embedded6xx: Use __func__ in mvme5100_pic_init()
Date: Mon,  2 Nov 2026 16:30:02 +0100
Message-ID: <20261102152957.300019-12-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102152957.300019-8-blum@kernel.org>
References: <20261102152957.300019-8-blum@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223; i=blum@kernel.org; h=from:subject; bh=DQpAMArsx0V454j55mEThyfCCKgQ0UM/KCPcob0Z2U8=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkv1jTuTyk8HHhkW4X7Zwv7p+fnSPw2N/RYaPLssMoNc eUQXs0vHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjCRm7wMv5imOOpzBEwPFvzd XVCTWdLnldjbvP6xaUdw7tTPXEZOmYwMcxj6KkIVEyucNzNK9zSetX8qkJvE3efqMLObSfaMwyY uAA==
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the hard-coded function names with __func__.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/powerpc/platforms/embedded6xx/mvme5100.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/mvme5100.c b/arch/powerpc/platforms/embedded6xx/mvme5100.c
index b2979a2a1721..f22e10eb0c65 100644
--- a/arch/powerpc/platforms/embedded6xx/mvme5100.c
+++ b/arch/powerpc/platforms/embedded6xx/mvme5100.c
@@ -75,13 +75,13 @@ static void __init mvme5100_pic_init(void)
 
 	cp = of_find_compatible_node(NULL, NULL, "chrp,iic");
 	if (cp == NULL) {
-		pr_warn("mvme5100_pic_init: couldn't find i8259\n");
+		pr_warn("%s: couldn't find i8259\n", __func__);
 		return;
 	}
 
 	cirq = irq_of_parse_and_map(cp, 0);
 	if (!cirq) {
-		pr_warn("mvme5100_pic_init: no cascade interrupt?\n");
+		pr_warn("%s: no cascade interrupt?\n", __func__);
 		return;
 	}
 
@@ -96,8 +96,7 @@ static void __init mvme5100_pic_init(void)
 	}
 
 	if (intack)
-		pr_debug("mvme5100_pic_init: PCI 8259 intack at 0x%016lx\n",
-		   intack);
+		pr_debug("%s: PCI 8259 intack at 0x%016lx\n", __func__, intack);
 
 	i8259_init(cp, intack);
 	of_node_put(cp);

