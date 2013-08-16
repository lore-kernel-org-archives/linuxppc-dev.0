Return-Path: <B40534@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DF1CC2C032B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 18:17:52 +1000 (EST)
Received: from mail51-db8 (localhost [127.0.0.1])	by mail51-db8-R.bigfish.com
 (Postfix) with ESMTP id B930D380089	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,
 16 Aug 2013 08:17:47 +0000 (UTC)
Received: from DB8EHSMHS018.bigfish.com (unknown [10.174.8.232])	by
 mail51-db8.bigfish.com (Postfix) with ESMTP id 0AA93340046	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 08:17:46 +0000 (UTC)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH 2/2] powerpc/85xx: add hardware automatically enter pw20 state
Date: Fri, 16 Aug 2013 15:23:09 +0800
Message-ID: <1376637789-27330-2-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1376637789-27330-1-git-send-email-dongsheng.wang@freescale.com>
References: <1376637789-27330-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

Using hardware features make core automatically enter PW20 state.
Set a TB count to hardware, the effective count begins when PW10
is entered. When the effective period has expired, the core will
proceed from PW10 to PW20 if no exit conditions have occurred during
the period.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index c047e08..3c81a88 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -219,6 +219,7 @@
 
 /* Bit definitions for PWRMGTCR0. */
 #define PWRMGTCR0_ALTIVEC_IDLE	(1 << 22) /* Altivec idle enable */
+#define PWRMGTCR0_PW20_WAIT	(1 << 14) /* PW20 state enable bit */
 
 /* Bit definitions for the MCSR. */
 #define MCSR_MCS	0x80000000 /* Machine Check Summary */
diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index dbbbc24..a208d52 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -17,12 +17,22 @@
 
 #define ALTIVEC_COUNT_OFFSET		16
 #define ALTIVEC_IDLE_COUNT_MASK		0x003f0000
+#define PW20_COUNT_OFFSET		8
+#define PW20_IDLE_COUNT_MASK		0x00003f00
 
 /*
  * FIXME - We don't know the AltiVec application scenarios.
  */
 #define ALTIVEC_IDLE_TIME	1000 /* 1ms */
 
+/*
+ * FIXME - We don't know, what time should we let the core into PW20 state.
+ * because we don't know the current state of the cpu load. And threads are
+ * independent, so we can not know the state of different thread has been
+ * idle.
+ */
+#define	PW20_IDLE_TIME		1000 /* 1ms */
+
 static struct of_device_id __initdata mpc85xx_common_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
@@ -145,9 +155,33 @@ static void setup_altivec_idle(void *unused)
 	mtspr(SPRN_PWRMGTCR0, altivec_idle);
 }
 
+static void setup_pw20_idle(void *unused)
+{
+	u32 pw20_idle, bit;
+
+	if (!has_pw20_altivec_idle())
+		return;
+
+	pw20_idle = mfspr(SPRN_PWRMGTCR0);
+
+	/* set PW20_WAIT bit, enable pw20 */
+	pw20_idle |= PWRMGTCR0_PW20_WAIT;
+
+	/* Set Automatic PW20 Core Idle Count */
+	/* clear count */
+	pw20_idle &= ~PW20_IDLE_COUNT_MASK;
+
+	/* set count */
+	bit = get_idle_ticks_bit(PW20_IDLE_TIME);
+	pw20_idle |= ((MAX_BIT - bit) << PW20_COUNT_OFFSET);
+
+	mtspr(SPRN_PWRMGTCR0, pw20_idle);
+}
+
 static int __init setup_idle_hw_governor(void)
 {
 	on_each_cpu(setup_altivec_idle, NULL, 1);
+	on_each_cpu(setup_pw20_idle, NULL, 1);
 
 	return 0;
 }
-- 
1.8.0
