Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6C4C3DDE26
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 23:46:31 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id EF6548817
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 18:46:29 +0500 (SAMST)
Date: Tue, 2 Oct 2007 17:47:40 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] [POWERPC] fsl_soc: fix uninitialized i2c_board_info
	structure
Message-ID: <20071002134740.GA19476@localhost.localdomain>
References: <20071002134535.GA17913@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071002134535.GA17913@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

i2c_board_info used semi-initialized, causing garbage in the
info->flags, and that, in turn, causes various symptoms of i2c
malfunctioning, like PEC mismatches.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/fsl_soc.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 4a16456..91987e0 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -363,7 +363,7 @@ static void __init of_register_i2c_devices(struct device_node *adap_node,
 	struct device_node *node = NULL;
 
 	while ((node = of_get_next_child(adap_node, node))) {
-		struct i2c_board_info info;
+		struct i2c_board_info info = {};
 		const u32 *addr;
 		int len;
 
@@ -380,7 +380,6 @@ static void __init of_register_i2c_devices(struct device_node *adap_node,
 		if (of_find_i2c_driver(node, &info) < 0)
 			continue;
 
-		info.platform_data = NULL;
 		info.addr = *addr;
 
 		i2c_register_board_info(bus_num, &info, 1);
-- 
1.5.0.6
