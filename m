Return-Path: <anton@samba.org>
Date: Tue, 12 Mar 2013 22:51:51 +1100
From: Anton Blanchard <anton@samba.org>
To: agraf@suse.de, benh@kernel.crashing.org, aaro.koskinen@iki.fi,
 amodra@gmail.com
Subject: [PATCH] powerpc: Fix -mcmodel=medium breakage in prom_init.c
Message-ID: <20130312225151.2faeb395@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Commit 5ac47f7a6efb (powerpc: Relocate prom_init.c on 64bit) made
prom_init.c position independent by manually relocating its entries
in the TOC.

We get the address of the TOC entries with the __prom_init_toc_start
linker symbol. If __prom_init_toc_start ends up as an entry in the
TOC then we need to add an offset to get the current address. This is
the case for older toolchains.

On the other hand, if we have a newer toolchain that supports
-mcmodel=medium then __prom_init_toc_start will be created by a
relative offset from r2 (the TOC pointer). Since r2 has already been
relocated, nothing more needs to be done.  Adding an offset in this
case is wrong and Aaro Koskinen and Alexander Graf have noticed noticed
G5 and OpenBIOS breakage.

Alan Modra suggested we just use r2 to get at the TOC which is simpler
and works with both old and new toolchains.

Reported-by: Alexander Graf <agraf@suse.de>
Signed-off-by: Anton Blanchard <anton@samba.org>
---

Thanks Aaro for reporting this, and Alexander for an initial
fix. This tested ok for me with both a new and an old toolchain,
but would appreciate if you could double check it fixes your issues
too.

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 7f7fb7f..13f8d16 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2832,11 +2832,13 @@ static void unreloc_toc(void)
 {
 }
 #else
-static void __reloc_toc(void *tocstart, unsigned long offset,
-			unsigned long nr_entries)
+static void __reloc_toc(unsigned long offset, unsigned long nr_entries)
 {
 	unsigned long i;
-	unsigned long *toc_entry = (unsigned long *)tocstart;
+	unsigned long *toc_entry;
+
+	/* Get the start of the TOC by using r2 directly. */
+	asm volatile("addi %0,2,-0x8000" : "=b" (toc_entry));
 
 	for (i = 0; i < nr_entries; i++) {
 		*toc_entry = *toc_entry + offset;
@@ -2850,8 +2852,7 @@ static void reloc_toc(void)
 	unsigned long nr_entries =
 		(__prom_init_toc_end - __prom_init_toc_start) / sizeof(long);
 
-	/* Need to add offset to get at __prom_init_toc_start */
-	__reloc_toc(__prom_init_toc_start + offset, offset, nr_entries);
+	__reloc_toc(offset, nr_entries);
 
 	mb();
 }
@@ -2864,8 +2865,7 @@ static void unreloc_toc(void)
 
 	mb();
 
-	/* __prom_init_toc_start has been relocated, no need to add offset */
-	__reloc_toc(__prom_init_toc_start, -offset, nr_entries);
+	__reloc_toc(-offset, nr_entries);
 }
 #endif
 #endif
