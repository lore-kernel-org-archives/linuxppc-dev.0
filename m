Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E1FC52BDA0
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Oct 2004 00:25:59 +1000 (EST)
In-Reply-To: <A3240F62EF3C2749B1A25D3BC9548F4148BCF1@ExchWENZ02.wenz.global.vpn>
References: <A3240F62EF3C2749B1A25D3BC9548F4148BCF1@ExchWENZ02.wenz.global.vpn>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <721875C6-236D-11D9-9860-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 21 Oct 2004 10:28:15 -0400
To: "Richard Williams" <richard_williams@stratexnet.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Jeff Angielski <jangiels@speakeasy.net>
Subject: Re: SCC UART stalling/hanging - progress
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 21, 2004, at 1:06 AM, Richard Williams wrote:

> I think there is a bug in the driver where the interrupt is being 
> cleared in the wrong place. My final solution was to move the clearing 
> of events to be before receive_chars().

There is a race condition that this could fix.

> This way any new rx interrupts that occur while transmit_chars() is 
> executing will not get lost.

The race condition is actually that both receive and transmit 
processing will
loop on the BDs until it finds an empty one.  Between finding that 
first empty
BD and clearing the interrupts another interrupt could arrive.

I'll see that this gets propagated into the sources.

Since this didn't help Jeff, I have to ask, are you doing any kind
of flow control?  Either hardware or software?

Thanks.


	-- Dan
