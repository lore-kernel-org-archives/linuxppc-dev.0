Return-Path: <linuxppc-dev+bounces-18075-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2026C1125859
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 17:36:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWHwg49nYz3cDt;
	Thu, 12 Mar 2026 04:36:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773250579;
	cv=none; b=PY661KLeadVfaXOaUhHweQzsIwqwb1CJMGjRrWBpgvQHYKYuBxlcLeaksMYA0DrSSpInBSEq7Z5YvZ9gKkphE5QH4TdEokmW16JMIkBGOtvub9nlhQ0kg/jDio98afR9LLGrNGaVEkm2CU6UZCAX39aVWPhxdoJCk1Gs+F7WmS8eWnNQkAkqP4HcuO6m2igo+qkw6wHdtx2YU+7IOD6+2VoZjznCaWhHbjaMC2lmrit2dXy0G6cBUhuXBnFNEYIie8nxpurv9OOTXGPsAEigfrWiYBGl+byemocXoHZT+4h8oDEflRyGfD6xd6TvNHOVVjSJ41WcfwW67TrPnmclGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773250579; c=relaxed/relaxed;
	bh=ohO2WG6eFUEtdjgFSABoMyf6GcCQRN+aUNBEn/cnOuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IMUKarzrmx4WOf+Al4uCpW08r16YgxPBl0MxojCvAoWDpF7Sp+/aaSguw+6dkltiGLsXNxWh3W+lI4FFVoVq8Bps0TlHlGnr8Av2+XAWZXvCZOOEzcSSW35HQIs8h2XFhB7hpIx3R5Md+gYg1QCoKR0DXdhpnA08jA+FdJXfdw+BlRL8fSeLvo4V7Kc0k5QR9tVy+scJk4oYfn9ggSO/C5iq4F/Bh/aB+yPilxuBtOLJZpICrvwNeAYvBe1G2/FUyMv0UQrlhyEFnNTG2hJULHbsZ2JGPuw0EAOcwiIupBcf97zD811bcj0l+ubslwbXpgSLuL5+AGUWwDPfVwqMvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RBEo2dAt; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+j.ne.posteo.net@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RBEo2dAt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+j.ne.posteo.net@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWHwf44gyz3cBd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 04:36:18 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 990A044568;
	Wed, 11 Mar 2026 17:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B633C19425;
	Wed, 11 Mar 2026 17:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773250575;
	bh=BX/UkU9Vtj08pcIHU3Fjvxm9lXOnjY3ihmDu95vFG+o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RBEo2dAtxi1B83GuEbqsLusQGSvH3vMnfvo/N6FQFtNI5Fgax+KTnnLGAb3/2S6GW
	 8elok6L/NYg/zYoa4BNoGHLrpwzNMZ7Jd4Traggsm27Lyfli3Bc58C+YzEr5xXbzX+
	 pzXs4QawHOXT7rNOIQkqloLKWgMz9OBmQunvCpDug69T6g2zATlNDTke7enPoJ5Q56
	 FlL6iWTqZIbkrYMvrPtJWtcX9HxPcLboc5hsDe7IXBXi/AobJn3aVbYM4Zb5HnPnUf
	 skj7TlUgInuxix0BSPDob41C/llKCNRczLCPWcJLcFRwwoIgT7NJtxiPYDYCfBw+sF
	 867ptWM7KRy6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A7B1125858;
	Wed, 11 Mar 2026 17:36:15 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Wed, 11 Mar 2026 18:35:56 +0100
Subject: [PATCH 1/3] powerpc: wii: Add unit address to /memory
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
Message-Id: <20260311-wii-schema-v1-1-1563ac4aefa8@posteo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773250574; l=818;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=mJE8J3UROLwpIHwAWtFDUS3Blti09quatD3rOT0SWfg=;
 b=ylDvuZVLPNLElaZid8QO26o8IzgFIG7Yx18Wx4wLYXyw7WJPvg4rFnGOx2Pcm54GcqvJM8ODQ
 NeSWti1K4DiDImCVseuhM2kXLW+7sUJmumCcQ6mYUeWExL689YVUr/O
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

This fixes the following dtschema warning:

  arch/powerpc/boot/dts/wii.dtb: /: memory: False schema does not allow
  {'device_type': ['memory'], 'reg': [[0, 25165824], [268435456, 67108864]]}

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 arch/powerpc/boot/dts/wii.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/wii.dts b/arch/powerpc/boot/dts/wii.dts
index e46143c3230882..e001c4c6fd79ad 100644
--- a/arch/powerpc/boot/dts/wii.dts
+++ b/arch/powerpc/boot/dts/wii.dts
@@ -29,7 +29,7 @@ chosen {
 		bootargs = "root=/dev/mmcblk0p2 rootwait udbg-immortal";
 	};
 
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x00000000 0x01800000	/* MEM1 24MB 1T-SRAM */
 		       0x10000000 0x04000000>;	/* MEM2 64MB GDDR3 */

-- 
2.51.0



