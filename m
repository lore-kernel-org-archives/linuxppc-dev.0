Return-Path: <me@tobin.cc>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSfkV3J1KzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 12:22:58 +1100 (AEDT)
Date: Wed, 22 Feb 2017 12:22:52 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: PowerPC build fail
Message-ID: <20170222012252.GD6131@eros>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current (2bfe01e) torvalds git tree fails to build on powerpc64. Build machine
is virtualized.

- Build error
arch/powerpc/kernel/time.c: In function ‘running_clock’:
arch/powerpc/kernel/time.c:712:25: error: implicit declaration of function ‘cputime_to_nsecs’
   return local_clock() - cputime_to_nsecs(kcpustat_this_cpu->cpustat[CPUTIME_STEAL]);
                          ^
                          
$ cat .config | grep CONFIG_VIRT_CPU
# CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is not set
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set

$ cat .config | grep CONFIG_PPC_PSERIES
CONFIG_PPC_PSERIES=y

Looking into it I found there are compile time guards on CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
preventing cputime_to_nsecs being defined.

Removing the compile time guard allows the build to proceed, surely
this is not the correct solution though.

diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/asm/cputime.h
index 99b5418..15482cb 100644
--- a/arch/powerpc/include/asm/cputime.h
+++ b/arch/powerpc/include/asm/cputime.h
@@ -16,7 +16,7 @@
 #ifndef __POWERPC_CPUTIME_H
 #define __POWERPC_CPUTIME_H

-#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
+

 #include <linux/types.h>
 #include <linux/time.h>
@@ -53,5 +53,5 @@ void arch_vtime_task_switch(struct task_struct *tsk);
 #endif

 #endif /* __KERNEL__ */
-#endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
 #endif /* __POWERPC_CPUTIME_H */
diff --git a/include/linux/cputime.h b/include/linux/cputime.h
index a691dc4..f730c14 100644
--- a/include/linux/cputime.h
+++ b/include/linux/cputime.h
@@ -1,13 +1,13 @@
 #ifndef __LINUX_CPUTIME_H
 #define __LINUX_CPUTIME_H

-#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
+
 #include <asm/cputime.h>

 #ifndef cputime_to_nsecs
-# define cputime_to_nsecs(__ct)        \
+#define cputime_to_nsecs(__ct) \
        (cputime_to_usecs(__ct) * NSEC_PER_USEC)
 #endif

-#endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
+
 #endif /* __LINUX_CPUTIME_H */


If you think this can be fixed with the *little* kernel dev knowledge
I have please point me at a starting place and I will dig into it.

thanks,
Tobin.
