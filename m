Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpFVs6WfCzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 14:27:49 +1000 (AEST)
Date: Mon, 18 Apr 2016 14:27:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jiri Kosina <jikos@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Axtens
 <dja@axtens.net>
Subject: linux-next: manual merge of the livepatching tree with the powerpc
 tree
Message-ID: <20160418142749.3a5910c6@canb.auug.org.au>
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

Hi Jiri,

Today's linux-next merge of the livepatching tree got a conflict in:

  arch/powerpc/kernel/process.c

between commit:

  7f92bc569455 ("powerpc: sparse: Include headers for __weak symbols")

from the powerpc tree and commit:

  5d31a96e6c01 ("powerpc/livepatch: Add livepatch stack to struct thread_info")

from the livepatching tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/kernel/process.c
index 4695088e7dd2,a290ee374aa0..000000000000
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@@ -56,7 -55,8 +56,9 @@@
  #include <asm/firmware.h>
  #endif
  #include <asm/code-patching.h>
 +#include <asm/exec.h>
+ #include <asm/livepatch.h>
+ 
  #include <linux/kprobes.h>
  #include <linux/kdebug.h>
  
