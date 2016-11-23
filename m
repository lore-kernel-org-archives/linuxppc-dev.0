Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPJcl4bVxzDvyv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 10:36:07 +1100 (AEDT)
Date: Thu, 24 Nov 2016 10:36:06 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas
 Piggin <npiggin@gmail.com>, "Naveen N. Rao"
 <naveen.n.rao@linux.vnet.ibm.com>
Subject: linux-next: manual merge of the powerpc tree with the powerpc-fixes
 tree
Message-ID: <20161124103606.0333e388@canb.auug.org.au>
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

Hi all,

Today's linux-next merge of the powerpc tree got a conflict in:

  arch/powerpc/include/asm/asm-prototypes.h

between commit:

  9e5f68842276 ("powerpc: Fix missing CRCs, add more asm-prototypes.h declarations")

from the powerpc-fixes tree and commit:

  82de5797a260 ("powerpc: Remove extraneous header from asm-prototypes.h")

from the powerpc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/include/asm/asm-prototypes.h
index e0baba1535e6,dfef1174663e..000000000000
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@@ -13,12 -13,6 +13,11 @@@
   */
  
  #include <linux/threads.h>
- #include <linux/kprobes.h>
 +#include <asm/cacheflush.h>
 +#include <asm/checksum.h>
 +#include <asm/uaccess.h>
 +#include <asm/epapr_hcalls.h>
 +
  #include <uapi/asm/ucontext.h>
  
  /* SMP */
