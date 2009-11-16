Return-Path: <CWald@WatchGuardVideo.com>
Received: from wgv4.watchguardvideo.com (mail.watchguardvideo.com
	[69.198.24.138]) by ozlabs.org (Postfix) with ESMTP id DA9C5B6F29
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 04:46:31 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [PATCH] POWERPC 4xx: Fix PCI in AMCC 440EP Yosemite DTS
Date: Mon, 16 Nov 2009 11:36:40 -0600
Message-ID: <13F6A75BE29CE44F801B912901C3EF27022A3993@wgv4.watchguardvideo.local>
From: "Curtis Wald" <CWald@WatchGuardVideo.com>
To: <jwboyer@linux.vnet.ibm.com>,
	<mporter@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Yosemite.dts stanza for PCI was copied from Bamboo which has four PCI
slots; Yosemite only has one PCI slot which is mapped to
IDSEL 12, ADDR 22, IRQ2 Vector 25, INTA.

Signed-off-by: Curtis Wald <cwald@watchguardvideo.com>
---
 arch/powerpc/boot/dts/yosemite.dts |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/boot/dts/yosemite.dts
b/arch/powerpc/boot/dts/yosemite.dts
index 1fa3cb4..8328be5 100644
--- a/arch/powerpc/boot/dts/yosemite.dts
+++ b/arch/powerpc/boot/dts/yosemite.dts
@@ -276,26 +276,19 @@
                         * later cannot be changed. Chip supports a
second
                         * IO range but we don't use it for now
                         */
+
+                        /*       u32              u64
u64                     u64  */
+                        /*       pci_space        pci_addr
cpu_addr                size */
                        ranges =3D <0x02000000 0x00000000 0xa0000000
0x00000000 0xa0000000 0x00000000 0x20000000
                                  0x01000000 0x00000000 0x00000000
0x00000000 0xe8000000 0x00000000 0x00010000>;
=20
                        /* Inbound 2GB range starting at 0 */
                        dma-ranges =3D <0x42000000 0x0 0x0 0x0 0x0 0x0
0x80000000>;
=20
-                       /* Bamboo has all 4 IRQ pins tied together per
slot */
                        interrupt-map-mask =3D <0xf800 0x0 0x0 0x0>;
                        interrupt-map =3D <
-                               /* IDSEL 1 */
-                               0x800 0x0 0x0 0x0 &UIC0 0x1c 0x8
-
-                               /* IDSEL 2 */
-                               0x1000 0x0 0x0 0x0 &UIC0 0x1b 0x8
-
-                               /* IDSEL 3 */
-                               0x1800 0x0 0x0 0x0 &UIC0 0x1a 0x8
-
-                               /* IDSEL 4 */
-                               0x2000 0x0 0x0 0x0 &UIC0 0x19 0x8
+                               /* IDSEL 12, ADDR 22, INTA, IRQ2 =3D
Vector 25, 0x19 */
+                               0x6000 0x0 0x0 0x0 &UIC0 0x19 0x8
                        >;
                };
        };
