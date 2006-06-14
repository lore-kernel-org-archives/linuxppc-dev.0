Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 9EE2967A60
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 00:22:38 +1000 (EST)
Date: Wed, 14 Jun 2006 09:22:23 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: [PATCH 0/3] powerpc: Instrument Hypervisor Calls: add sysfs files
Message-ID: <20060614142223.GD26750@localdomain>
References: <20060614034756.GA6759@monkey.ibm.com>
	<20060614035420.GD6759@monkey.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060614035420.GD6759@monkey.ibm.com>
Cc: Bryan Rosenburg <rosnbrg@us.ibm.com>, linuxppc-dev@ozlabs.org,
	Christopher Yeoh <cyeoh@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Mike-

> +#ifdef CONFIG_HCALL_STATS
> +DECLARE_PER_CPU(struct hcall_stats[MAX_HCALL_OPCODES+1], hcall_stats);
> +
> +static ssize_t show_hcall_stats(struct sys_device *dev, char *buf)
> +{
> +	struct cpu *cpu = container_of(dev, struct cpu, sysdev);
> +	struct hcall_stats *hs = per_cpu(hcall_stats, cpu->sysdev.id);
> +	size_t rc = 0;
> +	size_t b_written = 0;
> +	size_t b_remain = PAGE_SIZE;
> +	unsigned long i;
> +
> +	for (i=0; i<MAX_HCALL_OPCODES+1; i++){

Coding style:
                  i < MAX_HCALL_OPCODES + 1

> +		if (!hs[i].num_calls)
> +			continue;
> +
> +		b_written = snprintf(buf+rc, b_remain,
> +				"%lu %lu %lu\n",
> +				i<<2, hs[i].num_calls, hs[i].total_time);
> +
> +		if (b_written >= b_remain)
> +			break;	/* end of buffer */
> +
> +		rc += b_written;
> +		b_remain -= b_written;
> +	}
> +
> +	return rc;
> +}

This flagrantly violates the one-value-per-file rule for sysfs. ;)

Maybe debugfs or some other mechanism would be more appropriate.

Do we not run the risk of having output truncated after the system has
been up for a while and has done a few million hcalls?

> +
> +static SYSDEV_ATTR(hcall_stats, 0666, show_hcall_stats, NULL);

Mode should be 0444 or 0400, no need to have write permissions.

> +#endif /* CONFIG_HCALL_STATS */
> +
>  static int __init topology_init(void)
>  {
>  	int cpu;
> @@ -390,6 +423,9 @@ static int __init topology_init(void)
>  			register_cpu(c, cpu, parent);
>  
>  			sysdev_create_file(&c->sysdev, &attr_physical_id);
> +#ifdef CONFIG_HCALL_STATS
> +			sysdev_create_file(&c->sysdev, &attr_hcall_stats);
> +#endif

Let's not create the file on non-lpar systems.
