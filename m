Return-Path: <azanella@linux.vnet.ibm.com>
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp02.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D05422C0101
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 06:55:42 +1100 (EST)
Received: from /spool/local
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <azanella@linux.vnet.ibm.com>;
 Tue, 19 Mar 2013 16:55:36 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id C81523520060
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 15:55:32 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2JJrMKl2404404
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 16:53:22 -0300
Received: from d24av01.br.ibm.com (loopback [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2JJtWrX022167
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 16:55:32 -0300
Received: from [9.18.239.243] (carranca.br.ibm.com [9.18.239.243])
 by d24av01.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 r2JJtWv4022164
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 16:55:32 -0300
Message-ID: <5148C2B3.6010408@linux.vnet.ibm.com>
Date: Tue, 19 Mar 2013 16:55:31 -0300
From: Adhemerval Zanella <azanella@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] [RFC] powerpc: Add VDSO version of time
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

This patch implement the time syscall as vDSO. I have a glibc patch
to use it as IFUNC (as latest gettimeofday patch). Below the perf
numbers:

Baseline PPC32: 380 nsec
Baseline PPC64: 352 nsec
vdso PPC32:      20 nsec
vdso PPC64:      20 nsec

I focused on 64 bit kernel, do I need to provide a scheme for 32 bits
as well?

Any tips, advices, comments?


--

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 1b2076f..d4f463a 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -113,6 +113,10 @@ static struct vdso_patch_def vdso_patches[] = {
 		CPU_FTR_USE_TB, 0,
 		"__kernel_get_tbfreq", NULL
 	},
+	{
+		CPU_FTR_USE_TB, 0,
+		"__kernel_time", NULL
+	},
 };
 
 /*
diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
index 4ee09ee..9a60a87 100644
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -181,6 +181,35 @@ V_FUNCTION_END(__kernel_clock_getres)
 
 
 /*
+ * Exact prototype of time()
+ *
+ * time_t time(time *t);
+ *
+ */
+V_FUNCTION_BEGIN(__kernel_time)
+  .cfi_startproc
+	mflr	r12
+  .cfi_register lr,r12
+
+	mr	r11,r3			/* r11 holds t */
+	bl	__get_datapage@local
+	mr	r9, r3			/* datapage ptr in r9 */
+
+1:	lwz	r8,(CFG_TB_UPDATE_COUNT+LOPART)(r9)
+	lwz	r3,STAMP_XTIME+TSPEC_TV_SEC(r9)
+	andi.	r0,r8,1			/* pending update ? loop */
+	bne-	1b
+
+	cmplwi	r11,0			/* check if t is NULL */
+	beq	2f
+	stw	r3,0(r11)		/* store result at *t */
+2:	mtlr	r12
+	crclr	cr0*4+so
+	blr
+  .cfi_endproc
+V_FUNCTION_END(__kernel_time)
+
+/*
  * This is the core of clock_gettime() and gettimeofday(),
  * it returns the current time in r3 (seconds) and r4.
  * On entry, r7 gives the resolution of r4, either USEC_PER_SEC
diff --git a/arch/powerpc/kernel/vdso32/vdso32.lds.S b/arch/powerpc/kernel/vdso32/vdso32.lds.S
index 43200ba..f223409 100644
--- a/arch/powerpc/kernel/vdso32/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso32/vdso32.lds.S
@@ -150,6 +150,7 @@ VERSION
 #ifdef CONFIG_PPC64
 		__kernel_getcpu;
 #endif
+		__kernel_time;
 
 	local: *;
 	};
diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
index e97a9a0..f05aa68 100644
--- a/arch/powerpc/kernel/vdso64/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
@@ -164,6 +164,35 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
   .cfi_endproc
 V_FUNCTION_END(__kernel_clock_getres)
 
+/*
+ * Exact prototype of time()
+ *
+ * time_t time(time *t);
+ *
+ */
+V_FUNCTION_BEGIN(__kernel_time)
+  .cfi_startproc
+	mflr	r12
+  .cfi_register lr,r12
+
+	mr	r11,r3			/* r11 holds t */
+	bl	V_LOCAL_FUNC(__get_datapage)
+
+1:	ld	r8,CFG_TB_UPDATE_COUNT(r3)
+	ld	r4,STAMP_XTIME+TSPC64_TV_SEC(r3)
+	andi.	r0,r8,1			/* pending update ? loop */
+	bne-	1b
+
+	cmpldi	r11,0			/* check if t is NULL */
+	beq	2f
+	std	r4,0(r11)		/* store result at *t */
+2:	mtlr	r12
+	crclr	cr0*4+so
+	mr	r3,r4
+	blr
+  .cfi_endproc
+V_FUNCTION_END(__kernel_time)
+
 
 /*
  * This is the core of clock_gettime() and gettimeofday(),
diff --git a/arch/powerpc/kernel/vdso64/vdso64.lds.S b/arch/powerpc/kernel/vdso64/vdso64.lds.S
index e6c1758..e486381 100644
--- a/arch/powerpc/kernel/vdso64/vdso64.lds.S
+++ b/arch/powerpc/kernel/vdso64/vdso64.lds.S
@@ -147,6 +147,7 @@ VERSION
 		__kernel_sync_dicache_p5;
 		__kernel_sigtramp_rt64;
 		__kernel_getcpu;
+		__kernel_time;
 
 	local: *;
 	};
