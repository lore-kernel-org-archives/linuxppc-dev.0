Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id D0D24DDF40
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 08:33:50 +1100 (EST)
Message-ID: <48ED273B.7080101@harris.com>
Date: Wed, 08 Oct 2008 17:33:47 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: PPC440EPx gpio driver
References: <48ED1E96.4060406@harris.com>
In-Reply-To: <48ED1E96.4060406@harris.com>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is the remainder of the driver - just the structure of the
registers for the 440EPx.  I put the struct in this file because that
is similar to what was done for the mpc52xx, but the struct could go
elsewhere if more appropriate.

Anyway, I'd like some feedback on this driver, because I imagine other
folks would like to have a gpio driver for the 440 family.

Signed-off-by: Steve Falco <sfalco at harris.com>

diff --git a/arch/powerpc/include/asm/ppc4xx.h b/arch/powerpc/include/asm/ppc4xx.h
index 033039a..acbccb7 100644
--- a/arch/powerpc/include/asm/ppc4xx.h
+++ b/arch/powerpc/include/asm/ppc4xx.h
@@ -13,6 +13,28 @@
 #ifndef __ASM_POWERPC_PPC4xx_H__
 #define __ASM_POWERPC_PPC4xx_H__
 
+/* GPIO */
+struct ppc4xx_gpio {
+	unsigned int gpio_or;
+	unsigned int gpio_tcr;
+	unsigned int gpio_osrl;
+	unsigned int gpio_osrh;
+	unsigned int gpio_tsrl;
+	unsigned int gpio_tsrh;
+	unsigned int gpio_odr;
+	unsigned int gpio_ir;
+	unsigned int gpio_rr1;
+	unsigned int gpio_rr2;
+	unsigned int gpio_rr3;
+	unsigned int reserved1;
+	unsigned int gpio_isr1l;
+	unsigned int gpio_isr1h;
+	unsigned int gpio_isr2l;
+	unsigned int gpio_isr2h;
+	unsigned int gpio_isr3l;
+	unsigned int gpio_isr3h;
+};
+
 extern void ppc4xx_reset_system(char *cmd);
 
 #endif /* __ASM_POWERPC_PPC4xx_H__ */
