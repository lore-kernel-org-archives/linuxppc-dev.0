Message-ID: <40D695EE.5080907@intracom.gr>
Date: Mon, 21 Jun 2004 11:01:50 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] fec_8xx driver take 2 (+ethtool)
References: <40CD902A.4020702@intracom.gr> <40D4B1AF.3070209@pobox.com>
In-Reply-To: <40D4B1AF.3070209@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------090908070003060307090502"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------090908070003060307090502
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

And here is the ethtool patch...

Regards

Pantelis


--------------090908070003060307090502
Content-Type: text/x-patch;
 name="ethtool-fec_8xx.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ethtool-fec_8xx.diff"

diff -ruN ethtool-1.8/Makefile.am ethtool-1.8-work/Makefile.am
--- ethtool-1.8/Makefile.am	2003-05-30 00:20:20.000000000 +0300
+++ ethtool-1.8-work/Makefile.am	2004-06-14 14:18:18.328540128 +0300
@@ -5,7 +5,7 @@

 sbin_PROGRAMS = ethtool
 ethtool_SOURCES = de2104x.c ethtool.c ethtool-copy.h ethtool-util.h natsemi.c \
-                  e1000.c realtek.c e100.c tg3.c amd8111e.c
+                  e1000.c realtek.c e100.c tg3.c amd8111e.c fec_8xx.c

 dist-hook:
 	cp $(top_srcdir)/ethtool.spec $(distdir)
diff -ruN ethtool-1.8/ethtool-util.h ethtool-1.8-work/ethtool-util.h
--- ethtool-1.8/ethtool-util.h	2003-05-30 00:20:24.000000000 +0300
+++ ethtool-1.8-work/ethtool-util.h	2004-06-14 14:19:19.011314944 +0300
@@ -33,4 +33,7 @@
 /* Advanced Micro Devices  AMD8111 based Adapter */
 int amd8111e_dump_regs(struct ethtool_drvinfo *info, struct ethtool_regs *regs);

+/* Motorola 8xx FEC Ethernet controller */
+int fec_8xx_dump_regs(struct ethtool_drvinfo *info, struct ethtool_regs *regs);
+
 #endif
diff -ruN ethtool-1.8/ethtool.c ethtool-1.8-work/ethtool.c
--- ethtool-1.8/ethtool.c	2003-07-19 18:15:26.000000000 +0300
+++ ethtool-1.8-work/ethtool.c	2004-06-14 14:18:43.428724320 +0300
@@ -998,6 +998,8 @@
 		return e100_dump_regs(info, regs);
 	if (!strncmp("amd8111e", info->driver, ETHTOOL_BUSINFO_LEN))
 		return amd8111e_dump_regs(info, regs);
+	if (!strncmp("fec_8xx", info->driver, ETHTOOL_BUSINFO_LEN))
+		return fec_8xx_dump_regs(info, regs);


 	fprintf(stdout, "Offset\tValue\n");
diff -ruN ethtool-1.8/fec_8xx.c ethtool-1.8-work/fec_8xx.c
--- ethtool-1.8/fec_8xx.c	1970-01-01 02:00:00.000000000 +0200
+++ ethtool-1.8-work/fec_8xx.c	2004-06-14 14:20:09.546632408 +0300
@@ -0,0 +1,81 @@
+/*
+ * Copyright (C) 2004 Intracom S.A.
+ * Pantelis Antoniou <panto@intracom.gr>
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+#include <stddef.h>
+
+#include "ethtool-util.h"
+
+struct fec {
+	uint32_t	addr_low;	/* lower 32 bits of station address	*/
+	uint32_t	addr_high;	/* upper 16 bits of station address||0  */
+	uint32_t	hash_table_high;/* upper 32-bits of hash table		*/
+	uint32_t	hash_table_low;	/* lower 32-bits of hash table		*/
+	uint32_t	r_des_start;	/* beginning of Rx descriptor ring	*/
+	uint32_t	x_des_start;	/* beginning of Tx descriptor ring	*/
+	uint32_t	r_buff_size;	/* Rx buffer size			*/
+	uint32_t	res2[9];	/* reserved				*/
+	uint32_t	ecntrl;		/* ethernet control register		*/
+	uint32_t	ievent;		/* interrupt event register		*/
+	uint32_t	imask;		/* interrupt mask register		*/
+	uint32_t	ivec;		/* interrupt level and vector status	*/
+	uint32_t	r_des_active;	/* Rx ring updated flag			*/
+	uint32_t	x_des_active;	/* Tx ring updated flag			*/
+	uint32_t	res3[10];	/* reserved				*/
+	uint32_t	mii_data;	/* MII data register			*/
+	uint32_t	mii_speed;	/* MII speed control register		*/
+	uint32_t	res4[17];	/* reserved				*/
+	uint32_t	r_bound;	/* end of RAM (read-only)		*/
+	uint32_t	r_fstart;	/* Rx FIFO start address		*/
+	uint32_t	res5[6];	/* reserved				*/
+	uint32_t	x_fstart;	/* Tx FIFO start address		*/
+	uint32_t	res6[17];	/* reserved				*/
+	uint32_t	fun_code;	/* fec SDMA function code		*/
+	uint32_t	res7[3];	/* reserved				*/
+	uint32_t	r_cntrl;	/* Rx control register			*/
+	uint32_t	r_hash;		/* Rx hash register			*/
+	uint32_t	res8[14];	/* reserved				*/
+	uint32_t	x_cntrl;	/* Tx control register			*/
+	uint32_t	res9[0x1e];	/* reserved				*/
+};
+
+#define DUMP_REG(f, x)	fprintf(stdout, \
+			"0x%04x: %-16s 0x%08x\n", \
+				offsetof(struct fec, x), \
+				#x, f->x)
+
+int fec_8xx_dump_regs(struct ethtool_drvinfo *info, struct ethtool_regs *regs)
+{
+	struct fec *f = (struct fec *)regs->data;
+
+	fprintf(stdout, "Descriptor Registers\n");
+	fprintf(stdout, "---------------------\n");
+
+	DUMP_REG(f, addr_low);
+	DUMP_REG(f, addr_high);
+	DUMP_REG(f, hash_table_high);
+	DUMP_REG(f, hash_table_low);
+	DUMP_REG(f, r_des_start);
+	DUMP_REG(f, x_des_start);
+	DUMP_REG(f, r_buff_size);
+	DUMP_REG(f, ecntrl);
+	DUMP_REG(f, ievent);
+	DUMP_REG(f, imask);
+	DUMP_REG(f, ivec);
+	DUMP_REG(f, r_des_active);
+	DUMP_REG(f, x_des_active);
+	DUMP_REG(f, mii_data);
+	DUMP_REG(f, mii_speed);
+	DUMP_REG(f, r_bound);
+	DUMP_REG(f, r_fstart);
+	DUMP_REG(f, x_fstart);
+	DUMP_REG(f, fun_code);
+	DUMP_REG(f, r_cntrl);
+	DUMP_REG(f, r_hash);
+	DUMP_REG(f, x_cntrl);
+
+	return 0;
+}

--------------090908070003060307090502--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
