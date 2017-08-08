Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRWWj6D0VzDqjB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 20:55:13 +1000 (AEST)
In-Reply-To: <1501583364-14909-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: anton@samba.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [1/3] powerpc/mm/book3s64: Make KERN_IO_START a variable
Message-Id: <3xRWWj5NXhz9s72@ozlabs.org>
Date: Tue,  8 Aug 2017 20:55:13 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-08-01 at 10:29:22 UTC, Michael Ellerman wrote:
> Currently KERN_IO_START is defined as:
> 
>  #define KERN_IO_START  (KERN_VIRT_START + (KERN_VIRT_SIZE >> 1))
> 
> Although it looks like a constant, both the components are actually
> variables, to allow us to have a different value between Radix and
> Hash with a single kernel.
> 
> However that still requires both Radix and Hash to place the kernel IO
> region at the same location relative to the start and end of the
> kernel virtual region (namely 1/2 way through it), and we'd like to
> change that.
> 
> So split KERN_IO_START out into its own variable, and initialise it
> for Radix and Hash. In the medium term we should be able to
> reconsolidate this, by doing a more involved rearrangement of the
> location of the regions.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/63ee9b2ff9d306efaa61b04b8710fa

cheers
