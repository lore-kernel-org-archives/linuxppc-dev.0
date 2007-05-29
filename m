Return-Path: <sachinp@in.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6E084DDECB
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 16:17:53 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4T6HnUs013233
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 02:17:49 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4T6Hnx6353500
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 02:17:49 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4T6Hm0c003709
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 02:17:49 -0400
Message-ID: <465BC5A1.5040505@in.ibm.com>
Date: Tue, 29 May 2007 11:48:09 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Patch ] Kexec/Kdump support - POWER6
References: <4652E088.9080207@in.ibm.com> <4652E109.4020204@in.ibm.com>
	<4652E17C.7080607@in.ibm.com> <20070522153419.GA22047@lixom.net>
	<46540B6F.6030300@in.ibm.com>
	<18004.7556.311264.415721@cargo.ozlabs.ibm.com>
	<20070524121751.GB4547@in.ibm.com>
	<20070524142133.GA13191@lixom.net> <4656A488.2020507@in.ibm.com>
	<1180132987.19517.9.camel@localhost.localdomain>
	<465ABFC9.9020502@in.ibm.com>
	<1180387894.19517.99.camel@localhost.localdomain>
In-Reply-To: <1180387894.19517.99.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="------------020907050404060804010709"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	kexec@lists.infradead.org
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
--------------020907050404060804010709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:
> Move those to mmu-hash64.h along with the other ones. Also, keep the
> mask aligned to the top bits
>   
In previous patches i had these #defines in mmu-hash64.h. But got
review comments to move them to lpar.c :-)

Oh well i will move them back to mmu-hash64.h.

>> +                       if (!lpar_rc && (((dword0 >> 24) & HPTE_V_VRMA_MASK) 
>>     
> No need to shift >> 24, just have the mask left justified in the first
> place. No need to have a "magic" shift value in there.
>   
Ok.

> Appart from that, looks good. Does it actually work ? :-)
>   
Yes it does work. It must be my lucky day when i coded the patch :-)

Thanks
-Sachin

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
Signed-off-by : Mohan Kumar M <mohan@in.ibm.com>
---



--------------020907050404060804010709
Content-Type: text/plain;
 name="kexec-kdump-support-on-POWER6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kexec-kdump-support-on-POWER6"

* On Power machines supporting VRMA, Kexec/Kdump does not work.
* Hypervisor stores VRMA mapping used by the OS, in the hpte hash tables.
* Make sure these hpte entries are left untouched.
*
* This patch also adds plpar_pte_read_raw() on the lines of
* plpar_pte_remove_raw().

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
Signed-off-by : Mohan Kumar M <mohan@in.ibm.com>
---

diff -Naurp a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
--- a/arch/powerpc/platforms/pseries/lpar.c	2007-05-19 09:36:17.000000000 +0530
+++ b/arch/powerpc/platforms/pseries/lpar.c	2007-05-29 10:45:34.000000000 +0530
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
diff -Naurp a/arch/powerpc/platforms/pseries/plpar_wrappers.h b/arch/powerpc/platforms/pseries/plpar_wrappers.h
--- a/arch/powerpc/platforms/pseries/plpar_wrappers.h	2007-05-19 09:36:17.000000000 +0530
+++ b/arch/powerpc/platforms/pseries/plpar_wrappers.h	2007-05-25 12:20:38.000000000 +0530
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
diff -Naurp a/include/asm-powerpc/mmu-hash64.h b/include/asm-powerpc/mmu-hash64.h
--- a/include/asm-powerpc/mmu-hash64.h	2007-05-19 09:36:17.000000000 +0530
+++ b/include/asm-powerpc/mmu-hash64.h	2007-05-29 10:46:22.000000000 +0530
@@ -94,6 +94,9 @@ extern char initial_stab[];
 #define HPTE_R_C		ASM_CONST(0x0000000000000080)
 #define HPTE_R_R		ASM_CONST(0x0000000000000100)
 
+#define HPTE_V_1TB_SEG          ASM_CONST(0x4000000000000000)
+#define HPTE_V_VRMA_MASK        ASM_CONST(0x4001ffffff000000)
+
 /* Values for PP (assumes Ks=0, Kp=1) */
 /* pp0 will always be 0 for linux     */
 #define PP_RWXX	0	/* Supervisor read/write, User none */

--------------020907050404060804010709--
