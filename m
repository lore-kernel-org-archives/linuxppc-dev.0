Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20040717224138.36870.qmail@web15205.mail.bjs.yahoo.com>
Date: Sun, 18 Jul 2004 06:41:38 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: [patch]Make 2.6.7 kernel "make uImage" work for RPXlite DW
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20040709215108.5DC7DC109F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I found that the current 2.6.7 kernel "make uImage"
can make pass but didn't work with U-Boot on RPXlite
DW board.This fault is about bd_t,a FAQ in
DULG-13.2.5.Linux hangs after uncompressing the
kerne.So I make a patch against bk linuxppc-2.5 tree
as following.Wolfgang,could you check it?

Two questions with it:
1.Why 2.6.x kernel still use ppcboot.h rather than
u-boot.h?Anyway,ppcboot is a past thing.
2.Could <asm/ppcboot.h> include in rpxlite.h or
<BOARD.h> to replace bd_t a better idea all the time?

--- arch/ppc/platforms/rpxlite-bk.h	2004-07-10
19:36:40 +08:00
+++ arch/ppc/platforms/rpxlite.h	2004-07-11 18:16:08
+08:00
@@ -2,7 +2,7 @@
  * A collection of structures, addresses, and values
associated with
  * the RPCG RPX-Lite board.  Copied from the MBX
stuff.
  *
- * Copyright (c) 1998 Dan Malek (dmalek@jlc.net)
+ * Copyright (c) 2004 Dan Malek
(dan@embeddededge.com)
  */
 #ifdef __KERNEL__
 #ifndef __MACH_RPX_DEFS
@@ -14,14 +14,8 @@
 /* A Board Information structure that is given to a
program when
  * prom starts it up.
  */
-typedef struct bd_info {
-	unsigned int	bi_memstart;	/* Memory start address */
-	unsigned int	bi_memsize;	/* Memory (end) size in
bytes */
-	unsigned int	bi_intfreq;	/* Internal Freq, in Hz */
-	unsigned int	bi_busfreq;	/* Bus Freq, in Hz */
-	unsigned char	bi_enetaddr[6];
-	unsigned int	bi_baudrate;
-} bd_t;
+
+#include <asm/ppcboot.h>

 extern bd_t m8xx_board_info;

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
