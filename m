Return-Path: <linuxppc-dev+bounces-18169-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14422105F791
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2026 10:14:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXL2G0WT1z3cKS;
	Fri, 13 Mar 2026 21:14:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773396885;
	cv=none; b=WX3tB80H1gqINcMgmElrmdRzcoZoZm3wGazceesx9jyYCRHzRzQr4K5OhI8hujIbZJulHIgKuWdv7WkJEtuY0Cqw587Plrp6307CP8hVYISRMQ1SPTFcC9nzKOdAgZucPUhaTA9UYY8B7iwnsL3JN7YYKqHEORV2iqdKFFiXumWicDn6FR/JgFdCqM3K5G0XB13TFsvBTb5A0jVdkl9e9x2SgITNGtNTPR4b6r8u2PB9e0m837gOSdC4j0A5IPbVQxIs8/CGZseulTLyKAaNLZPWDdaQLTdgllX61UVtA8iy0yxgMhoS4BEGNdhpU1IP/haNB+LUhZmlA1eGzWCDkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773396885; c=relaxed/relaxed;
	bh=1iKcg2XIqA1fM+bNB6D5XkACEvxeYjh8RbLamHf50J4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sxr6KaLIxE7gwHhriUfO+KiIUvjjEJp/3+uznJT46gLNaIX7JsHXO9dOAdM0pM0R2Y4w0W8zJG1MDSOErdNRjGl6V7NAkmePvQQMnFLEeAwnPm9YJLQrrY8pyv5xIeX4q+tP2wZcxzP+gymRHLGTfllPTAaA+Q+7oS60uTaTcRNsnRANUGZdQVyGdGkMdwSG7hulG3rFUK14TJg1Def4pyITb+Sdl6iQa69m31GJSPJK3hFk3RWiRmd6xnXd0R53/vm1Rf59mvVOxSUsaBoxaGOtNi01C7qtZndKHpLw91jySMkOu3OGhUd7v+qYICrpP5x0q7MOX/nOK4bGCu/m3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=krF9kX/b; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+j.ne.posteo.net@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=krF9kX/b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+j.ne.posteo.net@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXL2F11ZQz3cJr
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 21:14:45 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7E9F460132;
	Fri, 13 Mar 2026 10:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32910C2BC87;
	Fri, 13 Mar 2026 10:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773396882;
	bh=gDumIVv2RR3qsw/ZjdbEy9pmhUNNs186HjaeGl6tevQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=krF9kX/bhbfUiId287+ErRL6HlUVHPpzYfTgRXIPVQO1NJFtNEukxqU1UIw52z5vK
	 d+8vJ9nDo+78IAjPUZyMGHmRuU7H4eJr3N/vFbOgakbMj3z36mTM0ZU+JhI9AGr2iH
	 CAqkNEWRP1j/WqVQJ3YH67vUOWIfQc+4AtH2VUWQuaS5sCUnsN+FtiPajQNvufmGJr
	 /9X7e+SXzP+iHSJpMTNCgkJ5loBgru5R+2ZbHh4Ggv6sGfAu3GB9O+nM3zmnjAXytT
	 zY2NBxLCjk+cDFoGDebpTiEP97DlDVIpbU/2X9ZU68pFD/ojJ57+S+y+ofuBCBn2XS
	 sqLDRzNZW4TBA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250B7105F791;
	Fri, 13 Mar 2026 10:14:42 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Fri, 13 Mar 2026 11:14:24 +0100
Subject: [PATCH 2/2] powerpc: dts: Add missing model properties
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
Message-Id: <20260313-ppc-model-v1-2-bf19b3d1b65d@posteo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773396881; l=3236;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=qyXxRV38xWkpDO+hT68IGUbfYPxG01yo3fihfYhDmgU=;
 b=MGt01luTb+JtIHA5onvF3/Xiuo5FxKvu4GNC6SUJCflpd0lvLCTUuURz46iyDEhNRvlL18oMI
 nebfhkFGMQ1Bud9z7D1Vu2OPt30215o7ucVsq+aqJGjg0V2dtd9wlFW
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

These are the remaining PowerPC devicetrees that do not have a /model
property, even though it is required by the devicetree specification.
Fix them by simply copying the compatible string.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 arch/powerpc/boot/dts/mpc8308_p1m.dts  | 1 +
 arch/powerpc/boot/dts/mpc8308rdb.dts   | 1 +
 arch/powerpc/boot/dts/mpc836x_rdk.dts  | 1 +
 arch/powerpc/boot/dts/mpc8377_rdb.dts  | 1 +
 arch/powerpc/boot/dts/mpc8377_wlan.dts | 1 +
 arch/powerpc/boot/dts/mpc8378_rdb.dts  | 1 +
 arch/powerpc/boot/dts/mpc8379_rdb.dts  | 1 +
 7 files changed, 7 insertions(+)

diff --git a/arch/powerpc/boot/dts/mpc8308_p1m.dts b/arch/powerpc/boot/dts/mpc8308_p1m.dts
index 2638555afcc454..2b24efd944113c 100644
--- a/arch/powerpc/boot/dts/mpc8308_p1m.dts
+++ b/arch/powerpc/boot/dts/mpc8308_p1m.dts
@@ -9,6 +9,7 @@
 
 / {
 	compatible = "denx,mpc8308_p1m";
+	model = "denx,mpc8308_p1m";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
diff --git a/arch/powerpc/boot/dts/mpc8308rdb.dts b/arch/powerpc/boot/dts/mpc8308rdb.dts
index af2ed8380a867c..37b785dc787b7c 100644
--- a/arch/powerpc/boot/dts/mpc8308rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8308rdb.dts
@@ -10,6 +10,7 @@
 
 / {
 	compatible = "fsl,mpc8308rdb";
+	model = "fsl,mpc8308rdb";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
diff --git a/arch/powerpc/boot/dts/mpc836x_rdk.dts b/arch/powerpc/boot/dts/mpc836x_rdk.dts
index 4ff38e1a2185f8..d3d36fbf4e8695 100644
--- a/arch/powerpc/boot/dts/mpc836x_rdk.dts
+++ b/arch/powerpc/boot/dts/mpc836x_rdk.dts
@@ -14,6 +14,7 @@ / {
 	#address-cells = <1>;
 	#size-cells = <1>;
 	compatible = "fsl,mpc8360rdk";
+	model = "fsl,mpc8360rdk";
 
 	aliases {
 		serial0 = &serial0;
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index f137ccb8cfdedf..45f78da31da182 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -9,6 +9,7 @@
 
 / {
 	compatible = "fsl,mpc8377rdb";
+	model = "fsl,mpc8377rdb";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
diff --git a/arch/powerpc/boot/dts/mpc8377_wlan.dts b/arch/powerpc/boot/dts/mpc8377_wlan.dts
index ce254dd74dd06b..318e2e1f4284f2 100644
--- a/arch/powerpc/boot/dts/mpc8377_wlan.dts
+++ b/arch/powerpc/boot/dts/mpc8377_wlan.dts
@@ -10,6 +10,7 @@
 
 / {
 	compatible = "fsl,mpc8377wlan";
+	model = "fsl,mpc8377wlan";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 19e5473d4161b5..1abec806525844 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -9,6 +9,7 @@
 
 / {
 	compatible = "fsl,mpc8378rdb";
+	model = "fsl,mpc8378rdb";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index 61519acca22804..b1e6a85624bef8 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -9,6 +9,7 @@
 
 / {
 	compatible = "fsl,mpc8379rdb";
+	model = "fsl,mpc8379rdb";
 	#address-cells = <1>;
 	#size-cells = <1>;
 

-- 
2.51.0



