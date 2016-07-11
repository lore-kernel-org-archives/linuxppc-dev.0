Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rp1Kk6Z4HzDqxP
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 20:19:22 +1000 (AEST)
In-Reply-To: <1467202586-13412-2-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, mikey <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org, Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [2/2] cxl: Fix allocating a minimum of 2 pages for the SPA
Message-Id: <3rp1Kk4Pgcz9t14@ozlabs.org>
Date: Mon, 11 Jul 2016 20:19:22 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-29-06 at 12:16:26 UTC, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> The Scheduled Process Area is allocated dynamically with enough pages to
> fit at least as many processes as the AFU descriptor indicated. Since
> the calculation is non-trivial, it does this by calculating how many
> processes could fit in an allocation of a given order, and increasing
> that order until it can fit enough processes or hits the maximum
> supported size.
> 
> Currently, it will start this search using a SPA of 2 pages instead of
> 1. This can waste a page of memory if the AFU's maximum number of
> supported processes was small enough to fit in one page.
> 
> Fix the algorithm to start the search at 1 page.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2224b6719b09052a9fbf29422a

cheers
