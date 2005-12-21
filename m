Return-Path: <galak@gate.crashing.org>
Date: Tue, 20 Dec 2005 20:45:27 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.44.0512202045040.1835-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: [PATCH] powerpc: Call find_legacy_serial_ports() if we enable
 CONFIG_SERIAL_8250
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
commit 399e10aa1c6a3ca64e8e8e8cea7289e9908cc62c
tree 3e5320b8a97a37c4d010186aabf8a95e5be264b4
parent 7b69a37a4e811e72e82896ab38e6ae04542455f5
author Kumar Gala <galak@kernel.crashing.org> Tue, 20 Dec 2005 20:48:36 -0600
committer Kumar Gala <galak@kernel.crashing.org> Tue, 20 Dec 2005 20:48:36 -0600

 arch/powerpc/kernel/setup_32.c |    2 +-
 arch/powerpc/kernel/setup_64.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
 
