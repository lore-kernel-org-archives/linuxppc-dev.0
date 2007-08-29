Return-Path: <ossthema@de.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1F747DDDCA
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 17:11:00 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id l7T7ArR71081428
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 07:10:53 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l7T7ArqE2285746
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 09:10:53 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l7T7Aqi4003728
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 09:10:53 +0200
Message-ID: <46D51BD7.6040904@de.ibm.com>
Date: Wed, 29 Aug 2007 09:10:15 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: RFC: issues concerning the next NAPI interface
References: <200708271147.01890.ossthema@de.ibm.com>
	<20070827.133721.59473971.davem@davemloft.net>
	<200708281319.03903.ossthema@de.ibm.com>
	<20070828.132152.38706038.davem@davemloft.net>
In-Reply-To: <20070828.132152.38706038.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi David

David Miller schrieb:
> Interrupt mitigation only works if it helps you avoid interrupts.
> This scheme potentially makes more of them happen.
>
> The hrtimer is just another interrupt, a cpu locally triggered one,
> but it has much of the same costs nonetheless.
>
> So if you set this timer, it triggers, and no packets arrive, you are
> taking more interrupts and doing more work than if you had disabled
> NAPI.
>
> In fact, for certain packet rates, your scheme would result in
> twice as many interrupts than the current scheme
>   
That depends how smart the driver switches between timer
polling and plain NAPI (depending on load situation).
> This is one of several reasons why hardware is the only truly proper
> place for this kind of logic.  Only the hardware can see the packet
> arrive, and do the interrupt deferral without any cpu intervention
> whatsoever.
>   
What I'm trying to improve with this approach is interrupt
mitigation for NICs where the hardware support for interrupt
mitigation is limited. I'm not trying to improve this for NICs
that work well with the means their HW provides. I'm aware of
the fact that this scheme has it's tradeoffs and certainly
can not be as good as a HW approach.
So I'm grateful for any ideas that do have less tradeoffs and
provide a mechanism to reduce interrupts without depending on
HW support of the NIC.

In the end I want to reduce the CPU utilization. And one way
to do that is LRO which also works only well if there are more
then just a very few packets to aggregate. So at least our
driver (eHEA) would benefit from a mix of timer based polling
and plain NAPI (depending on load situations).

If there is no need for a generic mechanism for this kind of
network adapters, then we can just leave this to each device
driver.
