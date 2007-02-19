Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17880.61499.932513.926761@cargo.ozlabs.ibm.com>
Date: Mon, 19 Feb 2007 11:32:59 +1100
From: Paul Mackerras <paulus@samba.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [RFC 2/3] zImage: SMP hold
In-Reply-To: <45D7A910.60702@am.sony.com>
References: <45D7A910.60702@am.sony.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand writes:

> +void smp_secondary_hold(unsigned int cpu_id)
> +{
> +	while(!smp_secondary_entry)
> +		(void)0;

Using a barrier() here rather than making smp_secondary_entry volatile
would be better, I think.

Also, what's the lifetime of this code after smp_secondary_entry is
set, i.e. how do we know the kernel running on the primary cpu will
wait for the secondary cpus to have got through this code into the
kernel before it reuses this memory for something else?

Paul.
