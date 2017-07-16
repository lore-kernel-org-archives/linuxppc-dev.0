Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x9CN853m3zDqmP
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jul 2017 13:59:04 +1000 (AEST)
Received: by mail-qt0-x243.google.com with SMTP id j25so998756qtf.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jul 2017 20:59:04 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com,
 linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org,
 corbet@lwn.net, mingo@redhat.com, mhocko@kernel.org
Subject: [RFC v6 25/62] powerpc: sys_pkey_mprotect() system call
Date: Sat, 15 Jul 2017 20:56:27 -0700
Message-Id: <1500177424-13695-26-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch provides the ability for a process to
associate a pkey with a address range.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/systbl.h      |    1 +
 arch/powerpc/include/asm/unistd.h      |    4 +---
 arch/powerpc/include/uapi/asm/unistd.h |    1 +
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 22dd776..b33b551 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -390,3 +390,4 @@
 SYSCALL(statx)
 SYSCALL(pkey_alloc)
 SYSCALL(pkey_free)
+SYSCALL(pkey_mprotect)
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index e0273bc..daf1ba9 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -12,12 +12,10 @@
 #include <uapi/asm/unistd.h>
 
 
-#define NR_syscalls		386
+#define NR_syscalls		387
 
 #define __NR__exit __NR_exit
 
-#define __IGNORE_pkey_mprotect
-
 #ifndef __ASSEMBLY__
 
 #include <linux/types.h>
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index 7993a07..71ae45e 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -396,5 +396,6 @@
 #define __NR_statx		383
 #define __NR_pkey_alloc		384
 #define __NR_pkey_free		385
+#define __NR_pkey_mprotect	386
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
1.7.1
