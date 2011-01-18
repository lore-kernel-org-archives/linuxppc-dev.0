Return-Path: <meador_inge@mentor.com>
Message-ID: <4D34E4A9.4080807@mentor.com>
Date: Mon, 17 Jan 2011 18:54:01 -0600
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc: make MPIC honor the 'no-reset' device tree
	property
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Meador Inge <meador_inge@mentor.com>, devicetree-discuss@lists.ozlabs.org,
	"Blanchard, Hollis" <Hollis_Blanchard@mentor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This property, defined in the MPIC binding, tells the kernel not to use 
the reset bit in the global configuration register.

Signed-off-by: Meador Inge <meador_inge@mentor.com>
CC: Hollis Blanchard <hollis_blanchard@mentor.com>
---
  arch/powerpc/sysdev/mpic.c |    4 +++-
  1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 30c44e6..44aa2c3 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1157,7 +1157,9 @@ struct mpic * __init mpic_alloc(struct device_node 
*node,
  	mpic_map(mpic, node, paddr, &mpic->tmregs, MPIC_INFO(TIMER_BASE), 
0x1000);

  	/* Reset */
-	if (flags & MPIC_WANTS_RESET) {
+	if ((flags & MPIC_WANTS_RESET) &&
+		!of_find_property(node, "no-reset", NULL)) {
+		printk(KERN_DEBUG "mpic: Resetting\n");
  		mpic_write(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0),
  			   mpic_read(mpic->gregs, MPIC_INFO(GREG_GLOBAL_CONF_0))
  			   | MPIC_GREG_GCONF_RESET);
-- 1.6.3.3
