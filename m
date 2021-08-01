Return-Path: <SRS0=vFFG=MY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33737C4320A
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Aug 2021 07:39:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ED6D6109F
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Aug 2021 07:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7ED6D6109F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GctL94Kl6z3cVB
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Aug 2021 17:38:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=luna.linkmauve.fr;
 envelope-from=linkmauve@linkmauve.fr; receiver=<UNKNOWN>)
Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net
 [82.65.109.163])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GctKl6nLlz2ykQ
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Aug 2021 17:38:34 +1000 (AEST)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
 id E65D9F409D0; Sun,  1 Aug 2021 09:38:30 +0200 (CEST)
From: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To: Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org
Subject: [PATCH v4 3/5] powerpc: wii.dts: Reduce the size of the control area
Date: Sun,  1 Aug 2021 09:38:20 +0200
Message-Id: <20210801073822.12452-4-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210801073822.12452-1-linkmauve@linkmauve.fr>
References: <20210701225743.14631-1-linkmauve@linkmauve.fr>
 <20210801073822.12452-1-linkmauve@linkmauve.fr>
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
Cc: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>, linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Ash Logan <ash@heyquark.com>, Paul Mackerras <paulus@samba.org>,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.ne@posteo.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is wrong, but needed in order to avoid overlapping ranges with the
OTP area added in the next commit.  A refactor of this part of the
device tree is needed: according to Wiibrew[1], this area starts at
0x0d800000 and spans 0x400 bytes (that is, 0x100 32-bit registers),
encompassing PIC and GPIO registers, amongst the ones already exposed in
this device tree, which should become children of the control@d800000
node.

[1] https://wiibrew.org/wiki/Hardware/Hollywood_Registers

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 arch/powerpc/boot/dts/wii.dts | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/wii.dts b/arch/powerpc/boot/dts/wii.dts
index aaa381da1906..c5fb54f8cc02 100644
--- a/arch/powerpc/boot/dts/wii.dts
+++ b/arch/powerpc/boot/dts/wii.dts
@@ -216,7 +216,13 @@ AVE: audio-video-encoder@70 {
 
 		control@d800100 {
 			compatible = "nintendo,hollywood-control";
-			reg = <0x0d800100 0x300>;
+			/*
+			 * Both the address and length are wrong, according to
+			 * Wiibrew this should be <0x0d800000 0x400>, but it
+			 * requires refactoring the PIC1 and GPIO nodes before
+			 * changing that.
+			 */
+			reg = <0x0d800100 0xa0>;
 		};
 
 		disk@d806000 {
-- 
2.32.0

