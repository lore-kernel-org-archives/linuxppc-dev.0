Return-Path: <tony@bakeyournoodle.com>
Date: Wed, 13 Jul 2011 15:57:03 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/3] powerpc/44x: don't use tlbivax on AMP systems
Message-ID: <20110713055703.GI20597@ozlabs.org>
References: <20110705043803.GG13483@ozlabs.org>
	<D1C71884-DD31-4F3C-8BF5-C6DB3BF4EC8F@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <D1C71884-DD31-4F3C-8BF5-C6DB3BF4EC8F@kernel.crashing.org>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>,
	LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 13, 2011 at 12:48:21AM -0500, Kumar Gala wrote:
> 
> On Jul 4, 2011, at 11:38 PM, Tony Breeds wrote:
> 
> > +#ifdef CONFIG_PPC_47x
> > +void __init early_init_mmu_47x(void)
> > +{
> > +#ifdef CONFIG_SMP
> > +	unsigned long root = of_get_flat_dt_root();
> > +	if (of_get_flat_dt_prop(root, "cooperative-partition", NULL))
> > +		mmu_clear_feature(MMU_FTR_USE_TLBIVAX_BCAST);
> > +#endif /* CONFIG_SMP */
> > +}
> > +#endif /* CONFIG_PPC_47x */
> > +
> 
> Is this device tree prop spec'd anywhere?

I don't think this has been formally written up, but this was discussed in Feb.
this year http://patchwork.ozlabs.org/patch/81355/

Yours Tony
