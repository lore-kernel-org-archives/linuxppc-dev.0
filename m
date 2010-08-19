Return-Path: <ankita@in.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp02.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A3672B70FD
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Aug 2010 01:58:31 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp02.in.ibm.com (8.14.4/8.13.1) with ESMTP id o7JFwRP0020699
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Aug 2010 21:28:27 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o7JFwRhX3805334
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Aug 2010 21:28:27 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o7JFwQnm026776
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Aug 2010 01:58:27 +1000
Date: Thu, 19 Aug 2010 21:28:24 +0530
From: Ankita Garg <ankita@in.ibm.com>
To: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
Message-ID: <20100819155824.GD2690@in.ibm.com>
References: <4C488CCD.60004@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C488CCD.60004@us.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Gautham R Shenoy <ego@in.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Will Schmidt <willschm@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Thomas Gleixner <tglx@linutronix.de>
Reply-To: Ankita Garg <ankita@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Darren,

On Thu, Jul 22, 2010 at 11:24:13AM -0700, Darren Hart wrote:
> 
> With some instrumentation we were able to determine that the
> preempt_count() appears to change across the extended_cede_processor()
> call.  Specifically across the plpar_hcall_norets(H_CEDE) call. On
> PREEMPT_RT we call this with preempt_count=1 and return with
> preempt_count=0xffffffff. On mainline with CONFIG_PREEMPT=y, the value
> is different (0x65) but is still incorrect.

I was trying to reproduce this issue on a 2.6.33.7-rt29 kernel. I could
easily reproduce this on the RT kernel and not the non-RT kernel.
However, I hit it every single time I did a cpu online operation. I also
noticed that the issue persists even when I disable H_CEDE by passing
the "cede_offline=0" kernel commandline parameter. Could you pl confirm
if you observe the same in your setup ? 

However, the issue still remains. Will spend few cycles looking into
this issue.

> 
> Also of interest is that this path
> cpu_idle()->cpu_die()->pseries_mach_cpu_die() to start_secondary()
> enters with a preempt_count=1 if it wasn't corrupted across the hcall.
> The early boot path from _start however appears to call
> start_secondary() with a preempt_count of 0.
> 
> The following patch is most certainly not correct, but it does eliminate
> the situation on mainline 100% of the time (there is still a 25%
> reproduction rate on PREEMPT_RT). Can someone comment on:
> 
> 1) How can the preempt_count() get mangled across the H_CEDE hcall?
> 2) Should we call preempt_enable() in cpu_idle() prior to cpu_die() ?
> 
> Hacked-up-by: Darren Hart <dvhltc@us.ibm.com>
> 
> Index: linux-2.6.33.6/arch/powerpc/platforms/pseries/hotplug-cpu.c
> ===================================================================
> --- linux-2.6.33.6.orig/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ linux-2.6.33.6/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -138,6 +138,7 @@ static void pseries_mach_cpu_die(void)
>  			 * Kernel stack will be reset and start_secondary()
>  			 * will be called to continue the online operation.
>  			 */
> +			preempt_count() = 0;
>  			start_secondary_resume();
>  		}
>  	}
> 
> 

-- 
Regards,
Ankita Garg (ankita@in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs,
Bangalore, India
