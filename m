Return-Path: <RAISCH@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 82B31DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 23:22:50 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id l8CDMkVT105516
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 13:22:46 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l8CDMkJS1859646
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 15:22:46 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l8CDMjL5017536
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 15:22:46 +0200
In-Reply-To: <20070912.055004.88490155.davem@davemloft.net>
References: <200709071137.02801.ossthema@de.ibm.com>
	<20070912.055004.88490155.davem@davemloft.net>
Subject: Re: new NAPI interface broken for POWER architecture?
To: David Miller <davem@davemloft.net>
Message-ID: <OF2D6ED296.BDB04FBF-ONC1257354.00473703-C1257354.0048406C@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Wed, 12 Sep 2007 15:10:08 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: ossthema@linux.vnet.ibm.com, Paul Mackerras <pmac@au1.ibm.com>,
	netdev@vger.kernel.org, Jan-Bernd Themann <THEMANN@de.ibm.com>,
	linuxppc-dev@ozlabs.org, Arnd Bergmann <ARNDB@de.ibm.com>,
	Michael Ellerman <ellerman@au1.ibm.com>, shemminger@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



David Miller <davem@davemloft.net> wrote on 12.09.2007 14:50:04:

> From: Jan-Bernd Themann <ossthema@de.ibm.com>
> Date: Fri, 7 Sep 2007 11:37:02 +0200
>
> > 2) On SMP systems: after netif_rx_complete has been called on CPU1
> >    (+interruts enabled), netif_rx_schedule could be called on CPU2
> >    (irq handler) before net_rx_action on CPU1 has checked
NAPI_STATE_SCHED.
> >    In that case the device would be added to poll lists of CPU1 and
CPU2
> >    as net_rx_action would see NAPI_STATE_SCHED set.
> >    This must not happen. It will be caught when netif_rx_complete is
> >    called the second time (BUG() called)
> >
> > This would mean we have a problem on all SMP machines right now.
>
> This is not a correct statement.
>
> Only on your platform do network device interrupts get moved
> around, no other platform does this.
>
> Sparc64 doesn't, all interrupts stay in one location after
> the cpu is initially choosen.
>
> x86 and x86_64 specifically do not move around network
> device interrupts, even though other device types do
> get dynamic IRQ cpu distribution.
>
> That's why you are the only person seeing this problem.
>
> I agree that it should be fixed, but we should also fix the IRQ
> distribution scheme used on powerpc platforms which is totally
> broken in these cases.

This is definitely not something we can change in the HEA device driver
alone.
It could also affect any other networking cards on POWER (e1000,s2io...).

Paul, Michael, Arndt, what is your opinion here?

Gruss / Regards
Christoph Raisch
