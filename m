Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 18 May 2009 15:17:59 +1000
Subject: [PATCH] powerpc: Explicit alignment for .data.cacheline_aligned
Message-Id: <20090518051800.57B89DE05C@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I don't think anything guarantees that the objects in data.page_aligned
are a multiple of PAGE_SIZE, thus the section may end on any boundary.

So the following section, .data.cacheline_aligned needs an explicit
alignment.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

And this is the right patch after a "quilt ref" and without typo :-)

 arch/powerpc/kernel/vmlinux.lds.S |    1 +
 1 file changed, 1 insertion(+)

--- linux-work.orig/arch/powerpc/kernel/vmlinux.lds.S	2009-05-18 14:24:05.000000000 +1000
+++ linux-work/arch/powerpc/kernel/vmlinux.lds.S	2009-05-18 15:16:54.000000000 +1000
@@ -264,6 +264,7 @@ SECTIONS
 		*(.data.page_aligned)
 	}
 
+	. = ALIGN(L1_CACHE_BYTES);
 	.data.cacheline_aligned : AT(ADDR(.data.cacheline_aligned) - LOAD_OFFSET) {
 		*(.data.cacheline_aligned)
 	}
