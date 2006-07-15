Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 05F3A67BA5
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Jul 2006 10:16:11 +1000 (EST)
Date: Fri, 14 Jul 2006 19:15:45 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: [PATCH 2/3] powerpc: Instrument Hypervisor Calls: add wrappers
Message-ID: <20060715001545.GK19076@localdomain>
References: <20060714233739.GA11487@monkey.ibm.com>
	<20060714234034.GC11487@monkey.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060714234034.GC11487@monkey.ibm.com>
Cc: Bryan Rosenburg <rosnbrg@us.ibm.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>,
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
> +static inline void update_stats(unsigned long opcode, unsigned long t_before)
> +{
> +	unsigned long op_index = opcode >> 2;
> +	struct hcall_stats *hs = &__get_cpu_var(hcall_stats[op_index]);
> +
> +	hs->total_time += (mftb() - t_before);
> +	hs->num_calls++;
> +}
> +
> +/*
> + * plpar_hcall wrapper
> + */
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
> +	unsigned long t_before;
> +
> +	t_before = mftb();
> +	rc = plpar_hcall_base(opcode, arg1, arg2, arg3, arg4, out1, out2, out3);
> +
> +	update_stats(opcode, t_before);
> +	return rc;
> +}

Hmm, isn't it possible that the stats could be corrupted if we process
an interrupt/softirq which does an hcall while the stats are being
updated?  Maybe it's not a show-stopper, but it seems to me that
accuracy could suffer under some workloads.
