Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3stXtR45KnzDskm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 21:15:11 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: jstancek@redhat.com,
	kda@linux-powerpc.org,
	benh@kernel.crashing.org
Subject: [PATCH] powerpc/mm/hash64: Fix might_have_hea() check
Date: Tue, 11 Oct 2016 21:15:04 +1100
Message-Id: <1476180904-19466-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 2b4e3ad8f579 ("powerpc/mm/hash64: Don't test for machine type
to detect HEA special case") we changed the logic in might_have_hea()
to check FW_FEATURE_SPLPAR rather than machine_is(pseries).

However the check was incorrectly negated, leading to crashes on
machines with HEA adapters, such as:

  mm: Hashing failure ! EA=0xd000080080004040 access=0x800000000000000e current=NetworkManager
      trap=0x300 vsid=0x13d349c ssize=1 base psize=2 psize 2 pte=0xc0003cc033e701ae
  Unable to handle kernel paging request for data at address 0xd000080080004040
  Call Trace:
    .ehea_create_cq+0x148/0x340 [ehea] (unreliable)
    .ehea_up+0x258/0x1200 [ehea]
    .ehea_open+0x44/0x1a0 [ehea]
    ...

Fix it by removing the negation.

Fixes: 2b4e3ad8f579 ("powerpc/mm/hash64: Don't test for machine type to detect HEA special case")
Cc: stable@vger.kernel.org # v4.8+
Reported-by: Denis Kirjanov <kda@linux-powerpc.org>
Reported-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/hash_utils_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 90480e23fd2c..44d3c3a38e3e 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -529,7 +529,7 @@ static bool might_have_hea(void)
 	 */
 #ifdef CONFIG_IBMEBUS
 	return !cpu_has_feature(CPU_FTR_ARCH_207S) &&
-		!firmware_has_feature(FW_FEATURE_SPLPAR);
+		firmware_has_feature(FW_FEATURE_SPLPAR);
 #else
 	return false;
 #endif
-- 
2.7.4
