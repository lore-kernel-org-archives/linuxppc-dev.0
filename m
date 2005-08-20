Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id ABB6567F88
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Aug 2005 17:36:14 +1000 (EST)
Date: Sat, 20 Aug 2005 00:36:12 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <20050820073612.GA14689@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: fix Bamboo and Luan build warnings
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Fix STD_UART_OP definitions in Bamboo and Luan board ports which 
were causing "initialization makes pointer from integer without a 
cast" warnings.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

diff --git a/arch/ppc/platforms/4xx/bamboo.h b/arch/ppc/platforms/4xx/bamboo.h
--- a/arch/ppc/platforms/4xx/bamboo.h
+++ b/arch/ppc/platforms/4xx/bamboo.h
@@ -88,7 +88,7 @@
 #define STD_UART_OP(num)					\
 	{ 0, BASE_BAUD, 0, UART##num##_INT,			\
 		(ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST),	\
-		iomem_base: UART##num##_IO_BASE,		\
+		iomem_base: (void*)UART##num##_IO_BASE,		\
 		io_type: SERIAL_IO_MEM},
 
 #define SERIAL_PORT_DFNS	\
diff --git a/arch/ppc/platforms/4xx/luan.h b/arch/ppc/platforms/4xx/luan.h
--- a/arch/ppc/platforms/4xx/luan.h
+++ b/arch/ppc/platforms/4xx/luan.h
@@ -55,7 +55,7 @@
 #define STD_UART_OP(num)					\
 	{ 0, BASE_BAUD, 0, UART##num##_INT,			\
 		(ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST),	\
-		iomem_base: UART##num##_IO_BASE,		\
+		iomem_base: (void*)UART##num##_IO_BASE,		\
 		io_type: SERIAL_IO_MEM},
 
 #define SERIAL_PORT_DFNS	\
