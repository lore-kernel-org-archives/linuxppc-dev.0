Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 461A667C25
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 00:37:28 +1100 (EST)
In-Reply-To: <D4D63351-AFCC-4E4B-AA3C-4F097DB23A13@schihei.de>
References: <20061207172259.64168f8c@localhost>
	<200612091244.05862.arnd@arndb.de>
	<89216897-DF66-4C4E-9436-BD7816424139@schihei.de>
	<200612111111.10740.arnd@arndb.de>
	<D4D63351-AFCC-4E4B-AA3C-4F097DB23A13@schihei.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6E77C43A-7A8B-4546-9058-5D8EBE42285F@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Openipmi-developer] [patch 1/1] ipmi: add autosensing of ipmi
	device on powerpc using device-tree
Date: Mon, 11 Dec 2006 14:37:12 +0100
To: Heiko J Schick <info@schihei.de>
Cc: linuxppc-dev@ozlabs.org, openipmi-developer@lists.sourceforge.net,
	Arnd Bergmann <arnd@arndb.de>, Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> I'd like to see (2), because that's what the driver currently  
>> expects.
>> The common ipmi code in linux _always_ does this calculation
>> anyway, and
>> (1) only means we have to compute the reg-spacing and reg-size from
>> the
>> layout of the registers, which gets rather complicated if you have
>> more
>> than two of them in the reg property.
>
> Yes, that is correct, but what happens if you have three registers
> and because of stupid reasons the reg-spacing and reg-size is  
> different.
>
> In (1) you can handle it without problems, in (2) not.

You mean, say, a 32-bit reg at (local) address 0 and 4,
and an 8-bit reg at offset 16?  Neither (1) nor (2) can
handle that -- the Linux interface isn't generic enough
for that.  Both (1) and (2) can describe the register
space just fine in "reg"; the "reg" property doesn't
describe how to use the registers, just where they are.

I doubt the IPMI spec allows such weird devices anyway.

> Also, where is
> the difference if you have to calculate the reg-spacing, etc. (1) or
> the addresses (2). The effort is more or less exactly the same.

The device tree describes the hardware.  How an OS (like Linux)
has to interpret it to fit that info to its internal interfaces
is the OS' problem, it's a big layering violation to put that
info into the device tree.

I wouldn't worry about supporting non-KCS controllers in your
Linux code right now at all -- you can't test it anyway, it's
dead code until someone makes such a device.


Segher
