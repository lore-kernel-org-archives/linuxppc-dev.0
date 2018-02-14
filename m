Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zh7cg6W51zDqpP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 16:43:47 +1100 (AEDT)
In-Reply-To: <b3202827b5f22e9a7e8f145f83140698911641f7.1518394650.git.sam.bobroff@au1.ibm.com>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/1] powerpc/pseries: Enable RAS hotplug events late
Message-Id: <3zh7cg1KxQz9t5R@ozlabs.org>
Date: Wed, 14 Feb 2018 16:43:47 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-02-12 at 00:19:29 UTC, Sam Bobroff wrote:
> Currently if the kernel receives a memory hot-unplug event early
> enough, it may get stuck in an infinite loop in
> dissolve_free_huge_pages(). This appears as a stall just after:
> 
> pseries-hotplug-mem: Attempting to hot-remove XX LMB(s) at YYYYYYYY
> 
> It appears to be caused by "minimum_order" being uninitialized, due to
> init_ras_IRQ() executing before hugetlb_init().
> 
> To correct this, extract the part of init_ras_IRQ() that enables
> hotplug event processing and place it in the machine_late_initcall
> phase, which is guaranteed to be after hugetlb_init() is called.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/c9dccf1d074a67d36c510845f66398

cheers
