Date: Thu, 6 Sep 2001 11:19:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Cc: Paul Mackerras <paulus@samba.org>
Subject: xmon support for Walnut
Message-ID: <20010906111950.D20279@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The following patch allows xmon to run on Walnut machines.

diff -urN ../linuxppc_2_4_devel/arch/ppc/xmon/start.c linux-bungo/arch/ppc/xmon/start.c
--- ../linuxppc_2_4_devel/arch/ppc/xmon/start.c	Wed Sep  5 13:58:54 2001
+++ linux-bungo/arch/ppc/xmon/start.c	Wed Sep  5 14:52:38 2001
@@ -151,6 +151,11 @@
 	sccd = (volatile unsigned char *) 0xffeffb08;
 	TXRDY = 0x20;
 	RXRDY = 1;
+#elif defined(CONFIG_405GP)
+	sccc = (volatile unsigned char *)0xef600305;
+	sccd = (volatile unsigned char *)0xef600300;
+	TXRDY = 0x20;
+	RXRDY = 1;
 #endif /* platform */
 }

diff -urN ../linuxppc_2_4_devel/arch/ppc/xmon/xmon.c linux-bungo/arch/ppc/xmon/xmon.c
--- ../linuxppc_2_4_devel/arch/ppc/xmon/xmon.c	Tue Aug 28 15:06:37 2001
+++ linux-bungo/arch/ppc/xmon/xmon.c	Fri Aug 31 15:23:57 2001
@@ -1,5 +1,5 @@
 /*
- * BK Id: %F% %I% %G% %U% %#%
+ * BK Id: SCCS/s.xmon.c 1.17 08/19/01 19:15:49 benh
  */
 /*
  * Routines providing a simple monitor for use on the PowerMac.
@@ -910,6 +910,16 @@
 }
 #endif

+#ifndef CONFIG_PPC_STD_MMU
+
+static void
+dump_hash_table()
+{
+	printf("Non-standard MMU.  Can't print has table.\n");
+}
+
+#else /* CONFIG_PPC_STD_MMU */
+
 #ifndef CONFIG_PPC64BRIDGE
 static void
 dump_hash_table_seg(unsigned seg, unsigned start, unsigned end)
@@ -1056,6 +1066,8 @@
 		seg_start = seg_end + 0x1000;
 	}
 }
+
+#endif /* CONFIG_PPC_STD_MMU */

 int
 mread(unsigned adrs, void *buf, int size)


--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
