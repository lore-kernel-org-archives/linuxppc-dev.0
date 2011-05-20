Return-Path: <dcarroll@astekcorp.com>
Received: from ether.astekcorp.com (unknown [173.160.34.133])
	by ozlabs.org (Postfix) with ESMTP id B085AB6F67
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 May 2011 09:23:55 +1000 (EST)
From: Dave Carroll <dcarroll@astekcorp.com>
To: 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>
Date: Fri, 20 May 2011 17:23:36 -0600
Subject: RE: [PATCH v2]powerpc: Force page alignment for initrd
Message-ID: <522F24EF533FC546962ECFA2054FF777373072AB72@MAILSERVER2.cos.astekcorp.com>
In-Reply-To: <1305930459.7481.194.camel@pasglop>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "Paul Mackerras \(E-mail\)" <paulus@samba.org>,
	"LPPC \(E-mail\)" <linuxppc-dev@lists.ozlabs.org>,
	"LKML \(E-mail\)" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


When using 64K pages with a separate cpio rootfs, U-Boot will align the roo=
tfs
on a 4K page boundary. When the memory is reserved, and subsequent early
memblock_alloc is called, it will allocate memory between the 64K page alig=
nment
and reserved memory. When the reserved memory is subsequently freed, it is =
done
so by pages, causing the early memblock_alloc requests to be re-used, which=
 in
my case, caused the device-tree to be clobbered.

This patch forces initrd to be kernel page aligned, to match the mechanism =
used
to free reserved memory.

Signed-off-by: Dave Carroll <dcarroll@astekcorp.com>
---
 arch/powerpc/kernel/prom.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 48aeb55..7e58f6b 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -555,7 +555,8 @@ static void __init early_reserve_mem(void)
 #ifdef CONFIG_BLK_DEV_INITRD
        /* then reserve the initrd, if any */
        if (initrd_start && (initrd_end > initrd_start))
-               memblock_reserve(__pa(initrd_start), initrd_end - initrd_st=
art);
+               memblock_reserve(_ALIGN_DOWN(__pa(initrd_start), PAGE_SIZE)=
,
+                       PAGE_ALIGN(initrd_end) - _ALIGN_DOWN(initrd_start, =
PAGE_SIZE));
 #endif /* CONFIG_BLK_DEV_INITRD */

 #ifdef CONFIG_PPC32
--
1.7.4
