Return-Path: <ossthema@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CB787DDF63
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 21:19:10 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id l7SBJ5Ii051168
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 11:19:05 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l7SBJ43l598164
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 13:19:04 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l7SBJ4aX025192
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 13:19:04 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: David Miller <davem@davemloft.net>
Subject: Re: RFC: issues concerning the next NAPI interface
Date: Tue, 28 Aug 2007 13:19:03 +0200
References: <46D1D634.7060007@katalix.com>
	<200708271147.01890.ossthema@de.ibm.com>
	<20070827.133721.59473971.davem@davemloft.net>
In-Reply-To: <20070827.133721.59473971.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708281319.03903.ossthema@de.ibm.com>
Cc: tklein@de.ibm.com, themann@de.ibm.com, stefan.roscher@de.ibm.com,
	netdev@vger.kernel.org, jchapman@katalix.com, raisch@de.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	akepner@sgi.com, meder@de.ibm.com, shemminger@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 27 August 2007 22:37, David Miller wrote:
> From: Jan-Bernd Themann <ossthema@de.ibm.com>
> Date: Mon, 27 Aug 2007 11:47:01 +0200
> 
> > So the question is simply: Do we want drivers that need (benefit
> > from) a timer based polling support to implement their own timers
> > each, or should there be a generic support?
> 
> I'm trying to figure out how an hrtimer implementation would
> even work.
> 
> Would you start the timer from the chip interrupt handler?  If so,
> that's taking two steps backwards as you've already taken all of the
> overhead of running the interrupt handler.

I'm also still trying to understand how hrtimer work exactly. 
The implementation of hrtimers for P6 has not been finished yet, so
I can't do experiments with hrtimers and eHEA now.

I will try the following scheme (once we get hrtimers):
Each device (queue) has a hrtimer.
Schedule the timer in the poll function instead of reactivating IRQs
when a high load situation has been detected and all packets have
been emptied from the receive queue.
The timer function could then just call netif_rx_schedule to register
the rx_queue for NAPI again. 

The advantages of this scheme (if it works as I understood it) would be:
- we don't have to modify NAPI
- benefit from fairness amoung rx_queues / network devices 
- The poll function can decide how long to stick to the timer based
  polling mode, and when to switch back to it's HW IRQs.
- driver can determine the time to wait based on the receive queue length and
  speed

Regards,
Jan-Bernd
