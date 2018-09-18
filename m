Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FZPG5jKhzF3HZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 19:31:30 +1000 (AEST)
To: linuxppc-dev@lists.ozlabs.org, linux-kbuild@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>,
 Segher Boessenkool <segher@kernel.crashing.org>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: How to define some additional KBUILD_CFLAGS after building
 include/generated/asm-offsets.h ?
Message-ID: <e1b65467-7497-5db4-aa93-1ad00d12af3f@c-s.fr>
Date: Tue, 18 Sep 2018 23:41:33 +0000
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

I'm trying to implement TLS based stack protector in the Linux Kernel.
For that I need to give to GCC the offset at which it will find the 
canary (register r2 is pointing to the current task struct).

I have been able to do it with the below patch, but it only works when 
include/generated/asm-offsets.h already exists from the start of the build.

Is there a way to evaluate CANARY_OFFSET and add the stack-protector 
flags to KBUILD_FLAGS only after include/generated/asm-offsets.h is built ?

Or another way of add -mstack-protector-guard-offset=offsetof(struct 
task_struct, stack_canary) ?

diff --git a/arch/powerpc/kernel/asm-offsets.c 
b/arch/powerpc/kernel/asm-offsets.c
index 89cf15566c4e..b25483946921 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -89,6 +89,9 @@ int main(void)
         DEFINE(THREAD_INFO_GAP, _ALIGN_UP(sizeof(struct thread_info), 16));
         OFFSET(KSP_LIMIT, thread_struct, ksp_limit);
  #endif /* CONFIG_PPC64 */
+#ifdef CONFIG_STACKPROTECTOR
+       DEFINE(TSK_STACK_CANARY, offsetof(struct task_struct, 
stack_canary));
+#endif

  #ifdef CONFIG_LIVEPATCH
         OFFSET(TI_livepatch_sp, thread_info, livepatch_sp);
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index e58c3f467db5..051b907b5c02 100644
[root@pc16082vm linux-powerpc]# git diff
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 748e34e81a03..7b5a23a8afe8 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -113,7 +113,8 @@ KBUILD_ARFLAGS      += --target=elf$(BITS)-$(GNUTARGET)
  endif

  ifdef CONFIG_STACKPROTECTOR
-KBUILD_CFLAGS  += -mstack-protector-guard=global
+CANARY_OFFSET := $(shell awk '{if ($$2 == "TSK_STACK_CANARY") print 
$$3;}' include/generated/asm-offsets.h)
+KBUILD_CFLAGS  += -mstack-protector-guard=tls 
-mstack-protector-guard-reg=r2 
-mstack-protector-guard-offset=$(CANARY_OFFSET)
  endif

  LDFLAGS_vmlinux-y := -Bstatic


Thanks
Christophe
