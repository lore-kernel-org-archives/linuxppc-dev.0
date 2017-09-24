Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y0bGB0cqPzDqNh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 04:24:17 +1000 (AEST)
Received: by mail-qt0-x244.google.com with SMTP id u48so3765366qtc.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Sep 2017 11:24:17 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com
Subject: [RFC] powerpc: add sys_pkey_modify() system call
Date: Sun, 24 Sep 2017 11:23:54 -0700
Message-Id: <1506277434-13773-1-git-send-email-linuxram@us.ibm.com>
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
 arch/powerpc/mm/pkeys.c                |   29 +++++++++++++++++++++++++++++
 5 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index b33b551..d6f667e 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -391,3 +391,4 @@
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
index 71ae45e..c70b6d3 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -397,5 +397,6 @@
 #define __NR_pkey_alloc		384
 #define __NR_pkey_free		385
 #define __NR_pkey_mprotect	386
+#define __NR_pkey_modify	387
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 4a0fd4f..5980b9e 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -455,6 +455,15 @@ _GLOBAL(ppc_switch_endian)
 	bl	sys_switch_endian
 	b	.Lsyscall_exit
 
+_GLOBAL(ppc_pkey_modify)
+	bl	save_nvgprs
+#ifdef  CONFIG_PPC64_MEMORY_PROTECTION_KEYS
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
index de2e88f..bd16bc4 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -364,3 +364,32 @@ bool arch_vma_access_permitted(struct vm_area_struct *vma,
 
 	return pkey_access_permitted(pkey, write, execute);
 }
+
+unsigned int arch_usable_pkeys(void)
+{
+	unsigned int reserved;
+
+	if (!pkey_inited)
+		return 0;
+
+	/* Reserve one more to account for the execute-only pkey. */
+	reserved = hweight32(initial_allocation_mask) + 1;
+
+	return pkeys_total > reserved ? pkeys_total - reserved : 0;
+}
+
+bool arch_supports_pkeys(int cap)
+{
+	if (cap & PKEY_DISABLE_EXECUTE)
+		return pkey_execute_disable_support;
+	return (cap & (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
+}
+
+long sys_pkey_modify(int pkey, unsigned long new_val)
+{
+	/* check for unsupported init values */
+	if (new_val & ~PKEY_ACCESS_MASK)
+		return -EINVAL;
+
+	return __arch_set_user_pkey_access(current, pkey, new_val);
+}
-- 
1.7.1
