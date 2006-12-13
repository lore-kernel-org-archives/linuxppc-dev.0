Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 13 Dec 2006 21:40:15 +1100
Subject: [PATCH 8/9] Activate MSI on Powerpc
In-Reply-To: <1166006370.90082.476088563252.qpush@cradle>
Message-Id: <20061213104016.5362A682CD@ozlabs.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hook up a few platforms to use the appropriate MSI backend.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/pseries/setup.c |    2 ++
 arch/powerpc/sysdev/mpic.c             |    6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

Index: msi/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- msi.orig/arch/powerpc/platforms/pseries/setup.c
+++ msi/arch/powerpc/platforms/pseries/setup.c
@@ -65,6 +65,7 @@
 #include <asm/i8259.h>
 #include <asm/udbg.h>
 #include <asm/smp.h>
+#include <asm/msi.h>
 
 #include "plpar_wrappers.h"
 #include "ras.h"
@@ -284,6 +285,7 @@ static void __init pseries_discover_pic(
 #ifdef CONFIG_SMP
 			smp_init_pseries_xics();
 #endif
+			msi_rtas_init();
 			return;
 		}
 	}
Index: msi/arch/powerpc/sysdev/mpic.c
===================================================================
--- msi.orig/arch/powerpc/sysdev/mpic.c
+++ msi/arch/powerpc/sysdev/mpic.c
@@ -1126,8 +1126,10 @@ void __init mpic_init(struct mpic *mpic)
 
 	/* Do the HT PIC fixups on U3 broken mpic */
 	DBG("MPIC flags: %x\n", mpic->flags);
-	if ((mpic->flags & MPIC_BROKEN_U3) && (mpic->flags & MPIC_PRIMARY))
- 		mpic_scan_ht_pics(mpic);
+	if ((mpic->flags & MPIC_BROKEN_U3) && (mpic->flags & MPIC_PRIMARY)) {
+		mpic_scan_ht_pics(mpic);
+		mpic_htmsi_init(mpic);
+	}
 
 	for (i = 0; i < mpic->num_sources; i++) {
 		/* start with vector = source number, and masked */
