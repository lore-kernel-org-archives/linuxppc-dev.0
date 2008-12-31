Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id AF8F0DDE0A
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 14:12:58 +1100 (EST)
Date: Wed, 31 Dec 2008 14:12:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Hoang-Nam Nguyen <hnguyen@de.ibm.com>, Christoph Raisch <raisch@de.ibm.com>
Subject: [PATCH] infiniband/ehca: spin_lock_irqsave takes an unsigned long
Message-Id: <20081231141257.9bafac41.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Heiko J Schick <schickhj@de.ibm.com>,
	Joachim Fenkes <fenkes@de.ibm.com>, general@lists.openfabrics.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This will also help prevent some warnings when we change u64 to unsigned
long long.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/infiniband/hw/ehca/ehca_main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index 3b77b67..c7b8a50 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -955,7 +955,7 @@ void ehca_poll_eqs(unsigned long data)
 			struct ehca_eq *eq = &shca->eq;
 			int max = 3;
 			volatile u64 q_ofs, q_ofs2;
-			u64 flags;
+			unsigned long flags;
 			spin_lock_irqsave(&eq->spinlock, flags);
 			q_ofs = eq->ipz_queue.current_q_offset;
 			spin_unlock_irqrestore(&eq->spinlock, flags);
-- 
1.6.0.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
