Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id DB0B1DDE37
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 13:35:08 +1000 (EST)
Date: Tue, 4 Sep 2007 21:41:59 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [PATCH] powerpc: Don't use generic machine check parsing everywhere
Message-ID: <20070905024159.GB27139@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If a platform provide it's own machine check handler, assume that code
will handle the reason parsing and reporting the error. The current
default fall-though only makes sense on a few 32-bit platforms that
lack individual handlers.
    
Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index ccfc99d..ce1aafc 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -440,34 +440,36 @@ void machine_check_exception(struct pt_regs *regs)
 	if (reason & MCSR_BUS_WRERR)
 		printk("Bus - Write Bus Error on buffered store or cache line push\n");
 #else /* !CONFIG_4xx && !CONFIG_E500 && !CONFIG_E200 */
-	printk("Machine check in kernel mode.\n");
-	printk("Caused by (from SRR1=%lx): ", reason);
-	switch (reason & 0x601F0000) {
-	case 0x80000:
-		printk("Machine check signal\n");
-		break;
-	case 0:		/* for 601 */
-	case 0x40000:
-	case 0x140000:	/* 7450 MSS error and TEA */
-		printk("Transfer error ack signal\n");
-		break;
-	case 0x20000:
-		printk("Data parity error signal\n");
-		break;
-	case 0x10000:
-		printk("Address parity error signal\n");
-		break;
-	case 0x20000000:
-		printk("L1 Data Cache error\n");
-		break;
-	case 0x40000000:
-		printk("L1 Instruction Cache error\n");
-		break;
-	case 0x00100000:
-		printk("L2 data cache parity error\n");
-		break;
-	default:
-		printk("Unknown values in msr\n");
+	if (!ppc_md.machine_check_exception) {
+		printk("Machine check in kernel mode.\n");
+		printk("Caused by (from SRR1=%lx): ", reason);
+		switch (reason & 0x601F0000) {
+		case 0x80000:
+			printk("Machine check signal\n");
+			break;
+		case 0:		/* for 601 */
+		case 0x40000:
+		case 0x140000:	/* 7450 MSS error and TEA */
+			printk("Transfer error ack signal\n");
+			break;
+		case 0x20000:
+			printk("Data parity error signal\n");
+			break;
+		case 0x10000:
+			printk("Address parity error signal\n");
+			break;
+		case 0x20000000:
+			printk("L1 Data Cache error\n");
+			break;
+		case 0x40000000:
+			printk("L1 Instruction Cache error\n");
+			break;
+		case 0x00100000:
+			printk("L2 data cache parity error\n");
+			break;
+		default:
+			printk("Unknown values in msr\n");
+		}
 	}
 #endif /* CONFIG_4xx */
 
