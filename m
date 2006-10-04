Return-Path: <arnd@arndb.de>
Message-Id: <20061004161505.407284000@arndb.de>
References: <20061004152610.151599000@dyn-9-152-242-103.boeblingen.de.ibm.com>
Date: Wed, 04 Oct 2006 17:26:18 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 08/14] spufs: remove support for ancient firmware
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

Any firmware that still uses the 'spc' nodes already
stopped running for other reasons, so lets get rid of this.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6/arch/powerpc/platforms/cell/spu_base.c
@@ -791,18 +791,6 @@ static int __init init_spu_base(void)
 			break;
 		}
 	}
-	/* in some old firmware versions, the spe is called 'spc', so we
-	   look for that as well */
-	for (node = of_find_node_by_type(NULL, "spc");
-			node; node = of_find_node_by_type(node, "spc")) {
-		ret = create_spu(node);
-		if (ret) {
-			printk(KERN_WARNING "%s: Error initializing %s\n",
-				__FUNCTION__, node->name);
-			cleanup_spu_base();
-			break;
-		}
-	}
 	return ret;
 }
 module_init(init_spu_base);

--
