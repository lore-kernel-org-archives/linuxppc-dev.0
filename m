Return-Path: <azanella@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp04.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 995E42C0155
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 05:30:11 +1000 (EST)
Received: from /spool/local
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <azanella@linux.vnet.ibm.com>;
 Mon, 22 Apr 2013 16:30:04 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id E25401DC0060
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 15:30:00 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3MJRKRD2785484
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 16:27:20 -0300
Received: from d24av04.br.ibm.com (loopback [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3MHTjNE026031
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 14:29:45 -0300
Message-ID: <51758F9D.4010108@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2013 16:29:33 -0300
From: Adhemerval Zanella <azanella@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] [RFC] powerpc: Add VDSO version of time
References: <5148C2B3.6010408@linux.vnet.ibm.com>
 <20130419083835.37f1c180@kryten>
In-Reply-To: <20130419083835.37f1c180@kryten>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/18/2013 07:38 PM, Anton Blanchard wrote:
> Since you are only reading one long you shouldn't need to check the
> update count and loop, you will always see a consistent value. The
> system call version of time() just does an unprotected load for example.

Fixed.

> With the above change and with Michael's comments covered (decent
> changelog entry and Signed-off-by):
>
> Acked-by: Anton Blanchard <anton@samba.org>

Thanks for the review, below the updated patch:


From: Adhemerval Zanella <azanella@linux.vnet.ibm.com>

This patch implement the time syscall as vDSO. The performance speedups
are:

Baseline PPC32: 380 nsec
Baseline PPC64: 350 nsec
vdso PPC32:      20 nsec
vsdo PPC64:      20 nsec

Tested on 64 bit build with both 32 bit and 64 bit userland.

Acked-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Adhemerval Zanella <azanella@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/vdso.c                |    4 ++++
 arch/powerpc/kernel/vdso32/gettimeofday.S |   26 ++++++++++++++++++++++++++
 arch/powerpc/kernel/vdso32/vdso32.lds.S   |    1 +
 arch/powerpc/kernel/vdso64/gettimeofday.S |   26 ++++++++++++++++++++++++++
 arch/powerpc/kernel/vdso64/vdso64.lds.S   |    1 +
 5 files changed, 58 insertions(+), 0 deletions(-)

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
index 4ee09ee..27e2f62 100644
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -181,6 +181,32 @@ V_FUNCTION_END(__kernel_clock_getres)
 
 
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
+	lwz	r3,STAMP_XTIME+TSPEC_TV_SEC(r9)
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
index e97a9a0..a76b4af 100644
--- a/arch/powerpc/kernel/vdso64/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
@@ -164,6 +164,32 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
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
+	ld	r4,STAMP_XTIME+TSPC64_TV_SEC(r3)
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
