Return-Path: <jcrigby@gmail.com>
Message-ID: <4b73d43f0704061557v2f38991ep54bc66706672075d@mail.gmail.com>
Date: Fri, 6 Apr 2007 16:57:37 -0600
From: "John Rigby" <jcrigby@gmail.com>
To: Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>,
	"Grant Likely" <grant.likely@secretlab.ca>,
	"Sylvain Munaut" <tnt@246tnt.com>
Subject: [PATCH] Avoid putting cpu node twice
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Call of_find_node_by_type with NULL instead of np
so the cpu node does not get put twice.
This was causing kref_put warnings.

Signed-off-by: John Rigby <jrigby@freescale.com>
---
 arch/powerpc/platforms/52xx/lite5200.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/lite5200.c
b/arch/powerpc/platforms/52xx/lite5200.c
index cc3b40d..d2f90eb 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -108,9 +108,11 @@ static void __init lite5200_setup_arch(void)
        lite5200_setup_cpu();   /* Platorm specific */

 #ifdef CONFIG_PCI
-       np = of_find_node_by_type(np, "pci");
-       if (np)
+       np = of_find_node_by_type(NULL, "pci");
+       if (np) {
                mpc52xx_add_bridge(np);
+               of_node_put(np);
+       }
 #endif

 #ifdef CONFIG_BLK_DEV_INITRD
--
1.5.0.6
