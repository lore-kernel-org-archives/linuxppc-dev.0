Return-Path: <pbadari@us.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 65668DE2E1
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jun 2008 05:43:59 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m56Jk2ob017071
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Jun 2008 15:46:02 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m56JhZSJ207862
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Jun 2008 15:43:36 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m56JhYC9031623
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Jun 2008 15:43:35 -0400
Subject: Re: [PATCH 1/2] make walk_memory_resource available with
	MEMORY_HOTPLUG=n
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20080603223054.GC7475@localdomain>
References: <200805071443.20192.hannes.hering@linux.vnet.ibm.com>
	<20080528164405.GA4836@localdomain>
	<200806031007.40162.hannes.hering@linux.vnet.ibm.com>
	<20080603204908.GB7475@localdomain>
	<1212527335.23656.2.camel@badari-desktop> <4845B382.20205@garzik.org>
	<20080603223054.GC7475@localdomain>
Content-Type: text/plain
Date: Fri, 06 Jun 2008 12:43:22 -0700
Message-Id: <1212781402.23656.45.camel@badari-desktop>
Mime-Version: 1.0
Cc: tklein@de.ibm.com, Jeff Garzik <jeff@garzik.org>, themann@de.ibm.com,
	Hannes Hering <hannes.hering@linux.vnet.ibm.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	ossrosch@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
	raisch@de.ibm.com, Paul Mackerras <paulus@samba.org>, ossthema@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-06-03 at 17:30 -0500, Nathan Lynch wrote:
> The ehea driver was recently changed[1] to use walk_memory_resource() to
> detect the system's memory layout.  However, walk_memory_resource() is
> available only when memory hotplug is enabled.  So CONFIG_EHEA was
> made to depend on MEMORY_HOTPLUG [2], but it is inappropriate for a
> network driver to have such a dependency.
> 
> Make the declaration of walk_memory_resource() and its powerpc
> implementation (ehea is powerpc-specific) unconditionally available.
> 
> [1] 48cfb14f8b89d4d5b3df6c16f08b258686fb12ad
>     "ehea: Add DLPAR memory remove support"
> 
> [2] fb7b6ca2b6b7c23b52be143bdd5f55a23b9780c8
>     "ehea: Add dependency to Kconfig"
> 
> Signed-off-by: Nathan Lynch <ntl@pobox.com>
> ---
>  arch/powerpc/mm/mem.c          |    3 +--
>  include/linux/memory_hotplug.h |   16 ++++++++--------
>  2 files changed, 9 insertions(+), 10 deletions(-)
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

Sorry. I couldn't get back earlier.

Acked-by: Badari Pulavarty <pbadari@us.ibm.com>
