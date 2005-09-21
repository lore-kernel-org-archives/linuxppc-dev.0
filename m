Return-Path: <galak@freescale.com>
Date: Wed, 21 Sep 2005 14:56:45 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.61.0509211456130.27823@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] powerpc: need to define __HAVE_ARCH_GATE_AREA for ppc32
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The merging of auxvec.h into asm-powerpc introduced the AT_SYSINFO_EHDR
into the ppc32 build that is used for VDSO.  However, we dont use the
gate mechanism for VDSO so we need to define __HAVE_ARCH_GATE_AREA.

Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>

---
commit ed88e411b2af8c41c50953e3138059fce60486f5
tree 32a15cfe1e4d8b4446552b22e42e0c85b85e16b8
parent 23e5b24d486fc63bd38b594c49240ffbac1aa474
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 21 Sep 2005 14:55:45 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 21 Sep 2005 14:55:45 -0500

 include/asm-ppc/page.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/asm-ppc/page.h b/include/asm-ppc/page.h
--- a/include/asm-ppc/page.h
+++ b/include/asm-ppc/page.h
@@ -160,6 +160,9 @@ extern __inline__ int get_order(unsigned
 	return 32 - lz;
 }
 
+/* We do define AT_SYSINFO_EHDR but don't use the gate mecanism */
+#define __HAVE_ARCH_GATE_AREA		1
+
 #endif /* __ASSEMBLY__ */
 
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
