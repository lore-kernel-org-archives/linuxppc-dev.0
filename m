Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 391E267B3C
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 00:42:39 +1000 (EST)
Date: Wed, 14 Jun 2006 09:42:30 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: [PATCH 2/3] powerpc: Instrument Hypervisor Calls: add wrappers
Message-ID: <20060614144230.GE26750@localdomain>
References: <20060614034756.GA6759@monkey.ibm.com>
	<20060614035258.GC6759@monkey.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060614035258.GC6759@monkey.ibm.com>
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

Mike Kravetz wrote:
> +config HCALL_STATS
> +	bool "Hypervisor call instrumentation"
> +	depends on PPC_PSERIES
> +	help
> +	  Adds code to keep track of number of hypervisor calls made and
> +	  the amount of time spent in hypervisor calls.
> +
> +	  This option will add a small amount of overhead to all hypervisor
> +	  calls.

Would be good to say how the stats are made available to userspace
here.


> +DEFINE_PER_CPU(struct hcall_stats[MAX_HCALL_OPCODES+1], hcall_stats);
> +
> +static inline void update_stats(unsigned long opcode, unsigned long t_before)
> +{
> +	unsigned long op_index= opcode >> 2;
> +	struct hcall_stats *hs = &__get_cpu_var(hcall_stats[op_index]);
> +
> +	/* racey, but acceptable for non-critical stats */
> +	hs->total_time += (mfspr(SPRN_PURR) - t_before);
> +	hs->num_calls++;
> +}
> +
> +extern long plpar_hcall_base (unsigned long opcode,
> +                 unsigned long arg1,
> +                 unsigned long arg2,
> +                 unsigned long arg3,
> +                 unsigned long arg4,
> +                 unsigned long *out1,
> +                 unsigned long *out2,
> +                 unsigned long *out3);
> +
> +long plpar_hcall(unsigned long opcode,
> +                 unsigned long arg1,
> +                 unsigned long arg2,
> +                 unsigned long arg3,
> +                 unsigned long arg4,
> +                 unsigned long *out1,
> +                 unsigned long *out2,
> +                 unsigned long *out3)
> +{
> +	long rc;
> +	unsigned long t_before = mfspr(SPRN_PURR);
> +
> +	rc = plpar_hcall_base(opcode, arg1, arg2, arg3, arg4, out1, out2, out3);
> +
> +	update_stats(opcode, t_before);
> +	return rc;
> +}

Without disabling preemption around the mfspr ... update_stats section
in these hcall wrappers, you risk updating the stats on the wrong cpu.


> +struct hcall_stats {
> +	unsigned long	num_calls;
> +	unsigned long	total_time;
> +};

A comment explaining the unit of time used for the total_time field
would be nice.
