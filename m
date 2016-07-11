Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rp1Kh3XNGzDqxP
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 20:19:20 +1000 (AEST)
In-Reply-To: <1467202586-13412-1-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, mikey <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org, Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [1/2] cxl: Fix allowing bogus AFU descriptors with 0 maximum
 processes
Message-Id: <3rp1Kh2hZCz9t0v@ozlabs.org>
Date: Mon, 11 Jul 2016 20:19:20 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-29-06 at 12:16:25 UTC, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> If the AFU descriptor of an AFU directed AFU indicates that it supports
> 0 maximum processes, we will accept that value and attempt to use it.
> The SPA will still be allocated (with 2 pages due to another minor bug
> and room for 958 processes), and when a context is allocated we will
> pass the value of 0 to idr_alloc as the maximum. However, idr_alloc will
> treat that as meaning no maximum and will allocate a context number and
> we return a valid context.
> 
> Conceivably, this could lead to a buffer overflow of the SPA if more
> than 958 contexts were allocated, however this is mitigated by the fact
> that there are no known AFUs in the wild with a bogus AFU descriptor
> like this, and that only the root user is allowed to flash an AFU image
> to a card.
> 
> Add a check when validating the AFU descriptor to reject any with 0
> maximum processes.
> 
> We do still allow a dedicated process only AFU to indicate that it
> supports 0 contexts even though that is forbidden in the architecture,
> as in that case we ignore the value and use 1 instead. This is just on
> the off-chance that such a dedicated process AFU may exist (not that I
> am aware of any), since their developers are less likely to have cared
> about this value at all.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/49e9c99f47fc43abc9598f9fcf

cheers
