Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40PrcJ2VTszF1S0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 00:39:12 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: paulus@samba.org,
	aik@ozlabs.ru
Subject: [PATCH 2/5] powerpc/lib: Fix feature fixup test of external branch
Date: Tue, 17 Apr 2018 00:39:02 +1000
Message-Id: <20180416143905.2716-2-mpe@ellerman.id.au>
In-Reply-To: <20180416143905.2716-1-mpe@ellerman.id.au>
References: <20180416143905.2716-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The expected case for this test was wrong, the source of the alternate
code sequence is:

  FTR_SECTION_ELSE
  2:	or	2,2,2
  	PPC_LCMPI	r3,1
  	beq	3f
  	blt	2b
  	b	3f
  	b	1b
  ALT_FTR_SECTION_END(0, 1)
  3:	or	1,1,1
  	or	2,2,2
  4:	or	3,3,3

So when it's patched the '3' label should still be on the 'or 1,1,1',
and the 4 label is irrelevant and can be removed.

Fixes: 362e7701fd18 ("powerpc: Add self-tests of the feature fixup code")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/lib/feature-fixups-test.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/feature-fixups-test.S b/arch/powerpc/lib/feature-fixups-test.S
index f4613118132e..12ff0f673956 100644
--- a/arch/powerpc/lib/feature-fixups-test.S
+++ b/arch/powerpc/lib/feature-fixups-test.S
@@ -167,9 +167,9 @@ globl(ftr_fixup_test6_expected)
 	blt	2b
 	b	3f
 	b	1b
-2:	or	1,1,1
+3:	or	1,1,1
 	or	2,2,2
-3:	or	3,3,3
+	or	3,3,3
 
 
 #if 0
-- 
2.14.1
