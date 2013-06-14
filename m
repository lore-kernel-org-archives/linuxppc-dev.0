Return-Path: <B31939@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A72962C031E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 17:15:55 +1000 (EST)
Received: from mail169-tx2 (localhost [127.0.0.1])	by
 mail169-tx2-R.bigfish.com (Postfix) with ESMTP id 878DC400CE	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 07:15:50 +0000 (UTC)
Received: from TX2EHSMHS019.bigfish.com (unknown [10.9.14.228])	by
 mail169-tx2.bigfish.com (Postfix) with ESMTP id A13361E004A	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 07:15:47 +0000 (UTC)
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 4/5] powerpc/dts: remove msi-available-ranges property
Date: Fri, 14 Jun 2013 15:15:58 +0800
Message-ID: <1371194159-17332-4-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1371194159-17332-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1371194159-17332-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Minghuan Lian <Minghuan.Lian@freescale.com>,
 Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For MPIC v4.3 MSIIR supports 8 MSI registers and MSIIR1 supports
16 MSI registers, but uses different IBS and SRS shift. For the
first register, when using MSIIR we will get the irqs 0x0 0x1 0x2
...0x1f, but when using MSIIR1, the irqs are 0x0 0x10 0x20 ... 0x1f0
It is hard to describe the available irqs using property
'msi-available-ranges'. The patch removes this property.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
 arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi      | 1 -
 arch/powerpc/boot/dts/fsl/qoriq-mpic.dtsi    | 3 ---
 arch/powerpc/boot/dts/fsl/qoriq-mpic4.3.dtsi | 4 ----
 3 files changed, 8 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi b/arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi
index 71c30eb..1ac4f23 100644
--- a/arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi
+++ b/arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi
@@ -66,7 +66,6 @@ message@41400 {
 msi@41600 {
 	compatible = "fsl,mpic-msi";
 	reg = <0x41600 0x80>;
-	msi-available-ranges = <0 0x100>;
 	interrupts = <
 		0xe0 0 0 0
 		0xe1 0 0 0
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-mpic.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-mpic.dtsi
index 08f4227..cf7355c 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-mpic.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-mpic.dtsi
@@ -54,7 +54,6 @@ timer@41100 {
 msi0: msi@41600 {
 	compatible = "fsl,mpic-msi";
 	reg = <0x41600 0x200 0x44140 4>;
-	msi-available-ranges = <0 0x100>;
 	interrupts = <
 		0xe0 0 0 0
 		0xe1 0 0 0
@@ -69,7 +68,6 @@ msi0: msi@41600 {
 msi1: msi@41800 {
 	compatible = "fsl,mpic-msi";
 	reg = <0x41800 0x200 0x45140 4>;
-	msi-available-ranges = <0 0x100>;
 	interrupts = <
 		0xe8 0 0 0
 		0xe9 0 0 0
@@ -84,7 +82,6 @@ msi1: msi@41800 {
 msi2: msi@41a00 {
 	compatible = "fsl,mpic-msi";
 	reg = <0x41a00 0x200 0x46140 4>;
-	msi-available-ranges = <0 0x100>;
 	interrupts = <
 		0xf0 0 0 0
 		0xf1 0 0 0
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-mpic4.3.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-mpic4.3.dtsi
index e2665b8..8a997ea 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-mpic4.3.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-mpic4.3.dtsi
@@ -54,7 +54,6 @@ timer@41100 {
 msi0: msi@41600 {
 	compatible = "fsl,mpic-msi", "fsl,mpic-msi-v4.3";
 	reg = <0x41600 0x200 0x44148 4>;
-	msi-available-ranges = <0 0x200>;
 	interrupts = <
 		0xe0 0 0 0
 		0xe1 0 0 0
@@ -77,7 +76,6 @@ msi0: msi@41600 {
 msi1: msi@41800 {
 	compatible = "fsl,mpic-msi", "fsl,mpic-msi-v4.3";
 	reg = <0x41800 0x200 0x45148 4>;
-	msi-available-ranges = <0 0x200>;
 	interrupts = <
 		0xe8 0 0 0
 		0xe9 0 0 0
@@ -100,7 +98,6 @@ msi1: msi@41800 {
 msi2: msi@41a00 {
 	compatible = "fsl,mpic-msi", "fsl,mpic-msi-v4.3";
 	reg = <0x41a00 0x200 0x46148 4>;
-	msi-available-ranges = <0 0x200>;
 	interrupts = <
 		0xf0 0 0 0
 		0xf1 0 0 0
@@ -123,7 +120,6 @@ msi2: msi@41a00 {
 msi3: msi@41c00 {
 	compatible = "fsl,mpic-msi", "fsl,mpic-msi-v4.3";
 	reg = <0x41c00 0x200 0x47148 4>;
-	msi-available-ranges = <0 0x200>;
 	interrupts = <
 		0xf8 0 0 0
 		0xf9 0 0 0
-- 
1.8.1.2
