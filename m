Return-Path: <kalle.pokki@iki.fi>
Received: from host32.eke.fi (host32.eke.fi [194.100.64.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8155B67D86
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Oct 2006 23:39:44 +1000 (EST)
Date: Thu, 26 Oct 2006 16:33:53 +0300 (EEST)
From: Kalle Pokki <kalle.pokki@iki.fi>
To: linuxppc-embedded@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH] 8xx: Fixed compile error
Message-ID: <Pine.LNX.4.64.0610261630390.2243@host32.eke.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Compilation fails in case of CONFIG_MTD_PARTITIONS && !CONFIG_MTD_PHYSMAP.
Also put board-specific definitions inside #ifdef.

Signed-off-by: Kalle Pokki <kalle.pokki@iki.fi>
---
  arch/ppc/syslib/m8xx_setup.c |    6 +++---
  1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/ppc/syslib/m8xx_setup.c b/arch/ppc/syslib/m8xx_setup.c
index 54303a7..7d3bf66 100644
--- a/arch/ppc/syslib/m8xx_setup.c
+++ b/arch/ppc/syslib/m8xx_setup.c
@@ -31,12 +31,10 @@ #include <linux/bootmem.h>
  #include <linux/seq_file.h>
  #include <linux/root_dev.h>

-#if defined(CONFIG_MTD) && defined(CONFIG_MTD_PHYSMAP)
  #include <linux/mtd/partitions.h>
  #include <linux/mtd/physmap.h>
  #include <linux/mtd/mtd.h>
  #include <linux/mtd/map.h>
-#endif

  #include <asm/mmu.h>
  #include <asm/reg.h>
@@ -53,6 +51,7 @@ #include <asm/ppc_sys.h>

  #include "ppc8xx_pic.h"

+#if defined (CONFIG_MPC86XADS) || defined (CONFIG_MPC885ADS)
  #ifdef CONFIG_MTD_PHYSMAP
  #define MPC8xxADS_BANK_WIDTH 4
  #endif
@@ -79,7 +78,8 @@ static struct mtd_partition mpc8xxads_pa

  #define mpc8xxads_part_num (sizeof (mpc8xxads_partitions) / sizeof (mpc8xxads_partitions[0]))

-#endif
+#endif /* CONFIG_MTD_PARTITIONS */
+#endif /* CONFIG_MPC86XADS || CONFIG_MPC855ADS */

  static int m8xx_set_rtc_time(unsigned long time);
  static unsigned long m8xx_get_rtc_time(void);
-- 
1.4.1.1
