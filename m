Return-Path: <dcarroll@astekcorp.com>
Received: from ether.astekcorp.com (unknown [173.160.34.133])
	by ozlabs.org (Postfix) with ESMTP id A4208B6F86
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 May 2011 07:32:59 +1000 (EST)
From: Dave Carroll <dcarroll@astekcorp.com>
To: "Benjamin Herrenschmidt (E-mail)" <benh@kernel.crashing.org>, "Paul
	Mackerras (E-mail)" <paulus@samba.org>, "Grant Likely (E-mail)"
	<grant.likely@secretlab.ca>
Date: Fri, 20 May 2011 15:26:19 -0600
Subject: [PATCH]powerpc: Force page alignment for early reserved memory
Message-ID: <522F24EF533FC546962ECFA2054FF777373072AB71@MAILSERVER2.cos.astekcorp.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "LPPC \(E-mail\)" <linuxppc-dev@lists.ozlabs.org>,
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
tfs on a 4K
page boundary. When the memory is reserved, and subsequent early memblock_a=
lloc
is called, it will allocate memory between the 64K page alignment and reser=
ved
memory. When the reserved memory is subsequently freed, it is done so by pa=
ges,
causing the early memblock_alloc requests to be re-used, which in my case, =
caused
the device-tree to be clobbered.

This patch forces all early reserved memory to be kernel page aligned, to m=
atch
the mechanism used to free reserved memory.

Signed-off-by: Dave Carroll <dcarroll@astekcorp.com>
---
 arch/powerpc/kernel/prom.c |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index e74fa12..2744792 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -534,6 +534,19 @@ void __init early_init_dt_setup_initrd_arch(unsigned l=
ong start,
 }
 #endif

+static void __init reserve_mem(u64 base, u64 size)
+{
+       u64 top =3D base + size;
+       if (size =3D=3D 0)
+               return;
+
+       base =3D _ALIGN_DOWN(base, PAGE_SIZE);
+       top =3D _ALIGN_UP(top, PAGE_SIZE);
+       size =3D top - base;
+       memblock_reserve(base, size);
+
+}
+
 static void __init early_reserve_mem(void)
 {
        u64 base, size;
@@ -547,12 +560,12 @@ static void __init early_reserve_mem(void)
        /* before we do anything, lets reserve the dt blob */
        self_base =3D __pa((unsigned long)initial_boot_params);
        self_size =3D initial_boot_params->totalsize;
-       memblock_reserve(self_base, self_size);
+       reserve_mem(self_base, self_size);

 #ifdef CONFIG_BLK_DEV_INITRD
        /* then reserve the initrd, if any */
        if (initrd_start && (initrd_end > initrd_start))
-               memblock_reserve(__pa(initrd_start), initrd_end - initrd_st=
art);
+               reserve_mem(__pa(initrd_start), initrd_end - initrd_start);
 #endif /* CONFIG_BLK_DEV_INITRD */

 #ifdef CONFIG_PPC32
@@ -573,7 +586,7 @@ static void __init early_reserve_mem(void)
                        if (base_32 =3D=3D self_base && size_32 =3D=3D self=
_size)
                                continue;
                        DBG("reserving: %x -> %x\n", base_32, size_32);
-                       memblock_reserve(base_32, size_32);
+                       reserve_mem(base_32, size_32);
                }
                return;
        }
@@ -584,7 +597,7 @@ static void __init early_reserve_mem(void)
                if (size =3D=3D 0)
                        break;
                DBG("reserving: %llx -> %llx\n", base, size);
-               memblock_reserve(base, size);
+               reserve_mem(base, size);
        }
 }

--
1.7.4
