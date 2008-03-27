Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id BCD85DDFA3
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 11:40:03 +1100 (EST)
Message-ID: <47EAEC52.6040105@am.sony.com>
Date: Wed, 26 Mar 2008 17:37:38 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 2/6] PS3: Add ps3_get_speid routine
References: <20080327001821.827672589@am.sony.com>
In-Reply-To: <20080327001821.827672589@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Takashi Yamamoto <TakashiA.Yamamoto@jp.sony.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Takashi Yamamoto <TakashiA.Yamamoto@jp.sony.com>

Add a new routine ps3_get_speid() which returns the logical
SPE ID.  This ID is needed for profiling support.

Signed-off-by: Takashi Yamamoto <TakashiA.Yamamoto@jp.sony.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/spu.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/powerpc/platforms/ps3/spu.c
+++ b/arch/powerpc/platforms/ps3/spu.c
@@ -27,6 +27,7 @@
 #include <asm/spu.h>
 #include <asm/spu_priv1.h>
 #include <asm/lv1call.h>
+#include <asm/ps3.h>
 
 #include "../cell/spufs/spufs.h"
 #include "platform.h"
@@ -140,6 +141,12 @@ static void _dump_areas(unsigned int spe
 	pr_debug("%s:%d: shadow:  %lxh\n", func, line, shadow);
 }
 
+inline u64 ps3_get_spe_id(void *arg)
+{
+	return spu_pdata(arg)->spe_id;
+}
+EXPORT_SYMBOL_GPL(ps3_get_spe_id);
+
 static unsigned long get_vas_id(void)
 {
 	unsigned long id;

-- 
