Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDdTl1yNTzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 22:45:15 +1100 (AEDT)
In-Reply-To: <02d198a9-5e64-74df-ac30-dec0a8a05ecc@linux.vnet.ibm.com>
To: John Allen <jallen@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v3,
 1/3] powerpc/pseries: Make the acquire/release of the drc for memory
 a seperate step
Message-Id: <3vDdTl1N0Rz9s7Q@ozlabs.org>
Date: Thu,  2 Feb 2017 22:45:15 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-01-06 at 19:25:53 UTC, John Allen wrote:
> When adding and removing LMBs we should make the acquire/release of
> the DRC a separate step to allow for a few improvements. First
> this will ensure that LMBs removed during a remove by count operation
> are all available if a error occurs and we need to add them back. By
> first removeing all the LMBs from the kernel before releasing their
> DRCs the LMBs are available to add back should an error occur.
> 
> Also, this will allow for faster re-add operations of memory for
> PRRN event handling since we can skip the unneeded step of having
> to release the DRC and the acquire it back.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Signed-off-by: John Allen <jallen@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c21f515c743687c6c2b3d38227e6ad

cheers
