Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 331CBDDEBD
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Aug 2007 07:37:52 +1000 (EST)
Date: Fri, 24 Aug 2007 14:37:51 -0700 (PDT)
Message-Id: <20070824.143751.112614506.davem@davemloft.net>
To: ossthema@de.ibm.com
Subject: Re: RFC: issues concerning the next NAPI interface
From: David Miller <davem@davemloft.net>
In-Reply-To: <200708241559.17055.ossthema@de.ibm.com>
References: <200708241559.17055.ossthema@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Cc: tklein@de.ibm.com, themann@de.ibm.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	raisch@de.ibm.com, meder@de.ibm.com, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jan-Bernd Themann <ossthema@de.ibm.com>
Date: Fri, 24 Aug 2007 15:59:16 +0200

> 1) The current implementation of netif_rx_schedule, netif_rx_complete=

> =A0 =A0and the net_rx_action have the following problem: netif_rx_sch=
edule
> =A0 =A0sets the NAPI_STATE_SCHED flag and adds the NAPI instance to t=
he poll_list.
> =A0 =A0netif_rx_action checks NAPI_STATE_SCHED, if set it will add th=
e device
> =A0 =A0to the poll_list again (as well). netif_rx_complete clears the=
 NAPI_STATE_SCHED.
> =A0 =A0If an interrupt handler calls netif_rx_schedule on CPU 2
> =A0 =A0after netif_rx_complete has been called on CPU 1 (and the poll=
 function =

> =A0 =A0has not returned yet), the NAPI instance will be added twice t=
o the =

> =A0 =A0poll_list (by netif_rx_schedule and net_rx_action). Problems o=
ccur when =

> =A0 =A0netif_rx_complete is called twice for the device (BUG() called=
)

Indeed, this is the "who should manage the list" problem.
Probably the answer is that whoever transitions the NAPI_STATE_SCHED
bit from cleared to set should do the list addition.

Patches welcome :-)

> 3) On modern systems the incoming packets are processed very fast. Es=
pecially
> =A0 =A0on SMP systems when we use multiple queues we process only a f=
ew packets
> =A0 =A0per napi poll cycle. So NAPI does not work very well here and =
the interrupt =

> =A0 =A0rate is still high. What we need would be some sort of timer p=
olling mode =

> =A0 =A0which will schedule a device after a certain amount of time fo=
r high load =

> =A0 =A0situations. With high precision timers this could work well. C=
urrent
> =A0 =A0usual timers are too slow. A finer granularity would be needed=
 to keep the
>    latency down (and queue length moderate).

This is why minimal levels of HW interrupt mitigation should be enabled=

in your chip.  If it does not support this, you will indeed need to loo=
k
into using high resolution timers or other schemes to alleviate this.

I do not think it deserves a generic core networking helper facility,
the chips that can't mitigate interrupts are few and obscure.
