Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zN3kJ1tXKzF0xT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 12:52:56 +1100 (AEDT)
Received: by mail-qt0-x244.google.com with SMTP id s3so423778qtb.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 17:52:56 -0800 (PST)
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
Subject: [PATCH v10 25/27] powerpc: sys_pkey_mprotect() system call
Date: Thu, 18 Jan 2018 17:50:46 -0800
Message-Id: <1516326648-22775-26-git-send-email-linuxram@us.ibm.com>
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

Patch provides the ability for a process to
associate a pkey with a address range.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/systbl.h      |    1 +
 arch/powerpc/include/asm/unistd.h      |    4 +---
 arch/powerpc/include/uapi/asm/unistd.h |    1 +
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index dea4a95..d61f9c9 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -391,3 +391,4 @@
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
index 5db4385..389c36f 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -397,5 +397,6 @@
 #define __NR_statx		383
 #define __NR_pkey_alloc		384
 #define __NR_pkey_free		385
+#define __NR_pkey_mprotect	386
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
1.7.1
