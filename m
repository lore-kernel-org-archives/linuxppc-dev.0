Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2CB3EDDDEB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Nov 2007 04:21:49 +1100 (EST)
Message-ID: <47431799.6010802@scram.de>
Date: Tue, 20 Nov 2007 18:21:29 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] powerpc: Change _tlbie arguments to reflect new API
Content-Type: text/plain; charset=ISO-8859-15
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

A new pid argument has been added to _tlbie for 4xx platforms.
Add this argument to the 8xx path in mem.c, as well. As 8xx
does not need th epid information, this argument can always be 0.

Signed-off-by: Jochen Friedrich <jochen@scram.de>

  CC      arch/powerpc/mm/mem.o
arch/powerpc/mm/mem.c: In function 'update_mmu_cache':
arch/powerpc/mm/mem.c:467: error: too few arguments to function '_tlbie'
make[1]: *** [arch/powerpc/mm/mem.o] Error 1
make: *** [arch/powerpc/mm] Error 2
---
 arch/powerpc/mm/mem.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 81eb96e..e07852e 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -464,7 +464,7 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 		 * we invalidate the TLB here, thus avoiding dcbst
 		 * misbehaviour.
 		 */
-		_tlbie(address);
+		_tlbie(address, 0);
 #endif
 		if (!PageReserved(page)
 		    && !test_bit(PG_arch_1, &page->flags)) {
-- 
1.5.3.4
