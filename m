Return-Path: <mgreer@mvista.com>
Date: Wed, 25 Oct 2006 16:36:16 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [POWERPC] Round up bootwrapper alloc size for vmlinux to page size
Message-ID: <20061025233616.GA17461@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The powerpc kernel linker script, arch/powerpc/kernel/vmlinux.lds.S,
aligns '_end' up to a page boundary.  However, the bootwrapper
does not round up the size of the area that it allocates to gunzip
the kernel into.  This leaves space between '__bss_stop' and '_end'
where the bootwrapper could allocate other things (e.g., space for
a flattened device tree).  This patch rounds up the allocation size
to a multiple of the page size to match '_end' and prevent the latent
bug.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

 main.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
---

diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index 4184974..234bb5b 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -198,7 +198,7 @@ static void prep_kernel(unsigned long *a
 	 * be claimed (it will be zero'd by the kernel itself)
 	 */
 	printf("Allocating 0x%lx bytes for kernel ...\n\r", vmlinux.memsize);
-	vmlinux.addr = (unsigned long)malloc(vmlinux.memsize);
+	vmlinux.addr = (unsigned long)malloc(_ALIGN(vmlinux.memsize, 4096));
 	if (vmlinux.addr == 0) {
 		printf("Can't allocate memory for kernel image !\n\r");
 		exit();
