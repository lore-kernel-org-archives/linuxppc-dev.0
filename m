Return-Path: <hannes.hering@linux.vnet.ibm.com>
Received: from mtagate8.uk.ibm.com (mtagate8.uk.ibm.com [195.212.29.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 05CACDDED2
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 18:07:50 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate8.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m5387fZJ029574
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jun 2008 08:07:41 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m5387foU2408636
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jun 2008 09:07:41 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m5387ec9002286
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jun 2008 09:07:41 +0100
From: Hannes Hering <hannes.hering@linux.vnet.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 2/3] [2.6.26] ehea: Add dependency to Kconfig
Date: Tue, 3 Jun 2008 10:07:39 +0200
References: <200805071443.20192.hannes.hering@linux.vnet.ibm.com>
	<20080528164405.GA4836@localdomain>
In-Reply-To: <20080528164405.GA4836@localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806031007.40162.hannes.hering@linux.vnet.ibm.com>
Cc: tklein@de.ibm.com, jeff@garzik.org, themann@de.ibm.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	ossrosch@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
	raisch@de.ibm.com, ossthema@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Nathan,

I agree that the ehea cannot be built without MEMORY_HOTPLUG. The problem is
the fact that the ppc walk_memory_resource declaration is in the scope of
MEMORY_HOTPLUG. At the moment I don't have complete overview if the move of the
code as you propose in your patch has any side effects. We probably need to
talk to Badari who provided the walk_memory_resource code. We can also just
throw it onto one of our boxes to see what happens. ;)

Regards

Hannes

On Wednesday 28 May 2008 18:44:05 Nathan Lynch wrote:
> Hello,
> 
> Hannes Hering wrote:
> > The new ehea memory hot plug implementation depends on MEMORY_HOTPLUG.
> > 
> > Signed-off-by: Hannes Hering <hering2@de.ibm.com>
> > ---
> > 
> > diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> > index f90a86b..181cd86 100644
> > --- a/drivers/net/Kconfig
> > +++ b/drivers/net/Kconfig
> > @@ -2440,7 +2440,7 @@ config CHELSIO_T3
> >  
> >  config EHEA
> >  	tristate "eHEA Ethernet support"
> > -	depends on IBMEBUS && INET && SPARSEMEM
> > +	depends on IBMEBUS && INET && SPARSEMEM && MEMORY_HOTPLUG
> >  	select INET_LRO
> >  	---help---
> >  	  This driver supports the IBM pSeries eHEA ethernet adapter.
> 
> I disagree with this change.
> 
> It makes it impossible to build the ehea driver without memory hotplug
> enabled.  Presumably, this commit was intended to work around a build
> break of this sort (with EHEA=m and MEMORY_HOTPLUG=n):
> 
> drivers/net/ehea/ehea_qmr.c: In function 'ehea_create_busmap':
> drivers/net/ehea/ehea_qmr.c:635: error: implicit declaration of function 'walk_memory_resource'
> 
> (some indication of this should have been in the commit message, btw)
> 
> I think this was the wrong way to fix the issue.  EHEA=m and
> MEMORY_HOTPLUG=n is a valid configuration for machines I test.
> 
> Any thoughts on the following, which makes walk_memory_resource()
> available regardless of MEMORY_HOTPLUG's setting?  I've tested it on a
> JS22 (Power6 blade).
> 
> ---
> 
>  arch/powerpc/mm/mem.c          |    3 +--
>  drivers/net/Kconfig            |    2 +-
>  include/linux/memory_hotplug.h |   16 ++++++++--------
>  3 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index f67e118..51f82d8 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -151,6 +151,7 @@ out:
>  	return ret;
>  }
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
> +#endif /* CONFIG_MEMORY_HOTPLUG */
> 
>  /*
>   * walk_memory_resource() needs to make sure there is no holes in a given
> @@ -184,8 +185,6 @@ walk_memory_resource(unsigned long start_pfn, unsigned long nr_pages, void *arg,
>  }
>  EXPORT_SYMBOL_GPL(walk_memory_resource);
> 
> -#endif /* CONFIG_MEMORY_HOTPLUG */
> -
>  void show_mem(void)
>  {
>  	unsigned long total = 0, reserved = 0;
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index dd0ec9e..f4182cf 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -2426,7 +2426,7 @@ config CHELSIO_T3
> 
>  config EHEA
>  	tristate "eHEA Ethernet support"
> -	depends on IBMEBUS && INET && SPARSEMEM && MEMORY_HOTPLUG
> +	depends on IBMEBUS && INET && SPARSEMEM
>  	select INET_LRO
>  	---help---
>  	  This driver supports the IBM pSeries eHEA ethernet adapter.
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 73e3586..ea9f5ad 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -77,14 +77,6 @@ extern int __add_pages(struct zone *zone, unsigned long start_pfn,
>  extern int __remove_pages(struct zone *zone, unsigned long start_pfn,
>  	unsigned long nr_pages);
> 
> -/*
> - * Walk through all memory which is registered as resource.
> - * arg is (start_pfn, nr_pages, private_arg_pointer)
> - */
> -extern int walk_memory_resource(unsigned long start_pfn,
> -			unsigned long nr_pages, void *arg,
> -			int (*func)(unsigned long, unsigned long, void *));
> -
>  #ifdef CONFIG_NUMA
>  extern int memory_add_physaddr_to_nid(u64 start);
>  #else
> @@ -199,6 +191,14 @@ static inline void register_page_bootmem_info_node(struct pglist_data *pgdat)
> 
>  #endif /* ! CONFIG_MEMORY_HOTPLUG */
> 
> +/*
> + * Walk through all memory which is registered as resource.
> + * arg is (start_pfn, nr_pages, private_arg_pointer)
> + */
> +extern int walk_memory_resource(unsigned long start_pfn,
> +			unsigned long nr_pages, void *arg,
> +			int (*func)(unsigned long, unsigned long, void *));
> +
>  extern int add_memory(int nid, u64 start, u64 size);
>  extern int arch_add_memory(int nid, u64 start, u64 size);
>  extern int remove_memory(u64 start, u64 size);
> 
