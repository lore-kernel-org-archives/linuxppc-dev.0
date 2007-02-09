Return-Path: <dgibson@ozlabs.org>
Date: Fri, 9 Feb 2007 14:07:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: More DCR native fixups
Message-ID: <20070209030707.GD3489@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paulus, please apply

Getting BenH's new EMAC driver working on 440GP, I found some more
problems in the native mode paths of the new DCR code.  Here's a fix.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

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
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
