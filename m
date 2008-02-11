Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C03E3DDE44
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 09:26:09 +1100 (EST)
Message-ID: <47B0CB79.7090400@freescale.com>
Date: Mon, 11 Feb 2008 16:26:01 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: WARN_ON() hit in fsl bitbanged phy driver
References: <DCEAAC0833DD314AB0B58112AD99B93B03F931E6@ismail.innsys.innovsys.com>
	<47B0C30A.1030801@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03F9325F@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B03F9325F@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rune Torgersen wrote:
> Scott Wood wrote:
>> Rune Torgersen wrote:
>>> I hit the following WARN_ON when using mii-tools agains a ethernet
>>> interface using a bit-banged mii interface
>> It looks like the kernel thinks it's in an interrupt, even though it
>> clearly isn't from the backtrace.  Presumably, something
>> slept from an
>> interrupt handler; try turning on sleep-in-spinlock debugging.
> 
> I turned on sleep-in-spinlock and it did not reveal anything. I'm trying
> some other debug options.
> 
>> The root cause was probably something other than the phy code.
> I'm not so sure, because it only happens when I run mii-tool agains the
> interface useing the bit-banged driver, and then only the first time.

OK, it seems I should have checked 2.6.24 instead of head-of-tree; 
softirq.c:139 is a different assertion than I thought.  It's not 
in_irq(), but irqs_disabled().  fs_ioctl() is disabling interrupts, and 
spin_unlock_bh() doesn't like that.  The current use of mutexes likes it 
even less.  The locking should be moved inside the phy bus 
implementation, if it's needed at all.

It only happens once because it's a WARN_ON_ONCE(). :-)

-Scott
