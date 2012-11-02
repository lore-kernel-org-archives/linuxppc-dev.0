Return-Path: <anton@samba.org>
Date: Fri, 2 Nov 2012 11:55:04 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, sfr@ozlabs.org,
 dhowells@redhat.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: Move most of setup.h out of uapi
Message-ID: <20121102115504.02c7fe4c@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Most of setup.h should not be exported to userspace, so move it
back. All we are left with is the asm-generic include to pick
up the COMMAND_LINE_SIZE define.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/include/asm/setup.h
===================================================================
--- /dev/null
+++ b/arch/powerpc/include/asm/setup.h
@@ -0,0 +1,33 @@
+#ifndef _ASM_POWERPC_SETUP_H
+#define _ASM_POWERPC_SETUP_H
+
+#include <uapi/asm/setup.h>
+
+#ifndef __ASSEMBLY__
+extern void ppc_printk_progress(char *s, unsigned short hex);
+
+extern unsigned int rtas_data;
+extern int mem_init_done;	/* set on boot once kmalloc can be called */
+extern int init_bootmem_done;	/* set once bootmem is available */
+extern unsigned long long memory_limit;
+extern unsigned long klimit;
+extern void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
+
+extern void via_cuda_init(void);
+extern void read_rtc_time(void);
+extern void pmac_find_display(void);
+
+struct device_node;
+extern void note_scsi_host(struct device_node *, void *);
+
+/* Used in very early kernel initialization. */
+extern unsigned long reloc_offset(void);
+extern unsigned long add_reloc_offset(unsigned long);
+extern void reloc_got2(unsigned long);
+
+#define PTRRELOC(x)	((typeof(x)) add_reloc_offset((unsigned long)(x)))
+
+#endif /* !__ASSEMBLY__ */
+
+#endif	/* _ASM_POWERPC_SETUP_H */
+
Index: b/arch/powerpc/include/uapi/asm/setup.h
===================================================================
--- a/arch/powerpc/include/uapi/asm/setup.h
+++ b/arch/powerpc/include/uapi/asm/setup.h
@@ -1,32 +1 @@
-#ifndef _ASM_POWERPC_SETUP_H
-#define _ASM_POWERPC_SETUP_H
-
 #include <asm-generic/setup.h>
-
-#ifndef __ASSEMBLY__
-extern void ppc_printk_progress(char *s, unsigned short hex);
-
-extern unsigned int rtas_data;
-extern int mem_init_done;	/* set on boot once kmalloc can be called */
-extern int init_bootmem_done;	/* set once bootmem is available */
-extern unsigned long long memory_limit;
-extern unsigned long klimit;
-extern void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
-
-extern void via_cuda_init(void);
-extern void read_rtc_time(void);
-extern void pmac_find_display(void);
-
-struct device_node;
-extern void note_scsi_host(struct device_node *, void *);
-
-/* Used in very early kernel initialization. */
-extern unsigned long reloc_offset(void);
-extern unsigned long add_reloc_offset(unsigned long);
-extern void reloc_got2(unsigned long);
-
-#define PTRRELOC(x)	((typeof(x)) add_reloc_offset((unsigned long)(x)))
-
-#endif /* !__ASSEMBLY__ */
-
-#endif	/* _ASM_POWERPC_SETUP_H */
