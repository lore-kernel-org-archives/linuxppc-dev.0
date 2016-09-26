Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjcG72H5gzDrLD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 07:16:15 +1000 (AEST)
Message-ID: <1474924541.2857.258.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 5/5] mm: enable CONFIG_MOVABLE_NODE on powerpc
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
Date: Tue, 27 Sep 2016 07:15:41 +1000
In-Reply-To: <1474828616-16608-6-git-send-email-arbab@linux.vnet.ibm.com>
References: <1474828616-16608-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1474828616-16608-6-git-send-email-arbab@linux.vnet.ibm.com>
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
> To create a movable node, we need to hotplug all of its memory into
> ZONE_MOVABLE.
> 
> Note that to do this, auto_online_blocks should be off. Since the memory
> will first be added to the default zone, we must explicitly use
> online_movable to online.
> 
> Because such a node contains no normal memory, can_online_high_movable()
> will only allow us to do the onlining if CONFIG_MOVABLE_NODE is set.
> Enable the use of this config option on PPC64 platforms.

What is that business with a command line argument ? Do that mean that
we'll need some magic command line argument to properly handle LPC memory
on CAPI devices or GPUs ? If yes that's bad ... kernel arguments should
be a last resort.

We should have all the information we need from the device-tree.

Note also that we shouldn't need to create those nodes at boot time,
we need to add the ability to create the whole thing at runtime, we may know
that there's an NPU with an LPC window in the system but we won't know if it's
used until it is and for CAPI we just simply don't know until some PCI device
gets turned into CAPI mode and starts claiming LPC memory...

Ben.

> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
> ---
>  Documentation/kernel-parameters.txt | 2 +-
>  mm/Kconfig                          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index a4f4d69..3d8460d 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -2344,7 +2344,7 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
> >  			that the amount of memory usable for all allocations
> >  			is not too small.
>  
> > > -	movable_node	[KNL,X86] Boot-time switch to enable the effects
> > > +	movable_node	[KNL,X86,PPC] Boot-time switch to enable the effects
> >  			of CONFIG_MOVABLE_NODE=y. See mm/Kconfig for details.
>  
> > >  	MTD_Partition=	[MTD]
> diff --git a/mm/Kconfig b/mm/Kconfig
> index be0ee11..4b19cd3 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -153,7 +153,7 @@ config MOVABLE_NODE
> >  	bool "Enable to assign a node which has only movable memory"
> >  	depends on HAVE_MEMBLOCK
> >  	depends on NO_BOOTMEM
> > -	depends on X86_64
> > +	depends on X86_64 || PPC64
> >  	depends on NUMA
> >  	default n
> >  	help
