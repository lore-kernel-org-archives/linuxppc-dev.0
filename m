Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 55F711A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 16:05:02 +1000 (AEST)
Message-ID: <1442988302.31273.81.camel@neuling.org>
Subject: [PATCH] powerpc/vdso: Avoid link stack corruption in __get_datapage()
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <michael@ellerman.id.au>, benh <benh@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Anton Blanchard
 <anton@samba.org>, Aaron Sawdey <sawdey@us.ibm.com>, Steve Munroe
 <sjmunroe@us.ibm.com>
Date: Wed, 23 Sep 2015 16:05:02 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The 32 and 64 bit variants of __get_datapage() use a "bcl; mflr" to
determine the loaded address of the VDSO. The current version of these
attempt to use the special bcl variant which avoids pushing to the
link stack.

Unfortunately it uses bcl+8 rather than the required bcl+4. Hence the
current code results in link stack corruption and the resulting
performance degradation (due to branch mis-prediction).

This patch moves us to bcl+4 by moving __kernel_datapage_offset
out of __get_datapage().

With this patch, running the below benchmark we get a bump in
performance on POWER8 for gettimeofday() (which uses
__get_datapage()).

64bit gets ~4% improvement:
  Without patch:
    # ./tb
    time =3D 0.180321
  With patch:
    # ./tb
    time =3D 0.187408

32bit gets ~9% improvement:
  Without patch:
    # ./tb
    time =3D 0.276551
  With patch:
    # ./tb
    time =3D 0.252767

Testcase tb.c (stolen from Anton)
  /* gcc -O2 tb.c -o tb */
  #include <sys/time.h>
  #include <stdio.h>

  int main()
  {
	  int i;

	  struct timeval tv_start, tv_end;

	  gettimeofday(&tv_start, NULL);

	  for(i =3D 0; i < 10000000; i++) {
		  gettimeofday(&tv_end, NULL);
	  }

	  printf("time =3D %.6f\n", tv_end.tv_sec - tv_start.tv_sec + (tv_end.tv_u=
sec - tv_start.tv_usec) * 1e-6);

	  return 0;
  }

Signed-off-by: Michael Neuling <mikey@neuling.org>
Reported-by: Aaron Sawdey <sawdey@us.ibm.com>

diff --git a/arch/powerpc/kernel/vdso32/datapage.S b/arch/powerpc/kernel/vd=
so32/datapage.S
index dc21e89..59cf5f4 100644
--- a/arch/powerpc/kernel/vdso32/datapage.S
+++ b/arch/powerpc/kernel/vdso32/datapage.S
@@ -16,6 +16,10 @@
 #include <asm/vdso.h>
=20
 	.text
+	.global	__kernel_datapage_offset;
+__kernel_datapage_offset:
+	.long	0
+
 V_FUNCTION_BEGIN(__get_datapage)
   .cfi_startproc
 	/* We don't want that exposed or overridable as we want other objects
@@ -27,13 +31,11 @@ V_FUNCTION_BEGIN(__get_datapage)
 	mflr	r0
   .cfi_register lr,r0
=20
-	bcl	20,31,1f
-	.global	__kernel_datapage_offset;
-__kernel_datapage_offset:
-	.long	0
-1:
+	bcl	20,31,data_page_branch
+data_page_branch:
 	mflr	r3
 	mtlr	r0
+	addi	r3, r3, __kernel_datapage_offset-data_page_branch
 	lwz	r0,0(r3)
 	add	r3,r0,r3
 	blr
diff --git a/arch/powerpc/kernel/vdso64/datapage.S b/arch/powerpc/kernel/vd=
so64/datapage.S
index 79796de..2f01c4a 100644
--- a/arch/powerpc/kernel/vdso64/datapage.S
+++ b/arch/powerpc/kernel/vdso64/datapage.S
@@ -16,6 +16,10 @@
 #include <asm/vdso.h>
=20
 	.text
+.global	__kernel_datapage_offset;
+__kernel_datapage_offset:
+	.long	0
+
 V_FUNCTION_BEGIN(__get_datapage)
   .cfi_startproc
 	/* We don't want that exposed or overridable as we want other objects
@@ -27,13 +31,11 @@ V_FUNCTION_BEGIN(__get_datapage)
 	mflr	r0
   .cfi_register lr,r0
=20
-	bcl	20,31,1f
-	.global	__kernel_datapage_offset;
-__kernel_datapage_offset:
-	.long	0
-1:
+	bcl	20,31,data_page_branch
+data_page_branch:
 	mflr	r3
 	mtlr	r0
+	addi	r3, r3, __kernel_datapage_offset-data_page_branch
 	lwz	r0,0(r3)
 	add	r3,r0,r3
 	blr
