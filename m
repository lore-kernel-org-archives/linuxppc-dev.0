Return-Path: <mgreer@mvista.com>
Date: Mon, 5 Nov 2007 18:28:05 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: prpmc2800 - Don't trust documented memory size
Message-ID: <20071106012805.GA20909@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It turns out that the firmware on some PrPMC2800 processor modules
initializes the memory controller for 512 MB even when there is more
memory.  As a simple work around, set the amount of memory in the
device tree passed to the kernel to the lesser of what the memory
controller is set up for and the actual amount of memory.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---
 arch/powerpc/boot/prpmc2800.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/prpmc2800.c b/arch/powerpc/boot/prpmc2800.c
index 9614e1d..559c45e 100644
--- a/arch/powerpc/boot/prpmc2800.c
+++ b/arch/powerpc/boot/prpmc2800.c
@@ -405,7 +405,10 @@ static void prpmc2800_fixups(void)
 
 	bip = prpmc2800_get_bip(); /* Get board info based on VPD */
 
-	mem_size = (bip) ? bip->mem_size : mv64x60_get_mem_size(bridge_base);
+	mem_size = mv64x60_get_mem_size(bridge_base);
+	if (bip)
+		mem_size = min(mem_size, bip->mem_size);
+
 	prpmc2800_bridge_setup(mem_size); /* Do necessary bridge setup */
 
 	/* If the VPD doesn't match what we know about, just use the
