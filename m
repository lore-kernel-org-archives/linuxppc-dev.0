Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 971B8DE020
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 07:38:25 +1000 (EST)
Message-ID: <471E68E2.3040008@freescale.com>
Date: Tue, 23 Oct 2007 16:34:26 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/7] Implement arch disable/enable irq hooks.
References: <20071023212404.GA30942@loki.buserror.net>
	<20071023163301.4857393e@weaponx.rchland.ibm.com>
In-Reply-To: <20071023163301.4857393e@weaponx.rchland.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
>> +#ifdef CONFIG_SUSPEND
>> +void generic_suspend_disable_irqs(void)
>> +{
>> +	preempt_disable();
>> +
>> +	/* Disable the decrementer, so that it doesn't interfere
>> +	 * with suspending.
>> +	 */
>> +
>> +	set_dec(0x7fffffff);
>> +	hard_irq_disable();
>> +	set_dec(0x7fffffff);
>> +}
>> +
>> +void generic_suspend_enable_irqs(void)
>> +{
>> +	wakeup_decrementer();
>> +
>> +	local_irq_enable();
>> +	preempt_enable();
>> +}
> 
> Should these be static functions?  Seems so...

I was asked to make them available to be called by non-generic 
implementations.

-Scott
