Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 8C334DDDEF
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2008 13:16:33 +1100 (EST)
Date: Tue, 2 Dec 2008 20:16:24 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: __cpu_up vs. start_secondary race?
Message-ID: <20081203021624.GE6829@localdomain>
References: <20081201213016.GC6829@localdomain>
	<1228169318.7356.146.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1228169318.7356.146.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Mon, 2008-12-01 at 15:30 -0600, Nathan Lynch wrote:
> > 
> > cpu_callin_map is used during secondary CPU bootstrap to notify the
> > waiting CPU that the new CPU is coming up.  __cpu_up clears
> > cpu_callin_map[cpu] and then polls the same location, waiting for
> > start_secondary to set it to 1.  But I'm wondering how safe the
> > current implementation is -- start_secondary doesn't have an explicit
> > sync following cpu_callin_map[cpu] = 1, and __cpu_up has no
> > synchronization instructions in its polling loop, so how can we be
> > sure that the waiting cpu will see the update to that location in
> > time?
> 
> I think it works because there's no big ordering problem (though we
> should still probably stick a few barriers here for safety) so it's
> really just a problem of how long it takes for the store to be visible,
> and the duration of the waiting loop is such that in practice, it will
> end up being visible wayyyyy before we timeout.

At least on "real" hardware, yes.  Various 64-bit systems I've tested
see the update after two iterations at most (during boot, didn't check
the hotplug case).

> IE. It's not like stores get buffered for ever due to absence of
> barriers. They ultimately get out to the bus.

Hrm, "ultimately" :)  Okay, thanks.

Apart from barriers (or lack thereof), the fact that __cpu_up gives up
after a more-or-less arbitrary period seems... well, arbitrary.  If we
get to "Processor X is stuck" then something is seriously wrong:
there's either a kernel bug or a platform issue, and the CPU just
kicked is in an unknown state.  Polling indefinitely seems safer, no?
Especially since some hypervisors allow overcommitting processors and
memory, which can introduce latencies in unexpected places.
