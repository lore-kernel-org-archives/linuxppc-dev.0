Return-Path: <linuxppc-dev+bounces-29643-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A88CCF2C9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2026 09:13:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j6tJR4TLDz2xlk;
	Sun, 18 Oct 2026 20:13:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792288414;
	cv=none; b=lP1CttwR1/ld/y/eZa3fUaI/AqV/vB9iddm7oHUWfT0KLjnN/u4+XKNC8YV0G29sAeOmDBYT3nP4plLJz+acGEdFIhgi/+Enw2ZI+NlxWh/2MlTHxmV3JBfywrAsnTxYzF+zU5c8PS7HdkOnq0nkySE9/6tbAit/ejOSGnZ2QKn8x7ANsmrz1lpYmCfseoo5mSa7DEdGI635fUY5crGcvAK8w7uFulPWa6UvG3yueUp/VSrV+i6LowUrxjbokEMiUj4fs1BI+AyLSGnExfzDx5/h7sog7W2MDzeyMKgchlL4CGRKWvakjb+Dg3Q0XG+L9PdTO6/DMesbnseXEC+AYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792288414; c=relaxed/relaxed;
	bh=lsYh4u+DYPUqhXBMq03iEnUnM/d2oVIMCY2NQWtGtm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZXhNHMucZrSEUO7V8gQNLtFfjXf3WFucZX7j5nH2QjyapI6ZO5cN18+cx0ziA7ctw/lzfyYpFHqn+LTx+yIRLSHY71c0GwoAYPqP6P4qxdlnKOYr0r7HP7X5MMEtLbAgjVUo6gL3ViQnKtCJ9DY/ZjEPyw3PK2cRA5xOWAV4kuL1ZFbWk7e+dmi60BR+VXJeaE49zmiS2gnMfbHr+SjkIgZ9M8BXYa67xfLQEO88VPJ4LHyyJuUxPpcg1STIbgnq5MazdcUZorumAq/Tw6ehdelYH4zIRaJm58S7mIGu85iASkBHPtagxmymn2PZTyk9osF6AO7+/FEzerwrDefJfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IUFc7P/1; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=pepe.schlehofer@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IUFc7P/1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=pepe.schlehofer@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j6hXr2ynLz2xlk
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 12:53:31 +1100 (AEDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4a1e3098ee2so1115555e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2026 18:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792288407; x=1792893207; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lsYh4u+DYPUqhXBMq03iEnUnM/d2oVIMCY2NQWtGtm0=;
        b=IUFc7P/1/U/lKJsbiCx2/uD14waN/rE1ZuDghDQsXsdp7EcdS/DD2L+BexcgaJVKQC
         wuzqaYVsqPSMevn9HoHKsOzVPRIflRsdgzvHOqXrVUz9gpV+914sZOuz3T590XWJfNpv
         LH08R6UcqEbds5n1BM13/bKTXEjgO1j6KYjmNyRDXlUi9wNtVEPTAp/e8swN0RqgLdlV
         QWW3gN11nVOTcA0EYlLMneJuU2ns9ne6wEZ4c/OO9eFFeTdX9y2LbSzLyU5REr0S3/a4
         +mwlKguCWZA+fX5lZCEYclWel0hbvZ+8EqmY8oVoRnzDI7mZGFPQlnLEef4Kuxk3/MF7
         6wMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792288407; x=1792893207;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lsYh4u+DYPUqhXBMq03iEnUnM/d2oVIMCY2NQWtGtm0=;
        b=QIQuBO0uItajHvmVFiojK/aeFaPzNXcAsOsVKVgnvSEwa6H9GPHiU5nfPG1tGu27z3
         L6dQynVvQbs4MTn2WXnqXT91JlEzoBF/irfcZk1D1inpP+AENgOhZVNF7KP8VEIeaS8w
         F2nwHKMtZqapMfO7OdeBN2MM+fH1rD2cHiflh+gvrCNHxkNiEAE3BspHpCI3T2DytWHU
         kQMqEb6nyM1DfmOisvgOC7YnVUHaT94jYZGnE1/fI3N3ZrSmyb3QRzEN5TL5GRthzZAL
         ry8dF+qdqOsN21nm5G1wdcfd5o23LKz4aNIHfnMlK3DmpMyb4jAsa+SeHPF2NTgeNc9O
         1Wqg==
X-Forwarded-Encrypted: i=1; AKwUvBxWpJ0zEcM6oO9dIzhohqz3cQlisoOZ9vh9L5vmL/SiJvU+qW/TdbwrCM8H63gRUGmN4qSF3zcpqXp+S5Q=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKcDg6UqGxSA5oyyTk8IFRrI9XJfJUH9GAZvx4rn9VY5mOK+JC7
	oixkDvKte/f4FmsuuLWsBQigJ6Bba4NI+7H/mVogEV3PIl7r4Uevo4sR
X-Gm-Gg: AYBFou0NB98MXg7Y30qfnUEvlD5cde7sA3rkLsPGimnVphAJvbxsxsD2X0lxrRnWKov
	KyAWzSxi4PeGwZnZygIbYHEdnQv4X9BM7NH8j2Gc+pkz3DAuG3rR87fmVInEMtWIVprLyniQ5Sj
	RqeMC1Nh9LYLqdDf9AphC9w8rAp8WOfhqe3X0wvfRRefhLXZ8mOIae1327wkUn7cWLh+aEqk44z
	6sWMV1sS6urHMIb01TuQ63nlcQQVBPkiEFjQD3aiz5xAixbTwC69KUSSq8K0IpSrWChPqcflOAf
	9ubH14+nF83R3gxWw0jtC0uW6IOHFTfPM3Krp9xdmOPoUuBDbT76oRr17X9FHy/H2o3qjcgHcFe
	4rDcUD1RnpygsVhDDVyRfd2GJzLgvjE3jWf5BS55BBcSMKco/oEfRVKtdLrmRHIub2XxBGX9p1/
	PVUNj2ZbFF/OnAJeRRSPCcsaURm5En6sTf2Z7Ec6fkg7JZQjRKbBoOFgmdZxqst6QBHZp/jZoDm
	3QxeOptw/zn/U2NZBK2hj2M0QSrIHqMcJ5pKrAb1+7hO4FUx+bg4aVoI0VZe5uIyVniNey3sxdr
	8I1dl6HXkP6X896nhlf8QyK10IWLgZtnwubquVWIbpPpgq76mf5bf1nAHuIVMDlj3+4Aw/4JGjm
	+rLvoWoso3LQ2nztmXmCvjA4=
X-Received: by 2002:a05:600c:a4b:b0:4a0:eae0:b30e with SMTP id 5b1f17b1804b1-4a1d7604051mr83202275e9.22.1792288407109;
        Sat, 17 Oct 2026 18:53:27 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-318a-f58b-5e43-a2b9.ipv6.o2.cz. [2a00:1028:8388:a84e:318a:f58b:5e43:a2b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c5957sm13802245f8f.9.2026.10.17.18.53.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 18:53:25 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] powerpc: dts: turris1x.dts: Describe switch PHYs on the MDIO bus
Date: Sun, 18 Oct 2026 03:53:11 +0200
Message-ID: <20261018015311.4822-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
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

The QCA8337's integrated PHYs are visible on the same MDIO bus as the
KSZ9031, at addresses 0–4. Since they are not described in the device
tree, qca8k accesses them through the switch's MDIO master.

Describe the PHYs and reference them from the switch ports so phylib
accesses them directly through the MDIO bus. This fixes intermittent
WAN link recovery failures on Turris 1.x.

Tested on Turris 1.1: 40 WAN link down/up cycles across 3 boots and
10 LAN link down/up cycles passed.

Fixes: 54c15ec3b738 ("powerpc: dts: Add DTS file for CZ.NIC Turris 1.x routers")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---
Tested with OpenWrt's 6.18.44 kernel.

Andrew asked in [1] whether the internal PHYs show up on the host MDIO
bus: they do, at mdio@ffe24520:00..04. The same workaround was found
for a QCA8327 board in [2].

[1] https://lore.kernel.org/netdev/20250425151309.30493-1-kabel@kernel.org/
[2] https://lore.kernel.org/all/ao8DqOFZJkln4pvh@larwa.hq.kempniu.pl/

 arch/powerpc/boot/dts/turris1x.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/powerpc/boot/dts/turris1x.dts b/arch/powerpc/boot/dts/turris1x.dts
index dff1ea074d9d..977f9f9c63c7 100644
--- a/arch/powerpc/boot/dts/turris1x.dts
+++ b/arch/powerpc/boot/dts/turris1x.dts
@@ -143,6 +143,27 @@ fixed-link {
 		};
 
 		mdio@24520 {
+			/* Integrated PHYs of QCA8337N-AL3C switch ports 1-5 */
+			phy_port1: ethernet-phy@0 {
+				reg = <0x0>;
+			};
+
+			phy_port2: ethernet-phy@1 {
+				reg = <0x1>;
+			};
+
+			phy_port3: ethernet-phy@2 {
+				reg = <0x2>;
+			};
+
+			phy_port4: ethernet-phy@3 {
+				reg = <0x3>;
+			};
+
+			phy_port5: ethernet-phy@4 {
+				reg = <0x4>;
+			};
+
 			/* KSZ9031RNXCA ethernet phy for WAN port */
 			phy: ethernet-phy@7 {
 				interrupts = <3 1 0 0>;
@@ -174,26 +195,31 @@ fixed-link {
 					port@1 {
 						reg = <1>;
 						label = "lan5";
+						phy-handle = <&phy_port1>;
 					};
 
 					port@2 {
 						reg = <2>;
 						label = "lan4";
+						phy-handle = <&phy_port2>;
 					};
 
 					port@3 {
 						reg = <3>;
 						label = "lan3";
+						phy-handle = <&phy_port3>;
 					};
 
 					port@4 {
 						reg = <4>;
 						label = "lan2";
+						phy-handle = <&phy_port4>;
 					};
 
 					port@5 {
 						reg = <5>;
 						label = "lan1";
+						phy-handle = <&phy_port5>;
 					};
 
 					port@6 {
-- 
2.54.0 (Apple Git-157)


