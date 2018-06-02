Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ydkN1kWzzF0mQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 21:09:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH stable 4.9 02/23] powerpc/pseries: Support firmware disable of
 RFI flush
Date: Sat,  2 Jun 2018 21:08:47 +1000
Message-Id: <20180602110908.29773-3-mpe@ellerman.id.au>
In-Reply-To: <20180602110908.29773-1-mpe@ellerman.id.au>
References: <20180602110908.29773-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 582605a429e20ae68fd0b041b2e840af296edd08 upstream.

Some versions of firmware will have a setting that can be configured
to disable the RFI flush, add support for it.

Fixes: 8989d56878a7 ("powerpc/pseries: Query hypervisor for RFI flush settings")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 1845fc611912..0982e13b2942 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -473,7 +473,8 @@ static void pseries_setup_rfi_flush(void)
 		if (types == L1D_FLUSH_NONE)
 			types = L1D_FLUSH_FALLBACK;
 
-		if (!(result.behaviour & H_CPU_BEHAV_L1D_FLUSH_PR))
+		if ((!(result.behaviour & H_CPU_BEHAV_L1D_FLUSH_PR)) ||
+		    (!(result.behaviour & H_CPU_BEHAV_FAVOUR_SECURITY)))
 			enable = false;
 	} else {
 		/* Default to fallback if case hcall is not available */
-- 
2.14.1
