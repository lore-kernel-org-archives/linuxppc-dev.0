Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <49935FC7.9010006@am.sony.com>
Date: Wed, 11 Feb 2009 15:31:19 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC patch] powerpc/ps3: Add ps3_topology_ready routine
References: <49935F81.7060203@am.sony.com>
In-Reply-To: <49935F81.7060203@am.sony.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Switch the PS3 hotplug memory routine ps3_mm_add_memory() from
being a core_initcall routine to being called via the new
topology_ready powerpc machdep call.

core_initcall routines run before the powerpc topology_init()
startup routine, resulting in failure of ps3_mm_add_memory()
when CONFIG_NUMA=y.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/mm.c       |    4 +---
 arch/powerpc/platforms/ps3/platform.h |    1 +
 arch/powerpc/platforms/ps3/setup.c    |    6 ++++++
 3 files changed, 8 insertions(+), 3 deletions(-)

--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -289,7 +289,7 @@ static void ps3_mm_region_destroy(struct
  * ps3_mm_add_memory - hot add memory
  */
 
-static int __init ps3_mm_add_memory(void)
+int __init ps3_mm_add_memory(void)
 {
 	int result;
 	unsigned long start_addr;
@@ -328,8 +328,6 @@ static int __init ps3_mm_add_memory(void
 	return result;
 }
 
-core_initcall(ps3_mm_add_memory);
-
 /*============================================================================*/
 /* dma routines                                                               */
 /*============================================================================*/
--- a/arch/powerpc/platforms/ps3/platform.h
+++ b/arch/powerpc/platforms/ps3/platform.h
@@ -37,6 +37,7 @@ void __init ps3_mm_init(void);
 void __init ps3_mm_vas_create(unsigned long* htab_size);
 void ps3_mm_vas_destroy(void);
 void ps3_mm_shutdown(void);
+int __init ps3_mm_add_memory(void);
 
 /* irq */
 
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -249,6 +249,11 @@ static int __init ps3_probe(void)
 	return 1;
 }
 
+static void __init ps3_topology_ready(void)
+{
+	ps3_mm_add_memory();
+}
+
 #if defined(CONFIG_KEXEC)
 static void ps3_kexec_cpu_down(int crash_shutdown, int secondary)
 {
@@ -267,6 +272,7 @@ define_machine(ps3) {
 	.name				= "PS3",
 	.probe				= ps3_probe,
 	.setup_arch			= ps3_setup_arch,
+	.topology_ready			= ps3_topology_ready,
 	.init_IRQ			= ps3_init_IRQ,
 	.panic				= ps3_panic,
 	.get_boot_time			= ps3_get_boot_time,
