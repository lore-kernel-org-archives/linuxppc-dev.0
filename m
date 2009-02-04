Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-6.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 28CBCDDEF1
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 12:09:10 +1100 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Eli Cohen <eli@mellanox.co.il>
Subject: FW: [PATCH] powerpc/mm: Export HPAGE_SHIFT
References: <20090203164930.GA10101@mtls03>
Date: Tue, 03 Feb 2009 17:08:54 -0800
In-Reply-To: <20090203164930.GA10101@mtls03> (Eli Cohen's message of "Tue, 3
	Feb 2009 18:49:30 +0200")
Message-ID: <ada8wonnh3t.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Forwarding Eli's patch below, since PowerPC guys may have missed it.  I
guess the question for Ben et al is whether there is any issue with
exporting HPAGE_SHIFT for modules (can be EXPORT_SYMBOL_GPL if you feel
it's an internal detail).  It would probably make sense to roll this
change into the mlx4 change that Eli alludes to below and merge through
my tree (with ppc maintainer acks of course), rather than splitting this
patch out and introducing cross-tree dependencies (and also separating
the rationale for the change from the change itself).

Thanks,
  Roland


Drivers may want to take advantage of the large pages used for memory obtained
from hugetlbfs. One example is mlx4_ib which can use much less MTT entries (in
the order of HPAGE_SIZE / PAGE_SIZE) when registering such memory, thus scale
significantly better when registering larger memory regions. Other drivers
could also benefit from this.

Signed-off-by: Eli Cohen <eli@mellanox.co.il>
---
 arch/powerpc/mm/hash_utils_64.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 8d5b475..6cff8c7 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -104,6 +104,7 @@ int mmu_highuser_ssize = MMU_SEGSIZE_256M;
 u16 mmu_slb_size = 64;
 #ifdef CONFIG_HUGETLB_PAGE
 unsigned int HPAGE_SHIFT;
+EXPORT_SYMBOL(HPAGE_SHIFT);
 #endif
 #ifdef CONFIG_PPC_64K_PAGES
 int mmu_ci_restrictions;
-- 
1.6.1
