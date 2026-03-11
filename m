Return-Path: <linuxppc-dev+bounces-18073-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502AF1125859
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 17:36:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWHwf2M5Tz3bnJ;
	Thu, 12 Mar 2026 04:36:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773250578;
	cv=none; b=AefUqTWRoEm6IT5bm9necQ6/5GCa7nkbdqpptB/CrsFfuk6ZAWzNB4IG/ip4v1fgUI4XU9LWufti0xTUOS2/1iWswX64Wlk8IWb7dIqOhDe81wQTwkSEhe2hFvy/s8kWJ6eQo832u1RyBsWwan9LQesXPPotZoi6Ju+dwStmVAYt+lq9XBfJwnWG9JwZZw9qqciylORaNoPj4llUSN61Ja5Tzljr6GcyLBSXjNJkGkj3TO0fVB8eqmBdXuFO/oHLBTHziS6hjXABjO0AA5r3IohgmmeRqOFJQd29+6efY5PQkudkcxSpt+gDsJ/XOjXIAaE0AFoSY+eOknrDtQC9dg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773250578; c=relaxed/relaxed;
	bh=/n4FZenIz8wQOxAo+5+aDnwYgrj0fGGzeSXpZxRkgHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IJZe2Mfh6MPqw7m+lsLNv1k8ErzWUvFCAs8c34dofSFZRhdr9T7grrI7gTtHEr4by8wxHGpJj70UHcuGE0ZQCgVuXFIDSaulNssLVd7M5S55Jb1PxfU1/b/czZDoIMJCsyNl7k+Vxn/BLDPLXRqaWYLcaWp7CfLV4NyZb/fLTBI3rae/jltYxp6otA5dfI1YRYwROHXG32dp0DjNa5/cm5MRg4FiZVJdPFVCVYQGHDF27A/HrZGhVe/RTbivZ1l55bCjM3vUrLR123hBd85v5ISjCfvPgI5AlzsEer+kgTn69qEdcEZ1WY58dvHiB1tUqvru6V0acYktMyOk/6WlRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SZtIEoqG; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+j.ne.posteo.net@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SZtIEoqG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+j.ne.posteo.net@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWHwd3Txhz3bf8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 04:36:17 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A3BE24456B;
	Wed, 11 Mar 2026 17:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CF13C2BC9E;
	Wed, 11 Mar 2026 17:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773250575;
	bh=sYp6SDAoGDNbT6mgkoV4qYqYzFe4douGMtogxZUg/TI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SZtIEoqG91q8bUKj+cVruHBbPaK25z3wGdLyYgPV2+t/vlxsG1aqrte0zYaQc6azB
	 qCbDVJgKj+ti9uV8xqrbT+ExZlDCsEYcBGE0h9IJscWZEK7ff5wzmdT6Ifm75wZ99g
	 e3e8nJxE6uia3fKMw/gJw+0FT1cZckfnZy+VecQTDTWwV4rEfi6ezgDoT3aD8rrOwm
	 jkbX/DcHbbXHz855KxHcd7Ilk5yg1zX9kl4Vfh3KNrBMw/vYbGYAnn/34rLPafLJN2
	 WFr0yaUD4ybRfTKbrGU6dWKJQW4uI/KBFGLSeF71mz2VLI67MX1rqWLvm1hrawwXKw
	 XmSNb3EgBs2yg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A86C1125859;
	Wed, 11 Mar 2026 17:36:15 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Wed, 11 Mar 2026 18:35:57 +0100
Subject: [PATCH 2/3] powerpc: wii: Fix GPIO key name pattern
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
Message-Id: <20260311-wii-schema-v1-2-1563ac4aefa8@posteo.net>
References: <20260311-wii-schema-v1-0-1563ac4aefa8@posteo.net>
In-Reply-To: <20260311-wii-schema-v1-0-1563ac4aefa8@posteo.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Link Mauve <linkmauve@linkmauve.fr>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773250574; l=841;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=tYdEm39DKLsN+x1RpeowsrJyD+YP6FEzuLwykYwk9Tg=;
 b=eu9NoxwayNEl+/lwzPRUx2hDf2f/CIq8ukS16+rS7u1veFXrlYg4Je6EO0OllPuFTl0P/IFJQ
 m4mqXChvjZiDuGcPr2pjiPZEde5GpJVtDCvkqzolstrWf79oQpkrfo5
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

Adjust the names of GPIO key nodes to comply with the schema in
Documentation/devicetree/bindings/input/gpio-keys.yaml.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 arch/powerpc/boot/dts/wii.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/wii.dts b/arch/powerpc/boot/dts/wii.dts
index e001c4c6fd79ad..57d428b1f78740 100644
--- a/arch/powerpc/boot/dts/wii.dts
+++ b/arch/powerpc/boot/dts/wii.dts
@@ -256,13 +256,13 @@ drive-slot {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		power {
+		button-power {
 			label = "Power Button";
 			gpios = <&GPIO 0 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_POWER>;
 		};
 
-		eject {
+		button-eject {
 			label = "Eject Button";
 			gpios = <&GPIO 6 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_EJECTCD>;

-- 
2.51.0



