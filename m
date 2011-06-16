Return-Path: <monstr@monstr.eu>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1EA41B7720
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2011 00:14:50 +1000 (EST)
Received: by mail-fx0-f42.google.com with SMTP id 1so1329303fxm.15
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2011 07:14:50 -0700 (PDT)
From: Michal Simek <monstr@monstr.eu>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 3/7] powerpc: simpleboot get load address from ELF instead
	of assuming zero
Date: Thu, 16 Jun 2011 16:14:24 +0200
Message-Id: <1308233668-24166-4-git-send-email-monstr@monstr.eu>
In-Reply-To: <1308233668-24166-3-git-send-email-monstr@monstr.eu>
References: <1308233668-24166-1-git-send-email-monstr@monstr.eu>
	<1308233668-24166-2-git-send-email-monstr@monstr.eu>
	<1308233668-24166-3-git-send-email-monstr@monstr.eu>
Cc: arnd@arndb.de, tmarri@apm.com, suzuki@in.ibm.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: John Williams <john.williams@petalogix.com>

simpleboot current assumes that the physical load address is zero, even if
the ELF payload has a non-zero paddr.

This is a simple fix that avoids a custom pltform_ops handler in this case.

Signed-off-by: John Williams <john.williams@petalogix.com>
---
 arch/powerpc/boot/elf.h      |    1 +
 arch/powerpc/boot/elf_util.c |    2 ++
 arch/powerpc/boot/main.c     |    1 +
 3 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/elf.h b/arch/powerpc/boot/elf.h
index 1941bc5..39af242 100644
--- a/arch/powerpc/boot/elf.h
+++ b/arch/powerpc/boot/elf.h
@@ -150,6 +150,7 @@ struct elf_info {
 	unsigned long loadsize;
 	unsigned long memsize;
 	unsigned long elfoffset;
+	unsigned long loadaddr;
 };
 int parse_elf64(void *hdr, struct elf_info *info);
 int parse_elf32(void *hdr, struct elf_info *info);
diff --git a/arch/powerpc/boot/elf_util.c b/arch/powerpc/boot/elf_util.c
index 1567a0c..3aef4f0 100644
--- a/arch/powerpc/boot/elf_util.c
+++ b/arch/powerpc/boot/elf_util.c
@@ -43,6 +43,7 @@ int parse_elf64(void *hdr, struct elf_info *info)
 	info->loadsize = (unsigned long)elf64ph->p_filesz;
 	info->memsize = (unsigned long)elf64ph->p_memsz;
 	info->elfoffset = (unsigned long)elf64ph->p_offset;
+	info->loadaddr = (unsigned long)elf64ph->p_paddr;
 
 	return 1;
 }
@@ -74,5 +75,6 @@ int parse_elf32(void *hdr, struct elf_info *info)
 	info->loadsize = elf32ph->p_filesz;
 	info->memsize = elf32ph->p_memsz;
 	info->elfoffset = elf32ph->p_offset;
+	info->loadaddr = elf32ph->p_paddr;
 	return 1;
 }
diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index a28f021..fbbffa5 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -56,6 +56,7 @@ static struct addr_range prep_kernel(void)
 	if (platform_ops.vmlinux_alloc) {
 		addr = platform_ops.vmlinux_alloc(ei.memsize);
 	} else {
+		addr = ei.loadaddr;
 		/*
 		 * Check if the kernel image (without bss) would overwrite the
 		 * bootwrapper. The device tree has been moved in fdt_init()
-- 
1.5.5.6
