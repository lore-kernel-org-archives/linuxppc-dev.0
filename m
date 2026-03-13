Return-Path: <linuxppc-dev+bounces-18170-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78A4105F78F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2026 10:14:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXL2L6q8Nz3cML;
	Fri, 13 Mar 2026 21:14:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773396890;
	cv=none; b=F6hgqw3xqMtjnRt3TOvaMnByuGIiz9VofIrYqRp5Jl4wSFg0fSSlyi9dmM/LEr/h88wjTRqXoLl4ScyfXA1fjejP2YK3e3UNr5SjgejJfJgbMwj7W4OW3iTGbc+jvse/zPXb/WNdnRddpfO5Ahn58ztrg5P0XJj9QjlIlKu5a5KppEge7wN+5apKQV7KhIf/QuGuG1XZuAVV8xZ8qBhGPAgBzG4OxAJZMwsLClKII2Zb+wNL9r+JAH3QlJEp2SL+6l4ZuC/M/ldqS5X3uuDkDI9pOP8QAM0qYlVguqpnxSABr0KzIA/02uIlXzsGlZ6x19NQYt3A0X1EwAGmg9fFrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773396890; c=relaxed/relaxed;
	bh=vBX0jqAE1R9RQTHGi5ReffuIwkC5Fr0lMdKaPmca1Ao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OCam4xdk9T0vVIM4B6sxf8WQ69RifNXFHQsmnuCFzhvTjX686ika5l9B38Ghjc6rQJp7t0uArXFmltxZlbmjv9ZIcvxf2PGGDlMLB2h2f7yf9Wfq3NKHYpTzc5xe1aBr3MPRY5mMyjY3+eXosQYPOq7tWLrb4uy7WBdnjuV3e9c5z1vb+PA61TDHv8uXOKXeqhl1oS1fZWKJR/Dw0wb/jGoywPa7CnjBy51Rc3yvsjJIr82Rc9jv9UuksYoM3bSaaVghTAV3RTXKhPxysNbwUKonAnIkIzTif8T1XAFaB6jfzmK2GSfveCND5xJ5jJTnUEWan5714p73k5da6ZbtVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ux4zeEVG; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+j.ne.posteo.net@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ux4zeEVG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+j.ne.posteo.net@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXL2L2Nnbz3cJr
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 21:14:50 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7EA1160133;
	Fri, 13 Mar 2026 10:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AC00C2BC86;
	Fri, 13 Mar 2026 10:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773396882;
	bh=/pO5zXw/fthiQHWvwEHxiXFG2mc46C68maKdMVoO3gI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ux4zeEVG1SAPwlqpR791eu1HaCw3k3B9Hffk/7zgO/uLtHUCbibnKRfj9C7egh558
	 LVzUUytnNsaBtHsfbW8iXwEG8qtvTTyzyqJUz+Ho97hRMQ1MkQVh832P67k/mlajM8
	 lvlXxasRC41GYyrM+NoNqhIi8/C1F/mVgTnV0C/q/EfrieGNG9KsTk4HcBiAW7OBHL
	 +EG2dwPs8qwtaFjTiJG+KN7k0Z4Jn50dlt5OR0v9XvazVwDenWISRlf3xSjumqQuWg
	 tjwe4w8/QnHsXFEV5+4QKQx5D1/EqygO4xrkZy4QOftd6DstPySeVPNpkZ3J3NyaOR
	 sOQZw37np++Hw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C19105F78F;
	Fri, 13 Mar 2026 10:14:42 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 13 Mar 2026 11:14:23 +0100
Subject: [PATCH 1/2] powerpc: dts: mpc8315erdb: Add missing model property
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
Message-Id: <20260313-ppc-model-v1-1-bf19b3d1b65d@posteo.net>
References: <20260313-ppc-model-v1-0-bf19b3d1b65d@posteo.net>
In-Reply-To: <20260313-ppc-model-v1-0-bf19b3d1b65d@posteo.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773396881; l=823;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=n/fxdtwbMAquaGebzGobrDraGsEGpPXQQhSlOEczEkk=;
 b=dtJysHo1jeWHtdEVPqw0MX6RrcpcMzqlk1jHr+6f+LP/gTsarP97ua2tGpMwR0jgzcUYOShn9
 +8B3gmyhHETA9Ckmj4HeU5jvbIPXNT9xD5h45Ill/st37PxovESUZwF
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

The mpc8315erdb devicetree did thus far not have a /model property, even
though it is required by the devicetree specification.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---

This patch was previously part of another series, which turned out to be
too large and unweildy:

  [PATCH 00/19] powerpc: MPC83xx cleanup and LANCOM NWAPP2 board
---
 arch/powerpc/boot/dts/mpc8315erdb.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/dts/mpc8315erdb.dts
index a8f68d6e50b0dd..100717e2cdc365 100644
--- a/arch/powerpc/boot/dts/mpc8315erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
@@ -10,6 +10,7 @@
 
 / {
 	compatible = "fsl,mpc8315erdb";
+	model = "MPC8315E-RDB";
 	#address-cells = <1>;
 	#size-cells = <1>;
 

-- 
2.51.0



