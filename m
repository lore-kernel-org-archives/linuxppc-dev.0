Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A08ED2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 09:59:40 +1000 (EST)
Message-ID: <1375747168.13074.100.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 6/8] powerpc: introduce early_get_first_memblock_info
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Date: Mon, 5 Aug 2013 18:59:28 -0500
In-Reply-To: <20130804004531.GD19141@pek-khao-d1.corp.ad.wrs.com>
References: <1372942454-25191-7-git-send-email-haokexin@gmail.com>
 <1374884281.30721.40@snotra>
 <20130804004531.GD19141@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-08-04 at 08:45 +0800, Kevin Hao wrote:
> On Fri, Jul 26, 2013 at 07:18:01PM -0500, Scott Wood wrote:
> > >+ * This function run before early_init_devtree, so we have to init
> > >+ * initial_boot_params. Since early_init_dt_scan_memory_ppc will be
> > >+ * executed again in early_init_devtree, we have to reinitialize the
> > >+ * memblock data before return.
> > >+ */
> > >+void __init early_get_first_memblock_info(void *params,
> > >phys_addr_t *size)
> > >+{
> > >+	/* Setup flat device-tree pointer */
> > >+	initial_boot_params = params;
> > >+
> > >+	/* Scan memory nodes and rebuild MEMBLOCKs */
> > >+	of_scan_flat_dt(early_init_dt_scan_root, NULL);
> > >+	of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
> > >+
> > >+	if (size)
> > >+		*size = first_memblock_size;
> > >+
> > >+	/* Undo what early_init_dt_scan_memory_ppc does to memblock */
> > >+	memblock_reinit();
> > >+}
> > >+#endif
> > 
> > Wouldn't it be simpler to set a flag so that
> > early_init_dt_add_memory_arch() doesn't mess with memblocks on the
> > first pass?
> 
> Do you mean something like this?
> 
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 9a69d2d..e861394 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -523,6 +523,10 @@ static int __init early_init_dt_scan_memory_ppc(unsigned long node,
>  
>  void __init early_init_dt_add_memory_arch(u64 base, u64 size)
>  {
> +#if defined(CONFIG_RELOCATABLE) && defined(CONFIG_FSL_BOOKE)
> +	static int first_time = 1;
> +#endif
> +
>  #ifdef CONFIG_PPC64
>  	if (iommu_is_off) {
>  		if (base >= 0x80000000ul)
> @@ -541,6 +545,13 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
>  	}
>  
>  	/* Add the chunk to the MEMBLOCK list */
> +
> +#if defined(CONFIG_RELOCATABLE) && defined(CONFIG_FSL_BOOKE)
> +	if (first_time) {
> +		first_time = 0;
> +		return;
> +	}
> +#endif
>  	memblock_add(base, size);
>  }

I think it'd be clearer for it to be an external variable that gets set
by the relocation code -- plus, the above wouldn't work if this gets
called twice due to having multiple memory regions.

-Scott
