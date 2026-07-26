Return-Path: <linuxppc-dev+bounces-24844-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A01C531C9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jul 2026 18:19:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7VPT0NRXz2xyk;
	Mon, 27 Jul 2026 04:19:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:e0a:1040:9780:49:5ff:fe41:d261"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785089980;
	cv=none; b=fBQgi3ymxq7UbZ1JX0gUjBUMOEXOsfa60LIWAAZuiqrU+Cr/EY1yTPVesAGNYeXesge3YW+t5oh/hM9635k+29p9Tfbtm80+rVbKRsgFHbDyNriuG+78h9xoXrkqfADYZADi3KUQVaGKw/z97KiCHNwSWFXBBY+fiZGS7NVYxiqpXVWwornVsNsH7CHUqSrj7c855fas5RitbEXpeGuizquhDpNGQkEB+CUAgPe6qLGAfgAgyFi/NI8toGPLAe36jFS9ZCpbaMaF61L2fSXibPWjMGRJ2khz81TBj7+oSYgbe15BWCxM9g4hj7tX68fAqhfkNkWIbumbcjANkIT5Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785089980; c=relaxed/relaxed;
	bh=IsOzB8x/LpNBKVoFXO16AxjWNFHxoy7IV6c9YvDgm0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bautKFt3q09qrQlGPolQRRgQ1P2rzhBn3YSktqTdX5kwXsCEKnnxAf9YmOy9/ddCU1/PPVPpNUYXhU3RucA1P27Hy/QcNi6s3fXn/2yrDZ9HXwbtORoobGfS1Cbtka/e26GEbSHBOl5NzsEO4UW6D9kp5NL9UnNekNvi6yZnGCjmNvw81C0oj/rYqtwlymub6sccu3IbNh+EsuZGHxiIawKWrF3gggmOtH3MOwsd0X1hM7uxrxwHaDlilhz6z/yFK2alNt5e7uw47GJXDqZffF/GjEkVH6GG2YJJjDpJe9HhaxmEt84lgEY/Ef6auk1fUML7AHY5pfsN0/6ZWTpRRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=2a01:e0a:1040:9780:49:5ff:fe41:d261; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=2a01:e0a:1040:9780:49:5ff:fe41:d261; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
Received: from luna.linkmauve.fr (unknown [IPv6:2a01:e0a:1040:9780:49:5ff:fe41:d261])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7VPP2Zvxz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 04:19:35 +1000 (AEST)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id 0B081F40DE2; Sun, 26 Jul 2026 20:19:27 +0200 (CEST)
From: Link Mauve <linkmauve@linkmauve.fr>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Link Mauve <linkmauve@linkmauve.fr>,
	=?UTF-8?q?J=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
	techflashYT <officialTechflashYT@gmail.com>,
	Ash Logan <ash@heyquark.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: wii: Add the fixed OTP layout
Date: Sun, 26 Jul 2026 20:19:19 +0200
Message-ID: <20260726181921.16269-1-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.55.0
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These 128 bytes have a known fixed layout, so we can expose those as
cells for either kernel or userspace consumption.

Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
---
 arch/powerpc/boot/dts/wii.dts | 38 +++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/powerpc/boot/dts/wii.dts b/arch/powerpc/boot/dts/wii.dts
index 473d9feb9cdb..0d1806273d43 100644
--- a/arch/powerpc/boot/dts/wii.dts
+++ b/arch/powerpc/boot/dts/wii.dts
@@ -233,6 +233,44 @@ control@d800100 {
 		otp@d8001ec {
 			compatible = "nintendo,hollywood-otp";
 			reg = <0x0d8001ec 0x8>;
+
+			nvmem-layout {
+				compatible = "fixed-layout";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				boot1_sha1@0 {
+					reg = <0x00 0x14>;
+				};
+
+				common_key@14 {
+					reg = <0x14 0x10>;
+				};
+
+				device_id@24 {
+					reg = <0x24 0x4>;
+				};
+
+				device_private_key@28 {
+					reg = <0x28 0x1c>;
+				};
+
+				nand_hmac_key@44 {
+					reg = <0x44 0x14>;
+				};
+
+				nand_key@58 {
+					reg = <0x58 0x10>;
+				};
+
+				backup_key@68 {
+					reg = <0x68 0x10>;
+				};
+
+				unknown@78 {
+					reg = <0x78 0x8>;
+				};
+			};
 		};
 
 		disk@d806000 {

base-commit: 9eebf259d5352b87080d67758f483583d9e763d7
-- 
2.55.0


