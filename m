Return-Path: <weiyj.lk@gmail.com>
MIME-Version: 1.0
Date: Mon, 3 Dec 2012 08:36:03 -0500
Message-ID: <CAPgLHd_esknTwVv4EeehwSJz6ee5eFJ+zf6xntH-vaNwdxkrvg@mail.gmail.com>
Subject: [PATCH -next] powerpc/85xx: use for_each_compatible_node() macro
From: Wei Yongjun <weiyj.lk@gmail.com>
To: galak@kernel.crashing.org, benh@kernel.crashing.org, paulus@samba.org,
 grant.likely@secretlab.ca, rob.herring@calxeda.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: yongjun_wei@trendmicro.com.cn, linuxppc-dev@lists.ozlabs.org,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Use for_each_compatible_node() macro instead of open coding it.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/powerpc/platforms/85xx/mpc85xx_mds.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index bd12588..a7b3621 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -206,9 +206,7 @@ static void __init mpc85xx_mds_reset_ucc_phys(void)
 		setbits8(&bcsr_regs[7], BCSR7_UCC12_GETHnRST);
 		clrbits8(&bcsr_regs[8], BCSR8_UEM_MARVELL_RST);
 
-		for (np = NULL; (np = of_find_compatible_node(np,
-						"network",
-						"ucc_geth")) != NULL;) {
+		for_each_compatible_node(np, "network", "ucc_geth") {
 			const unsigned int *prop;
 			int ucc_num;
 
