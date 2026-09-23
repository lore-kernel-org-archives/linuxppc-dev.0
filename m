Return-Path: <linuxppc-dev+bounces-28062-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC59C98304
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 18:40:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqm4M4Nllz30M6;
	Thu, 24 Sep 2026 04:40:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790188835;
	cv=none; b=im3zR03Jn0YEweWn1O7iIDqpRnn5Hxpl43b0TZvMereizAN3pAJt4E1Wec8HY6HuLQWG20L5ZvRyGEEYT05tjD3P8VHobEOcjiCw0XTLjDm9Yx+EKfNxPCxKAWHY1HtIijhwKw3Ng3EP9iJ7Dnlhpm2XRqcL9dCQ4TTr73oC4v7wUvb4O29StkOlrnMTB9IqiltRitMa5V7dgWeeguViFTR4pYWx04ibaFub1VDPj2+jwBam1B3/sRQoIQONAAKZC/Rg1F595dw1AI1Jm0xjkLJ/rCZ9U+S2RpzRetY5ojl4LQOQeOINvr6tTpmjD8w2EUeYeuUVTd6yBAL1Q4yw4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790188835; c=relaxed/relaxed;
	bh=3gc3lVJFpeHvTVPTQlhw9bRs3DHSZ5NaiLqgYc9qgEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=feVyhxL0sCWh2RrCQ+HcdH1Z2K4EQOm01LgJrm3n9U7uy67Q30myxDn9+pdFeRAMHWDzhxW3/FrJ5NoZ/RbzQRZtsFu+8SCTUk13bwUcgZeq9Ila4vHQrnVWgiY8oM088PDsivfT2+fXHdpLyWWSJFQvNUrHW8ZUFodY3BPPcgKDRkO50jMPDyOwVT34y9/4oHvE3vv+KRuC6QnQV4OrI+t8B0/A66eVEO23m+zBu9k5HB0oe2XEq4QpJAu4tPrcuvSx/5FaNWUeM7nnH9sB8dnh9/euiMhRwyMEYJbCIAsZCZnjJpp7bW8P6w3Y4KrgS9/4uGU6KQtvVxfYN+d3PA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JxxqphU3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JxxqphU3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com [IPv6:2607:f8b0:4864:3b::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqm4L0gkRz2yDm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 04:40:32 +1000 (AEST)
Received: by mail-pz2-x10.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2cso842858a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 11:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790188830; x=1790793630; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3gc3lVJFpeHvTVPTQlhw9bRs3DHSZ5NaiLqgYc9qgEg=;
        b=JxxqphU376jctSQTW3MISsqhlX9OpRYQGxf4nCbG7hNHS/gRgVW2ITpIeXOyuv7UCz
         uWmGQ6BhyR94QvS2HHnCcffgNEKZBPaMD2LFOFUsgaIn+aNc3jdIVks3S6F6Ee5lwXmV
         t0Q7JC3NPkvqv4z0DDzchXeeIMHTJtK5CImiS6S1vQ6VepS5B073uf8yFQrQqE5j/uWN
         905WPZgUspUlnHi1R9cahIuS6YC4itJFdkkr192zf+8YaCjMPlBSd5/O+3SpOj4pqnXe
         HaS5IkpryxLRe3UuVBzNPN4vGyCu+ADNe9bQJz39ofgCcA3qh373Vj25jy6QQ9SvfDrT
         fdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790188830; x=1790793630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3gc3lVJFpeHvTVPTQlhw9bRs3DHSZ5NaiLqgYc9qgEg=;
        b=cF1SgkASxR+ak6f5HGtQ0vv0u5YfP/vOGttUw+ZlzvsvZlnAzFVU79Wv940R5Sv7zx
         vlUBNdkl3M4cvF+p/qDBhx4VNx+ei2XHBj+iq4J5x/f65Cs5RVVBmPhctDkOUqPRU8gM
         wrCKywm3rhDm4zCkXxLMn5xDymFJVPBAATq93FrjPiiBp9PxgLqnqREz31qxJMfkH+LN
         0WJtVo0GtSxBJHflw8m8tb7DuqXlK+Q4zr/DSesw4JqSJbTHosUNmLp8KPCCTM8Ebl1j
         an+iPk/NCiGLCN2l5mvYrrvZksfxRcJwJnCpL+CDx3mZMzy0lq1W3XdmYmKDVXybI4Cy
         GLpg==
X-Gm-Message-State: AFuF++m03HzHaPxVvRs8QmQxKNE5H8yNiQwcOOanWb4gLUdHOivC0MVt
	PAVaVLtfpjvVAa7Jcih0oPzlE+WXfZkMpq988tCJ6SxUvV2X2V3xTTnhCgkUgA==
X-Gm-Gg: AYBFou3hQmPCua7uYZUFOIhSgG5QoR3VIbPvUQ0fN/RuWZkMM5RSBVhNvbYvRNksAE5
	IuDTGYN+COzL7krRu4bf/j0dxyfeHi4gdvUol746ZNBkkwrgIGQeBVDtOXyVJdtfjf8M6iqiif7
	2JmD8eTjHdRS8Bel5zseIMTZzs58nU4vydDV0I7VPXqCHPdX3fv1exZQM50ECyZwxEFCMn9WO43
	CxTqK2T66Chtvjem9t0EhOUlUzpuo7fBh3s4xMMt3WOFNaumxVEkjOhsQCwNWm+ISUQfoeMgUUE
	7ZOrBda19IKQXmcbjHo4gyfC3fG3ZXPdVr3VQExiqFoXNYdQ+nLAX0iMf06t9dC4pI7kIag/y2y
	Vm94R3+iWfUfAXzEsEdTwT1ECGPGjDs5/lPtJ5WdwQ1F5hQLkVuU+Xa4LP+dlW50pZngEknzaB+
	N7Zej0kfcyu8Kpn+Rd6wt4sXNi3b2QUVbhxM8uV+d2tzR0A+KBTeiughNhG2YzMwdbW6Dbpe/5P
	ig4awZNf3h1MQxGlZDrJlUu7D/ZKZOnwNO0YSQzFtGmzTwc9JROUTanVkiOPgtJsgkZ3SpLV14D
	Ii9epy+fDuOeH4/F8SKqows/s3mc6TJrwN6vHEnOq8Iictt9
X-Received: by 2002:a05:6a20:6f07:b0:3cc:8f53:26c0 with SMTP id adf61e73a8af0-3de0e73d922mr85921637.17.1790188830372;
        Wed, 23 Sep 2026 11:40:30 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc75f3b82aasm1644341a12.9.2026.09.23.11.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 11:40:29 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] powerpc: dts: turris1x: use qca8337 internal PHYs
Date: Wed, 23 Sep 2026 11:40:28 -0700
Message-ID: <20260923184028.13830-1-rosenp@gmail.com>
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
Content-Transfer-Encoding: 8bit

The QCA8337 switch has a managed internal MDIO bus for its built-in
PHYs.  Declare the five PHYs in an mdio subnode of the switch and
link the LAN ports to them with phy-mode = "internal" and
phy-handle, so each switch port is connected to the correct internal
PHY instead of relying on the implicit legacy port-to-PHY mapping.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/powerpc/boot/dts/turris1x.dts | 35 ++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/powerpc/boot/dts/turris1x.dts b/arch/powerpc/boot/dts/turris1x.dts
index d0b7c62b8c6e..58c9e7b34e50 100644
--- a/arch/powerpc/boot/dts/turris1x.dts
+++ b/arch/powerpc/boot/dts/turris1x.dts
@@ -174,26 +174,36 @@ fixed-link {
 					port@1 {
 						reg = <1>;
 						label = "lan5";
+						phy-mode = "internal";
+						phy-handle = <&phy_port1>;
 					};
 
 					port@2 {
 						reg = <2>;
 						label = "lan4";
+						phy-mode = "internal";
+						phy-handle = <&phy_port2>;
 					};
 
 					port@3 {
 						reg = <3>;
 						label = "lan3";
+						phy-mode = "internal";
+						phy-handle = <&phy_port3>;
 					};
 
 					port@4 {
 						reg = <4>;
 						label = "lan2";
+						phy-mode = "internal";
+						phy-handle = <&phy_port4>;
 					};
 
 					port@5 {
 						reg = <5>;
 						label = "lan1";
+						phy-mode = "internal";
+						phy-handle = <&phy_port5>;
 					};
 
 					port@6 {
@@ -208,6 +218,31 @@ fixed-link {
 						};
 					};
 				};
+
+				mdio {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					phy_port1: ethernet-phy@0 {
+						reg = <0>;
+					};
+
+					phy_port2: ethernet-phy@1 {
+						reg = <1>;
+					};
+
+					phy_port3: ethernet-phy@2 {
+						reg = <2>;
+					};
+
+					phy_port4: ethernet-phy@3 {
+						reg = <3>;
+					};
+
+					phy_port5: ethernet-phy@4 {
+						reg = <4>;
+					};
+				};
 			};
 		};
 
-- 
2.55.0


