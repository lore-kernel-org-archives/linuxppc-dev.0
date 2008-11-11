Return-Path: <hollisb@us.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B2C31DDE2A
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 11:33:50 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id mAB0XiUa003953
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Nov 2008 19:33:44 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mAB0XiBj162484
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Nov 2008 19:33:44 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mAB0XhCe021838
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Nov 2008 19:33:44 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] powerpc: remove WARN_ON() from dma-noncoherent.c
Message-Id: <2094bb9371fc6b6c228b.1226363616@localhost.localdomain>
Date: Mon, 10 Nov 2008 18:33:36 -0600
From: Hollis Blanchard <hollisb@us.ibm.com>
To: vitb@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I can't tell why this WARN_ON exists, and there's no comment explaining it.
Whether the pmd is present or not, pte_alloc_kernel() seems to handle both
cases.

Booting a 440 kernel with 64K PAGE_SIZE triggers the warning, but boot
successfully completes and I see no problems beyond that.

Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>

---

Large page support is critical for improving KVM performance, so I'd like this
apparently unnecessary warning to be removed to make way for Ilya's patch.

Vitaly, this code was added by you in Feb 2007. Any thoughts?

diff --git a/arch/powerpc/lib/dma-noncoherent.c b/arch/powerpc/lib/dma-noncoherent.c
--- a/arch/powerpc/lib/dma-noncoherent.c
+++ b/arch/powerpc/lib/dma-noncoherent.c
@@ -320,7 +320,6 @@ static int __init dma_alloc_init(void)
 			ret = -ENOMEM;
 			break;
 		}
-		WARN_ON(!pmd_none(*pmd));
 
 		pte = pte_alloc_kernel(pmd, CONSISTENT_BASE);
 		if (!pte) {
