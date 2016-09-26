Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjcBV1yZLzDrMD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 07:13:06 +1000 (AEST)
Message-ID: <1474924351.2857.255.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 4/5] powerpc/mm: restore top-down allocation when
 using movable_node
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Reza Arbab <arbab@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Rob Herring
 <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>, Nathan Fontenot
 <nfont@linux.vnet.ibm.com>, Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>, Balbir Singh
 <bsingharora@gmail.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 linux-mm@kvack.org
Date: Tue, 27 Sep 2016 07:12:31 +1000
In-Reply-To: <1474828616-16608-5-git-send-email-arbab@linux.vnet.ibm.com>
References: <1474828616-16608-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1474828616-16608-5-git-send-email-arbab@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-09-25 at 13:36 -0500, Reza Arbab wrote:
> At boot, the movable_node option sets bottom-up memblock allocation.
> 
> This reduces the chance that, in the window before movable memory has
> been identified, an allocation for the kernel might come from a movable
> node. By going bottom-up, early allocations will most likely come from
> the same node as the kernel image, which is necessarily in a nonmovable
> node.
> 
> Then, once any known hotplug memory has been marked, allocation can be
> reset back to top-down. On x86, this is done in numa_init(). This patch
> does the same on power, in numa initmem_init().

That's fragile and a bit gross.

But then I'm not *that* fan of making accelerator memory be "memory" nodes
in the first place. Oh well...

In any case, if the memory hasn't been hotplug, this shouldn't be necessary
as we shouldn't be considering it for allocation.

If we want to prevent it for other reason, we should add logic for that
in memblock, or reserve it early or something like that.

Just relying magically on the direction of the allocator is bad, really bad.

Ben.

> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/numa.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index d7ac419..fdf1e69 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -945,6 +945,9 @@ void __init initmem_init(void)
> >  	max_low_pfn = memblock_end_of_DRAM() >> PAGE_SHIFT;
> >  	max_pfn = max_low_pfn;
>  
> > +	/* bottom-up allocation may have been set by movable_node */
> > +	memblock_set_bottom_up(false);
> +
> >  	if (parse_numa_properties())
> >  		setup_nonnuma();
> >  	else
