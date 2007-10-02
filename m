Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail196-dub-R.bigfish.com (mail-dub.bigfish.com
	[213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EAB06DDF4F
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 06:31:32 +1000 (EST)
Message-ID: <4702A5FE.5000308@am.sony.com>
Date: Tue, 02 Oct 2007 13:11:42 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [RFC] PPC64 Exporting memory information through /proc/iomem
References: <1191346196.6106.20.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1191346196.6106.20.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, anton@au1.ibm.com,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	linux-mm <linux-mm@kvack.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Badari,

Badari Pulavarty wrote:
> Hi Paul & Ben,
> 
> I am trying to get hotplug memory remove working on ppc64.
> In order to verify a given memory region, if its valid or not -
> current hotplug-memory patches used /proc/iomem. On IA64 and
> x86-64 /proc/iomem shows all memory regions. 
> 
> I am wondering, if its acceptable to do the same on ppc64 also ?
> Otherwise, we need to add arch-specific hooks in hotplug-remove
> code to be able to do this.


It seems the only reasonable place is in /proc/iomem, as the the 
generic memory hotplug routines put it in there, and if you have
a ppc64 system that uses add_memory() you will have mem info in
several places, none of which are complete.  


> Index: linux-2.6.23-rc8/arch/powerpc/mm/numa.c
> ===================================================================
> --- linux-2.6.23-rc8.orig/arch/powerpc/mm/numa.c	2007-10-02 10:16:42.000000000 -0700
> +++ linux-2.6.23-rc8/arch/powerpc/mm/numa.c	2007-10-02 10:17:05.000000000 -0700
> @@ -587,6 +587,22 @@ static void __init *careful_allocation(i
>  	return (void *)ret;
>  }
>  
> +static void add_regions_iomem()
> +{
> +	int i;
> +	struct resource *res;
> +
> +	for (i = 0; i < lmb.memory.cnt; i++) {
> +		res = alloc_bootmem_low(sizeof(struct resource));
> +
> +		res->name = "System RAM";
> +		res->start = lmb.memory.region[i].base;
> +		res->end = res->start + lmb.memory.region[i].size - 1;
> +		res->flags = IORESOURCE_MEM;
> +		request_resource(&iomem_resource, res);
> +	}
> +}
> +

I think this duplication of the code in register_memory_resource()
is a maintenance concern though.  I wonder if it would be better
to somehow hook your stuff into into the existing memory hotplug
routines.


-Geoff
