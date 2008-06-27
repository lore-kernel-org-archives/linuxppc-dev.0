Return-Path: <nyet@mrv.com>
Received: from chmailsrv.int.mrv.com (unknown [66.43.110.3])
	by ozlabs.org (Postfix) with ESMTP id EA321DDFBD
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 06:13:25 +1000 (EST)
Date: Fri, 27 Jun 2008 13:01:00 -0700
From: Nye Liu <nyet@mrv.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] POWERPC CPM: Minor cosmetic changes to udbg_putc
Message-ID: <20080627200100.GA16661@mrv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Nye Liu <nyet@mrv.com>

udbg_putc is a *function pointer* that is initialized during
udbg_init_cpm. It might not be initialized properly when called from
udbg_putc_cpm(), so (recursively) call udbg_putc_cpm() directly.

Printing an "X" on initialization is ugly. How about a "\n" instead?

Signed-off-by: Nye Liu <nyet@mrv.com>

---

diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
index cb7df2d..dcde743 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -37,7 +37,7 @@ static void udbg_putc_cpm(char c)
 	u8 __iomem *txbuf = (u8 __iomem __force *)in_be32(&cpm_udbg_txdesc[1]);
 
 	if (c == '\n')
-		udbg_putc('\r');
+		udbg_putc_cpm('\r');
 
 	while (in_be32(&cpm_udbg_txdesc[0]) & 0x80000000)
 		;
@@ -53,7 +53,7 @@ void __init udbg_init_cpm(void)
 		setbat(1, 0xf0000000, 0xf0000000, 1024*1024, _PAGE_IO);
 #endif
 		udbg_putc = udbg_putc_cpm;
-		udbg_putc('X');
+		udbg_putc('\n');
 	}
 }
 #endif

-- 
Nye Liu
nliu@mrv.com
(818) 772-6235x248
(818) 772-0576 fax

"Who would be stupid enough to quote a fictitious character?"
	-- Don Quixote
