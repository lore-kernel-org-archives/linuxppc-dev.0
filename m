Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3F360722B6
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aq8BOmL1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFzq5V71z3f1l;
	Tue, 03 Nov 2026 02:31:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793633495;
	cv=none; b=jtd5SthEHwkApUXd1bpwgL+hFHoETpYujK/qUkyJN3SxbV/qet++PCLnJhXBXaspiMOsct974RQkiie39U9bCV4lI/M+M+y47VtdYSiXJk1iRHg+O+HPR74ztPe1LGYb8WYnZFVDGYD1Q2W5+KfPu6vlYZASeBk1yOC3pkwJJaCgtcWCaWEM5l+rLHqzVjohUO2wBj3dF1qLro2LUIqq5tOkFfFgGDNLC/Zg2N7y+5Teix9CQ6hc1Y/UWyfqWXBEQCkC/TEjUiCoZ6kz2a9OQ9Lwx23oQ0THdllvk9g+h4gNh6N4cY8gJYZawz85q7LjjMfUN3mK0AtJIB8FuUpTeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793633495; c=relaxed/relaxed;
	bh=/MUczHsrZCLhXqfwnzNJcmotoXnZOpvgzY+6AFaxS3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SC9KjMXhyllaHwbEDaZYdws5i1LMbiR+BUGzC5yO8oJks0QMNCkvKWVXEv55mxMH7R4F0vm3FYWmzFBa4GgkZfn9u+lwheZvtbyHcBDdyKO5r2gyjcbiSmIF7qbp7og9SzpSnaVy6v2iBr7MwukPQeuWrOxJ2XPGSr3ERlq9xJ7u82hvG+UikQtMI0QTJ+2grxhS1ggYv+2iY7Lapc9bSlmrP+ZQkXeD6hkodGAy9EX8x58tV7CYYbePgMozmYKnh0FtDQStBdrPsk7RRc6crgRLnw78+deGKf4zKknbajNO/Twwbwe25eXfQzlPJwiajUCdUPrdu39i9Hjda7eISA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aq8BOmL1; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aq8BOmL1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFzq1Zgnz3f1k
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:31:35 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B483640C54;
	Mon,  2 Nov 2026 15:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282201F00A16;
	Mon,  2 Nov 2026 15:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633493;
	bh=/MUczHsrZCLhXqfwnzNJcmotoXnZOpvgzY+6AFaxS3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aq8BOmL1uomLOk7NJfas1WmVwDPWWH1Bu6HslgvC4jNKbNbmdODgCYmALYY1FxTQP
	 4fuPqMJYYwPzz0lwSnTFNmSIoX7zFHeBBWOZ8Wau9udySXWGiV1UCga0JdfP78y0Jq
	 VCEjVKaEcIu92l1lkCZ9PcoVAWeFhMGDePj1EnCLm6l0qBefzZx7Zwb0TlTK/abtjs
	 yZt0lUnH3W70Gqpv59NBMdH/IaA+RL3t7Mh31FZocJeEPuM5QA0XpykgJUtTBYx5B6
	 y0YQNECddDapKVsBALbgb1xqoff2ipMF0XzkC9X145yuLw57mD31J46Dkvv7Xbbeqz
	 bDuBYeLhiWtLg==
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
Subject: [PATCH 3/6] powerpc/embedded6xx: Fix logged function name in mvme5100_add_bridge()
Date: Mon,  2 Nov 2026 16:30:01 +0100
Message-ID: <20261102152957.300019-11-blum@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=804; i=blum@kernel.org; h=from:subject; bh=PeXDYQ0uhML6QLG6892JtiNuhqrb1CCXjntXNBLkips=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkv1jTs2PfcnZUlZElLb9K2C2dPv1jdu2+Vk/alYNOz+ aW5C/j6O0pZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAiyRUM/1R6Wu4sF7yQ3GP8 VXvZEt/7XFabZmRveHda5eErhT2fM3UZ/vDPrDe6tfTx0z4nvmbGSefEPydzRUp03704a366Xo2 VFhsA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use __func__ to print the correct function name.

Fixes: be2019816e4d ("powerpc/embedded6xx: Add support for Motorola/Emerson MVME5100")
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/powerpc/platforms/embedded6xx/mvme5100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/embedded6xx/mvme5100.c b/arch/powerpc/platforms/embedded6xx/mvme5100.c
index 6a88abac047a..b2979a2a1721 100644
--- a/arch/powerpc/platforms/embedded6xx/mvme5100.c
+++ b/arch/powerpc/platforms/embedded6xx/mvme5100.c
@@ -144,7 +144,7 @@ static int __init mvme5100_add_bridge(struct device_node *dev)
 		return 0;
 	}
 
-	pr_info("mvme5100_pic_init: pci_membase: %x\n", pci_membase);
+	pr_info("%s: pci_membase: %x\n", __func__, pci_membase);
 
 	return 0;
 }

