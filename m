Return-Path: <ossthema@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EB3D6DDEE6
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 23:59:22 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id l7ODxHPc115930
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 13:59:17 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l7ODxHFR2314494
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 15:59:17 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l7ODxHOG031743
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 15:59:17 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: netdev <netdev@vger.kernel.org>
Subject: RFC: issues concerning the next NAPI interface
Date: Fri, 24 Aug 2007 15:59:16 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708241559.17055.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
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

Hi,

when I tried to get the eHEA driver working with the new interface,
the following issues came up.

1) The current implementation of netif_rx_schedule, netif_rx_complete
=A0 =A0and the net_rx_action have the following problem: netif_rx_schedule
=A0 =A0sets the NAPI_STATE_SCHED flag and adds the NAPI instance to the pol=
l_list.
=A0 =A0netif_rx_action checks NAPI_STATE_SCHED, if set it will add the devi=
ce
=A0 =A0to the poll_list again (as well). netif_rx_complete clears the NAPI_=
STATE_SCHED.
=A0 =A0If an interrupt handler calls netif_rx_schedule on CPU 2
=A0 =A0after netif_rx_complete has been called on CPU 1 (and the poll funct=
ion=20
=A0 =A0has not returned yet), the NAPI instance will be added twice to the=
=20
=A0 =A0poll_list (by netif_rx_schedule and net_rx_action). Problems occur w=
hen=20
=A0 =A0netif_rx_complete is called twice for the device (BUG() called)

2) If an ethernet chip supports multiple receive queues, the queues are=20
=A0 =A0currently all processed on the CPU where the interrupt comes in. This
=A0 =A0is because netif_rx_schedule will always add the rx queue to the CPU=
's
=A0 =A0napi poll_list. The result under heavy presure is that all queues wi=
ll
=A0 =A0gather on the weakest CPU (with highest CPU load) after some time as=
 they
=A0 =A0will stay there as long as the entire queue is emptied. On SMP syste=
ms=20
=A0 =A0this behaviour is not desired. It should also work well without inte=
rrupt
=A0 =A0pinning.
=A0 =A0It would be nice if it is possible to schedule queues to other CPU's=
, or
=A0 =A0at least to use interrupts to put the queue to another cpu (not nice=
 for=20
=A0 =A0as you never know which one you will hit).=20
=A0 =A0I'm not sure how bad the tradeoff would be.

3) On modern systems the incoming packets are processed very fast. Especial=
ly
=A0 =A0on SMP systems when we use multiple queues we process only a few pac=
kets
=A0 =A0per napi poll cycle. So NAPI does not work very well here and the in=
terrupt=20
=A0 =A0rate is still high. What we need would be some sort of timer polling=
 mode=20
=A0 =A0which will schedule a device after a certain amount of time for high=
 load=20
=A0 =A0situations. With high precision timers this could work well. Current
=A0 =A0usual timers are too slow. A finer granularity would be needed to ke=
ep the
   latency down (and queue length moderate).

What do you think?

Thanks,
Jan-Bernd
