Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id D178EDE17E
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 21:18:32 +1100 (EST)
Message-ID: <479EFE7F.4000104@denx.de>
Date: Tue, 29 Jan 2008 11:22:55 +0100
From: Heiko Schocher <hs@denx.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/4] 82xx: MGCOGE support
References: <mailman.813.1200609119.6908.linuxppc-dev@ozlabs.org>
In-Reply-To: <mailman.813.1200609119.6908.linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

To get the serial console on the SMC2 working, the
following patch is needed:

Fixing serial console on a SMC on MPC82xx based
board and using CONFIG_PPC_CPM_NEW_BINDING

Signed-off-by: Heiko Schocher <hs@denx.de>
---
 drivers/serial/cpm_uart/cpm_uart_core.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index b5e4478..7e610c2 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -978,9 +978,24 @@ static int cpm_uart_init_port(struct device_node *np,
 		pinfo->sccup = pram;
 	} else if (of_device_is_compatible(np, "fsl,cpm1-smc-uart") ||
 	           of_device_is_compatible(np, "fsl,cpm2-smc-uart")) {
+		u16 __iomem *pram_base;
+		struct resource res;
+
 		pinfo->flags |= FLAG_SMC;
 		pinfo->smcp = mem;
 		pinfo->smcup = pram;
+
+		if (of_address_to_resource(np, 1, &res)) {
+			ret = -ENOMEM;
+			goto out_pram;
+		}
+		pram_base = of_iomap(np, 2);
+		if (!pram_base) {
+			ret = -ENOMEM;
+			goto out_pram;
+		}
+		*pram_base = res.start;
+		iounmap (pram_base);
 	} else {
 		ret = -ENODEV;
 		goto out_pram;
-- 
1.5.2.2

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
