Return-Path: <npiggin@gmail.com>
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hDrl2h3YzF22V
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 01:40:06 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id d17-v6so1372468pgv.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Aug 2018 08:40:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH] powernv/cpuidle: Fix idle states all being marked invalid
Date: Fri,  3 Aug 2018 01:39:51 +1000
Message-Id: <20180802153951.3576-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 9c7b185ab2 ("powernv/cpuidle: Parse dt idle properties into
global structure") parses dt idle states into structs, but never
marks them valid. This results in all idle states being lost.

Cc: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/idle.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 3116bab10aa3..ecb002c5db83 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -651,11 +651,12 @@ static int __init pnv_power9_idle_init(void)
 					      &state->psscr_mask,
 					      state->flags);
 		if (err) {
-			state->valid = false;
 			report_invalid_psscr_val(state->psscr_val, err);
 			continue;
 		}
 
+		state->valid = true;
+
 		if (max_residency_ns < state->residency_ns) {
 			max_residency_ns = state->residency_ns;
 			pnv_deepest_stop_psscr_val = state->psscr_val;
-- 
2.17.0
