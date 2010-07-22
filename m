Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A91801007D2
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 04:56:19 +1000 (EST)
Date: Thu, 22 Jul 2010 20:38:35 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
In-Reply-To: <4C488CCD.60004@us.ibm.com>
Message-ID: <alpine.LFD.2.00.1007222028420.2616@localhost.localdomain>
References: <4C488CCD.60004@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Gautham R Shenoy <ego@in.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Will Schmidt <willschm@us.ibm.com>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 22 Jul 2010, Darren Hart wrote:
 
> Also of interest is that this path
> cpu_idle()->cpu_die()->pseries_mach_cpu_die() to start_secondary()
> enters with a preempt_count=1 if it wasn't corrupted across the hcall.

That triggers the problem as well. preempt_count needs to be 0 when
entering start_secondary(). So I really wonder how that ever worked.

> The early boot path from _start however appears to call
> start_secondary() with a preempt_count of 0.

Which is correct.
 
> The following patch is most certainly not correct, but it does eliminate

It is correct, but i think it is incomplete as other portions of the
thread_info on the stack might be in some weird state as well.

> the situation on mainline 100% of the time (there is still a 25%
> reproduction rate on PREEMPT_RT).

But those are diffferent issues, for which we have reasonable
explanations and patches/workarounds.

> 2) Should we call preempt_enable() in cpu_idle() prior to cpu_die() ?

No
 
Thanks,

	tglx
