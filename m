Return-Path: <arnd.bergmann@de.ibm.com>
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: fix cell platform detection
Date: Fri, 24 Mar 2006 19:52:53 +0100
References: <1143178947.4257.78.camel@localhost.localdomain>
	<1143187298.3710.3.camel@localhost.localdomain>
	<200603240946.51793.arnd@arndb.de>
In-Reply-To: <200603240946.51793.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200603241952.54126.arnd.bergmann@de.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>, cbe-oss-dev@ozlabs.org
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

---

This applies on top of the 'Kill machine numbers' patch
from Ben Herrenschmidt.

Index: linus-2.6/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/setup.c
+++ linus-2.6/arch/powerpc/platforms/cell/setup.c
@@ -198,7 +198,14 @@ static void __init cell_init_early(void)
 static int __init cell_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
-	if (!of_flat_dt_is_compatible(root, "IBM,CPB"))
+
+	/*
+	 * CPBW was used on early prototypes and will be removed.
+	 * The correct identification is CBEA.
+	 */
+	if (!of_flat_dt_is_compatible(root, "IBM,CPBW-1.0") &&
+	    !of_flat_dt_is_compatible(root, "IBM,CBEA") &&
+	    !of_flat_dt_is_compatible(root, "CBEA"))
 		return 0;
 
 	return 1;
