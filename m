Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 498F9DE025
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 16:39:29 +1000 (EST)
Date: Fri, 12 Oct 2007 01:44:55 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [PATCH] powerpc: Fix 1TB segment detection
Message-ID: <20071012064455.GA30829@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Buglet in the 1TB detection makes it return after checking the first
property word, even if it's not a match.

Signed-off-by: Olof Johansson <olof@lixom.net>


diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 611ad08..09da90b 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -209,8 +209,8 @@ static int __init htab_dt_scan_seg_sizes(unsigned long node,
 		if (prop[0] == 40) {
 			DBG("1T segment support detected\n");
 			cur_cpu_spec->cpu_features |= CPU_FTR_1T_SEGMENT;
+			return 1;
 		}
-		return 1;
 	}
 	return 0;
 }
