Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qk8fQ1QfxzDqBX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 22:35:10 +1000 (AEST)
In-Reply-To: <56BB6F6D.8050806@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [2/3] powerpc/pseries: Update LMB associativity index during
 DLPAR add/remove
Message-Id: <3qk8fP5kHDz9t49@ozlabs.org>
Date: Mon, 11 Apr 2016 22:35:09 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-10-02 at 17:12:13 UTC, Nathan Fontenot wrote:
> The associativity array index specified for a LMB in the device tree,
> /ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory, needs to be updated
> prior to DLPAR adding a LMB and after DLPAR removing a LMB.
> 
> Without doing this step in the DLPAR add process a LMB could be configured
> with the incorrect affinity. For a LMB that was not present at boot the
> affinity index is set to 0xffffffff, which defaults to adding the LMB to
> the first online node since the index is not a valid value. Or, the
> affinity index could contain a stale value if the LMB was present at boot
> but later DLPAR removed and is being DLPAR added back to the system.
> 
> This patch adds a step in the DLPAR add flow to look up the associativity
> index for a LMB prior to adding a LMB and setting the associativity to
> 0xffffffff when a LMB is removed.
> 
> This patch also modifies the DLPAR add/remove flow to no longer do a single
> update of the device tree property after all of the requested DLPAR
> operations are complete and now does a property update during the add
> or remove of each LMB.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bdf5fc6338047cfeba98d2ab62

cheers
