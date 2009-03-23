Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 23 Mar 2009 13:04:53 +1100
Subject: [PATCH] powerpc: Fix prom_init on 32-bit OF machines
Message-Id: <20090323020516.D633FDDE19@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit e7943fbbfdb6eef03c003b374de1f802cc14f02a broke ppc32 using
Open Firmware client interface due to using the wrong relocation
macro when accessing the variable "linux_banner".

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/prom_init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-work.orig/arch/powerpc/kernel/prom_init.c	2009-03-23 11:55:25.000000000 +1100
+++ linux-work/arch/powerpc/kernel/prom_init.c	2009-03-23 11:55:37.000000000 +1100
@@ -2283,7 +2283,7 @@ unsigned long __init prom_init(unsigned 
 	 */
 	prom_init_stdout();
 
-       	prom_printf("Preparing to boot %s", PTRRELOC((char *)linux_banner));
+       	prom_printf("Preparing to boot %s", RELOC(linux_banner));
 
 	/*
 	 * Get default machine type. At this point, we do not differentiate
