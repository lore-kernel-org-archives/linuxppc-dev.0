Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zsxZg4fcxzF1mg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2018 15:46:03 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexander.Levin@microsoft.com
Cc: stable@vger.kernel.org,
	linuxppc-dev@ozlabs.org,
	npiggin@gmail.com
Subject: [PATCH v4.1 backport 13/15] powerpc/pseries: include linux/types.h in
 asm/hvcall.h
Date: Fri,  2 Mar 2018 15:45:47 +1100
Message-Id: <20180302044549.14930-14-mpe@ellerman.id.au>
In-Reply-To: <20180302044549.14930-1-mpe@ellerman.id.au>
References: <20180302044549.14930-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michal Suchanek <msuchanek@suse.de>

commit 1b689a95ce7427075f9ac9fb4aea1af530742b7f upstream.

Commit 6e032b350cd1 ("powerpc/powernv: Check device-tree for RFI flush
settings") uses u64 in asm/hvcall.h without including linux/types.h

This breaks hvcall.h users that do not include the header themselves.

Fixes: 6e032b350cd1 ("powerpc/powernv: Check device-tree for RFI flush settings")
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/hvcall.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 51adbde09845..449bbb87c257 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -298,6 +298,7 @@
 #define H_CPU_BEHAV_BNDS_CHK_SPEC_BAR	(1ull << 61) // IBM bit 2
 
 #ifndef __ASSEMBLY__
+#include <linux/types.h>
 
 /**
  * plpar_hcall_norets: - Make a pseries hypervisor call with no return arguments
-- 
2.14.1
