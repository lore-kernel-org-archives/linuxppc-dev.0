Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id 27AB42BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Nov 2004 05:15:26 +1100 (EST)
Date: Fri, 19 Nov 2004 11:15:25 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, linuxppc-embedded@ozlabs.org
Message-ID: <20041119181525.GG16043@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH 2.6.10-rc2] ppc32: Fix __iomem warnings in TODC code
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

A trivial fix for the __iomem warnings in arch/ppc/syslib/todc_time.c

Signed-off-by: Randy Vinson <rvinson@mvista.com>
Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- a/arch/ppc/syslib/todc_time.c	2004-10-29 18:29:54.000000000 -0700
+++ b/arch/ppc/syslib/todc_time.c	2004-10-29 18:40:10.000000000 -0700
@@ -82,13 +82,13 @@ extern spinlock_t	rtc_lock;
 u_char
 todc_direct_read_val(int addr)
 {
-	return readb(todc_info->nvram_data + addr);
+	return readb((void __iomem *)(todc_info->nvram_data + addr));
 }
 
 void
 todc_direct_write_val(int addr, unsigned char val)
 {
-	writeb(val, todc_info->nvram_data + addr);
+	writeb(val, (void __iomem *)(todc_info->nvram_data + addr));
 	return;
 }


-- 
Tom Rini
http://gate.crashing.org/~trini/
