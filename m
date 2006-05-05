Return-Path: <schihei@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0A040679A6
	for <linuxppc-dev@ozlabs.org>; Fri,  5 May 2006 23:05:28 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.6/8.13.6) with ESMTP id k45D5PpM155082
	for <linuxppc-dev@ozlabs.org>; Fri, 5 May 2006 13:05:25 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k45D6cSh151872
	for <linuxppc-dev@ozlabs.org>; Fri, 5 May 2006 15:06:38 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	k45D5Nvr019962
	for <linuxppc-dev@ozlabs.org>; Fri, 5 May 2006 15:05:24 +0200
Message-ID: <445B4DA9.9040601@de.ibm.com>
Date: Fri, 05 May 2006 15:05:45 +0200
From: Heiko J Schick <schihei@de.ibm.com>
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [openib-general] [PATCH 07/16] ehca: interrupt handling routines
References: <4450A196.2050901@de.ibm.com> <adaejz9o4vh.fsf@cisco.com>
In-Reply-To: <adaejz9o4vh.fsf@cisco.com>
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

Hello Roland,

Roland Dreier wrote:
> It seems that you are deferring completion event dispatch into threads
> spread across all the CPUs.  This seems like a very strange thing to
> me -- you are adding latency and possibly causing cacheline pingpong.
> 
> It may help throughput in some cases to spread the work across
> multiple CPUs but it seems strange to me to do this in the low-level
> driver.  My intuition would be that it would be better to do this in
> the higher levels, and leave open the possibility for protocols that
> want the lowest possible latency to be called directly from the
> interrupt handler.

We've implemented this "spread CQ callbacks across multiple CPUs"
functionality to get better throughput on a SMP system, as you have
seen.

Originaly, we had the same idea as you mentioned, that it would be better
to do this in the higher levels. The point is that we can't see so far
any simple posibility how this can done in the OpenIB stack, the TCP/IP
network layer or somewhere in the Linux kernel.

For example:
For IPoIB we get the best throughput when we do the CQ callbacks on
different CPUs and not to stay on the same CPU.

In other papers and slides (see [1]) you can see similar approaches.

I think such one implementation or functionality could require more
or less a non-trivial changes. This could be also releated to other
I/O traffic.

[1]:  Speeding up Networking, Van Jacobson and Bob Felderman,
       http://www.lemis.com/grog/Documentation/vj/lca06vj.pdf

Regards,
	Heiko
