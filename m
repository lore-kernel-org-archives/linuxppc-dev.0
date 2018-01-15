Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKvNv2KLPzF0YW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 00:30:22 +1100 (AEDT)
From: Michal Suchanek <msuchanek@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.de>, "Tobin C. Harding" <me@tobin.cc>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/pseries: include linux/types.h in asm/hvcall.h
Date: Mon, 15 Jan 2018 14:30:03 +0100
Message-Id: <20180115133003.3447-1-msuchanek@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 6e032b350cd1 ("powerpc/powernv: Check device-tree for RFI flush
settings") uses u64 in asm/hvcall.h without including linux/types.h

This breaks hvcall.h users that do not include the header themselves.

Fixes: 6e032b350cd1 ("powerpc/powernv: Check device-tree for RFI flush
    settings")

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/include/asm/hvcall.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index f0461618bf7b..eca3f9c68907 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -353,6 +353,7 @@
 #define PROC_TABLE_GTSE		0x01
 
 #ifndef __ASSEMBLY__
+#include <linux/types.h>
 
 /**
  * plpar_hcall_norets: - Make a pseries hypervisor call with no return arguments
-- 
2.13.6
