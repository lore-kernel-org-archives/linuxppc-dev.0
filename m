Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CA891DDDF0
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 19:51:42 +1000 (EST)
Date: Thu, 19 Jun 2008 11:50:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [RFC/PATCH 0/3] sched: allow arch override of cpu power
Message-ID: <20080619095048.GD15228@elte.hu>
References: <1213835374-10868-1-git-send-email-ntl@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1213835374-10868-1-git-send-email-ntl@pobox.com>
Cc: linuxppc-dev@ozlabs.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Nathan Lynch <ntl@pobox.com> wrote:

> There is an "interesting" quality of POWER6 cores, which each have 2 
> hardware threads: assuming one thread on the core is idle, the primary 
> thread is a little "faster" than the secondary thread.  To illustrate:
> 
> for cpumask in 0x1 0x2 ; do
>     taskset $cpumask /usr/bin/time -f "%e elapsed, %U user, %S sys" \
>             /bin/sh -c "i=1000000 ; while (( i-- )) ; do : ; done"
> done
> 
> 17.05 elapsed, 16.83 user, 0.22 sys
> 17.54 elapsed, 17.32 user, 0.22 sys
> 
> (The first result is for a primary thread; the second result for a 
> secondary thread.)
> 
> So it would be nice to have the scheduler slightly prefer primary 
> threads on POWER6 machines.  These patches, which allow the 
> architecture to override the scheduler's CPU "power" calculation, are 
> one possible approach, but I'm open to others.  Please note: these 
> seemed to have the desired effect on 2.6.25-rc kernels (2-3% 
> improvement in a kernbench-like make -j <nr_cores>), but I'm not 
> seeing this improvement with 2.6.26-rc kernels for some reason I am 
> still trying to track down.

ok, i guess that discrepancy has to be tracked down before we can think 
about these patches - but the principle is OK.

One problem is that the whole cpu-power balancing code in sched.c is a 
bit ... unclear and under-documented. So any change to this area should 
begin at documenting the basics: what do the units mean exactly, how are 
they used in balancing and what is the desired effect.

I'd not be surprised if there were a few buglets in this area, SMT is 
not at the forefront of testing at the moment. There's nothing 
spectacularly broken in it (i have a HT machine myself), but the 
concepts have bitrotten a bit. Patches - even if they just add comments 
- are welcome :-)

	Ingo
