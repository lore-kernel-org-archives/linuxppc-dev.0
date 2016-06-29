Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfY5h0qgZzDr0H
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 16:43:04 +1000 (AEST)
In-Reply-To: <1466743750-28332-1-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, ppaidipe@in.ibm.com
Subject: Re: powerpc/eeh: Fix wrong argument passed to eeh_rmv_device()
Message-Id: <3rfY5g6J1xz9t0r@ozlabs.org>
Date: Wed, 29 Jun 2016 16:43:03 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-24-06 at 04:49:02 UTC, Gavin Shan wrote:
> When calling eeh_rmv_device() in eeh_reset_device() for partial
> hotplug case, @rmv_data instead of its address is the proper
> argument. Otherwise, the stack frame is corrupted when writing
> to @rmv_data (actually its address) in eeh_rmv_device(). It
> results in kernel crash as observed.
> 
> This fixes the issue by passing @rmv_data, not its address to
> eeh_rmv_device() in eeh_reset_device().
> 
> Fixes: 67086e32b564 ("powerpc/eeh: powerpc/eeh: Support error recovery for VF PE")
> Reported-by: Pridhiviraj Paidipeddi <ppaidipe@in.ibm.com>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/cca0e542e02e48cce541a49c40

cheers
