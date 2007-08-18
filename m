Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 55F82DDE25
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Aug 2007 03:09:41 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l7IH9aXB008742
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2007 12:09:37 -0500
Date: Sat, 18 Aug 2007 12:09:54 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3 v2][POWERPC] Copy over headers from arch/ppc to
	arch/powerpc that we need
In-Reply-To: <Pine.LNX.4.64.0708181206070.31362@blarg.am.freescale.net>
Message-ID: <Pine.LNX.4.64.0708181207530.31362@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0708181203320.31362@blarg.am.freescale.net>
	<Pine.LNX.4.64.0708181206070.31362@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

To build arch/powerpc without including asm-ppc/ we need these files
in asm-powerpc/

Moved some headers under arch/powerpc/platforms if they were only used by
platform files and fixed up the source file includes to match the new
locations

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Moved mpc10x.h, gg2.h, hydra.h into platforms. Removed new file diffs
from the patch.

 arch/powerpc/platforms/chrp/gg2.h                |   61 ++
 arch/powerpc/platforms/chrp/hydra.h              |  102 ++
 arch/powerpc/platforms/chrp/pci.c                |    4 +-
 arch/powerpc/platforms/chrp/setup.c              |    4 +-
 arch/powerpc/platforms/embedded6xx/linkstation.c |    3 +-
 arch/powerpc/platforms/embedded6xx/ls_uart.c     |    3 +-
 arch/powerpc/platforms/embedded6xx/mpc10x.h      |  180 ++++
 include/asm-powerpc/8xx_immap.h                  |  564 ++++++++++
 include/asm-powerpc/commproc.h                   |  692 ++++++++++++
 include/asm-powerpc/cpm2.h                       | 1248 ++++++++++++++++++++++
 include/asm-powerpc/highmem.h                    |  135 +++
 include/asm-powerpc/immap_cpm2.h                 |  648 +++++++++++
 include/asm-powerpc/kgdb.h                       |   57 +
 include/asm-powerpc/mpc52xx_psc.h                |  191 ++++
 14 files changed, 3886 insertions(+), 6 deletions(-)
 create mode 100644 arch/powerpc/platforms/chrp/gg2.h
 create mode 100644 arch/powerpc/platforms/chrp/hydra.h
 create mode 100644 arch/powerpc/platforms/embedded6xx/mpc10x.h
 create mode 100644 include/asm-powerpc/8xx_immap.h
 create mode 100644 include/asm-powerpc/commproc.h
 create mode 100644 include/asm-powerpc/cpm2.h
 create mode 100644 include/asm-powerpc/highmem.h
 create mode 100644 include/asm-powerpc/immap_cpm2.h
 create mode 100644 include/asm-powerpc/kgdb.h
 create mode 100644 include/asm-powerpc/mpc52xx_psc.h

diff --git a/arch/powerpc/platforms/chrp/pci.c b/arch/powerpc/platforms/chrp/pci.c
index 0c6dba9..fd80703 100644
--- a/arch/powerpc/platforms/chrp/pci.c
+++ b/arch/powerpc/platforms/chrp/pci.c
@@ -11,9 +11,7 @@
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/irq.h>
-#include <asm/hydra.h>
 #include <asm/prom.h>
-#include <asm/gg2.h>
 #include <asm/machdep.h>
 #include <asm/sections.h>
 #include <asm/pci-bridge.h>
@@ -21,6 +19,8 @@
 #include <asm/rtas.h>

 #include "chrp.h"
+#include "gg2.h"
+#include "hydra.h"

 /* LongTrail */
 void __iomem *gg2_pci_config_base;
diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index dde5ef4..03ccf1a 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -37,12 +37,10 @@
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/prom.h>
-#include <asm/gg2.h>
 #include <asm/pci-bridge.h>
 #include <asm/dma.h>
 #include <asm/machdep.h>
 #include <asm/irq.h>
-#include <asm/hydra.h>
 #include <asm/sections.h>
 #include <asm/time.h>
 #include <asm/i8259.h>
@@ -51,6 +49,8 @@
 #include <asm/xmon.h>

 #include "chrp.h"
+#include "gg2.h"
+#include "hydra.h"

 void rtas_indicator_progress(char *, unsigned short);

diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
index 8c60e02..61ca02c 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -18,9 +18,10 @@
 #include <asm/time.h>
 #include <asm/prom.h>
 #include <asm/mpic.h>
-#include <asm/mpc10x.h>
 #include <asm/pci-bridge.h>

+#include "mpc10x.h"
+
 static struct mtd_partition linkstation_physmap_partitions[] = {
 	{
 		.name   = "mtd_firmimg",
diff --git a/arch/powerpc/platforms/embedded6xx/ls_uart.c b/arch/powerpc/platforms/embedded6xx/ls_uart.c
index f7a4def..0d9f150 100644
--- a/arch/powerpc/platforms/embedded6xx/ls_uart.c
+++ b/arch/powerpc/platforms/embedded6xx/ls_uart.c
@@ -4,10 +4,11 @@
 #include <linux/serial_reg.h>
 #include <linux/serial_8250.h>
 #include <asm/io.h>
-#include <asm/mpc10x.h>
 #include <asm/prom.h>
 #include <asm/termbits.h>

+#include "mpc10x.h"
+
 static void __iomem *avr_addr;
 static unsigned long avr_clock;
-- 
1.5.2.2
