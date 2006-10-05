Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BCDFD67E34
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Oct 2006 04:35:16 +1000 (EST)
Message-ID: <4525505E.9090903@am.sony.com>
Date: Thu, 05 Oct 2006 11:35:10 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] clean up pseries hcall interfaces
References: <591B6A09961C354991CD653B274DC8C2023662CB@ussdixms03.am.sony.com>	<20060725144124.GA3769@krispykreme>	<44C68544.9000609@am.sony.com>
	<17617.30304.366738.986854@cargo.ozlabs.ibm.com>
	<44D267EA.8050103@am.sony.com>
In-Reply-To: <44D267EA.8050103@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand wrote:
> Paul Mackerras wrote:
>> Geoff Levand writes:
>> 
>>> Change the scope of some pSeries routines now called through
>>> ppc_md to static.
>> 
>> With this I get:
>> 
>>   CC      arch/powerpc/platforms/pseries/lpar.o
>> /home/paulus/kernel/powerpc/arch/powerpc/platforms/pseries/lpar.c:273: error: static declaration of ‘pSeries_lpar_hpte_insert’ follows non-static declaration
>> include2/asm/mmu.h:254: error: previous declaration of ‘pSeries_lpar_hpte_insert’ was here
>> make[3]: *** [arch/powerpc/platforms/pseries/lpar.o] Error 1
> 
> OK, thanks for checking it.  As I mentioned in my original
> mail, it just looked like there could be some cleanup done,
> but I didn't test it.  I'll take a look at it some more and
> see if I can make a proper re-work.

Sorry it took so long to get this out.  Updated patch follows.

-Geoff




Change the powerpc hpte_insert routines now called through ppc_md to static
scope.


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---

Did build tests with pseries_defconfig, iseries_defconfig and a cell
platform.

Index: cell--common--5/arch/powerpc/platforms/pseries/lpar.c
===================================================================
--- cell--common--5.orig/arch/powerpc/platforms/pseries/lpar.c
+++ cell--common--5/arch/powerpc/platforms/pseries/lpar.c
@@ -268,7 +268,7 @@
 				cpu, hwcpu, vpa, ret);
 }
 
-long pSeries_lpar_hpte_insert(unsigned long hpte_group,
+static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
  			      unsigned long va, unsigned long pa,
  			      unsigned long rflags, unsigned long vflags,
  			      int psize)
@@ -494,7 +494,7 @@
  * Take a spinlock around flushes to avoid bouncing the hypervisor tlbie
  * lock.
  */
-void pSeries_lpar_flush_hash_range(unsigned long number, int local)
+static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 {
 	int i;
 	unsigned long flags = 0;
Index: cell--common--5/include/asm-powerpc/mmu.h
===================================================================
--- cell--common--5.orig/include/asm-powerpc/mmu.h
+++ cell--common--5/include/asm-powerpc/mmu.h
@@ -248,21 +248,6 @@
 extern void hpte_init_lpar(void);
 extern void hpte_init_iSeries(void);
 
-extern long pSeries_lpar_hpte_insert(unsigned long hpte_group,
-				     unsigned long va, unsigned long prpn,
-				     unsigned long rflags,
-				     unsigned long vflags, int psize);
-
-extern long native_hpte_insert(unsigned long hpte_group,
-			       unsigned long va, unsigned long prpn,
-			       unsigned long rflags,
-			       unsigned long vflags, int psize);
-
-extern long iSeries_hpte_insert(unsigned long hpte_group,
-				unsigned long va, unsigned long prpn,
-				unsigned long rflags,
-				unsigned long vflags, int psize);
-
 extern void stabs_alloc(void);
 extern void slb_initialize(void);
 extern void slb_flush_and_rebolt(void);
Index: cell--common--5/arch/powerpc/mm/hash_native_64.c
===================================================================
--- cell--common--5.orig/arch/powerpc/mm/hash_native_64.c
+++ cell--common--5/arch/powerpc/mm/hash_native_64.c
@@ -123,7 +123,7 @@
 	clear_bit(HPTE_LOCK_BIT, word);
 }
 
-long native_hpte_insert(unsigned long hpte_group, unsigned long va,
+static long native_hpte_insert(unsigned long hpte_group, unsigned long va,
 			unsigned long pa, unsigned long rflags,
 			unsigned long vflags, int psize)
 {
