Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B0331DDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 09:08:53 +1100 (EST)
Subject: Re: __cpu_up vs. start_secondary race?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20081201213016.GC6829@localdomain>
References: <20081201213016.GC6829@localdomain>
Content-Type: text/plain
Date: Tue, 02 Dec 2008 09:08:38 +1100
Message-Id: <1228169318.7356.146.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-12-01 at 15:30 -0600, Nathan Lynch wrote:
> Hi,
> 
> I think there may be a plausible issue here.  If not, maybe I'll get
> an education :)
> 
> cpu_callin_map is used during secondary CPU bootstrap to notify the
> waiting CPU that the new CPU is coming up.  __cpu_up clears
> cpu_callin_map[cpu] and then polls the same location, waiting for
> start_secondary to set it to 1.  But I'm wondering how safe the
> current implementation is -- start_secondary doesn't have an explicit
> sync following cpu_callin_map[cpu] = 1, and __cpu_up has no
> synchronization instructions in its polling loop, so how can we be
> sure that the waiting cpu will see the update to that location in
> time?

I think it works because there's no big ordering problem (though we
should still probably stick a few barriers here for safety) so it's
really just a problem of how long it takes for the store to be visible,
and the duration of the waiting loop is such that in practice, it will
end up being visible wayyyyy before we timeout.

IE. It's not like stores get buffered for ever due to absence of
barriers. They ultimately get out to the bus.

Cheers,
Ben.
