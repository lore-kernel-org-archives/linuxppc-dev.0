Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE6B606A31A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 13:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xSiwqhzf
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jF7CW1n5rz2y8p;
	Thu, 29 Oct 2026 00:15:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793182956;
	cv=none; b=QPTH/1iWy3COEfodCtl035ohQEU35pkr+WWXlP8GVk2Z1IqeBcAuS3JmvforJkjnOxVkHvmHrZd2fsdlAlVHJaQerdu5zwmxT5BxJm+VIzfJKiyf7RvnQ5EsX0CTRJ5myfeVtp5O5Ux63k/PB/DCFp2fY66h8rHRf/ejvbPaYUacGBkXyg8UoANDQuenro4DIPrea3cHKlSLeDhD3t+tYjJEyUZ/zNekT7Vv96ZIRC13g9onZUbCwe454YGrWSqdwmBtMB4TO6OmgBS44k/8kgO8FZFFzYdY0tlD/GoTix9e3S3i04iizH3Fk1qGsDNvRxQ+/1LkTIAmInqBOLShRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793182956; c=relaxed/relaxed;
	bh=rza0kgIV8RKD+4VzREfwNDyHjukBXzxAznIzMlJT1PM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hq9CAQcLb4T1K6ODxWOuUTBmpDwEdURoplM161ucjFT6SPaU1YOoNd8a2eyVUgpE9ZLlGHP/pIfUO6s8BozWmG1lt6+hOLsyxEM+byyCbjwaY92DooZ8Unop9pgFn/FXD1uYMIC0n3OKYtbaD0k8M+Xvn+E7HPnwb1gtMhBh2MHPGG2lJSCq2R+mIlJab8PHMx0EWBm+gRI7KTbwLZEq4JoRerXjK9cImiGNKkdMlGT1WXFJiXI2lf1+NHoewrdtjkX2NnrUINjkuTfdCRrMpND/K8J2yKnx8+/64fHqSGlo7oxM9jlGGqXluEdxZyLrO/CrAkQWsAVe9gbW1sE93A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xSiwqhzf; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=lefteris.koutrakis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xSiwqhzf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com; envelope-from=lefteris.koutrakis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jF3MZ52yCz2xlj
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 21:22:34 +1100 (AEDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-48df4e9d2d4so442428f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 03:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793182951; x=1793787751; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rza0kgIV8RKD+4VzREfwNDyHjukBXzxAznIzMlJT1PM=;
        b=xSiwqhzfKR08rVBs+IEibCjOAafq/p+bU85faN5rSKqoRKcg6o1SfnZRxY6FN/5muK
         KI4YJgZMlrTezS7O6SL+skMEGJvsZm8IYj1t08VY3vRv/F1vGDpytX9mpva0KFc2DhyB
         toK1RFWSzkJiaOj3WdBeqFQ2nlplBln+wldffeE4+7tia+9ncqDDmT+IY0LEi+ze9TDZ
         lbmd+zJyPJUtMFtXoZ9ffzy6IvOjmj90BQ+Ss8429AhoUV5eCH6M0wsQ+u9pm2bvObZm
         SLfcRvhaQ3axNKvfbNSLtIufxBzNTwu8L7QegrKZGdlZmTBiXKCDKbOo3/wx+1PrMzA6
         s4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793182951; x=1793787751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rza0kgIV8RKD+4VzREfwNDyHjukBXzxAznIzMlJT1PM=;
        b=iKE31LJBzhNWeheSkdDzNFucTAM8vVsuiX7h8RmGwCnvTkBy/zHqtYnEgGf5k3ETrD
         MKLR+Qkbig604cjT80kzu2ZA7xi6S03WZb7blgBW/sGzyod1TtDYR7k3f6YrOIlvnfJT
         rZbYcrwI3hkeGDfBdN2HZQyUFWZcDnW9DmItHah9kAMfqcEkvaGOK8R46snXzXFpKBXf
         lbA0EqvAFsfqXszyAT7eQgx3/WwEcDWOdLtfc9upiqSARbG16HqL+Pi40U2dbDa1YiQ7
         ZtKgBj8gX81Y2/NtrDbUF3bqc8EbVbJg43cVrSk29gT6kwHIWEPmBxMtSZ6Gu7A0iUKU
         s8fg==
X-Gm-Message-State: AFq9FYLtK0ow0xYEMAPRZ4KNjft0quoHCx9/b7vd27iHVHVlQltqapan
	3Cqhpra62RQ2F263maihLP1pfUb+vcw1vlpNaEEkFFYTutAAU/N83YZ7LyodkoGNk+6zbQ==
X-Gm-Gg: AYBFou1Be9ZuMeQropSsWYd2No5IntOpolCaUbJ71YyrWtCNg1q7J3p115PEJTay2iB
	qNdMGX2MJKn3yTKa+DKEB5yNiqWtLXuj3LuvdDPMpF5YqDMrb1sPueysAMCLTi6FXd2yoJ1G2Zl
	MEemGngm2yKS2GgTwaGD5Ra+oUC+1pWbDPze4zDJblfDuwBukSKh49pvSqHse2xnLdLbcaqwr9W
	ufItHZn+dNrz6Yij5Xd/4W14+IB+cEVQsMCz+nV76FpCXSfSS/jx1akaCJxNx2j9tPBnp63Lj0h
	cSsznylyWF1QB8lDvSlyMxjDwT7wJJ9i23ydJSwtU0cVxRfo+IhN7HHTIw3Hy4QQ2zZXdvzPE9V
	IlaK5wV7IfTbcmkFYfKKbVBbeXFqxCZpg6tZH9gabi4fWLdyhr94TmD6zVPia/QSaGa7WSWnx/T
	u0s6HXdGqU7wOSjawQUwDTdVHOQ+72W2aPB4QYHgi+4jVT2NQRa4mW9FDPzJeMkObWqSc0A/Q8/
	J65cqHImKu3N3vfBb+NJLeeXq9Q+gvwtPYLRZ0TnID115S11VNQHxHe2Ihp4LCfCkN+rJw0fV2I
	dQ3ZJ5s0DUx9lgiOfP/oHakvaCe/2GwcYXeuXIPhHkKOZdlzzm2WZlT7W0mzdsQLrVRyi1PNu4Z
	9AqvlU9F0xq9zVMg4aCRp9Wo17NYyGpFkFyHXBkL0Btwkeq7Zq2OFb2vzn+Wz2SnuM7jTc+pmoQ
	mCmYwM7GhmwRq4EzaSG9zm+1qacnHGK6tq3kAU
X-Received: by 2002:a05:6000:2488:b0:486:f6dc:52c8 with SMTP id ffacd0b85a97d-48e5d5a4030mr4706468f8f.37.1793182950573;
        Wed, 28 Oct 2026 03:22:30 -0700 (PDT)
Received: from kali (adsl-101.109.242.200.tellas.gr. [109.242.200.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd35c2sm27135788f8f.39.2026.10.28.03.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 03:22:30 -0700 (PDT)
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
	Lefteris Koutrakis <lefteris.koutrakis@gmail.com>
Subject: [PATCH] powerpc/dts: Add dts for WatchGuard Firebox T30
Date: Wed, 28 Oct 2026 06:21:58 -0400
Message-ID: <20261028102158.71032-1-lefteris.koutrakis@gmail.com>
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

Add device tree support for the WatchGuard Firebox T30 and T30-W.

These devices are security appliances based on the Freescale P1020 SoC. They feature 5x Gigabit Ethernet ports, USB, and a serial console.

Signed-off-by: Lefteris Koutrakis <lefteris.koutrakis@gmail.com>
---
 arch/powerpc/boot/dts/fsl/Makefile        |   1 +
 arch/powerpc/boot/dts/fsl/firebox-t30.dts | 413 ++++++++++++++++++++++
 2 files changed, 414 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/fsl/firebox-t30.dts

diff --git a/arch/powerpc/boot/dts/fsl/Makefile b/arch/powerpc/boot/dts/fsl/Makefile
index d2cc8e1f0..ebbf301e1 100644
--- a/arch/powerpc/boot/dts/fsl/Makefile
+++ b/arch/powerpc/boot/dts/fsl/Makefile
@@ -3,6 +3,7 @@
 dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(src)/%.dts,%.dtb, $(wildcard $(src)/*.dts))
 
 # MPC85xx platforms
+dtb-$(CONFIG_MPC85xx_RDB) += firebox-t30.dtb
 dtb-$(CONFIG_BSC9131_RDB) += bsc9131rdb.dtb
 dtb-$(CONFIG_BSC9132_QDS) += bsc9132qds.dtb
 dtb-$(CONFIG_C293_PCIE) += c293pcie.dtb
diff --git a/arch/powerpc/boot/dts/fsl/firebox-t30.dts b/arch/powerpc/boot/dts/fsl/firebox-t30.dts
new file mode 100644
index 000000000..546e98938
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/firebox-t30.dts
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+/include/ "fsl/p1020si-pre.dtsi"
+
+/ {
+	model = "Watchguard Firebox T30";
+	compatible = "watchguard,firebox-t30";
+
+	chosen {
+		bootargs-override = "console=ttyS0,115200 rw root=/dev/mmcblk0p2 rootfstype=squashfs rootwait";
+	};
+
+	aliases {
+		label-mac-device = &enet0;
+		led-boot = &led0;
+		led-failsafe = &led1;
+		led-running = &led0;
+		led-upgrade = &led1;
+	};
+
+	memory {
+		device_type = "memory";
+	};
+
+	cpus {
+		/delete-property/ PowerPC,P1020@1;
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
+		i2c@3000 {
+			rtc@30 {
+				compatible = "sii,s35390a";
+				reg = <0x30>;
+			};
+		};
+
+		i2c@3100 {
+			tpm@29 {
+				compatible = "tpm,tpm_i2c_atmel";
+				reg = <0x29>;
+			};
+		};
+
+		sdhc@2e000 {
+			compatible = "fsl,p1020-esdhc", "fsl,esdhc";
+			sdhci,auto-cmd12;
+			reg = <0x2e000 0x1000>;
+			interrupts = <0x48 0x2 0x0 0x0>;
+			interrupt-parent = <&mpic>;
+			fsl,sdhci-dma-broken;
+			fsl,sdhci-ahb2mag-irq-bypass;
+			fsl,sdhci-adjust-timeout;
+			clock-frequency = <0>;
+		};
+
+		spi0: spi@7000 {
+			compatible = "fsl,mpc8536-espi";
+			reg = <0x7000 0x1000>;
+			interrupts = <0x3b 0x2>;
+			interrupt-parent = <&mpic>;
+			fsl,espi-num-chipselects = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
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
+			rx-internal-delay-ps = <2000>;
+			tx-internal-delay-ps = <2000>;
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
+
+		gpio0: gpio-controller@fc00 {
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
+				#gpio-cells = <2>;
+				gpio-controller;
+				nvmem-cells = <&macaddr_nor_cfg0_1894 0>;
+				nvmem-cell-names = "mac-address";
+			};
+		};
+	};
+};
+
+/include/ "fsl/p1020si-post.dtsi"
-- 
2.51.0


