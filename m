Return-Path: <chzigotzky@bayern-mail.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqp962C5JzDqxj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 18:03:05 +1000 (AEST)
To: linuxppc-dev@lists.ozlabs.org
From: Christian Zigotzky <chzigotzky@bayern-mail.de>
Subject: Kernel 4.1.28: Update TM user feature bits in scan_features()
Cc: "R.T.Dickinson" <rtd@a-eon.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Darren Stevens <darren@stevens-zone.net>, Alex Perez <aperez@alexperez.com>,
 Julian Margetson <runaway@candw.ms>, luigi burdo <intermediadc@hotmail.com>,
 "contact@a-eon.com" <contact@a-eon.com>, Matthew Leaman <matthew@a-eon.biz>,
 Pat Wall <pjwall@mac.com>, Pat Wall <pjwall@me.com>
Message-ID: <01f37269-7f95-225a-b09e-2f1995a394a3@bayern-mail.de>
Date: Thu, 14 Jul 2016 09:55:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

I tried to compile the kernel 4.1.28 today. Unfortunately it doesn't 
compile because of an undeclared variable PPC_FEATURE2_HTM_NOSC_COMP.

Error message:

   CHK     include/config/kernel.release
   CHK     include/generated/uapi/linux/version.h
   CHK     include/generated/utsrelease.h
   CHK     include/generated/bounds.h
   CHK     include/generated/asm-offsets.h
   CALL    scripts/checksyscalls.sh
   CHK     include/generated/compile.h
   CALL    arch/powerpc/kernel/systbl_chk.sh
   CC      arch/powerpc/kernel/prom.o
arch/powerpc/kernel/prom.c:170:25: error: 'PPC_FEATURE2_HTM_NOSC_COMP' 
undeclared here (not in a function)
    PPC_FEATURE2_HTM_COMP|PPC_FEATURE2_HTM_NOSC_COMP, 22, 0, 0},
                          ^
make[1]: *** [arch/powerpc/kernel/prom.o] Error 1
make: *** [arch/powerpc/kernel] Error 2

---

Commit:

f49eb503f0f9ab66874a81992b14249a1c59b6ad
Author: Anton Blanchard <anton@samba.org>
Date:   Fri Apr 15 12:08:19 2016 +1000

     powerpc: Update TM user feature bits in scan_features()

     [ Upstream commit 4705e02498d6d5a7ab98dfee9595cd5e91db2017 ]

     We need to update the user TM feature bits (PPC_FEATURE2_HTM and
     PPC_FEATURE2_HTM) to mirror what we do with the kernel TM feature
     bit.

     At the moment, if firmware reports TM is not available we turn off
     the kernel TM feature bit but leave the userspace ones on. Userspace
     thinks it can execute TM instructions and it dies trying.

     This (together with a QEMU patch) fixes PR KVM, which doesn't currently
     support TM.

     Signed-off-by: Anton Blanchard <anton@samba.org>
     Cc: stable@vger.kernel.org
     Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
     Signed-off-by: Sasha Levin <sasha.levin@oracle.com>

---

PPC_FEATURE2_HTM_NOSC_COMP isn't defined or doesn't exist in the 
following files:

arch/powerpc/include/asm/cputable.h
arch/powerpc/kernel/cputable.c
arch/powerpc/include/uapi/asm/tm.h

That means the following patches aren't included in the 4.1.28 source code:

diff --git a/arch/powerpc/include/asm/cputable.h 
b/arch/powerpc/include/asm/cputable.h
index 22d5a7d..4ec19da 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -236,11 +236,13 @@ extern const char *powerpc_base_platform;

  /* We only set the TM feature if the kernel was compiled with TM supprt */
  #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-#define CPU_FTR_TM_COMP        CPU_FTR_TM
-#define PPC_FEATURE2_HTM_COMP    PPC_FEATURE2_HTM
+#define CPU_FTR_TM_COMP            CPU_FTR_TM
+#define PPC_FEATURE2_HTM_COMP        PPC_FEATURE2_HTM
+#define PPC_FEATURE2_HTM_NOSC_COMP    PPC_FEATURE2_HTM_NOSC
  #else
-#define CPU_FTR_TM_COMP        0
-#define PPC_FEATURE2_HTM_COMP    0
+#define CPU_FTR_TM_COMP            0
+#define PPC_FEATURE2_HTM_COMP        0
+#define PPC_FEATURE2_HTM_NOSC_COMP    0
  #endif

  /* We need to mark all pages as being coherent if we're SMP or we have a
diff --git a/arch/powerpc/include/uapi/asm/cputable.h 
b/arch/powerpc/include/uapi/asm/cputable.h
index 67de80a..2734c00 100644
--- a/arch/powerpc/include/uapi/asm/cputable.h
+++ b/arch/powerpc/include/uapi/asm/cputable.h
@@ -43,5 +43,6 @@
  #define PPC_FEATURE2_ISEL        0x08000000
  #define PPC_FEATURE2_TAR        0x04000000
  #define PPC_FEATURE2_VEC_CRYPTO        0x02000000
+#define PPC_FEATURE2_HTM_NOSC        0x01000000

  #endif /* _UAPI__ASM_POWERPC_CPUTABLE_H */
diff --git a/arch/powerpc/include/uapi/asm/tm.h 
b/arch/powerpc/include/uapi/asm/tm.h
index 5d836b7..5047659 100644
--- a/arch/powerpc/include/uapi/asm/tm.h
+++ b/arch/powerpc/include/uapi/asm/tm.h
@@ -11,7 +11,7 @@
  #define TM_CAUSE_RESCHED    0xde
  #define TM_CAUSE_TLBI        0xdc
  #define TM_CAUSE_FAC_UNAV    0xda
-#define TM_CAUSE_SYSCALL    0xd8  /* future use */
+#define TM_CAUSE_SYSCALL    0xd8
  #define TM_CAUSE_MISC        0xd6  /* future use */
  #define TM_CAUSE_SIGNAL        0xd4
  #define TM_CAUSE_ALIGNMENT    0xd2
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index c18a2ea..bf3eb39 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -108,7 +108,9 @@ extern void __restore_cpu_e6500(void);
                   PPC_FEATURE_TRUE_LE | \
                   PPC_FEATURE_PSERIES_PERFMON_COMPAT)
  #define COMMON_USER2_POWER8    (PPC_FEATURE2_ARCH_2_07 | \
-                 PPC_FEATURE2_HTM_COMP | PPC_FEATURE2_DSCR | \
+                 PPC_FEATURE2_HTM_COMP | \
+                 PPC_FEATURE2_HTM_NOSC_COMP | \
+                 PPC_FEATURE2_DSCR | \
                   PPC_FEATURE2_ISEL | PPC_FEATURE2_TAR | \
                   PPC_FEATURE2_VEC_CRYPTO)
  #define COMMON_USER_PA6T    (COMMON_USER_PPC64 | PPC_FEATURE_PA6T |\

-- 

Temporary solution:

Not suitable for 4.1-stable (no PPC_FEATURE2_HTM_NOSC_COMP).

-     * If the kernel doesn't support TM (ie 
CONFIG_PPC_TRANSACTIONAL_MEM=n),
-     * we don't want to turn on TM here, so we use the *_COMP versions
-     * which are 0 if the kernel doesn't support TM.
+     * If the kernel doesn't support TM (ie. 
CONFIG_PPC_TRANSACTIONAL_MEM=n),
+     * we don't want to turn on CPU_FTR_TM here, so we use CPU_FTR_TM_COMP
+     * which is 0 if the kernel doesn't support TM.
       */
-    {CPU_FTR_TM_COMP, 0, 0,
-     PPC_FEATURE2_HTM_COMP|PPC_FEATURE2_HTM_NOSC_COMP, 22, 0, 0},
+    {CPU_FTR_TM_COMP, 0, 0, 0,        22, 0, 0},
  };

Cheers,

Christian
