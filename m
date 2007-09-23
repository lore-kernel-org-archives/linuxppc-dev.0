Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 89B92DDFC3
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Sep 2007 06:17:37 +1000 (EST)
Message-ID: <46F6C9D7.4060700@scram.de>
Date: Sun, 23 Sep 2007 22:17:27 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH3/4] [PPC] Compile fix for 8xx CPM Ehernet driver
Content-Type: multipart/mixed; boundary="------------010209040705070605030000"
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010209040705070605030000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Add #include <asm/cacheflush.h> for flush_dcache_range
to make the driver compile again.

  CC      arch/ppc/8xx_io/enet.o
arch/ppc/8xx_io/enet.c: In function 'scc_enet_start_xmit':
arch/ppc/8xx_io/enet.c:240: error: implicit declaration of function
'flush_dcache_range'
make[1]: *** [arch/ppc/8xx_io/enet.o] Error 1
make: *** [arch/ppc/8xx_io] Error 2

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/ppc/8xx_io/enet.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

--------------010209040705070605030000
Content-Type: text/x-patch;
 name="c10ab471b95ac13c93b0ae36d169756ae694a77d.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="c10ab471b95ac13c93b0ae36d169756ae694a77d.diff"

diff --git a/arch/ppc/8xx_io/enet.c b/arch/ppc/8xx_io/enet.c
index 703d47e..eace3bc 100644
--- a/arch/ppc/8xx_io/enet.c
+++ b/arch/ppc/8xx_io/enet.c
@@ -44,6 +44,7 @@
 #include <asm/mpc8xx.h>
 #include <asm/uaccess.h>
 #include <asm/commproc.h>
+#include <asm/cacheflush.h>
 
 /*
  *				Theory of Operation


--------------010209040705070605030000--
