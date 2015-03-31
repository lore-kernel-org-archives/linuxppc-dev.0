Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F7A51A03DB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 21:56:37 +1100 (AEDT)
In-Reply-To: <1424715500-21725-1-git-send-email-sudeep.holla@arm.com>
To: Sudeep Holla <Sudeep.Holla@arm.com>, linux-kernel@vger.kernel.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC/RFT,
 RESEND] powerpc: move cacheinfo sysfs to generic cacheinfo
 infrastructure
Message-Id: <20150331105637.39B451400DE@ozlabs.org>
Date: Tue, 31 Mar 2015 21:56:37 +1100 (AEDT)
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Sudeep Holla <sudeep.holla@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-23-02 at 18:18:20 UTC, Sudeep Holla wrote:
> This patch removes the redundant sysfs cacheinfo code by reusing
> the newly introduced generic cacheinfo infrastructure through the
> commit 246246cbde5e ("drivers: base: support cpu cache information
> interface to userspace via sysfs")
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/kernel/cacheinfo.c | 811 +++++-----------------------------------
>  arch/powerpc/kernel/cacheinfo.h |   8 -
>  arch/powerpc/kernel/sysfs.c     |  12 +-
>  3 files changed, 91 insertions(+), 740 deletions(-)
>  delete mode 100644 arch/powerpc/kernel/cacheinfo.h
> 
> Hi,
> 
> This patch is not tested. Last time Anshuman tested, he had seen issues.
> The core driver has changed a lot after that. Since PPC depends a lot
> on DT for cache information, there might be issues in the core later
> which I could not identify with ARM/ARM64. It would be much appreciable
> if someone help me in testing and fixing those so that PPC can migrate
> to new/common cacheinfo infrastructure. This resend is rebased on v4.0-rc1

Doesn't build for me.

  arch/powerpc/platforms/pseries/suspend.c:29:36: fatal error: ../../kernel/cacheinfo.h: No such file or directory
  #include "../../kernel/cacheinfo.h"

Anshuman must have worked around that somehow to test it previously?

Removing the include doesn't fix it, it needs cacheinfo_cpu_on/offline().

cheers
