Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <45CCE977.4000502@am.sony.com>
Date: Fri, 09 Feb 2007 13:36:55 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: vdso error
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There seems to be a rounding error in VDSO32_MAXPAGES.
Pulled today from linux-2.6.git-eaefd5fb7d793c9c1bcef1b0c0d5ec3824a85b91
Fix below, but I'm not entierly sue that is what is needed.


vdso_init:696: vdso64_end 0, vdso64_start 127
vdso64_kbase: c0000000004c0000, 0x1 pages
vdso32_kbase: c0000000004b0000, 0x1 pages
vdso_init:731: PAGE_MASK 18446744073709486080 (ffffffffffff0000h)
vdso_init:735: PAGE_SHIFT 16
vdso_init:739: (unsigned int)(0x3000 + PAGE_MASK) 4294914048 (ffff3000h)
vdso_init:743: ((0x3000 + PAGE_MASK) >> PAGE_SHIFT) 4294967295 (ffffffffh)
vdso_init:747: (((0x3000 + PAGE_MASK) >> PAGE_SHIFT) + 2) 1 (1h)
vdso_init:757: vdso32_pages 1, VDSO32_MAXPAGES 1 (1h)
<0>------------[ cut here ]------------
<2>kernel BUG at /home/geoff/projects/cell/ps3-linux-dev/arch/powerpc/kernel/vdso.c:760!


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 arch/powerpc/kernel/vdso.c |   42 +++++++++++++++++++++++++++++++++++++++---
 arch/powerpc/mm/mem.c      |    2 +-
 2 files changed, 40 insertions(+), 4 deletions(-)

--- ps3-linux-dev.orig/arch/powerpc/kernel/vdso.c
+++ ps3-linux-dev/arch/powerpc/kernel/vdso.c
@@ -49,8 +50,8 @@
 /* Max supported size for symbol names */
 #define MAX_SYMNAME	64
 
-#define VDSO32_MAXPAGES	(((0x3000 + PAGE_MASK) >> PAGE_SHIFT) + 2)
-#define VDSO64_MAXPAGES	(((0x3000 + PAGE_MASK) >> PAGE_SHIFT) + 2)
+#define VDSO32_MAXPAGES	(((unsigned int)(0x3000 + PAGE_MASK) >> PAGE_SHIFT) + 2)
+#define VDSO64_MAXPAGES	(((unsigned int)(0x3000 + PAGE_MASK) >> PAGE_SHIFT) + 2)
 
 extern char vdso32_start, vdso32_end;
 static void *vdso32_kbase = &vdso32_start;
