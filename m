Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 5C6BFB6F08
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 13 May 2011 21:03:16 +1000 (EST)
Date: Fri, 13 May 2011 13:03:13 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATHC] Fix for Pegasos keyboard and mouse
Message-ID: <20110513110313.GA4208@iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pacman@kosh.dhis.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[See http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-October/086424.html
and followups. Part of the commit message is directly copied from that.]

Commit 540c6c392f01887dcc96bef0a41e63e6c1334f01 tries to find i8042 IRQs in
the device-tree but doesn't fall back to the old hardcoded 1 and 12 in all
failure cases.

Specifically, the case where the device-tree contains nothing matching
pnpPNP,303 or pnpPNP,f03 doesn't seem to be handled well. It sort of falls
through to the old code, but leaves the IRQs set to 0.

Signed-off-by: Gabriel Paubert <paubert@iram.es>

---

This fix has only been tested on Pegasos, but to my knowledge it only 
affects a Pegasos specific path (all other fimwares should be able
to find the keyboard through the pnp identifiers.

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 21f30cb..6c7abbf 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -602,6 +602,10 @@ int check_legacy_ioport(unsigned long base_port)
 		 * name instead */
 		if (!np)
 			np = of_find_node_by_name(NULL, "8042");
+		if (np) {
+			of_i8042_kbd_irq = 1;
+			of_i8042_aux_irq = 12;
+		}
 		break;
 	case FDC_BASE: /* FDC1 */
 		np = of_find_node_by_type(NULL, "fdc");
