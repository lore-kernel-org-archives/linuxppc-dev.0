Return-Path: <geoffrey.levand@am.sony.com>
Message-ID: <44600047.2010401@am.sony.com>
Date: Mon, 08 May 2006 19:36:55 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch] powerpc: remove do-nothing cpu setup routines
References: <BE9739CD-B66A-43A4-B5E9-2DE49CEDE5B7@kernel.crashing.org>
In-Reply-To: <BE9739CD-B66A-43A4-B5E9-2DE49CEDE5B7@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: "Levand, Geoffrey" <Geoffrey.Levand@am.sony.com>,
	Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>>> Removes the processor specific do-nothing routines  
>>> __setup_cpu_power3 and
>>> __setup_cpu_power4 with the generic routine __setup_cpu_null.
>>
>> Why not just change the caller to test for NULL ?
> 
> Yes, please do (as Paul suggested already).

Paul, here is an updated patch.  This version makes my other
patch 'cell: remove broken __setup_cpu_be function', send by
Arnd, obsolete.

-Geoff


Removed the do-nothing routines __setup_cpu_power3 and
__setup_cpu_power4 and replaced them with a null pointer check
in the caller.  Also removed the Cell processor specific
routine __setup_cpu_be which improperly accessed the
hypervisor page size configuration at SPR HID6.


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>


---
Index: cell--alp--3/arch/powerpc/kernel/cpu_setup_power4.S
===================================================================
--- cell--alp--3.orig/arch/powerpc/kernel/cpu_setup_power4.S	2006-04-26 19:19:25.000000000 -0700
+++ cell--alp--3/arch/powerpc/kernel/cpu_setup_power4.S	2006-05-08 18:51:55.000000000 -0700
@@ -73,23 +73,6 @@
 	isync
 	blr

-_GLOBAL(__setup_cpu_power4)
-	blr
-
-_GLOBAL(__setup_cpu_be)
-        /* Set large page sizes LP=0: 16MB, LP=1: 64KB */
-        addi    r3, 0,  0
-        ori     r3, r3, HID6_LB
-        sldi    r3, r3, 32
-        nor     r3, r3, r3
-        mfspr   r4, SPRN_HID6
-        and     r4, r4, r3
-        addi    r3, 0, 0x02000
-        sldi    r3, r3, 32
-        or      r4, r4, r3
-        mtspr   SPRN_HID6, r4
-	blr
-
 _GLOBAL(__setup_cpu_ppc970)
 	mfspr	r0,SPRN_HID0
 	li	r11,5			/* clear DOZE and SLEEP */
Index: cell--alp--3/arch/powerpc/kernel/cputable.c
===================================================================
--- cell--alp--3.orig/arch/powerpc/kernel/cputable.c	2006-04-26 19:19:25.000000000 -0700
+++ cell--alp--3/arch/powerpc/kernel/cputable.c	2006-05-08 18:51:55.000000000 -0700
@@ -30,11 +30,6 @@
  * part of the cputable though. That has to be fixed for both ppc32
  * and ppc64
  */
-#ifdef CONFIG_PPC64
-extern void __setup_cpu_power3(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_power4(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_be(unsigned long offset, struct cpu_spec* spec);
-#else
 extern void __setup_cpu_603(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_604(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_750(unsigned long offset, struct cpu_spec* spec);
@@ -43,7 +38,6 @@
 extern void __setup_cpu_7400(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_7410(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_745x(unsigned long offset, struct cpu_spec* spec);
-#endif /* CONFIG_PPC32 */
 extern void __setup_cpu_ppc970(unsigned long offset, struct cpu_spec* spec);

 /* This table only contains "desktop" CPUs, it need to be filled with embedded
@@ -80,7 +74,6 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
-		.cpu_setup		= __setup_cpu_power3,
 		.oprofile_cpu_type	= "ppc64/power3",
 		.oprofile_type		= PPC_OPROFILE_RS64,
 		.platform		= "power3",
@@ -94,7 +87,6 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
-		.cpu_setup		= __setup_cpu_power3,
 		.oprofile_cpu_type	= "ppc64/power3",
 		.oprofile_type		= PPC_OPROFILE_RS64,
 		.platform		= "power3",
@@ -108,7 +100,6 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
-		.cpu_setup		= __setup_cpu_power3,
 		.oprofile_cpu_type	= "ppc64/rs64",
 		.oprofile_type		= PPC_OPROFILE_RS64,
 		.platform		= "rs64",
@@ -122,7 +113,6 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
-		.cpu_setup		= __setup_cpu_power3,
 		.oprofile_cpu_type	= "ppc64/rs64",
 		.oprofile_type		= PPC_OPROFILE_RS64,
 		.platform		= "rs64",
@@ -136,7 +126,6 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
-		.cpu_setup		= __setup_cpu_power3,
 		.oprofile_cpu_type	= "ppc64/rs64",
 		.oprofile_type		= PPC_OPROFILE_RS64,
 		.platform		= "rs64",
@@ -150,7 +139,6 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
-		.cpu_setup		= __setup_cpu_power3,
 		.oprofile_cpu_type	= "ppc64/rs64",
 		.oprofile_type		= PPC_OPROFILE_RS64,
 		.platform		= "rs64",
@@ -164,7 +152,6 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
-		.cpu_setup		= __setup_cpu_power4,
 		.oprofile_cpu_type	= "ppc64/power4",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.platform		= "power4",
@@ -178,7 +165,6 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
-		.cpu_setup		= __setup_cpu_power4,
 		.oprofile_cpu_type	= "ppc64/power4",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.platform		= "power4",
@@ -244,7 +230,6 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
-		.cpu_setup		= __setup_cpu_power4,
 		.oprofile_cpu_type	= "ppc64/power5",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.platform		= "power5",
@@ -258,7 +243,6 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
-		.cpu_setup		= __setup_cpu_power4,
 		.oprofile_cpu_type	= "ppc64/power5+",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.platform		= "power5+",
@@ -273,7 +257,6 @@
 			PPC_FEATURE_SMT,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
-		.cpu_setup		= __setup_cpu_be,
 		.platform		= "ppc-cell-be",
 	},
 	{	/* default match */
@@ -285,7 +268,6 @@
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
-		.cpu_setup		= __setup_cpu_power4,
 		.platform		= "power4",
 	}
 #endif	/* CONFIG_PPC64 */
Index: cell--alp--3/arch/powerpc/kernel/misc_32.S
===================================================================
--- cell--alp--3.orig/arch/powerpc/kernel/misc_32.S	2006-04-26 19:19:25.000000000 -0700
+++ cell--alp--3/arch/powerpc/kernel/misc_32.S	2006-05-08 18:57:44.000000000 -0700
@@ -216,7 +216,7 @@
 	lwz	r4,0(r4)
 	add	r4,r4,r3
 	lwz	r5,CPU_SPEC_SETUP(r4)
-	cmpi	0,r5,0
+	cmpwi	0,r5,0
 	add	r5,r5,r3
 	beqlr
 	mtctr	r5
Index: cell--alp--3/arch/powerpc/kernel/misc_64.S
===================================================================
--- cell--alp--3.orig/arch/powerpc/kernel/misc_64.S	2006-04-26 19:19:25.000000000 -0700
+++ cell--alp--3/arch/powerpc/kernel/misc_64.S	2006-05-08 19:00:13.000000000 -0700
@@ -482,7 +482,9 @@
 	sub	r0,r3,r5
 	std	r0,0(r4)
 	ld	r4,CPU_SPEC_SETUP(r3)
+	cmpdi	0,r4,0
 	add	r4,r4,r5
+	beqlr
 	ld	r4,0(r4)
 	add	r4,r4,r5
 	mtctr	r4
@@ -768,9 +770,6 @@

 #endif /* CONFIG_ALTIVEC */

-_GLOBAL(__setup_cpu_power3)
-	blr
-
 _GLOBAL(execve)
 	li	r0,__NR_execve
 	sc
