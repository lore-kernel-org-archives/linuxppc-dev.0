Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0F32EDDFED
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 08:50:45 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9ULogmV021621
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 17:50:42 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9ULofDn032252
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 15:50:41 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9ULofWs006851
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 15:50:41 -0600
From: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: [PATCH] [powerpc v2] update xmon slb code
To: linuxppc-dev@ozlabs.org
Date: Tue, 30 Oct 2007 16:50:39 -0500
Message-ID: <20071030215037.12776.73871.stgit@farscape.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


[powerpc] update xmon slb code

This adds a bit more detail to the xmon SLB output.  When the valid bit is
set, This displays the ESID and VSID values, as well as decoding the
segment size. (1T or 256M).  This supresses the output for any slb entries
that contain only zeros.

sample output from power6 (1T segment support):

00 c000000008000000 40004f7ca3000500  1T  ESID=   c00000  VSID=40004f7ca3 LLP bits:100
01 d000000008000000 4000eb71b0000400  1T  ESID=   d00000  VSID=4000eb71b0 LLP bits:  0
03 0000000008000000 0000628021c6ac80 256M ESID=        0  VSID= 628021c6a LLP bits:  0
04 00000f0008000000 400095c1e8000c80  1T  ESID=        f  VSID=400095c1e8 LLP bits:  0
22 cf00000008000000 400011b260000500  1T  ESID=   cf0000  VSID=400011b260 LLP bits:100
62 0000040008000000 40005d488d000c80  1T  ESID=        4  VSID=40005d488d LLP bits:  0
63 0000000018000000 0000633f90285c80 256M ESID=        1  VSID= 633f90285 LLP bits:  0

sample output from power5 (notice the non-valid but non-zero entries)

00 c000000008000000 0000408f92c94500 256M ESID=c00000000  VSID= 408f92c94 LLP bits:100
01 d000000008000000 0000f09b89af5400 256M ESID=d00000000  VSID= f09b89af5 LLP bits:  0
03 0000000010000000 0000136eafb0bc80
11 0000000008000000 00005928811f2c80 256M ESID=        0  VSID= 5928811f2 LLP bits:  0
12 00000000f8000000 0000645ff8d87c80 256M ESID=        f  VSID= 645ff8d87 LLP bits:  0
13 0000000048000000 00005c263aa5ec80 256M ESID=        4  VSID= 5c263aa5e LLP bits:  0
14 0000000018000000 000059e7ef80dc80 256M ESID=        1  VSID= 59e7ef80d LLP bits:  0
15 0000000010000000 000059e7ef80dc80

Tested on power5 and power6.

Signed-Off-By: Will Schmidt <will_schmidt@vnet.ibm.com>

---
This version adds padding around the ESID and VSID fields, and the LLP bits
are displayed too.  (Per request from Olof and Ben).
I'll try to follow up sometime later with code that will handle decoding page
sizes.  I dont have a testcase handy to properly exercise that yet. :-)
---

 arch/powerpc/xmon/xmon.c |   27 +++++++++++++++++++++------
 1 files changed, 21 insertions(+), 6 deletions(-)


diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 121b04d..93c26c3 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2527,16 +2527,31 @@ static void xmon_print_symbol(unsigned long address, const char *mid,
 static void dump_slb(void)
 {
 	int i;
-	unsigned long tmp;
+	unsigned long esid,vsid,valid;
+	unsigned long llp_bits;
 
 	printf("SLB contents of cpu %x\n", smp_processor_id());
 
 	for (i = 0; i < SLB_NUM_ENTRIES; i++) {
-		asm volatile("slbmfee  %0,%1" : "=r" (tmp) : "r" (i));
-		printf("%02d %016lx ", i, tmp);
-
-		asm volatile("slbmfev  %0,%1" : "=r" (tmp) : "r" (i));
-		printf("%016lx\n", tmp);
+		asm volatile("slbmfee  %0,%1" : "=r" (esid) : "r" (i));
+		asm volatile("slbmfev  %0,%1" : "=r" (vsid) : "r" (i));
+		valid = (esid & SLB_ESID_V);
+		if (valid | esid | vsid) {
+			printf("%02d %016lx %016lx", i, esid, vsid);
+			if (valid) {
+				llp_bits = vsid & SLB_VSID_LLP;
+				if (vsid & SLB_VSID_B_1T) {
+					printf("  1T  ESID=%9lx  VSID=%10lx LLP bits:%3lx \n",
+						GET_ESID_1T(esid),vsid >> SLB_VSID_SHIFT_1T,
+						llp_bits);
+				} else {
+					printf(" 256M ESID=%9lx  VSID=%10lx LLP bits:%3lx \n",
+						GET_ESID(esid),vsid >> SLB_VSID_SHIFT,
+						llp_bits);
+				}
+			} else
+				printf("\n");
+		}
 	}
 }
 
