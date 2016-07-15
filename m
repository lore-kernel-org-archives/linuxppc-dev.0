Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrTtt3b8nzDqFR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 20:53:10 +1000 (AEST)
In-Reply-To: <1468444634-1866-3-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Huy Nguyen <huyn@mellanox.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [02/15] cxl: Add cxl_slot_is_supported API
Message-Id: <3rrTtt1ZSCz9sC4@ozlabs.org>
Date: Fri, 15 Jul 2016 20:53:09 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-13-07 at 21:17:01 UTC, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> This extends the check that the adapter is in a CAPI capable slot so
> that it may be called by external users in the kernel API. This will be
> used by the upcoming Mellanox CX4 support, which needs to know ahead of
> time if the card can be switched to cxl mode so that it can leave it in
> PCI mode if it is not.
> 
> This API takes a parameter to check if CAPP DMA mode is supported, which
> it currently only allows on P8NVL systems, since that mode currently has
> issues accessing memory < 4GB on P8, and we cannot realistically avoid
> that.
> 
> This API does not currently check if a CAPP unit is available (i.e. not
> already assigned to another PHB) on P8. Doing so would be racy since it
> is assigned on a first come first serve basis, and so long as CAPP DMA
> mode is not supported on P8 we don't need this, since the only
> anticipated user of this API requires CAPP DMA mode.
> 
> Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4e56f858bdde5cbfb70f61badd

cheers
