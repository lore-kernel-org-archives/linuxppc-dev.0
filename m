Return-Path: <mgreer@mvista.com>
Date: Mon, 14 Jan 2008 15:58:34 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: [PATCH 2/4] powerpc: mv64x60 - Exit when no hs_reg_valid property
Message-ID: <20080114225834.GA22862@mag.az.mvista.com>
References: <20080114225150.GB21940@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080114225150.GB21940@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mark A. Greer <mgreer@mvista.com>

mv64x60_sysfs_init() should exit as soon as it discovers there is no
'hs_reg_valid' property in the Device Tree.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---
 arch/powerpc/sysdev/mv64x60_pci.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/sysdev/mv64x60_pci.c b/arch/powerpc/sysdev/mv64x60_pci.c
index 2115177..7cc1abf 100644
--- a/arch/powerpc/sysdev/mv64x60_pci.c
+++ b/arch/powerpc/sysdev/mv64x60_pci.c
@@ -97,6 +97,8 @@ static int __init mv64x60_sysfs_init(void)
 
 	prop = of_get_property(np, "hs_reg_valid", NULL);
 	of_node_put(np);
+	if (!prop)
+		return 0;
 
 	pdev = platform_device_register_simple("marvell,mv64360", 0, NULL, 0);
 	if (IS_ERR(pdev))
