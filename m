Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5D5E6DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2008 15:52:54 +1100 (EST)
Subject: Re: __cpu_up vs. start_secondary race?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20081203021624.GE6829@localdomain>
References: <20081201213016.GC6829@localdomain>
	<1228169318.7356.146.camel@pasglop> <20081203021624.GE6829@localdomain>
Content-Type: text/plain
Date: Wed, 03 Dec 2008 15:52:43 +1100
Message-Id: <1228279963.7356.238.camel@pasglop>
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

On Tue, 2008-12-02 at 20:16 -0600, Nathan Lynch wrote:
> Apart from barriers (or lack thereof), the fact that __cpu_up gives up
> after a more-or-less arbitrary period seems... well, arbitrary.  If we
> get to "Processor X is stuck" then something is seriously wrong:
> there's either a kernel bug or a platform issue, and the CPU just
> kicked is in an unknown state.  Polling indefinitely seems safer, no?
> Especially since some hypervisors allow overcommitting processors and
> memory, which can introduce latencies in unexpected places.

I'm pretty happy to keep the timeout :-) Proved useful in many cases
where we actually fail to bring it up or crash it at bringup. From my
experience, most of the time, the stuck CPU isn't getting in the way and
it gets us a chance to move forward.

Ben.
