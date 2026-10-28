Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137A1606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sILqDAIE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFGk70X0Qz2yLY;
	Thu, 29 Oct 2026 05:54:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793213662;
	cv=none; b=lXsWPibN08q7yx1us8dPCDS6AjYwp/54kt4JTOcRgyn7IIZef4tsokSasQL2m++4dm1u3DLXWpxf//mV9iojgKfziM/c3ToH4aZv6hejo3bjxiEMtRubN3/V/XDeJ9k0Yolan7YIy2dTulI4oiX8vJHmsXtIp1KCyzX0ZmF2xsmkUxdurCEpakM2BD37Y6FG5DsBNw9hVCwJk+2g93D5UTALi7Nw4+DMrQZphsJzMkK38tm4DPuELXKt8GABWlG9fkAt1lhbbD4Pf4TL2UymrB6B1HyzLrApaq0QitIrUaLPsJ72aJ2WnyPMeuZ5XSPqmvjMRdu+Ru3jc9V4bOuf+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793213662; c=relaxed/relaxed;
	bh=q5fF2hx6olz2rFBHGDuG2r9xOsD6VAnpq1WRECdo8IY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iYxxK9I909Suz/HWDzisM/SguwGdtJ350fxoRsl0lf1MFS23M6qcJv/j2LE0ZLTBbH9BPoOZLGzu9nfwcyBO9vCNK5A9RRBA5j0MdfXi0oM63p0ewCWurRuonO7Dgsww+kbOaRb/rl7V7mqekcbAPevdYSYRy4LkXlTw4hT6H+ZoHkkg9LPS6Rr5V66HsQjqrO9Z2UU23F30f1gdxhG3izuIl4w25h4z+s/7o2W7t+ZnTYmIagviArL7MdC1TNRT6rfVfDFsfuQXuo5ACRJ78+FN9fTs1SwJQX49DaYh24LgEqQyYvvHz35FkhITUBobZJlId0FV8nhzTSujOevfkQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sILqDAIE; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=lefteris.koutrakis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sILqDAIE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=lefteris.koutrakis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFGk53Ns0z2y8m
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 05:54:21 +1100 (AEDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so12064745e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 11:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793213653; x=1793818453; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q5fF2hx6olz2rFBHGDuG2r9xOsD6VAnpq1WRECdo8IY=;
        b=sILqDAIEFVL4Qeto/DS2Lo7nf5bNteW7EsC1ldFDPh23xpsFpLP984oIi2JYYpJU7W
         eQW5DfjsYt+8PiaG8gwBzDillstapWLMdrf8deEub/LEe0/lYi5KbwRTDzXuHgY7J+pM
         06BdNP535pTUZFAiY0VPU5YUcw/Qg6solP1Kncs0y3pZDicp28DsDFS16X1KjK0zjsr6
         aDhnyLaeAPNnwqin6JJXOOD168YcfB1zQCb2dKdZf5WE0XaAuOofpHLnhlpff5e5chHb
         iWH1lIdCMHIij3kuLlWxdMkZCevP6r0q2frpWBjEdDCbn3Zaizlx8w6erl7F4A7HmVFr
         QC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793213653; x=1793818453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q5fF2hx6olz2rFBHGDuG2r9xOsD6VAnpq1WRECdo8IY=;
        b=PrYbe6ldjIUkaFfKspFCuI4GT9Wsnv4Awuoieq7PnsColktw8eVgbkRBXP5ln+w5vM
         OMLuHC5w9jDtqZHl6SocPggEaz8k689v2kyAIquddqyuw0jYo27AQGRkePykyNWGgf9/
         Kb6HnJb4XkJNxQoIDicqy6w7Ozdfg/i1a29n8eXrv0THUim09mtEjmAeVBS6+p2oLy8T
         3KrDLMmueJzhNnZH9Hipa8sEhgM+BmAnBBnrkBHMhrX5LjyvgmgNSrO0z4p4kgdL+DPf
         gXKqFzJp8F+RRCu78q2XPEcr4oAx/3nCV80Y4JBMzblgfNmJ97sCjZ2Yywfi4jtYaxAe
         wL0g==
X-Gm-Message-State: AFq9FYL0qWBrqWHDHhhvLMfXJ3YIvAJ4caauKTJ7zovf02peqttS+jdV
	YnPzaoPl7Qb0VfQQPe/wGZcwadB31j3GswiwoALB5huS7sRKKbS3GouyO9oezQgf4dE=
X-Gm-Gg: AYBFou3uMZH7+ebYU2s0LPzg8UZeWp6b0BUwdIp5SCUE16lZPZVpP8rphXg5gsMHbad
	xBZXsAE0qqGpsvc6bkl4+3HkmL/xkPXIu4J7zokR+0+qvzHFcqu73QamdoPThw9sQscrJfMtIiz
	0OSuIEQs1y8PfY9zQJFLXN2WBxALjDVuyaJw+E5Jd1+wD/dpCUGmGCW4LWPTnd4HqXnT1gRdwWk
	EC7OWMz2h8F8oFqQiU5I8OhGCdb7YwEvk34RNcVDsEHHpiy/5nf4I3MINmbCOKEfSZTBmG9iiuz
	xfQN/BTdhZtBmm0hudHDsC5pBFSW5UI4RUlbi73dbnT2NDpboGl6Q9pdkQ9UZa2E/pOTeHS1RbW
	jtOWbxXVIq36gIpAHY9Xl1CJKHewYiLUG81SRapGLdIEKVIBQmChZ5bNQXAQuMtp2anQE1wX6CL
	GVaeQ+VJBrlykVDbrWrZd0PgoT97uNwGd02neEAL8RbxvlrEnWcXwnXX6LMLydYAC/QmoHDx/uv
	X2YHT+OfAAeArOKX8ifzNJQlfN7kTcHL2ihZpPTAk1BMfrZTrwi8/L6aRPrMvXD2WL6jYinJqKH
	35cLi4e+nheM/IygOd1xqgFso3sjev+6R1hke4X7Z32XpMjs7KqY/pVD8NB83P2cq3A+kx7Hs1O
	Cu8k3Bafr7NeUHHLAy+2s/qn4Dv7Lk2wFdU7tuam8DW4MF7V9447Ht2RpBViXep/HRG7qdbJ/s4
	YpvQ+trVWdmnrzEbw=
X-Received: by 2002:a05:600c:348f:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4a9678c68c3mr72504645e9.34.1793213652696;
        Wed, 28 Oct 2026 11:54:12 -0700 (PDT)
Received: from kali (adsl-101.109.242.200.tellas.gr. [109.242.200.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a94eb8dc84sm25417365e9.2.2026.10.28.11.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:54:12 -0700 (PDT)
From: Lefteris Koutrakis <lefteris.koutrakis@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	maddy@linux.ibm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	sashiko-bot@kernel.org,
	Lefteris Koutrakis <lefteris.koutrakis@gmail.com>
Subject: [PATCH v5] powerpc/dts: Add Device Tree for WatchGuard Firebox T30 (v5)
Date: Wed, 28 Oct 2026 14:54:06 -0400
Message-ID: <20261028185407.26952-1-lefteris.koutrakis@gmail.com>
X-Mailer: git-send-email 2.53.0
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This commit adds initial device tree support for the WatchGuard Firebox T30
board and enables building firebox-t30.dtb under CONFIG_MPC85xx_RDB in
arch/powerpc/boot/dts/fsl/Makefile.

Signed-off-by: Lefteris Koutrakis <lefteris.koutrakis@gmail.com>
---
 .../arch/powerpc/boot/dts/firebox-t30.dts     | 386 ++++++++++++++++++
 1 file changed, 386 insertions(+)
 create mode 100644 target/linux/mpc85xx/files/arch/powerpc/boot/dts/firebox-t30.dts

diff --git a/target/linux/mpc85xx/files/arch/powerpc/boot/dts/firebox-t30.dts b/target/linux/mpc85xx/files/arch/powerpc/boot/dts/firebox-t30.dts
new file mode 100644
index 0000000..ec6cf91
--- /dev/null
+++ b/target/linux/mpc85xx/files/arch/powerpc/boot/dts/firebox-t30.dts
@@ -0,0 +1,386 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Device Tree for WatchGuard Firebox T30
+ * Author: Lefteris Koutrakis <lefteris.koutrakis@gmail.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+/include/ "p1020si-pre.dtsi"
+
+/ {
+	model = "Watchguard Firebox T30";
+	compatible = "watchguard,firebox-t30", "fsl,P1020RDB";
+
+	memory {
+		device_type = "memory";
+	};
+
+	cpus {
+		/delete-node/ PowerPC,P1020@1;
+	};
+
+	lbc: localbus@ffe05000 {
+		reg = <0 0xffe05000 0 0x1000>;
+		ranges = <0x0 0x0 0x0 0xefc00000 0x400000>;
+
+		nor@0 {
+			compatible = "cfi-flash";
+			reg = <0x0 0x0 0x400000>;
+			bank-width = <2>;
+			device-width = <1>;
+
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				partition@0 {
+					reg = <0x0 0x20000>;
+					label = "nor-cfg0";
+
+					nvmem-layout {
+						compatible = "fixed-layout";
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						macaddr_nor_cfg0_1830: mac-address@1830 {
+							compatible = "mac-base";
+							reg = <0x1830 0x11>;
+							#nvmem-cell-cells = <1>;
+						};
+
+						macaddr_nor_cfg0_1844: mac-address@1844 {
+							compatible = "mac-base";
+							reg = <0x1844 0x11>;
+							#nvmem-cell-cells = <1>;
+						};
+
+						macaddr_nor_cfg0_1858: mac-address@1858 {
+							compatible = "mac-base";
+							reg = <0x1858 0x11>;
+							#nvmem-cell-cells = <1>;
+						};
+
+						macaddr_nor_cfg0_186c: mac-address@186c {
+							compatible = "mac-base";
+							reg = <0x186c 0x11>;
+							#nvmem-cell-cells = <1>;
+						};
+
+						macaddr_nor_cfg0_1880: mac-address@1880 {
+							compatible = "mac-base";
+							reg = <0x1880 0x11>;
+							#nvmem-cell-cells = <1>;
+						};
+
+						macaddr_nor_cfg0_1894: mac-address@1894 {
+							compatible = "mac-base";
+							reg = <0x1894 0x11>;
+							#nvmem-cell-cells = <1>;
+						};
+					};
+				};
+
+				partition@20000 {
+					reg = <0x20000 0x10000>;
+					label = "nor-cfg1";
+				};
+
+				partition@30000 {
+					reg = <0x30000 0x20000>;
+					label = "nor-mfg";
+				};
+
+				partition@50000 {
+					reg = <0x50000 0xc0000>;
+					label = "nor-bootopt";
+				};
+
+				partition@110000 {
+					reg = <0x110000 0xc0000>;
+					label = "nor-extra1";
+				};
+
+				partition@1d0000 {
+					reg = <0x1d0000 0xc0000>;
+					label = "nor-extra2";
+				};
+
+				partition@290000 {
+					reg = <0x290000 0xe0000>;
+					label = "nor-backup";
+				};
+
+				partition@370000 {
+					reg = <0x370000 0x10000>;
+					label = "nor-ubootenv";
+				};
+
+				partition@380000 {
+					reg = <0x380000 0x80000>;
+					label = "nor-uboot";
+				};
+			};
+		};
+	};
+
+	soc: soc@ffe00000 {
+		ranges = <0x0 0x0 0xffe00000 0x100000>;
+
+		gpio0: gpio-controller@fc00 {
+			#gpio-cells = <2>;
+			compatible = "fsl,pq3-gpio";
+			reg = <0xfc00 0x100>;
+			interrupts = <47 0x2 0 0>;
+			gpio-controller;
+		};
+
+		i2c@3000 {
+			rtc@30 {
+				compatible = "sii,s35390a";
+				reg = <0x30>;
+			};
+		};
+
+		i2c@3100 {
+			tpm@29 {
+				compatible = "atmel,at97sc3204t";
+				reg = <0x29>;
+			};
+		};
+
+		spi0: spi@7000 {
+			flash@0 {
+				compatible = "everspin,mr25h256", "jedec,spi-nor";
+				reg = <0>;
+				spi-max-frequency = <40000000>;
+				m25p,fast-read;
+
+				partitions {
+					compatible = "fixed-partitions";
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					partition@0 {
+						reg = <0x0 0x8000>;
+						label = "spi_mtd_0";
+					};
+				};
+			};
+
+			slic@1 {
+				compatible = "zarlink,le88266";
+				reg = <1>;
+				spi-max-frequency = <500000>;
+			};
+		};
+
+		usb@22000 {
+			phy_type = "ulpi";
+			dr_mode = "host";
+		};
+
+		mdio@24000 {
+			switch0: switch@10 {
+				compatible = "marvell,mv88e6085";
+				reg = <0x10>;
+
+				mdio {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					switch0phy0: ethernet-phy@0 {
+						reg = <0>;
+					};
+
+					switch0phy1: ethernet-phy@1 {
+						reg = <1>;
+					};
+
+					switch0phy2: ethernet-phy@2 {
+						reg = <2>;
+					};
+
+					switch0phy3: ethernet-phy@3 {
+						reg = <3>;
+					};
+
+					switch0phy4: ethernet-phy@4 {
+						reg = <4>;
+					};
+				};
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						label = "wan";
+						phy-handle = <&switch0phy0>;
+						nvmem-cells = <&macaddr_nor_cfg0_1830 0>;
+						nvmem-cell-names = "mac-address";
+					};
+
+					port@1 {
+						reg = <1>;
+						label = "lan1";
+						phy-handle = <&switch0phy1>;
+						nvmem-cells = <&macaddr_nor_cfg0_1844 0>;
+						nvmem-cell-names = "mac-address";
+					};
+
+					port@2 {
+						reg = <2>;
+						label = "lan2";
+						phy-handle = <&switch0phy2>;
+						nvmem-cells = <&macaddr_nor_cfg0_1858 0>;
+						nvmem-cell-names = "mac-address";
+					};
+
+					port@3 {
+						reg = <3>;
+						label = "lan3";
+						phy-handle = <&switch0phy3>;
+						nvmem-cells = <&macaddr_nor_cfg0_186c 0>;
+						nvmem-cell-names = "mac-address";
+					};
+
+					port@4 {
+						reg = <4>;
+						label = "lan4";
+						phy-handle = <&switch0phy4>;
+						nvmem-cells = <&macaddr_nor_cfg0_1880 0>;
+						nvmem-cell-names = "mac-address";
+					};
+
+					port@6 {
+						reg = <6>;
+						label = "cpu";
+						ethernet = <&enet0>;
+						phy-mode = "rgmii-id";
+
+						fixed-link {
+							speed = <1000>;
+							full-duplex;
+						};
+					};
+				};
+			};
+		};
+
+		mdio@25000 {
+			status = "disabled";
+		};
+
+		mdio@26000 {
+			status = "disabled";
+		};
+
+		enet0: ethernet@b0000 {
+			phy-connection-type = "rgmii-id";
+			nvmem-cells = <&macaddr_nor_cfg0_1830 0>;
+			nvmem-cell-names = "mac-address";
+
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
+		};
+
+		enet1: ethernet@b1000 {
+			status = "disabled";
+		};
+
+		enet2: ethernet@b2000 {
+			status = "disabled";
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led0: led-0 {
+			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
+			color = <LED_COLOR_ID_ORANGE>;
+			function = LED_FUNCTION_STATUS;
+		};
+
+		led1: led-1 {
+			gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_STATUS;
+		};
+
+		led2: led-2 {
+			gpios = <&gpio0 4 GPIO_ACTIVE_LOW>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_USB;
+		};
+
+		led3: led-3 {
+			gpios = <&gpio0 5 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_WLAN_5GHZ;
+			default-state = "keep";
+		};
+
+		led4: led-4 {
+			gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_ORANGE>;
+			function = LED_FUNCTION_WLAN_2GHZ;
+			default-state = "keep";
+		};
+
+		led5: led-5 {
+			gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_POWER;
+			default-state = "on";
+		};
+	};
+
+	pci0: pcie@ffe09000 {
+		reg = <0 0xffe09000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
+		status = "disabled";
+
+		pcie@0 {
+			ranges = <0x2000000 0x0 0xa0000000
+				  0x2000000 0x0 0xa0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+
+	pci1: pcie@ffe0a000 {
+		reg = <0 0xffe0a000 0 0x1000>;
+		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
+
+		pcie@0 {
+			ranges = <0x2000000 0x0 0x80000000
+				  0x2000000 0x0 0x80000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+
+			ath10k: wifi@0,0 {
+				reg = <0x0000 0 0 0 0>;
+				nvmem-cells = <&macaddr_nor_cfg0_1894 0>;
+				nvmem-cell-names = "mac-address";
+			};
+		};
+	};
+};
+
+/include/ "p1020si-post.dtsi"
-- 
2.53.0


