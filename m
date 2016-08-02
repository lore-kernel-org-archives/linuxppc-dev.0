Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3MQg2HDdzDqf5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 13:39:55 +1000 (AEST)
Date: Tue, 2 Aug 2016 13:39:54 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Hao
 <haokexin@gmail.com>, Jason Baron <jbaron@akamai.com>
Subject: linux-next: manual merge of the akpm tree with the powerpc tree
Message-ID: <20160802133954.00eac68c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andrew,

Today's linux-next merge of the akpm tree got a conflict in:

  kernel/jump_label.c

between commit:

  e3f91083facb ("jump_label: Make it possible for arches to invoke jump_label_init() earlier")

from the powerpc tree and patch:

   "jump_label: remove bug.h, atomic.h dependencies for HAVE_JUMP_LABEL"

from the akpm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc kernel/jump_label.c
index 85b7105fdd86,20400055f177..000000000000
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@@ -235,9 -279,15 +279,18 @@@ void __init jump_label_init(void
  	struct static_key *key = NULL;
  	struct jump_entry *iter;
  
+ 	/*
+ 	 * Since we are initializing the static_key.enabled field with
+ 	 * with the 'raw' int values (to avoid pulling in atomic.h) in
+ 	 * jump_label.h, let's make sure that is safe. There are only two
+ 	 * cases to check since we initialize to 0 or 1.
+ 	 */
+ 	BUILD_BUG_ON((int)ATOMIC_INIT(0) != 0);
+ 	BUILD_BUG_ON((int)ATOMIC_INIT(1) != 1);
+ 
 +	if (static_key_initialized)
 +		return;
 +
  	jump_label_lock();
  	jump_label_sort_entries(iter_start, iter_stop);
  
