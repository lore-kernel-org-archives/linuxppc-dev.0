Return-Path: <vijay.rai@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0109.outbound.protection.outlook.com [65.55.169.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 68AC41A01E4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Dec 2014 15:40:09 +1100 (AEDT)
From: Vijay Rai <vijay.rai@freescale.com>
To: <gregkh@linuxfoundation.org>, <linux-serial@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] tty: 8250: Add 64byte UART support for FSL platforms
Date: Tue, 30 Dec 2014 15:08:08 +0530
Message-ID: <1419932288-17562-1-git-send-email-vijay.rai@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Vijay Rai <vijay.rai@freescale.com>,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 Priyanka Jain <Priyanka.Jain@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some of FSL SoCs like T1040 has new version of UART controller which
can support 64byte FiFo.
To enable 64 byte support, following needs to be done:
-FCR[EN64] needs to be programmed to 1 to enable it.
-Also, when FCR[EN64]==1, RTL bits to be used as below
to define various Receive Trigger Levels:
        -FCR[RTL] = 00  1 byte
        -FCR[RTL] = 01  16 bytes
        -FCR[RTL] = 10  32 bytes
        -FCR[RTL] = 11  56 bytes
-tx_loadsz is set to 32-bytes instead of 64-bytes to implement
 workaround of errata A-008006 which states that tx_loadsz should
 be configured less than Maximum supported fifo bytes

Signed-off-by: Vijay Rai <vijay.rai@freescale.com>
Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
---
 drivers/tty/serial/8250/8250_core.c |   20 +++++++++++++++++++-
 include/uapi/linux/serial_core.h    |    3 ++-
 include/uapi/linux/serial_reg.h     |    3 ++-
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 11c6685..565748c 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -329,6 +329,14 @@ static const struct serial8250_config uart_config[] = {
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
 	},
+	[PORT_16550A_FSL64] = {
+		.name		= "16550A_FSL64",
+		.fifo_size	= 64,
+		.tx_loadsz	= 32,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10 |
+				  UART_FCR7_64BYTE,
+		.flags		= UART_CAP_FIFO,
+	},
 };
 
 /* Uart divisor latch read */
@@ -956,7 +964,17 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 			up->port.type = PORT_16650;
 			up->capabilities |= UART_CAP_EFR | UART_CAP_SLEEP;
 		} else {
-			DEBUG_AUTOCONF("Motorola 8xxx DUART ");
+			serial_out(up, UART_LCR, 0);
+			serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO |
+				   UART_FCR7_64BYTE);
+			status1 = serial_in(up, UART_IIR) >> 5;
+			serial_out(up, UART_FCR, 0);
+			serial_out(up, UART_LCR, 0);
+
+			if (status1 == 7)
+				up->port.type = PORT_16550A_FSL64;
+			else
+				DEBUG_AUTOCONF("Motorola 8xxx DUART ");
 		}
 		serial_out(up, UART_EFR, 0);
 		return;
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index c172180..a3b4491 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -55,7 +55,8 @@
 #define PORT_ALTR_16550_F64 27	/* Altera 16550 UART with 64 FIFOs */
 #define PORT_ALTR_16550_F128 28 /* Altera 16550 UART with 128 FIFOs */
 #define PORT_RT2880	29	/* Ralink RT2880 internal UART */
-#define PORT_MAX_8250	29	/* max port ID */
+#define PORT_16550A_FSL64 30	/* Freescale 16550 UART with 64 FIFOs */
+#define PORT_MAX_8250	31	/* max port ID */
 
 /*
  * ARM specific type numbers.  These are not currently guaranteed
diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
index 53af3b7..00adb01 100644
--- a/include/uapi/linux/serial_reg.h
+++ b/include/uapi/linux/serial_reg.h
@@ -86,7 +86,8 @@
 #define UART_FCR6_T_TRIGGER_8	0x10 /* Mask for transmit trigger set at 8 */
 #define UART_FCR6_T_TRIGGER_24  0x20 /* Mask for transmit trigger set at 24 */
 #define UART_FCR6_T_TRIGGER_30	0x30 /* Mask for transmit trigger set at 30 */
-#define UART_FCR7_64BYTE	0x20 /* Go into 64 byte mode (TI16C750) */
+#define UART_FCR7_64BYTE	0x20 /* Go into 64 byte mode (TI16C750 and
+					some Freescale UARTs) */
 
 #define UART_FCR_R_TRIG_SHIFT		6
 #define UART_FCR_R_TRIG_BITS(x)		\
-- 
1.7.9.5
