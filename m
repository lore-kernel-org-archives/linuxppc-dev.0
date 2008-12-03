Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id D5F17DDD01
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2008 16:20:30 +1100 (EST)
Date: Tue, 2 Dec 2008 23:20:20 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: __cpu_up vs. start_secondary race?
Message-ID: <20081203052020.GG6829@localdomain>
References: <20081201213016.GC6829@localdomain>
	<1228169318.7356.146.camel@pasglop> <20081203021624.GE6829@localdomain>
	<1228279963.7356.238.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1228279963.7356.238.camel@pasglop>
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
> On Tue, 2008-12-02 at 20:16 -0600, Nathan Lynch wrote:
> > Apart from barriers (or lack thereof), the fact that __cpu_up gives up
> > after a more-or-less arbitrary period seems... well, arbitrary.  If we
> > get to "Processor X is stuck" then something is seriously wrong:
> > there's either a kernel bug or a platform issue, and the CPU just
> > kicked is in an unknown state.  Polling indefinitely seems safer, no?
> > Especially since some hypervisors allow overcommitting processors and
> > memory, which can introduce latencies in unexpected places.
> 
> I'm pretty happy to keep the timeout :-) Proved useful in many cases
> where we actually fail to bring it up or crash it at bringup. From my
> experience, most of the time, the stuck CPU isn't getting in the way and
> it gets us a chance to move forward.

Fair enough -- thanks.
