Return-Path: <michael@ozlabs.org>
To: linux-pci@atrey.karlin.mff.cuni.cz
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 25 Jan 2007 19:34:14 +1100
Subject: [RFC/PATCH 11/16] Activate MSI via RTAS on pseries
In-Reply-To: <1169714047.65693.647693675533.qpush@cradle>
Message-Id: <20070125083415.908ABDE392@ozlabs.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, "David S. Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Activate MSI via RTAS on pseries.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/pseries/setup.c |    2 ++
 1 file changed, 2 insertions(+)

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
