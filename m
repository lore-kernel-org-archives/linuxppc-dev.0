Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 50079B6F56
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 01:29:59 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 923E8DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 01:29:51 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8AFTmRO018099
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 08:29:48 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n8AFVZVt022245
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 10:31:35 -0500 (CDT)
Message-ID: <4AA91B86.7090805@freescale.com>
Date: Thu, 10 Sep 2009 10:30:14 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Li Tao <b22598@freescale.com>
Subject: Re: Question about e300 core decrementer interrupt
References: <FF7429C6AD6EFB489C0A5A2021CDFEFA7C30E6@zmy16exm21.fsl.freescale.net>	
	<1252494967.10293.6.camel@localhost>	
	<20090909184343.GC8215@b07421-ec1.am.freescale.net>
	<1252583922.26108.23.camel@ubuntu.ubuntu-domain>
In-Reply-To: <1252583922.26108.23.camel@ubuntu.ubuntu-domain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Kenneth Johansson <kenneth@southpole.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Li Tao wrote:
> Hi Scott Wood,
> Thanks for your response
> 
> 在 2009-09-09三的 13:43 -0500，Scott Wood写道：
>> The decrementer stops ticking when the core goes to sleep.  However, if a
>> decrementer was already pending (but masked with MSR[EE]) before you
>> enter sleep mode, it will cause a wakeup.
>>
>> To avoid this, the decrementer is set to a very large value prior to and
>> after disabling interrupts.  See generic_suspend_disable_irqs() in
>> arch/powerpc/kernel/time.c.  Is this not happening for you?  Which kernel
>> version are you using, and what mechanism are you using to go to sleep?
> I use 2.6.24 kernel. The PM driver code have set decrementer to
> 0x7fffffff before go to sleep mode.

It looks like 2.6.24 doesn't have commit 
7ac5dde99eb9fefdb526973c600075b7c5703a86 (Implement arch disable/enable 
irq hooks) -- are you disabling the decrementer in a similar manner, or 
is it possible that the decrementer has already fired by the time you 
set it to 0x7fffffff?  Could you read the value just prior to entering 
sleep?

Why use such an old kernel, BTW?

> The driver set HID0[10]=1, then set MSR POW bit. PMCCR = 00111.

I was more interested in whether you were using the suspend_ops (maybe 
pm_ops back then?) infrastructure (which would invoke the irq hooks) or 
something custom.

-Scott
