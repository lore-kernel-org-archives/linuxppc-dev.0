Return-Path: <bharat.bhushan@nxp.com>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30087.outbound.protection.outlook.com [40.107.3.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cPQh2WSyzDqkJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 19:52:44 +1000 (AEST)
From: Bharat Bhushan <Bharat.Bhushan@nxp.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 oss@buserror.net, galak@kernel.crashing.org, mark.rutland@arm.com,
 kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: robh@kernel.org, keescook@chromium.org, tyreld@linux.vnet.ibm.com,
 joe@perches.com, Bharat Bhushan <Bharat.Bhushan@nxp.com>
Subject: [RFC 5/5] powerpc/fsl: Add supported-irq-ranges for P2020
Date: Fri, 27 Jul 2018 15:18:01 +0530
Message-Id: <1532684881-19310-6-git-send-email-Bharat.Bhushan@nxp.com>
In-Reply-To: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
References: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MPIC on NXP (Freescale) P2020 supports following irq
ranges:
  > 0 - 11      (External interrupt)
  > 16 - 79     (Internal interrupt)
  > 176 - 183   (Messaging interrupt)
  > 224 - 231   (Shared message signaled interrupt)

We have to remove "irq_count" from platform code as platform
is given precedence over device-tree, while I think device-tree
should have precedence.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
 arch/powerpc/boot/dts/fsl/p2020si-post.dtsi | 3 +++
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c   | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
index 884e01b..08e266b 100644
--- a/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
@@ -192,6 +192,9 @@
 /include/ "pq3-sec3.1-0.dtsi"
 /include/ "pq3-mpic.dtsi"
 /include/ "pq3-mpic-timer-B.dtsi"
+	pic@40000 {
+		supported-irq-ranges = <0 11 16 79 176 183 224 231>;
+	};
 
 	global-utilities@e0000 {
 		compatible = "fsl,p2020-guts";
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 1006950..49ff348 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -57,6 +57,11 @@ void __init mpc85xx_rdb_pic_init(void)
 			MPIC_BIG_ENDIAN |
 			MPIC_SINGLE_DEST_CPU,
 			0, 256, " OpenPIC  ");
+	} else if (of_machine_is_compatible("fsl,P2020RDB-PC")) {
+		mpic = mpic_alloc(NULL, 0,
+		  MPIC_BIG_ENDIAN |
+		  MPIC_SINGLE_DEST_CPU,
+		  0, 0, " OpenPIC  ");
 	} else {
 		mpic = mpic_alloc(NULL, 0,
 		  MPIC_BIG_ENDIAN |
-- 
1.9.3
