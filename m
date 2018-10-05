Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177D2C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:29:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE7C213A2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE7C213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RcDv3gGZzF3TC
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 03:29:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.194; helo=mail-oi1-f194.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RbZP6N7VzDrJl
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 02:59:09 +1000 (AEST)
Received: by mail-oi1-f194.google.com with SMTP id j68-v6so10952175oib.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 09:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=WLcoBwwBfOERKzo9rW58qzDysAW/KcU3knA0lIoHGhc=;
 b=t1PpoXG5UZ2bZ5IqWsd4PE501EPa3v3W/1KU3KXDFEEwLikloGWpT+uqbfU6V8RjWv
 q1KENBf0wSLbk8Y/S2k7tDlMPNnKF/Q17lLpBv9myXE9zSyzmSfkgRh0t6Mvx7s8tG8Z
 SMcGMhh5X5/Jc4oqMPKnBjww76g8dIvFvw3OKBfLtXqbIEMzvuwm/w+GG+Ai9uCJ0mDe
 v/CMo+dkmf2xuUXGNpgU35Ncq0piebQkmOqDPVs07i6kVjT829oz3EB3Sd+vAIEbgspu
 2VWETm3QDCyS0rQbojav7beFRpb4scgQG1/Ox1nMd3lFDXjw9ne8+ztuHGIOhB9nLwFX
 Cpcg==
X-Gm-Message-State: ABuFfoiSol1hV4hT1rJChN4z/l/+YGVhST1dTczkYBiGt7eAXRVZUmRm
 gX+sR0guou9ezlJs+REVJg==
X-Google-Smtp-Source: ACcGV60J7rtswjZ/DjFAKrFgFiWxxCLcvzDcsjlMwmnqP4spAG3vze2mZS4MGcSGsiFY5xWDB1shtA==
X-Received: by 2002:aca:c392:: with SMTP id
 t140-v6mr6048578oif.325.1538758747750; 
 Fri, 05 Oct 2018 09:59:07 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
 u63-v6sm2904328ota.75.2018.10.05.09.59.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 09:59:07 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 12/36] dt-bindings: arm: Convert cpu binding to json-schema
Date: Fri,  5 Oct 2018 11:58:24 -0500
Message-Id: <20181005165848.3474-13-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Tom Rini <trini@konsulko.com>,
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <glikely@secretlab.ca>,
 Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>,
 linux-mediatek@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert ARM CPU binding to DT schema format using json-schema.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/cpus.txt          | 490 -----------------
 .../devicetree/bindings/arm/cpus.yaml         | 503 ++++++++++++++++++
 2 files changed, 503 insertions(+), 490 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/cpus.txt
 create mode 100644 Documentation/devicetree/bindings/arm/cpus.yaml

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
deleted file mode 100644
index b0198a1cf403..000000000000
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ /dev/null
@@ -1,490 +0,0 @@
-=================
-ARM CPUs bindings
-=================
-
-The device tree allows to describe the layout of CPUs in a system through
-the "cpus" node, which in turn contains a number of subnodes (ie "cpu")
-defining properties for every cpu.
-
-Bindings for CPU nodes follow the Devicetree Specification, available from:
-
-https://www.devicetree.org/specifications/
-
-with updates for 32-bit and 64-bit ARM systems provided in this document.
-
-================================
-Convention used in this document
-================================
-
-This document follows the conventions described in the Devicetree
-Specification, with the addition:
-
-- square brackets define bitfields, eg reg[7:0] value of the bitfield in
-  the reg property contained in bits 7 down to 0
-
-=====================================
-cpus and cpu node bindings definition
-=====================================
-
-The ARM architecture, in accordance with the Devicetree Specification,
-requires the cpus and cpu nodes to be present and contain the properties
-described below.
-
-- cpus node
-
-	Description: Container of cpu nodes
-
-	The node name must be "cpus".
-
-	A cpus node must define the following properties:
-
-	- #address-cells
-		Usage: required
-		Value type: <u32>
-
-		Definition depends on ARM architecture version and
-		configuration:
-
-			# On uniprocessor ARM architectures previous to v7
-			  value must be 1, to enable a simple enumeration
-			  scheme for processors that do not have a HW CPU
-			  identification register.
-			# On 32-bit ARM 11 MPcore, ARM v7 or later systems
-			  value must be 1, that corresponds to CPUID/MPIDR
-			  registers sizes.
-			# On ARM v8 64-bit systems value should be set to 2,
-			  that corresponds to the MPIDR_EL1 register size.
-			  If MPIDR_EL1[63:32] value is equal to 0 on all CPUs
-			  in the system, #address-cells can be set to 1, since
-			  MPIDR_EL1[63:32] bits are not used for CPUs
-			  identification.
-	- #size-cells
-		Usage: required
-		Value type: <u32>
-		Definition: must be set to 0
-
-- cpu node
-
-	Description: Describes a CPU in an ARM based system
-
-	PROPERTIES
-
-	- device_type
-		Usage: required
-		Value type: <string>
-		Definition: must be "cpu"
-	- reg
-		Usage and definition depend on ARM architecture version and
-		configuration:
-
-			# On uniprocessor ARM architectures previous to v7
-			  this property is required and must be set to 0.
-
-			# On ARM 11 MPcore based systems this property is
-			  required and matches the CPUID[11:0] register bits.
-
-			  Bits [11:0] in the reg cell must be set to
-			  bits [11:0] in CPU ID register.
-
-			  All other bits in the reg cell must be set to 0.
-
-			# On 32-bit ARM v7 or later systems this property is
-			  required and matches the CPU MPIDR[23:0] register
-			  bits.
-
-			  Bits [23:0] in the reg cell must be set to
-			  bits [23:0] in MPIDR.
-
-			  All other bits in the reg cell must be set to 0.
-
-			# On ARM v8 64-bit systems this property is required
-			  and matches the MPIDR_EL1 register affinity bits.
-
-			  * If cpus node's #address-cells property is set to 2
-
-			    The first reg cell bits [7:0] must be set to
-			    bits [39:32] of MPIDR_EL1.
-
-			    The second reg cell bits [23:0] must be set to
-			    bits [23:0] of MPIDR_EL1.
-
-			  * If cpus node's #address-cells property is set to 1
-
-			    The reg cell bits [23:0] must be set to bits [23:0]
-			    of MPIDR_EL1.
-
-			  All other bits in the reg cells must be set to 0.
-
-	- compatible:
-		Usage: required
-		Value type: <string>
-		Definition: should be one of:
-			    "arm,arm710t"
-			    "arm,arm720t"
-			    "arm,arm740t"
-			    "arm,arm7ej-s"
-			    "arm,arm7tdmi"
-			    "arm,arm7tdmi-s"
-			    "arm,arm9es"
-			    "arm,arm9ej-s"
-			    "arm,arm920t"
-			    "arm,arm922t"
-			    "arm,arm925"
-			    "arm,arm926e-s"
-			    "arm,arm926ej-s"
-			    "arm,arm940t"
-			    "arm,arm946e-s"
-			    "arm,arm966e-s"
-			    "arm,arm968e-s"
-			    "arm,arm9tdmi"
-			    "arm,arm1020e"
-			    "arm,arm1020t"
-			    "arm,arm1022e"
-			    "arm,arm1026ej-s"
-			    "arm,arm1136j-s"
-			    "arm,arm1136jf-s"
-			    "arm,arm1156t2-s"
-			    "arm,arm1156t2f-s"
-			    "arm,arm1176jzf"
-			    "arm,arm1176jz-s"
-			    "arm,arm1176jzf-s"
-			    "arm,arm11mpcore"
-			    "arm,cortex-a5"
-			    "arm,cortex-a7"
-			    "arm,cortex-a8"
-			    "arm,cortex-a9"
-			    "arm,cortex-a12"
-			    "arm,cortex-a15"
-			    "arm,cortex-a17"
-			    "arm,cortex-a53"
-			    "arm,cortex-a57"
-			    "arm,cortex-a72"
-			    "arm,cortex-a73"
-			    "arm,cortex-m0"
-			    "arm,cortex-m0+"
-			    "arm,cortex-m1"
-			    "arm,cortex-m3"
-			    "arm,cortex-m4"
-			    "arm,cortex-r4"
-			    "arm,cortex-r5"
-			    "arm,cortex-r7"
-			    "brcm,brahma-b15"
-			    "brcm,brahma-b53"
-			    "brcm,vulcan"
-			    "cavium,thunder"
-			    "cavium,thunder2"
-			    "faraday,fa526"
-			    "intel,sa110"
-			    "intel,sa1100"
-			    "marvell,feroceon"
-			    "marvell,mohawk"
-			    "marvell,pj4a"
-			    "marvell,pj4b"
-			    "marvell,sheeva-v5"
-			    "nvidia,tegra132-denver"
-			    "nvidia,tegra186-denver"
-			    "nvidia,tegra194-carmel"
-			    "qcom,krait"
-			    "qcom,kryo"
-			    "qcom,kryo385"
-			    "qcom,scorpion"
-	- enable-method
-		Value type: <stringlist>
-		Usage and definition depend on ARM architecture version.
-			# On ARM v8 64-bit this property is required and must
-			  be one of:
-			     "psci"
-			     "spin-table"
-			# On ARM 32-bit systems this property is optional and
-			  can be one of:
-			    "actions,s500-smp"
-			    "allwinner,sun6i-a31"
-			    "allwinner,sun8i-a23"
-			    "allwinner,sun9i-a80-smp"
-			    "amlogic,meson8-smp"
-			    "amlogic,meson8b-smp"
-			    "arm,realview-smp"
-			    "brcm,bcm11351-cpu-method"
-			    "brcm,bcm23550"
-			    "brcm,bcm2836-smp"
-			    "brcm,bcm-nsp-smp"
-			    "brcm,brahma-b15"
-			    "marvell,armada-375-smp"
-			    "marvell,armada-380-smp"
-			    "marvell,armada-390-smp"
-			    "marvell,armada-xp-smp"
-			    "marvell,98dx3236-smp"
-			    "mediatek,mt6589-smp"
-			    "mediatek,mt81xx-tz-smp"
-			    "qcom,gcc-msm8660"
-			    "qcom,kpss-acc-v1"
-			    "qcom,kpss-acc-v2"
-			    "renesas,apmu"
-			    "renesas,r9a06g032-smp"
-			    "rockchip,rk3036-smp"
-			    "rockchip,rk3066-smp"
-			    "ste,dbx500-smp"
-
-	- cpu-release-addr
-		Usage: required for systems that have an "enable-method"
-		       property value of "spin-table".
-		Value type: <prop-encoded-array>
-		Definition:
-			# On ARM v8 64-bit systems must be a two cell
-			  property identifying a 64-bit zero-initialised
-			  memory location.
-
-	- qcom,saw
-		Usage: required for systems that have an "enable-method"
-		       property value of "qcom,kpss-acc-v1" or
-		       "qcom,kpss-acc-v2"
-		Value type: <phandle>
-		Definition: Specifies the SAW[1] node associated with this CPU.
-
-	- qcom,acc
-		Usage: required for systems that have an "enable-method"
-		       property value of "qcom,kpss-acc-v1" or
-		       "qcom,kpss-acc-v2"
-		Value type: <phandle>
-		Definition: Specifies the ACC[2] node associated with this CPU.
-
-	- cpu-idle-states
-		Usage: Optional
-		Value type: <prop-encoded-array>
-		Definition:
-			# List of phandles to idle state nodes supported
-			  by this cpu [3].
-
-	- capacity-dmips-mhz
-		Usage: Optional
-		Value type: <u32>
-		Definition:
-			# u32 value representing CPU capacity [4] in
-			  DMIPS/MHz, relative to highest capacity-dmips-mhz
-			  in the system.
-
-	- rockchip,pmu
-		Usage: optional for systems that have an "enable-method"
-		       property value of "rockchip,rk3066-smp"
-		       While optional, it is the preferred way to get access to
-		       the cpu-core power-domains.
-		Value type: <phandle>
-		Definition: Specifies the syscon node controlling the cpu core
-			    power domains.
-
-	- dynamic-power-coefficient
-		Usage: optional
-		Value type: <prop-encoded-array>
-		Definition: A u32 value that represents the running time dynamic
-			    power coefficient in units of uW/MHz/V^2. The
-			    coefficient can either be calculated from power
-			    measurements or derived by analysis.
-
-			    The dynamic power consumption of the CPU  is
-			    proportional to the square of the Voltage (V) and
-			    the clock frequency (f). The coefficient is used to
-			    calculate the dynamic power as below -
-
-			    Pdyn = dynamic-power-coefficient * V^2 * f
-
-			    where voltage is in V, frequency is in MHz.
-
-Example 1 (dual-cluster big.LITTLE system 32-bit):
-
-	cpus {
-		#size-cells = <0>;
-		#address-cells = <1>;
-
-		cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0x0>;
-		};
-
-		cpu@1 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0x1>;
-		};
-
-		cpu@100 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x100>;
-		};
-
-		cpu@101 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x101>;
-		};
-	};
-
-Example 2 (Cortex-A8 uniprocessor 32-bit system):
-
-	cpus {
-		#size-cells = <0>;
-		#address-cells = <1>;
-
-		cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a8";
-			reg = <0x0>;
-		};
-	};
-
-Example 3 (ARM 926EJ-S uniprocessor 32-bit system):
-
-	cpus {
-		#size-cells = <0>;
-		#address-cells = <1>;
-
-		cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,arm926ej-s";
-			reg = <0x0>;
-		};
-	};
-
-Example 4 (ARM Cortex-A57 64-bit system):
-
-cpus {
-	#size-cells = <0>;
-	#address-cells = <2>;
-
-	cpu@0 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x0 0x0>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@1 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x0 0x1>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@100 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x0 0x100>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@101 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x0 0x101>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@10000 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x0 0x10000>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@10001 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x0 0x10001>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@10100 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x0 0x10100>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@10101 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x0 0x10101>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@100000000 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x1 0x0>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@100000001 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x1 0x1>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@100000100 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x1 0x100>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@100000101 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x1 0x101>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@100010000 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x1 0x10000>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@100010001 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x1 0x10001>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@100010100 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x1 0x10100>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-
-	cpu@100010101 {
-		device_type = "cpu";
-		compatible = "arm,cortex-a57";
-		reg = <0x1 0x10101>;
-		enable-method = "spin-table";
-		cpu-release-addr = <0 0x20000000>;
-	};
-};
-
---
-[1] arm/msm/qcom,saw2.txt
-[2] arm/msm/qcom,kpss-acc.txt
-[3] ARM Linux kernel documentation - idle states bindings
-    Documentation/devicetree/bindings/arm/idle-states.txt
-[4] ARM Linux kernel documentation - cpu capacity bindings
-    Documentation/devicetree/bindings/arm/cpu-capacity.txt
diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
new file mode 100644
index 000000000000..bb75914324a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -0,0 +1,503 @@
+# SPDX-License-Identifier: None
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/arm/cpus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM CPUs bindings
+
+maintainers:
+  - Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+
+description: |+
+  The device tree allows to describe the layout of CPUs in a system through
+  the "cpus" node, which in turn contains a number of subnodes (ie "cpu")
+  defining properties for every cpu.
+
+  Bindings for CPU nodes follow the Devicetree Specification, available from:
+
+  https://www.devicetree.org/specifications/
+
+  with updates for 32-bit and 64-bit ARM systems provided in this document.
+
+  ================================
+  Convention used in this document
+  ================================
+
+  This document follows the conventions described in the Devicetree
+  Specification, with the addition:
+
+  - square brackets define bitfields, eg reg[7:0] value of the bitfield in
+    the reg property contained in bits 7 down to 0
+
+  =====================================
+  cpus and cpu node bindings definition
+  =====================================
+
+  The ARM architecture, in accordance with the Devicetree Specification,
+  requires the cpus and cpu nodes to be present and contain the properties
+  described below.
+
+properties:
+  $nodename:
+    const: cpus
+    description: Container of cpu nodes
+
+  '#address-cells':
+    enum: [1, 2]
+    description: |
+      Definition depends on ARM architecture version and configuration:
+
+      On uniprocessor ARM architectures previous to v7
+        value must be 1, to enable a simple enumeration
+        scheme for processors that do not have a HW CPU
+        identification register.
+      On 32-bit ARM 11 MPcore, ARM v7 or later systems
+        value must be 1, that corresponds to CPUID/MPIDR
+        registers sizes.
+      On ARM v8 64-bit systems value should be set to 2,
+        that corresponds to the MPIDR_EL1 register size.
+        If MPIDR_EL1[63:32] value is equal to 0 on all CPUs
+        in the system, #address-cells can be set to 1, since
+        MPIDR_EL1[63:32] bits are not used for CPUs
+        identification.
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  '^cpu@[0-9a-f]+$':
+    properties:
+      device_type:
+        const: cpu
+
+      reg:
+        maxItems: 1
+        description: |
+          Usage and definition depend on ARM architecture version and
+          configuration:
+
+          On uniprocessor ARM architectures previous to v7
+          this property is required and must be set to 0.
+
+          On ARM 11 MPcore based systems this property is
+            required and matches the CPUID[11:0] register bits.
+
+            Bits [11:0] in the reg cell must be set to
+            bits [11:0] in CPU ID register.
+
+            All other bits in the reg cell must be set to 0.
+
+          On 32-bit ARM v7 or later systems this property is
+            required and matches the CPU MPIDR[23:0] register
+            bits.
+
+            Bits [23:0] in the reg cell must be set to
+            bits [23:0] in MPIDR.
+
+            All other bits in the reg cell must be set to 0.
+
+          On ARM v8 64-bit systems this property is required
+            and matches the MPIDR_EL1 register affinity bits.
+
+            * If cpus node's #address-cells property is set to 2
+
+              The first reg cell bits [7:0] must be set to
+              bits [39:32] of MPIDR_EL1.
+
+              The second reg cell bits [23:0] must be set to
+              bits [23:0] of MPIDR_EL1.
+
+            * If cpus node's #address-cells property is set to 1
+
+              The reg cell bits [23:0] must be set to bits [23:0]
+              of MPIDR_EL1.
+
+          All other bits in the reg cells must be set to 0.
+
+      compatible:
+        items:
+          - enum:
+              - arm,arm710t
+              - arm,arm720t
+              - arm,arm740t
+              - arm,arm7ej-s
+              - arm,arm7tdmi
+              - arm,arm7tdmi-s
+              - arm,arm9es
+              - arm,arm9ej-s
+              - arm,arm920t
+              - arm,arm922t
+              - arm,arm925
+              - arm,arm926e-s
+              - arm,arm926ej-s
+              - arm,arm940t
+              - arm,arm946e-s
+              - arm,arm966e-s
+              - arm,arm968e-s
+              - arm,arm9tdmi
+              - arm,arm1020e
+              - arm,arm1020t
+              - arm,arm1022e
+              - arm,arm1026ej-s
+              - arm,arm1136j-s
+              - arm,arm1136jf-s
+              - arm,arm1156t2-s
+              - arm,arm1156t2f-s
+              - arm,arm1176jzf
+              - arm,arm1176jz-s
+              - arm,arm1176jzf-s
+              - arm,arm11mpcore
+              - arm,cortex-a5
+              - arm,cortex-a7
+              - arm,cortex-a8
+              - arm,cortex-a9
+              - arm,cortex-a12
+              - arm,cortex-a15
+              - arm,cortex-a17
+              - arm,cortex-a53
+              - arm,cortex-a57
+              - arm,cortex-a72
+              - arm,cortex-a73
+              - arm,cortex-m0
+              - arm,cortex-m0+
+              - arm,cortex-m1
+              - arm,cortex-m3
+              - arm,cortex-m4
+              - arm,cortex-r4
+              - arm,cortex-r5
+              - arm,cortex-r7
+              - brcm,brahma-b15
+              - brcm,brahma-b53
+              - brcm,vulcan
+              - cavium,thunder
+              - cavium,thunder2
+              - faraday,fa526
+              - intel,sa110
+              - intel,sa1100
+              - marvell,feroceon
+              - marvell,mohawk
+              - marvell,pj4a
+              - marvell,pj4b
+              - marvell,sheeva-v5
+              - nvidia,tegra132-denver
+              - nvidia,tegra186-denver
+              - nvidia,tegra194-carmel
+              - qcom,krait
+              - qcom,kryo
+              - qcom,kryo385
+              - qcom,scorpion
+
+      enable-method:
+        allOf:
+          - $ref: '/schemas/types.yaml#/definitions/string'
+          - oneOf:
+            # On ARM v8 64-bit this property is required
+            - enum:
+                - psci
+                - spin-table
+            # On ARM 32-bit systems this property is optional
+            - enum:
+                - actions,s500-smp
+                - allwinner,sun6i-a31
+                - allwinner,sun8i-a23
+                - allwinner,sun9i-a80-smp
+                - allwinner,sun8i-a83t-smp
+                - amlogic,meson8-smp
+                - amlogic,meson8b-smp
+                - arm,realview-smp
+                - brcm,bcm11351-cpu-method
+                - brcm,bcm23550
+                - brcm,bcm2836-smp
+                - brcm,bcm63138
+                - brcm,bcm-nsp-smp
+                - brcm,brahma-b15
+                - marvell,armada-375-smp
+                - marvell,armada-380-smp
+                - marvell,armada-390-smp
+                - marvell,armada-xp-smp
+                - marvell,98dx3236-smp
+                - mediatek,mt6589-smp
+                - mediatek,mt81xx-tz-smp
+                - qcom,gcc-msm8660
+                - qcom,kpss-acc-v1
+                - qcom,kpss-acc-v2
+                - renesas,apmu
+                - renesas,r9a06g032-smp
+                - rockchip,rk3036-smp
+                - rockchip,rk3066-smp
+                - ste,dbx500-smp
+
+      cpu-release-addr:
+        $ref: '/schemas/types.yaml#/definitions/uint64'
+
+        description:
+          Required for systems that have an "enable-method"
+            property value of "spin-table".
+          On ARM v8 64-bit systems must be a two cell
+            property identifying a 64-bit zero-initialised
+            memory location.
+
+      qcom,saw:
+        $ref: '/schemas/types.yaml#/definitions/phandle'
+        description: |
+          Usage: required for systems that have an "enable-method"
+                 property value of "qcom,kpss-acc-v1" or
+                 "qcom,kpss-acc-v2"
+          Definition: Specifies the SAW[1] node associated with this CPU.
+
+      qcom,acc:
+        $ref: '/schemas/types.yaml#/definitions/phandle'
+        description: |
+          Usage: required for systems that have an "enable-method"
+                 property value of "qcom,kpss-acc-v1" or
+                 "qcom,kpss-acc-v2"
+          Definition: Specifies the ACC[2] node associated with this CPU.
+
+      cpu-idle-states:
+        $ref: '/schemas/types.yaml#/definitions/phandle-array'
+        description: |
+          Usage: Optional
+          Value type: <prop-encoded-array>
+          description: List of phandles to idle state nodes supported
+            by this cpu [3].
+
+      capacity-dmips-mhz:
+        $ref: '/schemas/types.yaml#/definitions/uint32'
+        description:
+          u32 value representing CPU capacity [4] in
+          DMIPS/MHz, relative to highest capacity-dmips-mhz
+          in the system.
+
+      rockchip,pmu:
+        description: |
+          Optional for systems that have an "enable-method"
+          property value of "rockchip,rk3066-smp"
+          While optional, it is the preferred way to get access to
+          the cpu-core power-domains.
+          Value type: <phandle>
+          Definition: Specifies the syscon node controlling the cpu core
+                power domains.
+
+      dynamic-power-coefficient:
+        $ref: '/schemas/types.yaml#/definitions/uint32'
+        description:
+          A u32 value that represents the running time dynamic
+          power coefficient in units of uW/MHz/V^2. The
+          coefficient can either be calculated from power
+          measurements or derived by analysis.
+
+          The dynamic power consumption of the CPU  is
+          proportional to the square of the Voltage (V) and
+          the clock frequency (f). The coefficient is used to
+          calculate the dynamic power as below -
+
+          Pdyn = dynamic-power-coefficient * V^2 * f
+
+          where voltage is in V, frequency is in MHz.
+
+    required:
+      - device_type
+      - reg
+      - compatible
+
+    dependencies:
+      cpu-release-addr: [enable-method]
+      rockchip,pmu: [enable-method]
+
+required:
+  - '#address-cells'
+  - '#size-cells'
+
+examples:
+  - |
+    cpus {
+      #size-cells = <0>;
+      #address-cells = <1>;
+
+      cpu@0 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a15";
+        reg = <0x0>;
+      };
+
+      cpu@1 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a15";
+        reg = <0x1>;
+      };
+
+      cpu@100 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a7";
+        reg = <0x100>;
+      };
+
+      cpu@101 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a7";
+        reg = <0x101>;
+      };
+    };
+
+  - |
+    // Example 2 (Cortex-A8 uniprocessor 32-bit system):
+    cpus {
+      #size-cells = <0>;
+      #address-cells = <1>;
+
+      cpu@0 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a8";
+        reg = <0x0>;
+      };
+    };
+
+  - |
+    // Example 3 (ARM 926EJ-S uniprocessor 32-bit system):
+    cpus {
+      #size-cells = <0>;
+      #address-cells = <1>;
+
+      cpu@0 {
+        device_type = "cpu";
+        compatible = "arm,arm926ej-s";
+        reg = <0x0>;
+      };
+    };
+
+  - |
+    //  Example 4 (ARM Cortex-A57 64-bit system):
+    cpus {
+      #size-cells = <0>;
+      #address-cells = <2>;
+
+      cpu@0 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x0 0x0>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@1 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x0 0x1>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@100 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x0 0x100>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@101 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x0 0x101>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@10000 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x0 0x10000>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@10001 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x0 0x10001>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@10100 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x0 0x10100>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@10101 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x0 0x10101>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@100000000 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x1 0x0>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@100000001 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x1 0x1>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@100000100 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x1 0x100>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@100000101 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x1 0x101>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@100010000 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x1 0x10000>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@100010001 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x1 0x10001>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@100010100 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x1 0x10100>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+
+      cpu@100010101 {
+        device_type = "cpu";
+        compatible = "arm,cortex-a57";
+        reg = <0x1 0x10101>;
+        enable-method = "spin-table";
+        cpu-release-addr = <0 0x20000000>;
+      };
+    };
+...
-- 
2.17.1

