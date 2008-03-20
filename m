Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 9089FDDE2A
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 18:19:33 +1100 (EST)
Date: Thu, 20 Mar 2008 02:18:58 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH 2/2] Force 4K IOPages when eHEA is present in the machine.
Message-ID: <20080320071858.GS4712@localdomain>
References: <63cdefde19cb2a4adc17ed771f21261673428ce7.1205987625.git.tony@bakeyournoodle.com>
	<262bc32afdde978922b9500c2a83f7c7ed6e4043.1205987625.git.tony@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <262bc32afdde978922b9500c2a83f7c7ed6e4043.1205987625.git.tony@bakeyournoodle.com>
Cc: Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Olof,
	Jan-Bernd Themann <themann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tony Breeds wrote:
> 
> +#if defined(CONFIG_PPC_PSERIES) && defined(CONFIG_PPC_64K_PAGES)
> +static int __init scan_dt_for_ehea(unsigned long node, const char *uname,
> +                                  int depth, void *data)
> +{
> +	if (depth != 0)
> +		return 0;
> +
> +	if (of_flat_dt_search(node, "HEA ", "ibm,drc-names"))
> +		return 1;
> +
> +	return 0;
> +}
> +#endif

Searching ibm,drc-names is necessary, but is it sufficient?  That is,
can there be a system that has an HEA adapter without that property
being present?  Thinking in particular about single-partition systems
that run without an HMC attached.


>  static void __init htab_init_page_sizes(void)
>  {
>  	int rc;
> +#ifdef CONFIG_PPC_64K_PAGES
> +	int has_ehea = 0;
> +#endif
>  
>  	/* Default to 4K pages only */
>  	memcpy(mmu_psize_defs, mmu_psize_defaults_old,
>  	       sizeof(mmu_psize_defaults_old));
>  
> +#if defined(CONFIG_PPC_PSERIES) && defined(CONFIG_PPC_64K_PAGES)
> +	/* Scan to see if this system can have an EHEA, if so we'll
> +	 * demote io_psize to 4K */
> +	has_ehea = of_scan_flat_dt(scan_dt_for_ehea, NULL);
> +#endif

I'm wondering if some of the ifdef stuff could be avoided if you used
a firmware feature bit to signify the limitation (or the lack of it).
The bit could be set during pSeries_probe.  Just an idea; I don't feel
that strongly about it.
