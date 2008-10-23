Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18688.257.812926.680480@drongo.ozlabs.ibm.com>
Date: Thu, 23 Oct 2008 15:43:45 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Work around ld bug in older binutils
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit 549e8152de8039506f69c677a4546e5427aa6ae7 ("powerpc: Make the
64-bit kernel as a position-independent executable") added lines to
vmlinux.lds.S to add the extra sections needed to implement a
relocatable kernel.  However, those lines seem to trigger a bug in
older versions of GNU ld (such as 2.16.1) when building a
non-relocatable kernel.  Since ld 2.16.1 is still a popular choice for
cross-toolchains, this adds an #ifdef to vmlinux.lds.S so the added
lines are only included when building a relocatable kernel.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index b39c27e..384dca5 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -187,6 +187,7 @@ SECTIONS
 		*(.machine.desc)
 		__machine_desc_end = . ;
 	}
+#ifdef CONFIG_RELOCATABLE
 	. = ALIGN(8);
 	.dynsym : AT(ADDR(.dynsym) - LOAD_OFFSET) { *(.dynsym) }
 	.dynstr : AT(ADDR(.dynstr) - LOAD_OFFSET) { *(.dynstr) }
@@ -202,6 +203,7 @@ SECTIONS
 		__rela_dyn_start = .;
 		*(.rela*)
 	}
+#endif
 
 	/* Fake ELF header containing RPA note; for addnote */
 	.fakeelf : AT(ADDR(.fakeelf) - LOAD_OFFSET) { *(.fakeelf) }
