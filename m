Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews04.kpnxchange.com (cpsmtpb-ews04.kpnxchange.com
 [213.75.39.7]) by ozlabs.org (Postfix) with ESMTP id 99C242C02A2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 11:21:55 +1100 (EST)
Message-ID: <1363047710.3137.132.camel@x61.thuisdomein>
Subject: [PATCH] powerpc: remove outdated default
From: Paul Bolle <pebolle@tiscali.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>
Date: Tue, 12 Mar 2013 01:21:50 +0100
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

The Kconfig symbol PCI_PERMEDIA got removed in v2.6.24, through commit
e6b6e3ffb9ee8926f9f2f7dc9147df73e27d5828 ("[POWERPC] Remove APUS support
from arch/ppc"). Remove its last occurrence.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Tested with "make ARCH=powerpc menuconfig" using ps3_defconfig, both
before and after this patch. ("!4xx && !CPM2 && !8xx" is true for ps3,
and it uses PPC_PCI_CHOICE.) Nothing seemed to change. Which makes
sense, as defaulting to an undefined symbol should be a nop.

 arch/powerpc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b89d7eb..3d566c3 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -744,7 +744,6 @@ config PCI
 	bool "PCI support" if PPC_PCI_CHOICE
 	default y if !40x && !CPM2 && !8xx && !PPC_83xx \
 		&& !PPC_85xx && !PPC_86xx && !GAMECUBE_COMMON
-	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx
 	default PCI_QSPAN if !4xx && !CPM2 && 8xx
 	select ARCH_SUPPORTS_MSI
 	select GENERIC_PCI_IOMAP
-- 
1.7.11.7
