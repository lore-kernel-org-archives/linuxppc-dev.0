Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6EB9667A5E
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 20:47:16 +1100 (EST)
In-Reply-To: <200612090100.09380.arnd@arndb.de>
References: <20061207172259.64168f8c@localhost>
	<20061208185902.GA14675@localdomain>
	<1165618236.1103.87.camel@localhost.localdomain>
	<200612090100.09380.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4FBDC6E5-1B34-41A3-AF78-4B5917EA6848@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Openipmi-developer] [patch 1/1] ipmi: add autosensing of ipmi
	device on powerpc using device-tree
Date: Sat, 9 Dec 2006 10:46:46 +0100
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, openipmi-developer@lists.sourceforge.net,
	Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> How many registers do we expect here ? Might be better to have one
>> resource represent the whole MMIO area, and have a separate property
>> that indicates the stride between 2 registers.

Yes *please*.  Anything else will cause no end of problems, and
that only for wanting to not create a perfectly reasonable extra
property, with obvious semantics.

> I think the current representation is perfect. AFAICS, there are  
> always
> two registers,

How do you know?  Some later compatible implementation might add
some regs.  Also, there are implementations that simply ignore
the lower address bits, so size=1 in the "reg" property is wrong
for those.

> but depending on the HW implementation, they may be
> between 1 and 4 bytes wide, and can have a different spacing.

Always one byte wide.

> By having two separate areas in the reg property, the driver can
> easily determine both the size and the spacing. It will then do
> a single ioremap that spans both anyway.

It's much better to make it explicit and obvious in the device
tree what's going on.


Segher
