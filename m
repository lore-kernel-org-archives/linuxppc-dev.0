Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 841E4DDFAF
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 03:36:42 +1000 (EST)
Date: Tue, 8 Jul 2008 21:36:40 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/fsl_soc: gianfar: don't probe disabled devices
Message-ID: <20080708173640.GB7140@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Freescale ships MPC8315E-RDB boards in two variants:

1. With TSEC1 ethernet support and USB UTMI PHY;
2. Without TSEC1 support, but with USB ULPI PHY in addition.

For the second case U-Boot will add status = "disabled"; property
into the TSEC1 node, so Linux should not try to probe it.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/fsl_soc.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 7d4cf00..2a19769 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -296,6 +296,9 @@ static int __init gfar_of_init(void)
 		const phandle *ph;
 		int n_res = 2;
 
+		if (!of_device_is_available(np))
+			continue;
+
 		memset(r, 0, sizeof(r));
 		memset(&gfar_data, 0, sizeof(gfar_data));
 
-- 
1.5.5.4
