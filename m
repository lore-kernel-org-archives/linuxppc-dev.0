Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id B5C89DDE9F
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 11:33:12 +1100 (EST)
Date: Fri, 25 Jan 2008 19:08:41 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Paul Mackeras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] hide kernel only code in asm-powerpc/elf.h
Message-ID: <20080125180841.GA30091@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


stuff inside CONFIG_* should not be exported via make headers-install

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 include/asm-powerpc/elf.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/asm-powerpc/elf.h
+++ b/include/asm-powerpc/elf.h
@@ -420,6 +420,7 @@ do {									\
 /* Keep this the last entry.  */
 #define R_PPC64_NUM		107
 
+#ifdef __KERNEL__
 #ifdef CONFIG_SPU_BASE
 /* Notes used in ET_CORE. Note name is "SPU/<fd>/<filename>". */
 #define NT_SPU		1
@@ -427,5 +428,6 @@ do {									\
 #define ARCH_HAVE_EXTRA_ELF_NOTES
 
 #endif /* CONFIG_SPU_BASE */
+#endif /* __KERNEL__ */
 
 #endif /* _ASM_POWERPC_ELF_H */
