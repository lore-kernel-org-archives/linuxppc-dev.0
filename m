Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <49E8B015.7060808@am.sony.com>
Date: Fri, 17 Apr 2009 09:36:37 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [patch] powerpc/pasemi: Fix no SMP build error
References: <1239285094.5188.65.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1239285094.5188.65.camel@subratamodak.linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	linux-next <linux-next@vger.kernel.org>,
	Olof Johansson <olof@lixom.net>, subrata@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A non-SMP version of smp_send_stop() is now included in smp.h.
Remove the unneeded def in the pasemi setup.c.

Fixes build errors like these when CONFIG_SMP=3Dn:

  arch/powerpc/platforms/pasemi/setup.c:48: error: redefinition of =E2=80=
=98smp_send_stop=E2=80=99
  include/linux/smp.h:125: error: previous definition of 'smp_send_stop' =
was here

Reported-by: subrata@linux.vnet.ibm.com
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---

diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platfor=
ms/pasemi/setup.c
index c64fb5b..153051e 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -44,10 +44,6 @@
=20
 #include "pasemi.h"
=20
-#if !defined(CONFIG_SMP)
-static void smp_send_stop(void) {}
-#endif
-
 /* SDC reset register, must be pre-mapped at reset time */
 static void __iomem *reset_reg;
=20
