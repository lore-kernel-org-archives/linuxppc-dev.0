Return-Path: <travis@sgi.com>
Received: from relay.sgi.com (netops-testserver-4-out.sgi.com [192.48.171.29])
	by ozlabs.org (Postfix) with ESMTP id 0CC1FDDE26
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 05:33:09 +1000 (EST)
Message-ID: <4703EBE0.7080106@sgi.com>
Date: Wed, 03 Oct 2007 12:22:08 -0700
From: Mike Travis <travis@sgi.com>
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH 08/10] ia64: Convert cpu_sibling_map to a per_cpu data
	array (v3)
References: <20070912015644.927677070@sgi.com>	<20070912015647.214306428@sgi.com>
	<20070928024901.24ab6c99.pj@sgi.com>
In-Reply-To: <20070928024901.24ab6c99.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mm@kvack.org, ak@suse.de, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	akpm@linux-foundation.org, clameter@sgi.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

I just now found this.  I'll take a look immediately.  I tried it
on a couple of systems but not margin. 

Thanks,
Mike

Paul Jackson wrote:
> Mike,
> 
> I think there is a bug either in this ia64 patch, or in the related
> generic arch patch: Convert cpu_sibling_map to be a per cpu variable
> (v3).
> 
> It dies early in boot on me, on the SGI internal 8 processor IA64
> system that you and I know as 'margin'.  The death is a hard hang, due
> to a corrupt stack, due to a bogus cpu index.
> 
> I haven't tracked it down all the way, but have gotten this far.  If I add
> the following patch, I get a panic on the BUG_ON if I have these two patches
> in 2.6.23-rc8-mm1, but it boots just fine if I don't have these two patches.
> 
> It seems that the "cpu_sibling_map[cpu]" cpumask_t is empty (all zero
> bits) with your two patches applied, but has some non-zero bits
> otherwise, which leads to 'group' being NR_CPUS instead of a useful CPU
> number.  Unfortunately, I have no idea why the "cpu_sibling_map[cpu]"
> cpumask_t is empty -- good luck on that part.
> 
> The patch that catches this bug earlier is this:
> 
> --- 2.6.23-rc8-mm1.orig/kernel/sched.c	2007-09-28 01:42:20.144561024 -0700
> +++ 2.6.23-rc8-mm1/kernel/sched.c	2007-09-28 02:27:14.239075497 -0700
> @@ -5905,6 +5905,7 @@ static int cpu_to_phys_group(int cpu, co
>  #else
>  	group = cpu;
>  #endif
> +	BUG_ON(group == NR_CPUS);
>  	if (sg)
>  		*sg = &per_cpu(sched_group_phys, group);
>  	return group;
> 
> 
