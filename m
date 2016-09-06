Return-Path: <dja@axtens.net>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSwHN5ttczDrqg
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 15:33:20 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id x24so836885pfa.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Sep 2016 22:33:20 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Daniel Axtens <dja@axtens.net>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>
Subject: [PATCH v2 4/5] powerpc/fadump: Make ELF eflags depend on endian
Date: Tue,  6 Sep 2016 15:32:42 +1000
Message-Id: <1473139963-7496-4-git-send-email-dja@axtens.net>
In-Reply-To: <1473139963-7496-1-git-send-email-dja@axtens.net>
References: <1473139963-7496-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Firmware Assisted Dump is a facility to dump kernel core with assistance
from firmware.  As part of this process the kernel ELF version is
stored.

Currently, fadump.h defines this to 0 if it is not already defined. This
clashes with a define in elf.h which sets it based on the current task -
not based on the kernel.

When the kernel is compiled on LE, the kernel will always be version
2. Otherwise it will be version 0. So the correct behaviour is to set
the ELF eflags based on the endianness of the kernel. Do that.

Remove the definition in fadump.h, which becomes unused.

Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>

---

Mahesh or Hari: I'm not familiar with this code at all, so if either of
you could check that this makes sense I would really appreciate that.
Thanks!
---
 arch/powerpc/include/asm/fadump.h | 4 ----
 arch/powerpc/kernel/fadump.c      | 6 +++++-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index b4407d0add27..0031806475f0 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -45,10 +45,6 @@
 
 #define memblock_num_regions(memblock_type)	(memblock.memblock_type.cnt)
 
-#ifndef ELF_CORE_EFLAGS
-#define ELF_CORE_EFLAGS 0
-#endif
-
 /* Firmware provided dump sections */
 #define FADUMP_CPU_STATE_DATA	0x0001
 #define FADUMP_HPTE_REGION	0x0002
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 0638b82ce294..457f08e544c6 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -779,7 +779,11 @@ static int fadump_init_elfcore_header(char *bufp)
 	elf->e_entry = 0;
 	elf->e_phoff = sizeof(struct elfhdr);
 	elf->e_shoff = 0;
-	elf->e_flags = ELF_CORE_EFLAGS;
+#ifdef __LITTLE_ENDIAN__
+	elf->e_flags = 2;
+#else
+	elf->e_flags = 0;
+#endif
 	elf->e_ehsize = sizeof(struct elfhdr);
 	elf->e_phentsize = sizeof(struct elf_phdr);
 	elf->e_phnum = 0;
-- 
2.7.4
