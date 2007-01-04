Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2B2AADDE0A
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jan 2007 17:01:51 +1100 (EST)
Date: Thu, 4 Jan 2007 17:01:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] iSeries: fix mf proc initialisation
Message-Id: <20070104170151.1d653291.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This proc file should only be created if we are running on legacy iSeries.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/mf.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

Paulus, this is a bug fix and prevents an OOPS when using a combined
kernel on anything other than iSeries hardware - tested on iSeries and
pSeries.  The following patches are similar.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/iseries/mf.c b/arch/powerpc/platforms/iseries/mf.c
index cff15ae..1ad0e4a 100644
--- a/arch/powerpc/platforms/iseries/mf.c
+++ b/arch/powerpc/platforms/iseries/mf.c
@@ -38,6 +38,7 @@
 #include <asm/uaccess.h>
 #include <asm/paca.h>
 #include <asm/abs_addr.h>
+#include <asm/firmware.h>
 #include <asm/iseries/vio.h>
 #include <asm/iseries/mf.h>
 #include <asm/iseries/hv_lp_config.h>
@@ -1235,6 +1236,9 @@ static int __init mf_proc_init(void)
 	char name[2];
 	int i;
 
+	if (!firmware_has_feature(FW_FEATURE_ISERIES))
+		return 0;
+
 	mf_proc_root = proc_mkdir("iSeries/mf", NULL);
 	if (!mf_proc_root)
 		return 1;
-- 
1.4.4.3
