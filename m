Return-Path: <rdreier@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3-in.cisco.com [171.71.176.72])
	by ozlabs.org (Postfix) with ESMTP id 9630C679FF
	for <linuxppc-dev@ozlabs.org>; Sat,  6 May 2006 00:49:15 +1000 (EST)
To: Heiko J Schick <schihei@de.ibm.com>
Subject: Re: [openib-general] [PATCH 07/16] ehca: interrupt handling routines
References: <4450A196.2050901@de.ibm.com> <adaejz9o4vh.fsf@cisco.com>
	<445B4DA9.9040601@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 05 May 2006 07:49:10 -0700
In-Reply-To: <445B4DA9.9040601@de.ibm.com> (Heiko J. Schick's message of "Fri,
	05 May 2006 15:05:45 +0200")
Message-ID: <adafyjomsrd.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

    Heiko> Originaly, we had the same idea as you mentioned, that it
    Heiko> would be better to do this in the higher levels. The point
    Heiko> is that we can't see so far any simple posibility how this
    Heiko> can done in the OpenIB stack, the TCP/IP network layer or
    Heiko> somewhere in the Linux kernel.

    Heiko> For example: For IPoIB we get the best throughput when we
    Heiko> do the CQ callbacks on different CPUs and not to stay on
    Heiko> the same CPU.

So why not do it in IPoIB then?  This approach is not optimal
globally.  For example, uverbs event dispatch is just going to queue
an event and wake up the process waiting for events, and doing this on
some random CPU not related to the where the process will run is
clearly the worst possible way to dispatch the event.

    Heiko> In other papers and slides (see [1]) you can see similar
    Heiko> approaches.

    Heiko> [1]: Speeding up Networking, Van Jacobson and Bob
    Heiko> Felderman,
    Heiko> http://www.lemis.com/grog/Documentation/vj/lca06vj.pdf

I think you've misunderstood this paper.  It's about maximizing CPU
locality and pushing processing directly into the consumer.  In the
context of slide 9, what you've done is sort of like adding another
control loop inside the kernel, since you dispatch from interrupt
handler to driver thread to final consumer.  So I would argue that
your approach is exactly the opposite of what VJ is advocating.

 - R.
