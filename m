Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734AE6087622
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0xCskD2
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJG033JB4z2xSF;
	Tue, 03 Nov 2026 02:31:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793633507;
	cv=none; b=EqC2U4d/wLrucXUoee4CRtA6MvWnLwX6n36jhlIEo8bzTVccLVTR5jUgqo13u8mImaSQ0YLVJDeoM4I0KPDx44GA9k0lrPfFKUZDU9kOgTxnb2dWQbPyrNiw449XzGENZExZ51xh9HnT0otPq2vsN7to0kaTAzQAS0JSZpek5RDeqnakbb72pbt6wFUnyCxHTk0DD5PN+fA6EJ+XknLmUyqtFtMepr93G+3zKEV/6IxtpymBFmdOuT8QwCvZnw64OOQ2gQsMlSyrzeui4TuoXPkEYl1pyRgbwVYChjZY6b03Un2POE77ctUYSrSfipbjnWGry5s44c/d4/SVi1Ezyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793633507; c=relaxed/relaxed;
	bh=Zs0yc7hfCUyyfuvYuFp9idkJq9C39UALCEnyzzNFu4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JH7xO3wgQCcmrp6lGeNn7LmLovnSiCokwHqgymta/4u1afzA/IFo/AYSYNLQ/xlw5uwGCNy9K0bGYGEEE64drsQ9e/eTwdoo61vvzhK6S9VXdWRS81IyrApJM5Pmz5QXi9m17FHVPE3FdsarUgPHyi/06wnYCXQSwO4sx+h45I4ZfJ59L4ccKbyBYWeQ2DixfMgJOdWyZwdGpR0GWdyOQI07DYbusmO0UM2xHs8m59QgBxcvKD9ViJQ2DrvP6FSyi6LjV0W6+IjuqIibnHTk5VuKWmxbF1ZlCk7RfO3p8wJv2hsC0+XsM25Q+1MVM7vk+EmTWSJBbOmoqv87hsbEeg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0xCskD2; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n0xCskD2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=blum@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJG026H5Rz2xLh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:31:46 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 62EAA41287;
	Mon,  2 Nov 2026 15:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A00E1F00A1C;
	Mon,  2 Nov 2026 15:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633505;
	bh=Zs0yc7hfCUyyfuvYuFp9idkJq9C39UALCEnyzzNFu4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n0xCskD2tFQ6LsoMlk4Vfq+rBSeLSbi5l7O4cMyg92xtgC+U7Klj9ACf4l+ObJ1yu
	 gYL+IL0lU5CycNktu7G+DAmYdtWcGvn27AUGVwkKZKtyo9xyA52J5DkB3oFNsW8zXH
	 JcrHNgz077N+lnmwQ7O7czIIUdj7RBBkbqUpxFZbVxaYlKbfWa0SEEUdZxzuN0iE4g
	 jRCI6FGwYu40WXjCXjw1Hn4Gikdwd5YwTY/r/4p6dtRAW+u5A/4531SYMIRDp5IpK/
	 9F8/3eEPOkhntVK10EY7O86tAdLgf1cvBE3gbB3rK7DO5GRqVj8m7LCNTsdbkz26v3
	 rwki7F5QBhFYA==
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
Subject: [PATCH 5/6] powerpc/embedded6xx: Mark pci_membase as __initdata
Date: Mon,  2 Nov 2026 16:30:03 +0100
Message-ID: <20261102152957.300019-13-blum@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=809; i=blum@kernel.org; h=from:subject; bh=sLrnAV5jipybVaqGUaL8H8Sp9/7x0+b1dy7v5GWEcUE=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkv1jRfzWUx0a0V3qOsdGlOVtfWCiHLg/b/HVYvXvCbe deRxMXNHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjARl/mMDC/LLlufvf2ltCS2 Y8nxVK+bkdfM7Rc5vphxMyv00vx8Oy1Ghitfpnw8aLr1I2eH11pttaYG56xes29Z3YtCyvbeWML MwgQA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

pci_membase is only accessed by mvme5100_add_bridge() and
mvme5100_pic_init(), both of which are __init functions.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/powerpc/platforms/embedded6xx/mvme5100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/embedded6xx/mvme5100.c b/arch/powerpc/platforms/embedded6xx/mvme5100.c
index f22e10eb0c65..b6b4d0581fa9 100644
--- a/arch/powerpc/platforms/embedded6xx/mvme5100.c
+++ b/arch/powerpc/platforms/embedded6xx/mvme5100.c
@@ -35,7 +35,7 @@
 #define BOARD_EXT_FEATURE1_REG	0xfef880f0
 #define BOARD_EXT_FEATURE2_REG	0xfef88100
 
-static phys_addr_t pci_membase;
+static phys_addr_t pci_membase __initdata;
 static u_char *restart;
 
 static void mvme5100_8259_cascade(struct irq_desc *desc)

