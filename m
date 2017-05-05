Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [150.101.137.129])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wK0n66ZkDzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 15:28:58 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [RFC 0/2] powerpc/mm: Mark memory contexts requiring global TLBIs
Date: Fri, 05 May 2017 15:28:56 +1000
Message-ID: <1540900.y2pYiCMOAu@new-mexico>
In-Reply-To: <20170503142906.29220-1-fbarrat@linux.vnet.ibm.com>
References: <20170503142906.29220-1-fbarrat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Frederic,

On Wed, 3 May 2017 04:29:04 PM Frederic Barrat wrote:
> capi2 and opencapi require the TLB invalidations being sent for
> addresses used on the cxl adapter or opencapi device to be global, as
> there's a translation cache in the PSL (for capi2) or NPU (for
> opencapi). The CAPP (for PSL) and NPU snoop the power bus.
>
> This is not new: for the hash memory model, as soon as the cxl driver
> is active, all local TLBIs become global. We need a similar mechanism
> for the radix memory model. This patch tries to improve things a bit
> by flagging the contexts requiring global TLBIs, therefore limiting
> the "upgrade" and not affecting contexts not used by the card.
>
> Alistair: for nvlink2, it is my understanding that all the required
> invalidations are already in place through software mmio/ATSD, i.e. this
> patch is not useful for you.

Not quite true. I would like to drop the global TLBI from the MMU
notifier so will need this to invalidate entries the NMMU cache.

- Alistair

> Submitting as an RFC, since I don't get to touch mmu.h everyday and
> would like to probe people's reaction.
>
>
>
> Frederic Barrat (2):
>   powerpc/mm: Add marker for contexts requiring global TLB invalidations
>   cxl: Mark context requiring global TLBIs
>
>  arch/powerpc/include/asm/book3s/64/mmu.h |  9 +++++++++
>  arch/powerpc/include/asm/tlb.h           | 10 ++++++++--
>  arch/powerpc/mm/mmu_context_book3s64.c   |  1 +
>  drivers/misc/cxl/api.c                   |  5 ++++-
>  drivers/misc/cxl/file.c                  |  5 ++++-
>  5 files changed, 26 insertions(+), 4 deletions(-)
>
>
