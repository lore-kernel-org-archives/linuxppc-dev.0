Return-Path: <galak@gate.crashing.org>
Date: Wed, 21 Dec 2005 09:27:13 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.44.0512210926390.12446-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: [PATCH][UPDATE] powerpc: Call find_legacy_serial_ports() if we
 enable CONFIG_SERIAL_8250
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In setup_arch and setup_system call find_legacy_serial_ports() if we
build in support for 8250 serial ports instead of basing it on PPC_MULTIPLATFORM.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 27b4ecf949b83a0aa79640b2d124d65ffd4db0cd
tree 91c52973d0469e67fd20cd38650c216e3e26755d
parent 785912139d1f9480683e9fb359c81ce903a60fed
author Kumar Gala <galak@kernel.crashing.org> Wed, 21 Dec 2005 09:29:51 -0600
committer Kumar Gala <galak@kernel.crashing.org> Wed, 21 Dec 2005 09:29:51 -0600

 arch/powerpc/kernel/Makefile   |    3 +--
 arch/powerpc/kernel/setup_32.c |    2 +-
 arch/powerpc/kernel/setup_64.c |    2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 5bdc5fa..a852b37 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -56,8 +56,7 @@ obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
 obj-$(CONFIG_6xx)		+= idle_6xx.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
-obj-$(CONFIG_PPC_MULTIPLATFORM) += legacy_serial.o
-obj-$(CONFIG_PPC_MULTIPLATFORM) += udbg_16550.o
+obj-$(CONFIG_SERIAL_8250)	+= legacy_serial.o udbg_16550.o
 module-$(CONFIG_PPC64)		+= module_64.o
 obj-$(CONFIG_MODULES)		+= $(module-y)
 
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 79d434f..e5d285a 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -299,7 +299,7 @@ void __init setup_arch(char **cmdline_p)
 	if (ppc_md.init_early)
 		ppc_md.init_early();
 
-#ifdef CONFIG_PPC_MULTIPLATFORM
+#ifdef CONFIG_SERIAL_8250
 	find_legacy_serial_ports();
 #endif
 	finish_device_tree();
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 419e0b9..98e9f05 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -472,7 +472,7 @@ void __init setup_system(void)
 	 * hash table management for us, thus ioremap works. We do that early
 	 * so that further code can be debugged
 	 */
-#ifdef CONFIG_PPC_MULTIPLATFORM
+#ifdef CONFIG_SERIAL_8250
 	find_legacy_serial_ports();
 #endif
 
