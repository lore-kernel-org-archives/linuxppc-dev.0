Message-ID: <3EB1A550.5080007@mvista.com>
Date: Thu, 01 May 2003 15:53:04 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: linuxppc_2_4_devel patch for Force CPCI-690
References: <3EAF1A0C.3050401@mvista.com>
In-Reply-To: <3EAF1A0C.3050401@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------020701040202040908010004"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------020701040202040908010004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Mark A. Greer wrote:

> The following patch adds support for the Force CPCI-690 cPCI board.
>
> If no one objects, please push this into linuxppc_2_4_devel.
>
> Thanks,
>
> Mark

Grr, forgot a file in the patch...

Mark

--------------020701040202040908010004
Content-Type: text/plain;
 name="cpci690.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpci690.patch"

===== arch/ppc/boot/simple/misc-cpci690.c 1.1 vs edited =====
--- 1.1/arch/ppc/boot/simple/misc-cpci690.c	Thu May  1 15:44:08 2003
+++ edited/arch/ppc/boot/simple/misc-cpci690.c	Thu May  1 15:44:21 2003
@@ -0,0 +1,72 @@
+/*
+ * arch/ppc/boot/simple/misc-cpci690.c
+ *
+ * Add birec data for Force CPCI690 board.
+ *
+ * Author: Mark A. Greer <source@mvista.com>
+ *
+ * Copyright 2003 MontaVista Software Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/types.h>
+#include <asm/bootinfo.h>
+
+#include "nonstdio.h"
+
+#include "../../platforms/cpci690.h"
+
+#define ENET_MAC_LEN	6
+#define GT64260_SETUP	"gt_mac"
+
+extern struct bi_record *decompress_kernel(unsigned long load_addr,
+						int num_words,
+						unsigned long cksum);
+
+static bd_t	board_info;
+
+/*
+ * The MAC addresses are store in the RTC's NVRAM.  We need to get them out
+ * from there, convert to the proper format for the kernel driver,
+ * and pass them into the kernel.
+ */
+struct bi_record *
+load_kernel(u32 load_addr, int num_words, u32 chksum)
+{
+	struct bi_record	*bi_recs;
+	struct bi_record	*rec;
+	bd_t			*bip = &board_info;
+
+	bi_recs = decompress_kernel(load_addr, num_words, chksum);
+
+	/*
+	 * Get the MAC addrs from RTC's NVRAM and pass in to kernel via
+	 * a bd_t type of bi_rec.
+	 */
+	rec = bi_recs;
+	if (rec && rec->tag == BI_FIRST) {
+		bip->bi_magic = CPCI690_BI_MAGIC;
+
+		memcpy(bip->bi_enetaddr[0],
+				(void *)(CPCI690_TODC_BASE+CPCI690_MAC_OFFSET),
+				sizeof(bip->bi_enetaddr));
+
+		while (rec->tag != BI_LAST)
+			rec = (struct bi_record *)((ulong)rec + rec->size);
+
+		rec->tag = BI_BOARD_INFO;
+		memcpy((char *)rec->data, bip, sizeof(bd_t));
+		rec->size = sizeof(struct bi_record) + sizeof(bd_t);
+		rec = (struct bi_record *)((unsigned long)rec + rec->size);
+
+		rec->tag = BI_LAST;
+	        rec->size = sizeof(struct bi_record);
+	        rec = (struct bi_record *)((ulong)rec + rec->size);
+	}
+
+	return bi_recs;
+}

--------------020701040202040908010004--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
