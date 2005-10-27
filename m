Return-Path: <galak@freescale.com>
Date: Thu, 27 Oct 2005 08:54:36 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.61.0510270854090.27447@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH][UPDATED] powerpc: only build idle_6xx for 6xx
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For the current time idle_6xx only applies to 6xx ppc32 CPUs

Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>

---
commit e3b3bc6d075bd1d07caa64bcaa3add128a0cb6f3
tree e41cfdec6b3565258cb5bee14078a23f8be3b6ff
parent 0f72dedad02fc2869ddc13ff2f6998ec7dfdcbc1
author Kumar K. Gala <kumar.gala@freescale.com> Thu, 27 Oct 2005 08:53:36 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Thu, 27 Oct 2005 08:53:36 -0500

 arch/powerpc/kernel/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -33,11 +33,12 @@ extra-y				+= vmlinux.lds
 
 obj-y				+= process.o init_task.o time.o \
 				   prom.o systbl.o traps.o setup-common.o
-obj-$(CONFIG_PPC32)		+= entry_32.o idle_6xx.o setup_32.o misc_32.o
+obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o misc_32.o
 obj-$(CONFIG_PPC64)		+= setup_64.o misc_64.o
 obj-$(CONFIG_PPC_OF)		+= prom_init.o
 obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
+obj-$(CONFIG_6xx)		+= idle_6xx.o
 
 ifeq ($(CONFIG_PPC_ISERIES),y)
 $(obj)/head_64.o: $(obj)/lparmap.s
