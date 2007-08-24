Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7F130DDED0
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Aug 2007 02:45:45 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7OGjg4F005770
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 12:45:42 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7OGjfKO498690
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 12:45:41 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7OGjfvt023694
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 12:45:41 -0400
Date: Fri, 24 Aug 2007 11:45:41 -0500
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: RFC: issues concerning the next NAPI interface
Message-ID: <20070824164541.GG4282@austin.ibm.com>
References: <200708241559.17055.ossthema@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200708241559.17055.ossthema@de.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 24, 2007 at 03:59:16PM +0200, Jan-Bernd Themann wrote:
> 3) On modern systems the incoming packets are processed very fast. Especially
>    on SMP systems when we use multiple queues we process only a few packets
>    per napi poll cycle. So NAPI does not work very well here and the interrupt 
>    rate is still high. 

I saw this too, on a system that is "modern" but not terribly fast, and
only slightly (2-way) smp. (the spidernet)

I experimented wih various solutions, none were terribly exciting.  The
thing that killed all of them was a crazy test case that someone sprung on
me:  They had written a worst-case network ping-pong app: send one
packet, wait for reply, send one packet, etc.  

If I waited (indefinitely) for a second packet to show up, the test case 
completely stalled (since no second packet would ever arrive).  And if I 
introduced a timer to wait for a second packet, then I just increased 
the latency in the response to the first packet, and this was noticed, 
and folks complained.  

In the end, I just let it be, and let the system work as a busy-beaver, 
with the high interrupt rate. Is this a wise thing to do?  I was
thinking that, if the system is under heavy load, then the interrupt
rate would fall, since (for less pathological network loads) more 
packets would queue up before the poll was serviced.  But I did not
actually measure the interrupt rate under heavy load ... 

--linas
