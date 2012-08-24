Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/2] powerpc: Fix xmon dl command for new printk implementation
Date: Fri, 24 Aug 2012 18:09:12 +1000
Message-Id: <1345795753-2881-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since the printk internals were reworked the xmon 'dl' command which
dumps the content of __log_buf has stopped working.

It is now a structured buffer, so just dumping it doesn't really work.

Use the helpers added for kgdb to print out the content.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c |   36 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index eab3492..013f286 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -17,6 +17,7 @@
 #include <linux/reboot.h>
 #include <linux/delay.h>
 #include <linux/kallsyms.h>
+#include <linux/kmsg_dump.h>
 #include <linux/cpumask.h>
 #include <linux/export.h>
 #include <linux/sysrq.h>
@@ -2148,40 +2149,23 @@ print_address(unsigned long addr)
 void
 dump_log_buf(void)
 {
-        const unsigned long size = 128;
-        unsigned long end, addr;
-        unsigned char buf[size + 1];
-
-        addr = 0;
-        buf[size] = '\0';
+	struct kmsg_dumper dumper = { .active = 1 };
+	unsigned char buf[128];
+	size_t len;
 
         if (setjmp(bus_error_jmp) != 0) {
-                printf("Unable to lookup symbol __log_buf!\n");
+		printf("Error dumping printk buffer!\n");
                 return;
         }
 
         catch_memory_errors = 1;
         sync();
-        addr = kallsyms_lookup_name("__log_buf");
-
-        if (! addr)
-                printf("Symbol __log_buf not found!\n");
-        else {
-                end = addr + (1 << CONFIG_LOG_BUF_SHIFT);
-                while (addr < end) {
-                        if (! mread(addr, buf, size)) {
-                                printf("Can't read memory at address 0x%lx\n", addr);
-                                break;
-                        }
-
-                        printf("%s", buf);
 
-                        if (strlen(buf) < size)
-                                break;
-
-                        addr += size;
-                }
-        }
+	kmsg_dump_rewind_nolock(&dumper);
+	while (kmsg_dump_get_line_nolock(&dumper, false, buf, sizeof(buf), &len)) {
+		buf[len] = '\0';
+		printf("%s", buf);
+	}
 
         sync();
         /* wait a little while to see if we get a machine check */
-- 
1.7.9.5
