Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7FB49679E6
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 00:09:12 +1100 (EST)
In-Reply-To: <20060330142626.1a9d22f5@vitb.ru.mvista.com>
References: <20060328161431.18517.82573.stgit@vitb.ru.mvista.com>
	<bed6c40abe7664da7506270a46611d00@embeddededge.com>
	<20060330142626.1a9d22f5@vitb.ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0f0e0fbbf56f73879a70f785c497756c@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: [PATCH] powerpc: Add FSL CPM2 device tree node documentation
Date: Thu, 30 Mar 2006 08:09:01 -0500
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 30, 2006, at 5:26 AM, Vitaly Bordug wrote:

> - 	the new way, all that will not follow it will be obsoleted sooner 
> or later

The problem I see is the "new way" is done for the sake of doing 
something
new, without adding any value.  If you want to make the drivers 
dynamically
configurable, which I'll continue to argue is silly in an embedded 
environment
of the type with CPMs, all you need to know is personality of the 
device.
The reason it's silly is the wiring on the particular board dictates 
how a
CPM peripheral will be used.  The SCC1 can't be a serial uart one
moment and an Ethernet the next time you boot up.  Since you have 
already
done a "board port", you may as well wire this as part of the 
configuration
and eliminate potential mistakes.  If you insist on making this dynamic
(and as a port maintainer I would reject such patches), the only thing
you need to describe is the device type.  For example, the SCC1 can be
an Ethernet or uart.  We only support FCCs as Ethernets, and unless
someone submits some other kind of driver, like ATM/UTOPIA, there
isn't anything variable to configure.

All of the truly configurable options, like NMSI vs. TSA, are so complex
the device tree would not be helpful, as that would be built into the
custom driver to configure as necessary.

The offsets into the internal register maps are not so variable that 
adding
the information into the device tree is useful.  There is CPM1 and CPM2,
some common code shared between them that already solves the
problems, and the real difference between the two different CPM2 maps
on 82xx isn't reflected here (but again is already solved in the 
existing
software).  As I said in the past message, this seems more likely to 
cause
errors than be helpful.  To me it just seems new for the sake of being
new, rather than providing any real value.

I'd rather we spend our time adding the xmon and kgdb over serial port
features back into the driver that were lost during the "great driver 
clean up"
than pursing stuff like this.

Thanks.

	-- Dan
