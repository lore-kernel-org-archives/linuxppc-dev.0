Return-Path: <sonny@kevlar.burdell.org>
Received: from kevlar.burdell.org (kevlar.burdell.org [66.92.73.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7D72767A2E
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jun 2006 22:46:18 +1000 (EST)
Date: Tue, 27 Jun 2006 08:46:09 -0400
From: Sonny Rao <sonny@burdell.org>
To: paulus@samba.org
Subject: [PATCH] powerpc: fix idr locking in init_new_context
Message-ID: <20060627124609.GA2497@kevlar.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


We always need to serialize accesses to mmu_context_idr.

I hit this bug when testing with a small number of mmu contexts.


Signed-off-by: Sonny Rao <sonny@burdell.org>

--- a/arch/powerpc/mm/mmu_context_64.c
+++ b/arch/powerpc/mm/mmu_context_64.c
@@ -44,7 +44,9 @@ again:
                return err;
 
        if (index > MAX_CONTEXT) {
+               spin_lock(&mmu_context_lock);
                idr_remove(&mmu_context_idr, index);
+               spin_unlock(&mmu_context_lock);
                return -ENOMEM;
        }
