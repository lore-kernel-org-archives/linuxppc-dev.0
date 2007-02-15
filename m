Return-Path: <dgibson@ozlabs.org>
Resent-Message-ID: <20070215034108.GC17554@localhost.localdomain>
Date: Thu, 15 Feb 2007 14:38:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: More DCR native fixups
Message-ID: <20070215033804.GB17554@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlab.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paulus, resent with better description.  Please apply.

Getting BenH's new EMAC driver working on 440GP, I found some more
problems in the native mode paths of the new DCR code:
	- dcr_map() is supposed to return a dcr_host_t, but the native
version is a macro that doesn't expand to an expression.  With native
DCRs, dcr_host_t is an empty structure, so we just use a constructor
expression instead.
	- dcr_unmap() uses {} instead of the safer do {} while (0)
idiom to implement a no-op

Here's a fix.

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
