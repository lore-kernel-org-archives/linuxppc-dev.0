Return-Path: <schihei@de.ibm.com>
Received: from mtagate3.uk.ibm.com (mtagate3.uk.ibm.com [195.212.29.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E4B37679E2
	for <linuxppc-dev@ozlabs.org>; Tue,  9 May 2006 22:26:19 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate3.uk.ibm.com (8.13.6/8.13.6) with ESMTP id k49CQD4W155480
	for <linuxppc-dev@ozlabs.org>; Tue, 9 May 2006 13:26:13 +0100
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k49CR6Xg117454
	for <linuxppc-dev@ozlabs.org>; Tue, 9 May 2006 13:27:06 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11/8.13.3) with ESMTP id
	k49CQBOe021894
	for <linuxppc-dev@ozlabs.org>; Tue, 9 May 2006 13:26:13 +0100
Message-ID: <44608C90.30909@de.ibm.com>
Date: Tue, 09 May 2006 14:35:28 +0200
From: Heiko J Schick <schihei@de.ibm.com>
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [openib-general] [PATCH 07/16] ehca: interrupt handling routines
References: <4450A196.2050901@de.ibm.com>
	<adaejz9o4vh.fsf@cisco.com>	<445B4DA9.9040601@de.ibm.com>
	<adafyjomsrd.fsf@cisco.com>
In-Reply-To: <adafyjomsrd.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Roland Dreier wrote:
>     Heiko> Originaly, we had the same idea as you mentioned, that it
>     Heiko> would be better to do this in the higher levels. The point
>     Heiko> is that we can't see so far any simple posibility how this
>     Heiko> can done in the OpenIB stack, the TCP/IP network layer or
>     Heiko> somewhere in the Linux kernel.
> 
>     Heiko> For example: For IPoIB we get the best throughput when we
>     Heiko> do the CQ callbacks on different CPUs and not to stay on
>     Heiko> the same CPU.
> 
> So why not do it in IPoIB then?  This approach is not optimal
> globally.  For example, uverbs event dispatch is just going to queue
> an event and wake up the process waiting for events, and doing this on
> some random CPU not related to the where the process will run is
> clearly the worst possible way to dispatch the event.

Yes, I agree. It would not be an optimal solution, because other upper
level protocols (e.g. SDP, SRP, etc.) or userspace verbs would not be
affected by this changes. Nevertheless, how can an improved "scaling"
or "SMP" version of IPoIB look like. How could it be implemented?

>     Heiko> In other papers and slides (see [1]) you can see similar
>     Heiko> approaches.
> 
>     Heiko> [1]: Speeding up Networking, Van Jacobson and Bob
>     Heiko> Felderman,
>     Heiko> http://www.lemis.com/grog/Documentation/vj/lca06vj.pdf

> I think you've misunderstood this paper.  It's about maximizing CPU
> locality and pushing processing directly into the consumer.  In the
> context of slide 9, what you've done is sort of like adding another
> control loop inside the kernel, since you dispatch from interrupt
> handler to driver thread to final consumer.  So I would argue that
> your approach is exactly the opposite of what VJ is advocating.

Sorry, my idea was not to use the *.pdf file how it should be
implemented. I only wanted to show that other people are also thinking
about how TCP/IP performance could be increased and where the bottlenecks
(e.g. SOFTIRQs) are. :)

Regards,
	Heiko
