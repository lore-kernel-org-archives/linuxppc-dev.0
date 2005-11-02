Return-Path: <dgibson@ozlabs.org>
Date: Wed, 2 Nov 2005 11:06:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: David Woodhouse <dwmw2@infradead.org>
Message-ID: <20051102000644.GB8308@localhost.localdomain>
References: <17253.39993.502458.390760@cargo.ozlabs.ibm.com>
	<1130860444.21212.52.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1130860444.21212.52.camel@hades.cambridge.redhat.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: please pull the powerpc-merge.git tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 01, 2005 at 03:54:04PM +0000, David Woodhouse wrote:
> On Mon, 2005-10-31 at 15:23 +1100, Paul Mackerras wrote:
> > It is now possible to build kernels for powermac, pSeries, iSeries and
> > maple with ARCH=powerpc, and for powermac, both 32-bit and 64-bit
> > build and run. 
> 
> Hm. Not entirely in line with my experience. Can you share the configs
> you used?

I gather paulus doesn't believe in CONFIG_TAU.

> Using http://david/woodhou.se/powerpc-merge-32.config it doesn't
> actually boot on my powerbook. I'll try it on the Pegasos later or
> tomorrow, where I have a serial console; it dies very early.
> 
> Aside from disabling CONFIG_NVRAM because call_rtas() isn't implemented
> anywhere, I also needed to do this to make that config build:
> 
> --- linux-2.6.14/arch/powerpc/kernel/setup-common.c.orig	2005-11-01 10:14:32.000000000 +0000
> +++ linux-2.6.14/arch/powerpc/kernel/setup-common.c	2005-11-01 10:15:03.000000000 +0000
> @@ -203,11 +203,11 @@ static int show_cpuinfo(struct seq_file 
>  #ifdef CONFIG_TAU_AVERAGE
>  		/* more straightforward, but potentially misleading */
>  		seq_printf(m,  "temperature \t: %u C (uncalibrated)\n",
> -			   cpu_temp(i));
> +			   cpu_temp(cpu_id));
>  #else
>  		/* show the actual temp sensor range */
>  		u32 temp;
> -		temp = cpu_temp_both(i);
> +		temp = cpu_temp_both(cpu_id);
>  		seq_printf(m, "temperature \t: %u-%u C (uncalibrated)\n",
>  			   temp & 0xff, temp >> 16);
>  #endif
> 
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
