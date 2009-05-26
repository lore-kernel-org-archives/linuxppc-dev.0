Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D05DBDDFF4
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 08:38:55 +1000 (EST)
Message-ID: <4A1C6F80.7070307@freescale.com>
Date: Tue, 26 May 2009 17:38:56 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Wrong looking statement in cpm_common.c
References: <1243224033.24376.18.camel@pasglop>	
	<20090526175613.GB9464@loki.buserror.net>	
	<1243375671.17847.0.camel@pasglop> <4A1C69F8.9090301@freescale.com>
	<1243376537.17847.11.camel@pasglop>
In-Reply-To: <1243376537.17847.11.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Tue, 2009-05-26 at 17:15 -0500, Scott Wood wrote:
>> Benjamin Herrenschmidt wrote:
>>> On Tue, 2009-05-26 at 12:56 -0500, Scott Wood wrote:
>>>> Any suggestions for how to do it properly?
>>> ioremap ? :-)
>> Does ioremap work that early?
> 
> It works very early on ppc32 but maybe not -that- early... It works from
> start_kernel on. You might be able to do the ioremaps in machine_init
> (provided LMBs are up) but they won't be "effective" until MMU_init
> returns, but then, neither will setbat anyway.

Before the setbat takes effect, there is a BAT established by 
setup_cpm_bat in head_32.S.

How about something similar to btext_unmap to tell cpm2 udbg that the 
mapping is gone, and to do ioremap at that point (or perhaps it would be 
better to wait until the next print after unmap is called, which should 
be after load_up_mmu assuming nothing crashes in the assembly code)?

-Scott
