Return-Path: <pkiryukhin@ru.mvista.com>
Received: from smtp02.mtu.ru (smtp02.mtu.ru [62.5.255.49])
	by ozlabs.org (Postfix) with ESMTP id 9B427DDF4F
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 00:38:18 +1100 (EST)
Received: from smtp02.mtu.ru (localhost [127.0.0.1])
	by smtp02.mtu.ru (Postfix) with ESMTP id EFB3232125
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 16:38:11 +0300 (MSK)
Received: from [192.168.1.3] (ppp83-237-251-59.pppoe.mtu-net.ru
	[83.237.251.59]) by smtp02.mtu.ru (Postfix) with ESMTP id DB5EC320D4
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 16:38:11 +0300 (MSK)
Message-ID: <47B59631.10908@ru.mvista.com>
Date: Fri, 15 Feb 2008 16:40:01 +0300
From: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] booting-without-of: add Xilinx uart 16550.
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add uart 16550 properties description to Xilinx portion of booting-without-of.txt

Signed-off-by: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
---
 Documentation/powerpc/booting-without-of.txt |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 7b4e8a7..dd77bbc 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -2575,10 +2575,22 @@ platforms are moved over to use the flattened-device-tree model.
 
       Xilinx uartlite devices are simple fixed speed serial ports.
 
-      Requred properties:
+      Required properties:
        - current-speed : Baud rate of uartlite
 
-      v) Xilinx hwicap
+      v) Xilinx Uart 16550
+
+      Xilinx uart 16550 device registers are compatible with all standard 16540 
+      and 16550 UARTs.
+
+      Required properties:
+       - current-speed : Baud rate of uart.
+       - clock-frequency : Baud rate generator reference clock. May be driven 
+         by OPB_Clk (100 MHz).
+       - reg-shift : registers offset shift (standard uart_port field). 
+         Property is optional if regshift is zero.
+
+      vi) Xilinx hwicap
 
 		Xilinx hwicap devices provide access to the configuration logic
 		of the FPGA through the Internal Configuration Access Port
-- 
1.5.4.1
