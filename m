Return-Path: <arnd@arndb.de>
Message-Id: <200604300142.23473.arnd@arndb.de>
References: <20060429232812.825714000@localhost.localdomain>
Date: Sun, 30 Apr 2006 01:42:22 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: [PATCH 10/13] cell: correctly detect systemsim host
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	Christian Krafft <krafft@de.ibm.com>, cbe-oss-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christian Krafft <krafft@de.ibm.com>
Systemsim uses a different compatible property in the device tree.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: linus-2.6/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/setup.c	2006-04-29 
22:53:51.000000000 +0200
+++ linus-2.6/arch/powerpc/platforms/cell/setup.c	2006-04-29 
22:54:32.000000000 +0200
@@ -201,10 +201,13 @@
 	 * more appropriate detection logic
 	 */
 	unsigned long root = of_get_flat_dt_root();
-	if (!of_flat_dt_is_compatible(root, "IBM,CPBW-1.0"))
-		return 0;
+	if (of_flat_dt_is_compatible(root, "IBM,CPBW-1.0"))
+		return 1;
 
-	return 1;
+	if (of_flat_dt_is_compatible(root, "IBM,CPBW-SystemSim"))
+		return 1;
+
+	return 0;
 }
 
 /*

--
