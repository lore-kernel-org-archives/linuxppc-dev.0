Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18346.21469.512910.93325@cargo.ozlabs.ibm.com>
Date: Thu, 7 Feb 2008 11:42:05 +1100
From: Paul Mackerras <paulus@samba.org>
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH 2/8] pseries: phyp dump: reserve-release proof-of-concept
In-Reply-To: <47964422.7080505@austin.ibm.com>
References: <4796401D.5010907@austin.ibm.com> <47964422.7080505@austin.ibm.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linasvepstas@gmail.com,
	Larry Kessler <lkessler@us.ibm.com>,
	Michael Strosaker <strosake@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Manish Ahuja writes:

> Initial patch for reserving memory in early boot, and freeing it later.
> If the previous boot had ended with a crash, the reserved memory would contain
> a copy of the crashed kernel data.

[snip]

> +static void __init reserve_crashed_mem(void)
> +{
> +	unsigned long base, size;
> +
> +	if (phyp_dump_info->phyp_dump_is_active) {
> +		/* Reserve *everything* above RMR. We'll free this real soon.*/
> +		base = PHYP_DUMP_RMR_END;
> +		size = lmb_end_of_DRAM() - base;
> +
> +		/* XXX crashed_ram_end is wrong, since it may be beyond
> +	 	* the memory_limit, it will need to be adjusted. */
> +		lmb_reserve(base, size);
> +
> +		phyp_dump_info->init_reserve_start = base;
> +		phyp_dump_info->init_reserve_size = size;
> +	}
> +	else {
> +		size = phyp_dump_info->cpu_state_size +
> +			phyp_dump_info->hpte_region_size +
> +			PHYP_DUMP_RMR_END;
> +		base = lmb_end_of_DRAM() - size;
> +	printk(KERN_ERR "Manish reserve regular kernel space is %ld %ld\n", base, size);
> +		lmb_reserve(base, size);

This is still reserving memory even on systems that aren't running on
pHyp at all.  Please rework this so that no memory is reserved if the
system doesn't support phyp-assisted dump.

Paul.
