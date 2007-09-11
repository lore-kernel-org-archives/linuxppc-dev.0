Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5C1D4DDE03
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 07:33:54 +1000 (EST)
Message-ID: <46E70991.3060208@freescale.com>
Date: Tue, 11 Sep 2007 16:33:05 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/3] Implement arch disable/enable irq hooks.
References: <20070905220607.GA11330@ld0162-tx32.am.freescale.net>
	<18151.1452.702936.394284@cargo.ozlabs.ibm.com>
In-Reply-To: <18151.1452.702936.394284@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> It might be better to use hard_irq_disable rather than
> local_irq_disable here, since I think we will need that on 64-bit (and
> on 32-bit if we ever do lazy irq disabling there).

OK.

>> +/* Overrides the weak version in kernel/power/main.c */
>> +void arch_suspend_disable_irqs(void)
>> +{
>> +	if (ppc_md.suspend_disable_irqs)
>> +		ppc_md.suspend_disable_irqs();
>> +	else
>> +		generic_suspend_disable_irqs();
> 
> Any particular reason why we need a ppc_md hook here?  Do we expect
> some platform to need to do something different?

Not that I know the details of, but others requested it.

-Scott
