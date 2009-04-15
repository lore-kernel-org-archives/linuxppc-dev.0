Return-Path: <jk@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A2542DE13F
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 10:36:18 +1000 (EST)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH v2] powerpc: pseries/dtl.c should include asm/firmware.h
Message-Id: <1239755755.553226.808801509343.1.gpush@pingu>
In-Reply-To: <<49D3419E.7000005@in.ibm.com>>
To: <linuxppc-dev@ozlabs.org>, <linux-next@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 15 Apr 2009 10:35:55 +1000
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Michael Neuling <mikey@neuling.org>,
	Subrata Modak <subrata@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Sachin Sant <sachinp@in.ibm.com>

A randconfig build on powerpc failed with:

dtl.c: In function 'dtl_init':
dtl.c:238: error: implicit declaration of function 'firmware_has_feature'
dtl.c:238: error: 'FW_FEATURE_SPLPAR' undeclared (first use in this function)

- We need firmware.h for these definitions.

Signed-off-by: Sachin Sant <sachinp@in.ibm.com>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
v2: This time without the non-ascii quotes

---
 arch/powerpc/platforms/pseries/dtl.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index fafcaa0..ab69925 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -25,6 +25,7 @@
 #include <asm/smp.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
+#include <asm/firmware.h>
 
 #include "plpar_wrappers.h"
 
