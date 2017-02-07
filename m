Return-Path: <dougmill@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHlpq0LmczDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 00:40:50 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v17DdKNT057082
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 08:40:48 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28faaaxyh5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Feb 2017 08:40:48 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dougmill@linux.vnet.ibm.com>;
 Tue, 7 Feb 2017 06:40:47 -0700
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id C0AFF3E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 06:40:45 -0700 (MST)
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v17DeiIZ15860044
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 13:40:45 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1993B112047
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 08:40:45 -0500 (EST)
Received: from oc5780617838.ibm.com.rchland.ibm.com (unknown [9.10.86.191])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP id EF8A9112064
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 08:40:44 -0500 (EST)
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/1] powerpc/xmon: Dump memory in native endian format.
Date: Tue,  7 Feb 2017 07:40:44 -0600
Message-Id: <1486474844-9872-1-git-send-email-dougmill@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Extend dump command to allow display of 2, 4, and 8 byte words in native
endian format. Also adds dump command for "1 byte words" for the sake
of symmetry. New commands are:

	d1	dump 8 bit values
	d2	dump 16 bit values
	d4	dump 32 bit values
	d8	dump 64 bit values

Signed-off-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
---
 arch/powerpc/xmon/xmon.c |   65 +++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 9c0e17c..6249975 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -212,6 +212,10 @@ static void xmon_print_symbol(unsigned long address, const char *mid,
   "\
   C	checksum\n\
   d	dump bytes\n\
+  d1	dump 8 bit values\n\
+  d2	dump 16 bit values\n\
+  d4	dump 32 bit values\n\
+  d8	dump 64 bit values\n\
   di	dump instructions\n\
   df	dump float values\n\
   dd	dump double values\n\
@@ -2334,9 +2338,49 @@ static void dump_pacas(void)
 }
 #endif
 
+static void dump_by_size(unsigned long addr, long count, int size)
+{
+	unsigned char temp[16];
+	int i, j;
+	u64 val;
+
+	/*
+	 * 'count' was aligned 16. If that changes, the following
+	 * must also change to accommodate other values for 'count'.
+	 */
+	for (i = 0; i < count; i += 16, addr += 16) {
+		printf(REG, addr);
+
+		if (mread(addr, temp, 16) != 16) {
+			printf("Faulted reading %d bytes from 0x"REG"\n", 16, addr);
+			return;
+		}
+
+		for (j = 0; j < 16; j += size) {
+			putchar(' ');
+			switch (size) {
+			case 1: val = temp[j]; break;
+			case 2: val = *(u16 *)&temp[j]; break;
+			case 4: val = *(u32 *)&temp[j]; break;
+			case 8: val = *(u64 *)&temp[j]; break;
+			default: val = 0;
+			}
+
+			printf("%0*lx", size * 2, val);
+		}
+		printf("  |");
+		for (j = 0; j < 16; ++j) {
+			val = temp[j];
+			putchar(' ' <= val && val <= '~' ? val : '.');
+		}
+		printf("|\n");
+	}
+}
+
 static void
 dump(void)
 {
+	static char last[] = { "d?\n" };
 	int c;
 
 	c = inchar();
@@ -2350,8 +2394,9 @@ static void dump_pacas(void)
 	}
 #endif
 
-	if ((isxdigit(c) && c != 'f' && c != 'd') || c == '\n')
+	if (c == '\n')
 		termch = c;
+
 	scanhex((void *)&adrs);
 	if (termch != '\n')
 		termch = 0;
@@ -2383,9 +2428,23 @@ static void dump_pacas(void)
 			ndump = 64;
 		else if (ndump > MAX_DUMP)
 			ndump = MAX_DUMP;
-		prdump(adrs, ndump);
+
+		switch (c) {
+		case '8':
+		case '4':
+		case '2':
+		case '1':
+			ndump = ALIGN(ndump, 16);
+			dump_by_size(adrs, ndump, c - '0');
+			last[1] = c;
+			last_cmd = last;
+			break;
+		default:
+			prdump(adrs, ndump);
+			last_cmd = "d\n";
+		}
+
 		adrs += ndump;
-		last_cmd = "d\n";
 	}
 }
 
-- 
1.7.1
