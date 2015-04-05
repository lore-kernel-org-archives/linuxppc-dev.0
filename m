Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A2DF1A0B9B
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Apr 2015 22:26:16 +1000 (AEST)
Message-ID: <1428236761.20500.315.camel@kernel.crashing.org>
Subject: Re: [PATCHv9 RFC 1/3] Break up monolithic iommu table/lock into
 finer graularity pools and lock
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Sun, 05 Apr 2015 22:26:01 +1000
In-Reply-To: <a259c5bbc3d98dbaedc73a88250a5e7c937ec5f9.1428181553.git.sowmini.varadhan@oracle.com>
References: <cover.1428181553.git.sowmini.varadhan@oracle.com>
 <a259c5bbc3d98dbaedc73a88250a5e7c937ec5f9.1428181553.git.sowmini.varadhan@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-04-05 at 07:49 -0400, Sowmini Varadhan wrote:
> +               if (likely(pass == 0)) {
> +                       /* First failure, rescan from the beginning.
> */
> +                       pool->hint = pool->start;
> +                       set_flush(iommu);
> +                       pass++;
> +                       goto again;
> +               } else if (!largealloc && pass <= iommu->nr_pools) {
> +                       spin_unlock(&(pool->lock));
> +                       pool_nr = (pool_nr + 1) & (iommu->nr_pools -
> 1);
> +                       pool = &(iommu->pools[pool_nr]);
> +                       spin_lock(&(pool->lock));
> +                       pool->hint = pool->start;
> +                       set_flush(iommu);
> +                       pass++;
> +                       goto again;

So you decided to keep the logic here that updates the hint instead of
just getting rid of need_flush alltogether ?

Out of curiosity, what's the rationale ? Did you find a reason why
resetting the hint in those two cases (rather than just setting "start"
appropriately) is actually useful ?

Cheers,
Ben.
