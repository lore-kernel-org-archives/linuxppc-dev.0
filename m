Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdG612XWGzDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 14:23:53 +1000 (AEST)
Date: Mon, 27 Jun 2016 14:23:52 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Mahesh
 Salgaonkar <mahesh@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>
Subject: linux-next: manual merge of the kvm-ppc-paulus tree with the
 powerpc tree
Message-ID: <20160627142352.2c1ae65b@canb.auug.org.au>
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

Hi Paul,

Today's linux-next merge of the kvm-ppc-paulus tree got a conflict in:

  arch/powerpc/kernel/traps.c

between commit:

  42f5b4cacd78 ("powerpc: Introduce asm-prototypes.h")

from the powerpc tree and commit:

  fd7bacbca47a ("KVM: PPC: Book3S HV: Fix TB corruption in guest exit path on HMI interrupt")

from the kvm-ppc-paulus tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/kernel/traps.c
index f7e2f2e318bd,9ec95daccad9..000000000000
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@@ -60,7 -60,7 +60,8 @@@
  #include <asm/switch_to.h>
  #include <asm/tm.h>
  #include <asm/debug.h>
 +#include <asm/asm-prototypes.h>
+ #include <asm/hmi.h>
  #include <sysdev/fsl_pci.h>
  
  #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
