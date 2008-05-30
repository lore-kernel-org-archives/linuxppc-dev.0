Return-Path: <jes@sgi.com>
Received: from relay.sgi.com (netops-testserver-3-out.sgi.com [192.48.171.28])
	by ozlabs.org (Postfix) with ESMTP id 708A0DE267
	for <linuxppc-dev@ozlabs.org>; Fri, 30 May 2008 19:39:31 +1000 (EST)
Message-ID: <483FCB4E.8090104@sgi.com>
Date: Fri, 30 May 2008 11:39:26 +0200
From: Jes Sorensen <jes@sgi.com>
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: MMIO and gcc re-ordering issue
References: <1211852026.3286.36.camel@pasglop> <yq0iqwxrwuh.fsf@jaguar.mkp.net>
	<1212097223.8888.55.camel@pasglop>
	<200805291453.38492.jbarnes@virtuousgeek.org>
In-Reply-To: <200805291453.38492.jbarnes@virtuousgeek.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-arch@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
	linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
	linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	torvalds@linux-foundation.org, tpiepho@freescale.com,
	alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jesse Barnes wrote:
> On Thursday, May 29, 2008 2:40 pm Benjamin Herrenschmidt wrote:
>> On Thu, 2008-05-29 at 10:47 -0400, Jes Sorensen wrote:
>>> The only way to guarantee ordering in the above setup, is to either
>>> make writel() fully ordered or adding the mmiowb()'s inbetween the two
>>> writel's. On Altix you have to go and read from the PCI brige to
>>> ensure all writes to it have been flushed, which is also what mmiowb()
>>> is doing. If writel() was to guarantee this ordering, it would make
>>> every writel() call extremely expensive :-(
>> Interesting. I've always been taught by ia64 people that mmiowb() was
>> intended to be used solely between writel() and spin_unlock().
> 
> Well, that *was* true, afaik, but maybe these days multipath isn't just for 
> fail-over.  If that's true, then yeah making every single writeX ordered 
> would be the only way to go...

I could be getting bits wrong, but multi-path here is in the NUMA
routing, not at the device level.

>> If this is a performance problem, then provide relaxed variants and
>> use them in selected drivers.
> 
> Sounds reasonable.  That way drivers "just work" and important drivers can be 
> optimized.

That would kill all levels of performance in all drivers, resulting in
attempts to try and modify a fair bit of drivers to get the performance
back.

In reality this problem really only exists for devices where ordering of
consecutive writel's is a big issue. In my experience it really isn't
the case very frequently - and the number of mmiowb's that have put in
shows that too :-)

Cheers,
Jes
