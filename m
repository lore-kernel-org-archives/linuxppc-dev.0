Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjgLd23qHzDqRM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 21:36:25 +1000 (AEST)
In-Reply-To: <20170828083544.16514-1-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [v2] powerpc/mm/cxl: Add barrier when setting mm cpumask
Message-Id: <3xjgLc6yGrz9t3R@ozlabs.org>
Date: Thu, 31 Aug 2017 21:36:24 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-08-28 at 08:35:44 UTC, "Aneesh Kumar K.V" wrote:
> We need to add memory barrier so that the page table walk doesn't happen
> before the cpumask is set and made visible to the other cpus. We need
> to use a sync here instead of lwsync because lwsync is not sufficient for
> store/load ordering.
> 
> We also need to add an if (mm) check so that we do the right thing when called
> with a kernel context. For kernel context, we have mm = NULL. W.r.t kernel
> address we can skip setting the mm cpumask.
> 
> Fixes: 0f4bc0932e ("powerpc/mm/cxl: Add the fault handling cpu to mm cpumask")
> Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/22259a6e800cdb8e06e65432fcd019

cheers
