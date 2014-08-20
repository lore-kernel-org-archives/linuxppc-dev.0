Return-Path: <bobby.prani@gmail.com>
Received: from mail-yh0-x235.google.com (mail-yh0-x235.google.com
 [IPv6:2607:f8b0:4002:c01::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FEBA1A0037
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 13:24:18 +1000 (EST)
Received: by mail-yh0-f53.google.com with SMTP id c41so6484912yho.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 20:24:15 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Grant Likely <grant.likely@linaro.org>,
 linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC...),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] powerpc: Export dcr_ind_lock to fix build error
Date: Tue, 19 Aug 2014 23:24:15 -0400
Message-Id: <1408505056-24248-1-git-send-email-bobby.prani@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix build error caused by missing export:

ERROR: "dcr_ind_lock" [drivers/net/ethernet/ibm/emac/ibm_emac.ko] undefined!

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 arch/powerpc/sysdev/dcr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/sysdev/dcr.c b/arch/powerpc/sysdev/dcr.c
index e9056e4..2d8a101 100644
--- a/arch/powerpc/sysdev/dcr.c
+++ b/arch/powerpc/sysdev/dcr.c
@@ -230,5 +230,6 @@ EXPORT_SYMBOL_GPL(dcr_unmap_mmio);
 
 #ifdef CONFIG_PPC_DCR_NATIVE
 DEFINE_SPINLOCK(dcr_ind_lock);
+EXPORT_SYMBOL_GPL(dcr_ind_lock);
 #endif	/* defined(CONFIG_PPC_DCR_NATIVE) */
 
-- 
1.9.1
