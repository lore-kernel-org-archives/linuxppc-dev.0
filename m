Return-Path: <dgibson@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 2/16] More DCR native fixups
In-Reply-To: <20070213060904.GA6214@localhost.localdomain>
Message-Id: <20070213061024.518A9DDD0D@ozlabs.org>
Date: Tue, 13 Feb 2007 17:10:24 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Getting BenH's new EMAC driver working on 440GP, I found some more
problems in the native mode paths of the new DCR code.  Here's a fix.

Signed-off-by: David Gibson <dwg@au1.ibm.com>
---

 include/asm-powerpc/dcr-native.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: working-2.6/include/asm-powerpc/dcr-native.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/dcr-native.h	2007-02-09 13:59:07.000000000 +1100
+++ working-2.6/include/asm-powerpc/dcr-native.h	2007-02-09 13:59:36.000000000 +1100
@@ -26,8 +26,8 @@ typedef struct {} dcr_host_t;
 
 #define DCR_MAP_OK(host)	(1)
 
-#define dcr_map(dev, dcr_n, dcr_c)	{}
-#define dcr_unmap(host, dcr_n, dcr_c)	{}
+#define dcr_map(dev, dcr_n, dcr_c)	((dcr_host_t){})
+#define dcr_unmap(host, dcr_n, dcr_c)	do {} while (0)
 #define dcr_read(host, dcr_n)		mfdcr(dcr_n)
 #define dcr_write(host, dcr_n, value)	mtdcr(dcr_n, value)
 
