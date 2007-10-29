Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BFEDCDE161
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 07:00:33 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9TK0TG0014635
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 16:00:29 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9TK0TDj135520
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 16:00:29 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9TJxTgn003655
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 15:59:29 -0400
From: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: [PATCH] [powerpc] update xmon slb code
To: linuxppc-dev@ozlabs.org
Date: Mon, 29 Oct 2007 14:59:27 -0500
Message-ID: <20071029195925.9773.94394.stgit@farscape.rchland.ibm.com>
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

adds a bit more detail to the xmon SLB output.  When the valid bit is
set, This displays the ESID and VSID values, as well as decoding the
segment size. (1T or 256M).  This supresses the output for any slb entries
that contain only zeros.

I debated a bit on whether to check for just (valid) versus checking for
(valid|esid|vsid).  By inspection on power5, I do have SLB entries that
contain values but without the valid bit set, so opted to display any
non-zero values.

sample output from power6 (1T segment support):

00 c000000008000000 40004f7ca3000500  1T  ESID=c00000  VSID=40004f7ca3
01 d000000008000000 4000eb71b0000400  1T  ESID=d00000  VSID=4000eb71b0
24 cf00000008000000 400011b260000500  1T  ESID=cf0000  VSID=400011b260
25 0000040008000000 4000a9e949000c80  1T  ESID=4  VSID=4000a9e949
26 0000000018000000 00005e93bfd49c80 256M ESID=1  VSID=5e93bfd49
27 00000f0008000000 4000e262a4000c80  1T  ESID=f  VSID=4000e262a4
28 0000000008000000 00005dd45172ec80 256M ESID=0  VSID=5dd45172e

sample output from power5 (notice the non-valid but non-zero entries)

54 0000000048000000 0000cf33bb059c80 256M ESID=4  VSID=cf33bb059
55 0000000018000000 0000ccf56fe08c80 256M ESID=1  VSID=ccf56fe08
56 0000000010000000 0000dd82ce799c80
57 cf00000008000000 0000d59aca40f500 256M ESID=cf0000000  VSID=d59aca40f
58 c000000078000000 000045cb97751500 256M ESID=c00000007  VSID=45cb97751
59 0000040000000000 000061552db1bc80

Tested on power5 and power6.

Signed-Off-By: Will Schmidt <will_schmidt@vnet.ibm.com>
---

 arch/powerpc/xmon/xmon.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)


diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 121b04d..97984f3 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2527,16 +2527,24 @@ static void xmon_print_symbol(unsigned long address, const char *mid,
 static void dump_slb(void)
 {
 	int i;
-	unsigned long tmp;
+	unsigned long esid,vsid,valid;
 
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
+				if (vsid & SLB_VSID_B_1T)
+					printf("  1T  ESID=%lx  VSID=%lx \n", GET_ESID_1T(esid),vsid >>SLB_VSID_SHIFT_1T);
+				else 
+					printf(" 256M ESID=%lx  VSID=%lx \n", GET_ESID(esid),vsid >>SLB_VSID_SHIFT);
+			} else 
+				printf("\n");
+		}
 	}
 }
 
