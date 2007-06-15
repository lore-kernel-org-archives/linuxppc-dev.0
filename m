Return-Path: <sachinp@in.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CCF94DDF3C
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 15:32:35 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5F5WWAM016858
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 01:32:32 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5F5WWeN387930
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 01:32:32 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5F5WWWr009190
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 01:32:32 -0400
Message-ID: <46722489.9090503@in.ibm.com>
Date: Fri, 15 Jun 2007 11:02:57 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: for-2.6.23 branch in powerpc.git created
References: <18034.6787.951861.623265@cargo.ozlabs.ibm.com>
In-Reply-To: <18034.6787.951861.623265@cargo.ozlabs.ibm.com>
Content-Type: multipart/mixed; boundary="------------050903080802020908030908"
Cc: linuxppc-dev@ozlabs.org
Reply-To: sachinp@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050903080802020908030908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Paul Mackerras wrote:
> The patches I put in are listed below.  If you have a patch that
> should go in but isn't listed, remind me about it.
Paul, the following patch isn't listed. Please consider for merge.

[PATCH] Fix Kexec/Kdump for power6

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
Signed-off-by : Mohan Kumar M <mohan@in.ibm.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Acked-by: Olof Johansson <olof@lixom.net>


Thanks
-Sachin 




--------------050903080802020908030908
Content-Type: text/plain;
 name="kexec-kdump-on-power6"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="kexec-kdump-on-power6"

* On Power machines supporting VRMA, Kexec/Kdump does not work.
* Hypervisor stores VRMA mapping used by the OS, in the hpte hash tables.
* Make sure these hpte entries are left untouched.
*
* This patch also adds plpar_pte_read_raw() on the lines of
* plpar_pte_remove_raw().

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
Signed-off-by : Mohan Kumar M <mohan@in.ibm.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Acked-by: Olof Johansson <olof@lixom.net>
---

diff -Naurp old/arch/powerpc/platforms/pseries/lpar.c new/arch/powerpc/platforms/pseries/lpar.c
--- old/arch/powerpc/platforms/pseries/lpar.c	2007-06-05 06:27:25.000000000 +0530
+++ new/arch/powerpc/platforms/pseries/lpar.c	2007-06-07 15:28:07.000000000 +0530
@@ -373,12 +373,23 @@ static void pSeries_lpar_hptab_clear(voi
 {
 	unsigned long size_bytes = 1UL << ppc64_pft_size;
 	unsigned long hpte_count = size_bytes >> 4;
-	unsigned long dummy1, dummy2;
+	unsigned long dummy1, dummy2, dword0;
+	long lpar_rc;
 	int i;
 
 	/* TODO: Use bulk call */
-	for (i = 0; i < hpte_count; i++)
-		plpar_pte_remove_raw(0, i, 0, &dummy1, &dummy2);
+	for (i = 0; i < hpte_count; i++) {
+		/* dont remove HPTEs with VRMA mappings */
+		lpar_rc = plpar_pte_remove_raw(H_ANDCOND, i, HPTE_V_1TB_SEG,
+						&dummy1, &dummy2);
+		if (lpar_rc == H_NOT_FOUND) {
+			lpar_rc = plpar_pte_read_raw(0, i, &dword0, &dummy1);
+			if (!lpar_rc && ((dword0 & HPTE_V_VRMA_MASK)
+				!= HPTE_V_VRMA_MASK))
+				/* Can be hpte for 1TB Seg. So remove it */
+				plpar_pte_remove_raw(0, i, 0, &dummy1, &dummy2);
+		}
+	}
 }
 
 /*
diff -Naurp old/arch/powerpc/platforms/pseries/plpar_wrappers.h new/arch/powerpc/platforms/pseries/plpar_wrappers.h
--- old/arch/powerpc/platforms/pseries/plpar_wrappers.h	2007-06-05 06:27:25.000000000 +0530
+++ new/arch/powerpc/platforms/pseries/plpar_wrappers.h	2007-06-07 15:28:07.000000000 +0530
@@ -108,6 +108,21 @@ static inline long plpar_pte_read(unsign
 	return rc;
 }
 
+/* plpar_pte_read_raw can be called in real mode. It calls plpar_hcall_raw */
+static inline long plpar_pte_read_raw(unsigned long flags, unsigned long ptex,
+		unsigned long *old_pteh_ret, unsigned long *old_ptel_ret)
+{
+	long rc;
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+
+	rc = plpar_hcall_raw(H_READ, retbuf, flags, ptex);
+
+	*old_pteh_ret = retbuf[0];
+	*old_ptel_ret = retbuf[1];
+
+	return rc;
+}
+
 static inline long plpar_pte_protect(unsigned long flags, unsigned long ptex,
 		unsigned long avpn)
 {
diff -Naurp old/include/asm-powerpc/mmu-hash64.h new/include/asm-powerpc/mmu-hash64.h
--- old/include/asm-powerpc/mmu-hash64.h	2007-06-05 06:27:25.000000000 +0530
+++ new/include/asm-powerpc/mmu-hash64.h	2007-06-07 15:28:46.000000000 +0530
@@ -94,6 +94,9 @@ extern char initial_stab[];
 #define HPTE_R_C		ASM_CONST(0x0000000000000080)
 #define HPTE_R_R		ASM_CONST(0x0000000000000100)
 
+#define HPTE_V_1TB_SEG		ASM_CONST(0x4000000000000000)
+#define HPTE_V_VRMA_MASK	ASM_CONST(0x4001ffffff000000)
+
 /* Values for PP (assumes Ks=0, Kp=1) */
 /* pp0 will always be 0 for linux     */
 #define PP_RWXX	0	/* Supervisor read/write, User none */

--------------050903080802020908030908--
