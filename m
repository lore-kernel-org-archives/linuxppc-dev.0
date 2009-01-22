Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18808.6885.373593.934704@cargo.ozlabs.ibm.com>
Date: Thu, 22 Jan 2009 18:06:13 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Miller <davem@davemloft.net>
Subject: Re: perf_counter vs. oprofile
In-Reply-To: <20090121.212634.237965647.davem@davemloft.net>
References: <20090121.212634.237965647.davem@davemloft.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller writes:

> Paul, I just noticed that right now if perf counter is enabled, the
> oprofile module load will always fail because the powerpc perf counter
> support unconditionally grabs the PMC hardware using
> reserve_pmc_hardware() in an arch_initcall()
> 
> There really needs to be a way to segregate these multiple users of
> the PMC device.  For example, if I'm not using the perf counter
> APIs at all I should be able to use oprofile if I want to.
> 
> Anyways, just FYI...

Sure.  I know the current situation is distinctly sub-optimal but I
wanted to get something going so I could start playing with it.  (All
the perf_counter stuff is very much beta code at the moment IMHO.)
What I intend to do is claim the PMU when the first counter gets
opened and release it when the last counter gets closed, but that will
need some support in the core, I think.  I'm on vacation at the moment
and travelling, so I won't get to it in the next two weeks though. :)

Out of curiosity, what ppc hardware are you using perf_counters on?
A G5?

Regards,
Paul.
