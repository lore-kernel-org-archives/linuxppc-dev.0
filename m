Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com
 [IPv6:2607:f8b0:400d:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVmhk41X8zDrK2
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 19:59:34 +1100 (AEDT)
Received: by mail-qk0-x242.google.com with SMTP id n5so9990498qke.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 00:59:34 -0800 (PST)
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
Subject: [PATCH v9 26/51] powerpc: add sys_pkey_modify() system call
Date: Mon,  6 Nov 2017 00:57:18 -0800
Message-Id: <1509958663-18737-27-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

sys_pkey_modify()  is   powerpc  specific  system  call.  It
enables  the ability to modify *any* attribute of a key.

Since powerpc disallows modification of IAMR from user space
an application is unable to change a key's execute-attribute.

This system call helps accomplish the above.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/systbl.h      |    1 +
 arch/powerpc/include/asm/unistd.h      |    2 +-
 arch/powerpc/include/uapi/asm/unistd.h |    1 +
 arch/powerpc/kernel/entry_64.S         |    9 +++++++++
 arch/powerpc/mm/pkeys.c                |   17 +++++++++++++++++
 5 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index d61f9c9..533cdc5 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -392,3 +392,4 @@
 SYSCALL(pkey_alloc)
 SYSCALL(pkey_free)
 SYSCALL(pkey_mprotect)
+PPC64ONLY(pkey_modify)
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index daf1ba9..1e97086 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -12,7 +12,7 @@
 #include <uapi/asm/unistd.h>
 
 
-#define NR_syscalls		387
+#define NR_syscalls		388
 
 #define __NR__exit __NR_exit
 
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index 389c36f..318cd79 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -398,5 +398,6 @@
 #define __NR_pkey_alloc		384
 #define __NR_pkey_free		385
 #define __NR_pkey_mprotect	386
+#define __NR_pkey_modify	387
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 4a0fd4f..47c85f9 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -455,6 +455,15 @@ _GLOBAL(ppc_switch_endian)
 	bl	sys_switch_endian
 	b	.Lsyscall_exit
 
+_GLOBAL(ppc_pkey_modify)
+	bl	save_nvgprs
+#ifdef  CONFIG_PPC_MEM_KEYS
+	bl	sys_pkey_modify
+#else
+	bl	sys_ni_syscall
+#endif
+	b	.Lsyscall_exit
+
 _GLOBAL(ret_from_fork)
 	bl	schedule_tail
 	REST_NVGPRS(r1)
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index 5047371..2612f61 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -420,3 +420,20 @@ bool arch_vma_access_permitted(struct vm_area_struct *vma, bool write,
 
 	return pkey_access_permitted(vma_pkey(vma), write, execute);
 }
+
+long sys_pkey_modify(int pkey, unsigned long new_val)
+{
+	bool ret;
+	/* Check for unsupported init values */
+	if (new_val & ~PKEY_ACCESS_MASK)
+		return -EINVAL;
+
+	down_write(&current->mm->mmap_sem);
+	ret = mm_pkey_is_allocated(current->mm, pkey);
+	up_write(&current->mm->mmap_sem);
+
+	if (!ret)
+		return -EINVAL;
+
+	return __arch_set_user_pkey_access(current, pkey, new_val);
+}
-- 
1.7.1
