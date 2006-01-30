Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BA58F68A0F
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jan 2006 00:28:10 +1100 (EST)
Date: Mon, 30 Jan 2006 14:28:03 +0100
From: Olaf Hering <olh@suse.de>
To: Alan Modra <amodra@bigpond.net.au>,
	Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] remove check for ELF offset in powerpc bootimage
Message-ID: <20060130132803.GA31263@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Is this check really needed, are there PT_LOAD sections with offset
zero (either zImage or vmlinux)? I see an offset which is always 64k.




Do not check for offset, it is always set.

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/powerpc/boot/main.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.16-rc1-olh/arch/powerpc/boot/main.c
===================================================================
--- linux-2.6.16-rc1-olh.orig/arch/powerpc/boot/main.c
+++ linux-2.6.16-rc1-olh/arch/powerpc/boot/main.c
@@ -152,7 +152,7 @@ static int is_elf64(void *hdr)
 	elf64ph = (Elf64_Phdr *)((unsigned long)elf64 +
 				 (unsigned long)elf64->e_phoff);
 	for (i = 0; i < (unsigned int)elf64->e_phnum; i++, elf64ph++)
-		if (elf64ph->p_type == PT_LOAD && elf64ph->p_offset != 0)
+		if (elf64ph->p_type == PT_LOAD)
 			break;
 	if (i >= (unsigned int)elf64->e_phnum)
 		return 0;
@@ -193,7 +193,7 @@ static int is_elf32(void *hdr)
 	elf32 = (Elf32_Ehdr *)elfheader;
 	elf32ph = (Elf32_Phdr *) ((unsigned long)elf32 + elf32->e_phoff);
 	for (i = 0; i < elf32->e_phnum; i++, elf32ph++)
-		if (elf32ph->p_type == PT_LOAD && elf32ph->p_offset != 0)
+		if (elf32ph->p_type == PT_LOAD)
 			break;
 	if (i >= elf32->e_phnum)
 		return 0;
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
