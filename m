Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zN3kG0nTMzF0wr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 12:52:54 +1100 (AEDT)
Received: by mail-qt0-x241.google.com with SMTP id o35so414906qtj.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 17:52:54 -0800 (PST)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
 corbet@lwn.net, arnd@arndb.de
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com
Subject: [PATCH v10 24/27] powerpc: sys_pkey_alloc() and sys_pkey_free()
 system calls
Date: Thu, 18 Jan 2018 17:50:45 -0800
Message-Id: <1516326648-22775-25-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1516326648-22775-1-git-send-email-linuxram@us.ibm.com>
References: <1516326648-22775-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Finally this patch provides the ability for a process to
allocate and free a protection key.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/systbl.h      |    2 ++
 arch/powerpc/include/asm/unistd.h      |    4 +---
 arch/powerpc/include/uapi/asm/unistd.h |    2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 449912f..dea4a95 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -389,3 +389,5 @@
 COMPAT_SYS_SPU(pwritev2)
 SYSCALL(kexec_file_load)
 SYSCALL(statx)
+SYSCALL(pkey_alloc)
+SYSCALL(pkey_free)
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index 9ba11db..e0273bc 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -12,13 +12,11 @@
 #include <uapi/asm/unistd.h>
 
 
-#define NR_syscalls		384
+#define NR_syscalls		386
 
 #define __NR__exit __NR_exit
 
 #define __IGNORE_pkey_mprotect
-#define __IGNORE_pkey_alloc
-#define __IGNORE_pkey_free
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index df8684f..5db4385 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -395,5 +395,7 @@
 #define __NR_pwritev2		381
 #define __NR_kexec_file_load	382
 #define __NR_statx		383
+#define __NR_pkey_alloc		384
+#define __NR_pkey_free		385
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
1.7.1
