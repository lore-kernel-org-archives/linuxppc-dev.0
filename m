Return-Path: <krafft@de.ibm.com>
Message-ID: <443E38FE.2050304@de.ibm.com>
Date: Thu, 13 Apr 2006 13:41:50 +0200
From: Christian Krafft <krafft@de.ibm.com>
MIME-Version: 1.0
To: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: [patch] cell: correctly detect systemsim host
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Systemsim uses a different compatible property in the device tree.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>
---

Index: linux/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linux.orig/arch/powerpc/platforms/cell/setup.c
+++ linux/arch/powerpc/platforms/cell/setup.c
@@ -222,10 +222,13 @@ static int __init cell_probe(void)
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
