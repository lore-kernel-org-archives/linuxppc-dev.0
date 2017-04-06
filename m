Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzNh3752lzDqJL
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 23:23:31 +1000 (AEST)
In-Reply-To: <20170329171942.14267-1-fbarrat@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/mm: Add missing global TLBI if cxl is active
Message-Id: <3vzNh35lLSz9s8N@ozlabs.org>
Date: Thu,  6 Apr 2017 23:23:31 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-03-29 at 17:19:42 UTC, Frederic Barrat wrote:
> Commit 4c6d9acce1f4 ("powerpc/mm: Add hooks for cxl") converted local
> TLBIs to global if the cxl driver is active. It is necessary because
> the CAPP snoops invalidations to forward them to the PSL on the cxl
> adapter.
> However one path was apparently forgotten. native_flush_hash_range()
> still sends local TLBIs, as found out the hard way recently.
> 
> This patch fixes it by following the same logic as previously: if the
> cxl driver is active, the local TLBIs are 'upgraded' to global.
> 
> Fixes: 4c6d9acce1f4 ("powerpc/mm: Add hooks for cxl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/88b1bf7268f56887ca88eb09c6fb0f

cheers
