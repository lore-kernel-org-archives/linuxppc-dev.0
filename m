Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 16890DDDD5
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 04:29:50 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9VHTYli006384
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 13:29:34 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9VHTXai077892
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 11:29:34 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9VHTXXu014427
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 11:29:33 -0600
From: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: [PATCH] [powerpc v3] update xmon slb code
To: linuxppc-dev@ozlabs.org
Date: Wed, 31 Oct 2007 12:29:31 -0500
Message-ID: <20071031172929.23358.47755.stgit@farscape.rchland.ibm.com>
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
segment size, (1T or 256M) and displaying the LLP bits.  This supresses the
output for any slb entries that contain only zeros.

sample output from power6 (1T segment support):
00 c000000008000000 40004f7ca3000500  1T  ESID=   c00000  VSID=       4f7ca3 LLP:100
01 d000000008000000 4000eb71b0000400  1T  ESID=   d00000  VSID=       eb71b0 LLP:  0
08 0000000018000000 0000c8499f8ccc80 256M ESID=        1  VSID=    c8499f8cc LLP:  0
09 00000000f8000000 0000d2c1a8e46c80 256M ESID=        f  VSID=    d2c1a8e46 LLP:  0
10 0000000048000000 0000ca87eab1dc80 256M ESID=        4  VSID=    ca87eab1d LLP:  0
43 cf00000008000000 400011b260000500  1T  ESID=   cf0000  VSID=       11b260 LLP:100

sample output from power5 (notice the non-valid but non-zero entries)
10 0000000008000000 00004fd0e077ac80 256M ESID=        0  VSID=    4fd0e077a LLP:  0
11 00000000f8000000 00005b085830fc80 256M ESID=        f  VSID=    5b085830f LLP:  0
12 0000000048000000 000052ce99fe6c80 256M ESID=        4  VSID=    52ce99fe6 LLP:  0
13 0000000018000000 000050904ed95c80 256M ESID=        1  VSID=    50904ed95 LLP:  0
14 cf00000008000000 0000d59aca40f500 256M ESID=cf0000000  VSID=    d59aca40f LLP:100
15 c000000078000000 000045cb97751500 256M ESID=c00000007  VSID=    45cb97751 LLP:100

Tested on power5 and power6.

Signed-Off-By: Will Schmidt <will_schmidt@vnet.ibm.com>

---
(Updates made per comments from Olof and Ben and Paul).
This version adds padding around the ESID and VSID fields, and the LLP bits
are displayed too.
Counting bits, the VSID output looks to be as large as 51 bits, which requires
up to 13 spaces.  This doesnt count the B field bits which are now masked off
the top end of the VSID output.

I'll try to follow up sometime later with code that will handle decoding page
sizes.  I dont have a testcase handy to properly exercise that yet. :-)
---

 arch/powerpc/xmon/xmon.c |   29 +++++++++++++++++++++++------
 1 files changed, 23 insertions(+), 6 deletions(-)


diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 121b04d..5314db7 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2527,16 +2527,33 @@ static void xmon_print_symbol(unsigned long address, const char *mid,
 static void dump_slb(void)
 {
 	int i;
-	unsigned long tmp;
+	unsigned long esid,vsid,valid;
+	unsigned long llp;
 
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
+				llp = vsid & SLB_VSID_LLP;
+				if (vsid & SLB_VSID_B_1T) {
+					printf("  1T  ESID=%9lx  VSID=%13lx LLP:%3lx \n",
+						GET_ESID_1T(esid),
+						(vsid & ~SLB_VSID_B) >> SLB_VSID_SHIFT_1T,
+						llp);
+				} else {
+					printf(" 256M ESID=%9lx  VSID=%13lx LLP:%3lx \n",
+						GET_ESID(esid),
+						(vsid & ~SLB_VSID_B) >> SLB_VSID_SHIFT,
+						llp);
+				}
+			} else
+				printf("\n");
+		}
 	}
 }
 
