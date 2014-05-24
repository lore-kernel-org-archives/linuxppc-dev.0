Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews02.kpnxchange.com (cpsmtpb-ews02.kpnxchange.com
 [213.75.39.5])
 by lists.ozlabs.org (Postfix) with ESMTP id 665B11A058F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 May 2014 17:36:18 +1000 (EST)
Message-ID: <1400916970.31526.78.camel@x220>
Subject: [PATCH] pcmcia: m8xx: remove checks for four macros
From: Paul Bolle <pebolle@tiscali.nl>
To: Vitaly Bordug <vitb@kernel.crashing.org>, Marcelo Tosatti
 <marcelo@kvack.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Date: Sat, 24 May 2014 09:36:10 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-pcmcia@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This driver contains checks for four Kconfig macros. But the related
Kconfig symbols have never been part of the tree. Remove these checks
and the code they hide.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

This has been an issue ever since this driver was added in v2.6.15. Note
that there is no header named "*/cpld.h", so setting PRxK can't possibly
work.

 drivers/pcmcia/m8xx_pcmcia.c | 75 --------------------------------------------
 1 file changed, 75 deletions(-)

diff --git a/drivers/pcmcia/m8xx_pcmcia.c b/drivers/pcmcia/m8xx_pcmcia.c
index 182034d2ef58..53b71fe50767 100644
--- a/drivers/pcmcia/m8xx_pcmcia.c
+++ b/drivers/pcmcia/m8xx_pcmcia.c
@@ -78,24 +78,14 @@ MODULE_LICENSE("Dual MPL/GPL");
 
 /* The FADS series are a mess */
 #ifdef CONFIG_FADS
-#if defined(CONFIG_MPC860T) || defined(CONFIG_MPC860) || defined(CONFIG_MPC821)
-#define CONFIG_PCMCIA_SLOT_A
-#else
 #define CONFIG_PCMCIA_SLOT_B
 #endif
-#endif
 
 #if defined(CONFIG_MPC885ADS)
 #define CONFIG_PCMCIA_SLOT_A
 #define PCMCIA_GLITCHY_CD
 #endif
 
-/* Cyclades ACS uses both slots */
-#ifdef CONFIG_PRxK
-#define CONFIG_PCMCIA_SLOT_A
-#define CONFIG_PCMCIA_SLOT_B
-#endif
-
 #endif				/* !defined(CONFIG_PCMCIA_SLOT_A) && !defined(CONFIG_PCMCIA_SLOT_B) */
 
 #if defined(CONFIG_PCMCIA_SLOT_A) && defined(CONFIG_PCMCIA_SLOT_B)
@@ -340,71 +330,6 @@ static inline int voltage_set(int slot, int vcc, int vpp)
 
 #endif
 
-#if defined(CONFIG_PRxK)
-#include <asm/cpld.h>
-extern volatile fpga_pc_regs *fpga_pc;
-
-#define PCMCIA_BOARD_MSG "MPC855T"
-
-static int voltage_set(int slot, int vcc, int vpp)
-{
-	u8 reg = 0;
-	u8 regread;
-	cpld_regs *ccpld = get_cpld();
-
-	switch (vcc) {
-	case 0:
-		break;
-	case 33:
-		reg |= PCMCIA_VCC_33;
-		break;
-	case 50:
-		reg |= PCMCIA_VCC_50;
-		break;
-	default:
-		return 1;
-	}
-
-	switch (vpp) {
-	case 0:
-		break;
-	case 33:
-	case 50:
-		if (vcc == vpp)
-			reg |= PCMCIA_VPP_VCC;
-		else
-			return 1;
-		break;
-	case 120:
-		if ((vcc == 33) || (vcc == 50))
-			reg |= PCMCIA_VPP_12;
-		else
-			return 1;
-	default:
-		return 1;
-	}
-
-	reg = reg >> (slot << 2);
-	regread = in_8(&ccpld->fpga_pc_ctl);
-	if (reg !=
-	    (regread & ((PCMCIA_VCC_MASK | PCMCIA_VPP_MASK) >> (slot << 2)))) {
-		/* enable new powersettings */
-		regread =
-		    regread & ~((PCMCIA_VCC_MASK | PCMCIA_VPP_MASK) >>
-				(slot << 2));
-		out_8(&ccpld->fpga_pc_ctl, reg | regread);
-		msleep(100);
-	}
-
-	return 0;
-}
-
-#define socket_get(_slot_) PCMCIA_SOCKET_KEY_LV
-#define hardware_enable(_slot_)	/* No hardware to enable */
-#define hardware_disable(_slot_)	/* No hardware to disable */
-
-#endif				/* CONFIG_PRxK */
-
 static u32 pending_events[PCMCIA_SOCKETS_NO];
 static DEFINE_SPINLOCK(pending_event_lock);
 
-- 
1.9.0
