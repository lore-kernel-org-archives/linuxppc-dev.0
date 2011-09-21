Return-Path: <sfr@canb.auug.org.au>
Received: from calzone.tip.net.au (calzone.tip.net.au
	[IPv6:2402:b800:7003:1::15])
	by ozlabs.org (Postfix) with ESMTP id 72947B6F8F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 21 Sep 2011 15:04:41 +1000 (EST)
Date: Wed, 21 Sep 2011 15:04:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: linux-next: manual merge of the moduleh tree with the powerpc tree
Message-Id: <20110921150439.9f776ec7ea3de37c642d419e@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,

Today's linux-next merge of the moduleh tree got a conflict in
arch/powerpc/mm/tlb_nohash.c between commit 41151e77a4d9 ("powerpc:
Hugetlb for BookE") from the powerpc tree and commit 09773e3bc0e4
("powerpc: include export.h for files using EXPORT_SYMBOL/THIS_MODULE")
from the moduleh tree.

Just context changes. I fixed it up (see below) and can carry the fix as
necessary.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --cc arch/powerpc/mm/tlb_nohash.c
index afc95c7,ab06aea..0000000
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@@ -36,7 -36,7 +36,8 @@@
  #include <linux/spinlock.h>
  #include <linux/memblock.h>
  #include <linux/of_fdt.h>
 +#include <linux/hugetlb.h>
+ #include <linux/export.h>
  
  #include <asm/tlbflush.h>
  #include <asm/tlb.h>
