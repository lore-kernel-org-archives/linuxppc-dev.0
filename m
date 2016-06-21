Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYTRV26ByzDqDR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 10:40:54 +1000 (AEST)
In-Reply-To: <1462958539-25552-1-git-send-email-oohall@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-mm@kvack.org, Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [v2] powerpc/mm: Ensure "special" zones are empty
Message-Id: <3rYTRT6gDSz9t0f@ozlabs.org>
Date: Tue, 21 Jun 2016 10:40:53 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-11-05 at 09:22:18 UTC, Oliver O'Halloran wrote:
> The mm zone mechanism was traditionally used by arch specific code to
> partition memory into allocation zones. However there are several zones
> that are managed by the mm subsystem rather than the architecture. Most
> architectures set the max PFN of these special zones to zero, however on
> powerpc we set them to ~0ul. This, in conjunction with a bug in
> free_area_init_nodes() results in all of system memory being placed in
> ZONE_DEVICE when enabled. Device memory cannot be used for regular kernel
> memory allocations so this will cause a kernel panic at boot. Given the
> planned addition of more mm managed zones (ZONE_CMA) we should aim to be
> consistent with every other architecture and set the max PFN for these
> zones to zero.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>
> Cc: linux-mm@kvack.org

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3079abe555511031e2ba5d1e21

cheers
