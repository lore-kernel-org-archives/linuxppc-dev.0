Return-Path: <SRS0=lOLd=5O=de.ibm.com=abergman@srs.kundenserver.de>
Message-Id: <20060323203521.261957000@dyn-9-152-242-103.boeblingen.de.ibm.com>
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
Date: Thu, 23 Mar 2006 00:00:03 +0100
From: Arnd Bergmann <abergman@de.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [patch 03/13] powerpc: update cell platform detection
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All future firmware should have 'CBEA' in the compatible
property in order to tell us that we are running on the
cell platform, so check for that as well as the now
deprecated value we have been using so far.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index d34fe53..fc1f169 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1503,7 +1503,8 @@ static int __init prom_find_machine_type
 #ifdef CONFIG_PPC64
 			if (strstr(p, RELOC("Momentum,Maple")))
 				return PLATFORM_MAPLE;
-			if (strstr(p, RELOC("IBM,CPB")))
+			if (strstr(p, RELOC("IBM,CPB"))||
+			    strstr(p, RELOC("CBEA")))
 				return PLATFORM_CELL;
 #endif
 			i += sl + 1;

--
