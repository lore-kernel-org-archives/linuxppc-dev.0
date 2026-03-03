Return-Path: <linuxppc-dev+bounces-17583-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A81EDA682
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2026 15:09:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQK3P61gCz3bt9;
	Wed, 04 Mar 2026 02:09:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772550593;
	cv=none; b=VNkm5GxK/+i0fl3ZWWMTSVT1Q2pw+rlAZbV18paMjy/tpPSuCoxQKwAP2SBsxLs6kzfex94k3XXvwIAHaIQ4UgWCftvx6vF2wrmdYLfoQyHs7J8u9XjtUjnp2wdiv6RVKAFCXBmP1wciyufXYcNPgtuiZt58grRsHvffAgp1JFZnId3R8wWnyNxGuNkPlMXPDq+46qT2g2L6Odf4+7zgiuHQfbrEM/okXE/qyAZb5HaIS+Mh60WASuJSaAUZ4CkHM2qhysrmHD4BNF8jRRlYr7ycdIko7uYds4v/MW8ZXB3MUZ3g10TM2Q3881bRwD8QkHAkXBtliOhPzlXjXYvq+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772550593; c=relaxed/relaxed;
	bh=YB7W/b1VQn0kvNgrqs3UC9ByQmqXrG7dIuJcfO3um30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PdQmpXvV1lkGrg94nyU/7w3tTOOK8uEOdmE43hoC0ZgOD6wox6uSuCaAZtS/G1ImFvNIlULsFRVDNPby9fYIlSOy87FhGiBLphJwXWmsLtGt3mSSopmDPdAanB2DuHBlxHd8w+rWof3Ipcuuq+aWu7Ls4kaBFDSJRy5jeFjpvYoVdUfTCH0J8f9ioF4/uNnvbuzzZfbl5Q9BwPkQ1X6A8iHmZu7p0dOprGW31RfbKRN1De3/gdtRFBkY2vXQpz1YbheUgr4dVx3oBCfYpQxVbql/JMe2lLd/iW4LhYIANwCM9CsIMDIaTrNaWc9U2BCBLt6BRQDA5971oEY1BIk7Pw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oEpXkRsB; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+j.ne.posteo.net@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oEpXkRsB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+j.ne.posteo.net@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQK3P0cp3z3bt1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 02:09:53 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 83D9443D60;
	Tue,  3 Mar 2026 15:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5ED17C2BC9E;
	Tue,  3 Mar 2026 15:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772550591;
	bh=R4w6+sdSTrHVY71plBapF63HN9oGwBYSt5kWxnbsngU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=oEpXkRsB9wHnAYPpdRbFWfJ+0ZcSWIzbZwV2CJQIwkoh/EUfyJtVoFwFUsftB5nYg
	 q8nfngUgi8DqRYrEEL8Y61rNZqBJNCMPo0qW0Fif8OLKSQ7hTB20d1u3KMFD64c/95
	 mev4GiezNk6CR4TaNcT5pv32za6syzyoGp0WZFiZan2v6qkR+jGbvytBbktAr1o+BM
	 Mt4XV+BrmiastrjT9OCFkHKl7lbMhbW9XRfpnQ838RI/r58Ak/OaGMNSY/Yb7zgVCa
	 97YQ/EymVY5ogIDKnfK/IQltYtfJo+AQu+EWyKaD2xRe8Q0EVciBAG/SwAE0yJPDdh
	 70vVHGoO4YbNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DAAEDA683;
	Tue,  3 Mar 2026 15:09:51 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Tue, 03 Mar 2026 16:09:49 +0100
Subject: [PATCH RESEND] powerpc: Move GameCube/Wii options under
 EMBEDDED6xx
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
Message-Id: <20260303-gcwii-kconfig-v1-1-636b288e7270@posteo.net>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Link Mauve <linkmauve@linkmauve.fr>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772550590; l=2106;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=Xmi3nHsOpx0ZMFbJp+lFFK0uM65XCmoMsN2vzb2RwRI=;
 b=yiVBUQtZ+yjf3Bem6jDqzzZEFCyn8pmHnGrNQO0JTMrDNAXZgUUARRgjKbUoOBuq37W6WFgTu
 ewBssZJw5itAmj1Yd8mt/ux4HTcB8xa6N9MEisBWh1vemIWhMLc+/Wf
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

Move CONFIG_GAMECUBE and CONFIG_WII directly below other embedded6xx
boards, and above options such as TSI108_BRIDGE. This has two
advantages for the GC/Wii options:

 - They won't be moved around by USBGECKO_UDBG appearing or disappearing
 - They will be intendented in menuconfig/nconfig, to make it clear they
   are part of the embedded6xx platforms

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 arch/powerpc/platforms/embedded6xx/Kconfig | 31 +++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index c6adff216fe633..f406b3c7936b23 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -51,6 +51,22 @@ config MVME5100
 	  This option enables support for the Motorola (now Emerson) MVME5100
 	  board.
 
+config GAMECUBE
+	bool "Nintendo-GameCube"
+	depends on EMBEDDED6xx
+	select GAMECUBE_COMMON
+	help
+	  Select GAMECUBE if configuring for the Nintendo GameCube.
+	  More information at: <http://gc-linux.sourceforge.net/>
+
+config WII
+	bool "Nintendo-Wii"
+	depends on EMBEDDED6xx
+	select GAMECUBE_COMMON
+	help
+	  Select WII if configuring for the Nintendo Wii.
+	  More information at: <http://gc-linux.sourceforge.net/>
+
 config TSI108_BRIDGE
 	bool
 	select FORCE_PCI
@@ -77,18 +93,3 @@ config USBGECKO_UDBG
 
 	  If in doubt, say N here.
 
-config GAMECUBE
-	bool "Nintendo-GameCube"
-	depends on EMBEDDED6xx
-	select GAMECUBE_COMMON
-	help
-	  Select GAMECUBE if configuring for the Nintendo GameCube.
-	  More information at: <http://gc-linux.sourceforge.net/>
-
-config WII
-	bool "Nintendo-Wii"
-	depends on EMBEDDED6xx
-	select GAMECUBE_COMMON
-	help
-	  Select WII if configuring for the Nintendo Wii.
-	  More information at: <http://gc-linux.sourceforge.net/>

---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20260103-gcwii-kconfig-0ba5b415b99b

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>



