Return-Path: <firoz.khan@linaro.org>
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BTLr6hj8zF33M
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 18:33:40 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id d19-v6so4066715pgv.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 01:33:40 -0700 (PDT)
From: Firoz Khan <firoz.khan@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Ram Pai <linuxram@us.ibm.com>, Breno Leitao <leitao@debian.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, deepa.kernel@gmail.com,
 marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 1/3] powerpc: Replace NR_syscalls macro from asm/unistd.h
Date: Fri, 14 Sep 2018 14:02:58 +0530
Message-Id: <1536913980-4811-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1536913980-4811-1-git-send-email-firoz.khan@linaro.org>
References: <1536913980-4811-1-git-send-email-firoz.khan@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

__NR_syscalls macro holds the number of system call exist in POWERPC
architecture. This macro is currently the part of asm/unistd.h file.
We have to change the value of __NR_syscalls, if we add or delete a
system call.

One of the patch in this patch series has a script which will generate
a uapi header based on syscall.tbl file. The syscall.tbl file contains
the number of system call information. So we have two option to update
__NR_syscalls value.

1. Update __NR_syscalls in asm/unistd.h manually by counting the
   no.of system calls. No need to update __NR_syscalls untill
   we either add a new system call or delete an existing system
   call.

2. We can keep this feature it above mentioned script, that'll
   count the number of syscalls and keep it in a generated file.
   In this case we don't need to explicitly update __NR_syscalls
   in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I moved the
NR_syscalls macro from asm/unistd.h to uapi/asm/unistd.h. The macro
name also changed form NR_syscalls to __NR_syscalls for making the
name convention same across all architecture. While __NR_syscalls
isn't strictly part of the uapi, having it as part of the generated
header to simplifies the implementation.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/powerpc/include/asm/unistd.h      | 3 +--
 arch/powerpc/include/uapi/asm/unistd.h | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index c19379f..54732f9 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -11,8 +11,7 @@
 
 #include <uapi/asm/unistd.h>
 
-
-#define NR_syscalls		389
+#define NR_syscalls  __NR_syscalls
 
 #define __NR__exit __NR_exit
 
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index 985534d..f999df2 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -401,4 +401,6 @@
 #define __NR_rseq		387
 #define __NR_io_pgetevents	388
 
+#define __NR_syscalls           389
+
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
1.9.1
