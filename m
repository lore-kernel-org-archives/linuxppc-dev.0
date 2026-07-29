Return-Path: <linuxppc-dev+bounces-25045-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04260C54FCD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 22:50:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9SGP3gkjz2xJT;
	Thu, 30 Jul 2026 08:50:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=82.65.109.163
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785365421;
	cv=none; b=ZIY4iQ2y+onuJ8qLX8OrwIdhvOZKWpZbj6JF0VBWpGFROdCaTaOv649ZCAZ6l+utOrOJ98UunnB32gMOf+ztTbtLTZ5RsuRVOu2Jz7m/HnJPwKH84fbtc0wy/xSEQewKQyz8U5Tn+t+sr4Tsd8x3B08BLvNjhMZQNza2Zn+T3v+lE7ePHnK6Rd3FQGmmhAfZm8gRwR1ItfFhEPqjBWeklABeqlhG6XcrWALChJUTvO6xAh9lrFNSyQ8HiTGBr36iPcc5eG5h6WNArztllMrZBGaFDFznSKbiyW34KKY9NFHTNPRVddzGIdF1pydG0O2CtR/4CNaXJUezIX4J8rR/jA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785365421; c=relaxed/relaxed;
	bh=P2e+I2aWLWUjEGk5tz+LiT5n4oTlRspoDGU0ntcWjmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FMcsZlHIZ0+wo0mKRhGCcu11eT4ItRe0bCvZMdhhzP4lGdoKDbwbDmmGUrAnNg4g6dYSsHtV3+qsAF4DCC2rNhqfXFBOFEAB0GB42nVn8Dkjhy0qnnsryg7Tencb5/p4t0Uf1DQsHB/14JfaYw9Ef5QYv8r7LJJHIqXl0oDp2JTRQxEs55eAg1vQxZ1bx69HgRVUpajzTNrqlDS0p75UP6i48xwPqlhSn50vcFMkUhotkpE3GpsAjE53OHRX1G6sCsi071B4Cpq1/eGMr7GHQ0TviQyBIee0gAY4harQlDansnHquyd/CLgVKBKIkbZnExyOb8xQ4qcb4rjL9M2NWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=82.65.109.163; helo=linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
Received: from linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9SGN0SVBz2xFc
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 08:50:19 +1000 (AEST)
Received: by linkmauve.fr (Postfix, from userid 1000)
	id 9290C7098F6D; Thu, 30 Jul 2026 00:50:16 +0200 (CEST)
From: Link Mauve <linkmauve@linkmauve.fr>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Link Mauve <linkmauve@linkmauve.fr>,
	Michael Garofalo <officialTechflashYT@gmail.com>,
	Ash Logan <ash@heyquark.com>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc: wii: Add the fixed OTP layout
Date: Thu, 30 Jul 2026 00:50:08 +0200
Message-ID: <20260729225010.838760-1-linkmauve@linkmauve.fr>
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
 arch/powerpc/boot/dts/wii.dts | 42 +++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

Changes since v1:
- Link to v1:
  https://lore.kernel.org/lkml/20260726181921.16269-1-linkmauve@linkmauve.fr/T/
- Switch to using hyphens instead of underscores as it is preferred in
  device-trees.
- Extend device-private-key@28 to 0x1e bytes instead of 0x1c, which is
  its correct size.
- Document that this cell and the next one overlap for two bytes, and
  it’s expected.

diff --git a/arch/powerpc/boot/dts/wii.dts b/arch/powerpc/boot/dts/wii.dts
index 473d9feb9cdb..d3a94d94e9e1 100644
--- a/arch/powerpc/boot/dts/wii.dts
+++ b/arch/powerpc/boot/dts/wii.dts
@@ -233,6 +233,48 @@ control@d800100 {
 		otp@d8001ec {
 			compatible = "nintendo,hollywood-otp";
 			reg = <0x0d8001ec 0x8>;
+
+			nvmem-layout {
+				compatible = "fixed-layout";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				boot1-sha1@0 {
+					reg = <0x00 0x14>;
+				};
+
+				common-key@14 {
+					reg = <0x14 0x10>;
+				};
+
+				device-id@24 {
+					reg = <0x24 0x4>;
+				};
+
+				/*
+				 * device-private-key@28 and nand-hmac-key@44
+				 * overlap on two bytes, that’s expected.
+				 */
+				device-private-key@28 {
+					reg = <0x28 0x1e>;
+				};
+
+				nand-hmac-key@44 {
+					reg = <0x44 0x14>;
+				};
+
+				nand-key@58 {
+					reg = <0x58 0x10>;
+				};
+
+				backup-key@68 {
+					reg = <0x68 0x10>;
+				};
+
+				unknown@78 {
+					reg = <0x78 0x8>;
+				};
+			};
 		};
 
 		disk@d806000 {

base-commit: 78bc8af4affb9a732504eb22eeac7d1e50883853
-- 
2.55.0


