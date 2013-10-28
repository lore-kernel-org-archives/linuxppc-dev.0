Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: FA_DUMP depends on KEXEC
Date: Mon, 28 Oct 2013 15:00:35 +1100
Message-Id: <1382932835-23830-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If you try and build the FA_DUMP code with CONFIG_KEXEC=n, you see
errors such as the following:

arch/powerpc/kernel/fadump.c
  408:2: error: 'crashing_cpu' undeclared (first use in this function)
  410:2: error: implicit declaration of function 'crash_save_vmcoreinfo'
  513:22: error: storage size of 'prstatus' isn't known
  520:2: error: implicit declaration of function 'elf_core_copy_kernel_regs'
  521:36: error: 'KEXEC_CORE_NOTE_NAME' undeclared (first use in this function)
  624:49: error: 'note_buf_t' undeclared (first use in this function)
  872:2: error: implicit declaration of function 'paddr_vmcoreinfo_note'
  874:18: error: 'vmcoreinfo_max_size' undeclared (first use in this function)

This is because although FA_DUMP doesn't use kexec as the actual reboot
mechanism, it does use parts of the kexec code to assemble/disassemble
the crash image.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 38f3b7e..9d4e80e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -404,7 +404,7 @@ config CRASH_DUMP
 
 config FA_DUMP
 	bool "Firmware-assisted dump"
-	depends on PPC64 && PPC_RTAS && CRASH_DUMP
+	depends on PPC64 && PPC_RTAS && CRASH_DUMP && KEXEC
 	help
 	  A robust mechanism to get reliable kernel crash dump with
 	  assistance from firmware. This approach does not use kexec,
-- 
1.8.3.2
