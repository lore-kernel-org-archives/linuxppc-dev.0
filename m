Return-Path: <ARNDB@de.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 03794DDEE9
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 01:21:59 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8CFLsNp004913
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 11:21:54 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8CFLsTP692424
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 11:21:54 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8CFLrf0016494
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 11:21:54 -0400
From: Arnd Bergmann <ARNDB@de.ibm.com>
To: Christoph Raisch <RAISCH@de.ibm.com>
Subject: Re: new NAPI interface broken for POWER architecture?
Date: Wed, 12 Sep 2007 17:18:36 +0200
References: <200709071137.02801.ossthema@de.ibm.com>
	<20070912.055004.88490155.davem@davemloft.net>
	<OF2D6ED296.BDB04FBF-ONC1257354.00473703-C1257354.0048406C@de.ibm.com>
In-Reply-To: <OF2D6ED296.BDB04FBF-ONC1257354.00473703-C1257354.0048406C@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709121718.37820.ARNDB@de.ibm.com>
Cc: ossthema@linux.vnet.ibm.com, Paul Mackerras <pmac@au1.ibm.com>,
	netdev@vger.kernel.org, Jan-Bernd Themann <THEMANN@de.ibm.com>,
	linuxppc-dev@ozlabs.org, Michael Ellerman <ellerman@au1.ibm.com>,
	shemminger@linux-foundation.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 12 September 2007, Christoph Raisch wrote:
> David Miller <davem@davemloft.net> wrote on 12.09.2007 14:50:04:
>
> > I agree that it should be fixed, but we should also fix the IRQ
> > distribution scheme used on powerpc platforms which is totally
> > broken in these cases.
> 
> This is definitely not something we can change in the HEA device driver
> alone.
> It could also affect any other networking cards on POWER (e1000,s2io...).
> 
> Paul, Michael, Arndt, what is your opinion here?

The situation on Cell with the existing south bridge chips is that
interrupts _never_ get moved around, but are routed to specific
SMT threads by the firmware, while Linux does not interfere with
this.

We have been thinking about changing this so we can distribute
interrupts over all SMT threads in a given NUMA node, or even
over all logical CPUs in the system by reprogramming the
interrupt controller after each interrupt, but the current Axon bridge
chip will always have all devices routed to the same target CPU,
so it's unclear whether that is even an advantage.

	Arnd <><
