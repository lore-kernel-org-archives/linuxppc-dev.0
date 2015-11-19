Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 11C5F1A0947
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 17:05:32 +1100 (AEDT)
Received: by padhx2 with SMTP id hx2so70097116pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 22:05:29 -0800 (PST)
Received: from circle.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id qk7sm7762555pbb.80.2015.11.18.22.05.27
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 18 Nov 2015 22:05:29 -0800 (PST)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Standardise on NR_syscalls rather than __NR_syscalls.
Date: Thu, 19 Nov 2015 17:04:53 +1100
Message-Id: <1447913093-28342-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Most architectures use NR_syscalls as the #define for the number of syscalls.

We use __NR_syscalls, and then define NR_syscalls as __NR_syscalls.

__NR_syscalls is not used outside arch code, whereas NR_syscalls is. So as
NR_syscalls must be defined and __NR_syscalls does not, replace __NR_syscalls
with NR_syscalls.

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---
 arch/powerpc/include/asm/unistd.h        | 3 +--
 arch/powerpc/include/asm/vdso_datapage.h | 2 +-
 arch/powerpc/kernel/systbl_chk.c         | 2 +-
 arch/powerpc/kernel/systbl_chk.sh        | 2 +-
 arch/powerpc/kernel/vdso.c               | 2 +-
 arch/powerpc/kernel/vdso32/datapage.S    | 2 +-
 arch/powerpc/kernel/vdso64/datapage.S    | 2 +-
 arch/powerpc/platforms/cell/spufs/run.c  | 2 +-
 8 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index 6d8f8023ac27..05bf34296144 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -12,10 +12,9 @@
 #include <uapi/asm/unistd.h>
 
 
-#define __NR_syscalls		378
+#define NR_syscalls		378
 
 #define __NR__exit __NR_exit
-#define NR_syscalls	__NR_syscalls
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/asm/vdso_datapage.h
index b73a8199f161..1afe90ade595 100644
--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -41,7 +41,7 @@
 #include <linux/unistd.h>
 #include <linux/time.h>
 
-#define SYSCALL_MAP_SIZE      ((__NR_syscalls + 31) / 32)
+#define SYSCALL_MAP_SIZE      ((NR_syscalls + 31) / 32)
 
 /*
  * So here is the ppc64 backward compatible version
diff --git a/arch/powerpc/kernel/systbl_chk.c b/arch/powerpc/kernel/systbl_chk.c
index 2384129f5893..55323a620cfe 100644
--- a/arch/powerpc/kernel/systbl_chk.c
+++ b/arch/powerpc/kernel/systbl_chk.c
@@ -57,4 +57,4 @@
 
 START_TABLE
 #include <asm/systbl.h>
-END_TABLE __NR_syscalls
+END_TABLE NR_syscalls
diff --git a/arch/powerpc/kernel/systbl_chk.sh b/arch/powerpc/kernel/systbl_chk.sh
index 19415e7674a5..31b6e7c358ca 100644
--- a/arch/powerpc/kernel/systbl_chk.sh
+++ b/arch/powerpc/kernel/systbl_chk.sh
@@ -16,7 +16,7 @@ awk	'BEGIN { num = -1; }	# Ignore the beginning of the file
 	/^START_TABLE/ { num = 0; next; }
 	/^END_TABLE/ {
 		if (num != $2) {
-			printf "__NR_syscalls (%s) is not one more than the last syscall (%s)\n",
+			printf "NR_syscalls (%s) is not one more than the last syscall (%s)\n",
 				$2, num - 1;
 			exit(1);
 		}
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index b457bfa28436..def1b8b5e6c1 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -671,7 +671,7 @@ static void __init vdso_setup_syscall_map(void)
 	extern unsigned long sys_ni_syscall;
 
 
-	for (i = 0; i < __NR_syscalls; i++) {
+	for (i = 0; i < NR_syscalls; i++) {
 #ifdef CONFIG_PPC64
 		if (sys_call_table[i*2] != sys_ni_syscall)
 			vdso_data->syscall_map_64[i >> 5] |=
diff --git a/arch/powerpc/kernel/vdso32/datapage.S b/arch/powerpc/kernel/vdso32/datapage.S
index 59cf5f452879..3745113fcc65 100644
--- a/arch/powerpc/kernel/vdso32/datapage.S
+++ b/arch/powerpc/kernel/vdso32/datapage.S
@@ -61,7 +61,7 @@ V_FUNCTION_BEGIN(__kernel_get_syscall_map)
 	addi	r3,r3,CFG_SYSCALL_MAP32
 	cmpli	cr0,r4,0
 	beqlr
-	li	r0,__NR_syscalls
+	li	r0,NR_syscalls
 	stw	r0,0(r4)
 	crclr	cr0*4+so
 	blr
diff --git a/arch/powerpc/kernel/vdso64/datapage.S b/arch/powerpc/kernel/vdso64/datapage.S
index 2f01c4a0d8a0..184a6ba7f283 100644
--- a/arch/powerpc/kernel/vdso64/datapage.S
+++ b/arch/powerpc/kernel/vdso64/datapage.S
@@ -62,7 +62,7 @@ V_FUNCTION_BEGIN(__kernel_get_syscall_map)
 	cmpli	cr0,r4,0
 	crclr	cr0*4+so
 	beqlr
-	li	r0,__NR_syscalls
+	li	r0,NR_syscalls
 	stw	r0,0(r4)
 	blr
   .cfi_endproc
diff --git a/arch/powerpc/platforms/cell/spufs/run.c b/arch/powerpc/platforms/cell/spufs/run.c
index 4ddf769a64e5..9f79004e6d6f 100644
--- a/arch/powerpc/platforms/cell/spufs/run.c
+++ b/arch/powerpc/platforms/cell/spufs/run.c
@@ -326,7 +326,7 @@ static int spu_process_callback(struct spu_context *ctx)
 	spu_ret = -ENOSYS;
 	npc += 4;
 
-	if (s.nr_ret < __NR_syscalls) {
+	if (s.nr_ret < NR_syscalls) {
 		spu_release(ctx);
 		/* do actual system call from here */
 		spu_ret = spu_sys_callback(&s);
-- 
2.5.0
