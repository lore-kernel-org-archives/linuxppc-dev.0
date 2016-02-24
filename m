Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E41091A0776
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 01:35:17 +1100 (AEDT)
In-Reply-To: <1455253387-478-1-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: powerpc/eeh: Fix partial hotplug criterion
Message-Id: <20160224143517.64011140BFD@ozlabs.org>
Date: Thu, 25 Feb 2016 01:35:17 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-12-02 at 05:03:05 UTC, Gavin Shan wrote:
> During error recovery, the device could be removed as part of the
> partial hotplug. The criterion used to come with partial hotplug
> is: if the device driver provides error_detected(), slot_reset()
> and resume() callbacks, it's immune from hotplug. Otherwise,
> it's going to experience partial hotplug during EEH recovery. But
> the criterion isn't correct enough: mlx4_core driver for Mellanox
> adapters provides error_detected(), slot_reset() callbacks, but
> resume() isn't there. Those Mellanox adapters won't be to involved
> in the partial hotplug.
> 
> This fixes the criterion to a practical one: adpater with driver
> that provides error_detected(), slot_reset() will be immune from
> partial hotplug. resume() isn't mandatory.
> 
> Fixes: f2da4ccf ("powerpc/eeh: More relaxed hotplug criterion")
> Cc: stable@vger.kernel.org #v4.4+
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/f6bf0fa14cf848ae770e0b7842

cheers
