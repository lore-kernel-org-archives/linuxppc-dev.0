Return-Path: <rsalvaterra@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qq4212JXyzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 22:24:09 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id vv3so1633499pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 05:24:09 -0700 (PDT)
From: Rui Salvaterra <rsalvaterra@gmail.com>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [PATCH] powerpc: wire up preadv2 and pwritev2 syscalls
Date: Tue, 19 Apr 2016 13:23:36 +0100
Message-Id: <1461068616-16646-1-git-send-email-rsalvaterra@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wire up preadv2/pwritev2 in the same way as preadv/pwritev. Fixes two
build warnings on ppc64.

Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
---
 arch/powerpc/include/asm/systbl.h      | 2 ++
 arch/powerpc/include/asm/unistd.h      | 2 +-
 arch/powerpc/include/uapi/asm/unistd.h | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 3fa9df7..2fc5d4d 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -384,3 +384,5 @@ SYSCALL(ni_syscall)
 SYSCALL(ni_syscall)
 SYSCALL(mlock2)
 SYSCALL(copy_file_range)
+COMPAT_SYS_SPU(preadv2)
+COMPAT_SYS_SPU(pwritev2)
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index 1f2594d..cf12c58 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -12,7 +12,7 @@
 #include <uapi/asm/unistd.h>
 
 
-#define NR_syscalls		380
+#define NR_syscalls		382
 
 #define __NR__exit __NR_exit
 
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index 940290d..e9f5f41 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -390,5 +390,7 @@
 #define __NR_membarrier		365
 #define __NR_mlock2		378
 #define __NR_copy_file_range	379
+#define __NR_preadv2		380
+#define __NR_pwritev2		381
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
2.7.4
