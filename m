Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 72160B815F
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 08:16:41 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 3/3] powerpc: mpc5121: enable support for more PSC UARTs
Date: Tue,  9 Feb 2010 22:13:52 +0100
Message-Id: <1265750032-2803-4-git-send-email-agust@denx.de>
In-Reply-To: <1265750032-2803-1-git-send-email-agust@denx.de>
References: <1265750032-2803-1-git-send-email-agust@denx.de>
Cc: wd@denx.de, dzu@denx.de, gregkh@suse.de, linux-kernel@vger.kernel.org,
	Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MPC5121 has 12 PSC devices. Enable UART support for all of
them by defining the number of max. PSCs depending on
selection of PPC_MPC512x platform support.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
No changes since v1.

 arch/powerpc/include/asm/mpc52xx_psc.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc52xx_psc.h b/arch/powerpc/include/asm/mpc52xx_psc.h
index fb84120..42561f4 100644
--- a/arch/powerpc/include/asm/mpc52xx_psc.h
+++ b/arch/powerpc/include/asm/mpc52xx_psc.h
@@ -25,7 +25,11 @@
 #include <asm/types.h>
 
 /* Max number of PSCs */
+#ifdef CONFIG_PPC_MPC512x
+#define MPC52xx_PSC_MAXNUM     12
+#else
 #define MPC52xx_PSC_MAXNUM	6
+#endif
 
 /* Programmable Serial Controller (PSC) status register bits */
 #define MPC52xx_PSC_SR_UNEX_RX	0x0001
-- 
1.6.3.3
