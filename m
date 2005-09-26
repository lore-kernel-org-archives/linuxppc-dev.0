Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id 1C26168394
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Sep 2005 07:37:28 +1000 (EST)
Date: Mon, 26 Sep 2005 14:37:27 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Matt Porter <mporter@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Message-ID: <20050926213727.GL18074@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] Add support for XMON on AMCC 440GX
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Note: The hex address rather than define matches style in the rest of
the code.

Add support for XMON on the AMCC 440GX boards.

Signed-off-by: Cal Erickson <cerickson@mvista.com>
Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- a/arch/ppc/xmon/start.c	2003-12-30 17:41:00.000000000 -0800
+++ b/arch/ppc/xmon/new_start.c	2005-09-23 09:20:24.000000000 -0700
@@ -213,6 +213,12 @@
 	TXRDY = 0x20;
 	RXRDY = 1;
 	DLAB = 0x80;
+#elif defined(CONFIG_440GX)
+        sccd = (volatile unsigned char *)ioremap64(0x0000000140000200, 8);
+        sccc = (volatile unsigned char *)( sccd + 5 );
+        TXRDY = 0x20;
+        RXRDY = 1;
+        DLAB = 0x80;
 #endif /* platform */
 
 	__sysrq_put_key_op('x', &sysrq_xmon_op);

-- 
Tom Rini
http://gate.crashing.org/~trini/
