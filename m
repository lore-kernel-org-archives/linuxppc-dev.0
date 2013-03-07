Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews10.kpnxchange.com (cpsmtpb-ews10.kpnxchange.com
 [213.75.39.15]) by ozlabs.org (Postfix) with ESMTP id 23BDF2C02C3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 09:29:22 +1100 (EST)
Message-ID: <1362694559.5994.31.camel@x61.thuisdomein>
Subject: [PATCH] powerpc/wsp: drop "select PPC_WSP_COPRO"
From: Paul Bolle <pebolle@tiscali.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>
Date: Thu, 07 Mar 2013 23:15:59 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is no Kconfig symbol PPC_WSP_COPRO. The select statement for it is
a nop. Drop it.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
A short treatise on the uneventful life of PPC_WSP_COPRO in the mainline
kernel tree

Release v3.0 included commit 76b4eda866c4936af8d696f040abea56bf688e16
("powerpc: Add A2 cpu support"). It added some code wrapped in an
"#ifdef CONFIG_PPC_WSP_COPRO" and "#endif" pair. It did not add a
Kconfig symbol PPC_WSP_COPRO. Neither did it add a preprocessor #define
for CONFIG_PPC_WSP_COPRO. There haS actually never been such a symbol or
such a macro in the mainline tree.

Release v3.3 included commit fac26ad4f9cb794c9d1032f55f40a31cb55be09a
("powerpc/book3e: Add ICSWX/ACOP support to Book3e cores like A2"). It
basically renamed CONFIG_PPC_WSP_COPRO to CONFIG_PPC_ICSWX. It did not
elaborate why it did that. But at least PPC_ICSWX was a valid Kconfig
symbol.

Release v3.3 also included commit
cc35b6766878e31accc95c3fdae945bdadc73a46 ("powerpc/book3e: Add Chroma as
a new WSP/PowerEN platform."). That commit added a Kconfig select
statement for PPC_WSP_COPRO. It is not clear why it did that. Current
opinion is that it served no purpose and that the kernel tree would be
better of without that statement.

 arch/powerpc/platforms/wsp/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/wsp/Kconfig b/arch/powerpc/platforms/wsp/Kconfig
index 79d2225..56203a4 100644
--- a/arch/powerpc/platforms/wsp/Kconfig
+++ b/arch/powerpc/platforms/wsp/Kconfig
@@ -9,7 +9,6 @@ config PPC_WSP
 	select PCI
 	select PPC_IO_WORKAROUNDS if PCI
 	select PPC_INDIRECT_PIO if PCI
-	select PPC_WSP_COPRO
 	default n
 
 menu "WSP platform selection"
-- 
1.7.11.7
