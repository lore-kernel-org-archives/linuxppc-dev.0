Return-Path: <boutcher@cs.umn.edu>
Received: from mail.cs.umn.edu (mail.cs.umn.edu [128.101.35.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.cs.umn.edu",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 282FC67B8F
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 01:51:23 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17552.7568.609704.956810@hound.rchland.ibm.com>
Date: Wed, 14 Jun 2006 09:30:40 -0500
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: [PATCH 0/3] powerpc: Instrument Hypervisor Calls: add sysfs files
In-Reply-To: <20060614035420.GD6759@monkey.ibm.com>
References: <20060614034756.GA6759@monkey.ibm.com>
	<20060614035420.GD6759@monkey.ibm.com>
From: boutcher@cs.umn.edu (Dave C Boutcher)
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

On Tue, 13 Jun 2006 20:54:20 -0700, Mike Kravetz <kravetz@us.ibm.com> said:
> 
> Make statistics available via files in sysfs.
> -- 
> Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
> 
> 
> diff -Naupr linux-2.6.17-rc6/arch/powerpc/kernel/sysfs.c linux-2.6.17-rc6.work/arch/powerpc/kernel/sysfs.c
> --- linux-2.6.17-rc6/arch/powerpc/kernel/sysfs.c	2006-06-06 00:57:02.000000000 +0000
> +++ linux-2.6.17-rc6.work/arch/powerpc/kernel/sysfs.c	2006-06-13 21:42:32.000000000 +0000
> @@ -356,6 +356,39 @@ static ssize_t show_physical_id(struct s
>  }
>  static SYSDEV_ATTR(physical_id, 0444, show_physical_id, NULL);
>  
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
> +

You're violating the "one value per file" rule for sysfs.  Ware the
wrath of Greg KH.

Dave B
