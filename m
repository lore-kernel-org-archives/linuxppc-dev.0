Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id A7A1BDDE05
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 09:41:59 +1000 (EST)
Date: Thu, 3 Jul 2008 18:41:40 -0500
From: Nathan Lynch <ntl@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] elf loader support for auxvec base platform string
Message-ID: <20080703234140.GC9594@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	McGrath <roland@redhat.com>, Roland
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some IBM POWER-based platforms have the ability to run in a
mode which mostly appears to the OS as a different processor from the
actual hardware.  For example, a Power6 system may appear to be a
Power5+, which makes the AT_PLATFORM value "power5+".

However, some applications (virtual machines, optimized libraries) can
benefit from knowledge of the underlying CPU model.  A new aux vector
entry, AT_BASE_PLATFORM, will denote the actual hardware.  For
example, on a Power6 system in Power5+ compatibility mode, AT_PLATFORM
will be "power5+" and AT_BASE_PLATFORM will be "power6".

If the architecture has defined ELF_BASE_PLATFORM, copy that value to
the user stack in the same manner as ELF_PLATFORM.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---

Next patch implements ELF/AT_BASE_PLATFORM for powerpc.

 fs/binfmt_elf.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index d48ff5f..834c2c4 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -131,6 +131,10 @@ static int padzero(unsigned long elf_bss)
 #define STACK_ALLOC(sp, len) ({ sp -= len ; sp; })
 #endif
 
+#ifndef ELF_BASE_PLATFORM
+#define ELF_BASE_PLATFORM NULL
+#endif
+
 static int
 create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 		unsigned long load_addr, unsigned long interp_load_addr)
@@ -142,7 +146,9 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 	elf_addr_t __user *envp;
 	elf_addr_t __user *sp;
 	elf_addr_t __user *u_platform;
+	elf_addr_t __user *u_base_platform;
 	const char *k_platform = ELF_PLATFORM;
+	const char *k_base_platform = ELF_BASE_PLATFORM;
 	int items;
 	elf_addr_t *elf_info;
 	int ei_index = 0;
@@ -172,6 +178,19 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 			return -EFAULT;
 	}
 
+	/*
+	 * If this architecture has a "base" platform capability
+	 * string, copy it to userspace.
+	 */
+	u_base_platform = NULL;
+	if (k_base_platform) {
+		size_t len = strlen(k_base_platform) + 1;
+
+		u_base_platform = (elf_addr_t __user *)STACK_ALLOC(p, len);
+		if (__copy_to_user(u_base_platform, k_base_platform, len))
+			return -EFAULT;
+	}
+
 	/* Create the ELF interpreter info */
 	elf_info = (elf_addr_t *)current->mm->saved_auxv;
 	/* update AT_VECTOR_SIZE_BASE if the number of NEW_AUX_ENT() changes */
@@ -208,6 +227,10 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 		NEW_AUX_ENT(AT_PLATFORM,
 			    (elf_addr_t)(unsigned long)u_platform);
 	}
+	if (k_base_platform) {
+		NEW_AUX_ENT(AT_BASE_PLATFORM,
+			    (elf_addr_t)(unsigned long)u_base_platform);
+	}
 	if (bprm->interp_flags & BINPRM_FLAGS_EXECFD) {
 		NEW_AUX_ENT(AT_EXECFD, bprm->interp_data);
 	}
-- 
1.5.5.1
