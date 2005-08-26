Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D436B6807F
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Aug 2005 06:13:34 +1000 (EST)
In-Reply-To: <Pine.LNX.4.61.0508261415080.29975@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0508261415080.29975@nylon.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f0351d402e64b569bbcfc16fa921d860@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 26 Aug 2005 16:13:04 -0400
To: Kumar Gala <galak@freescale.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc32: add CONFIG_HZ
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 26, 2005, at 3:15 PM, Kumar Gala wrote:

> While ppc32 has the CONFIG_HZ Kconfig option, it wasnt actually being
> used. Connect it up and set all platforms to 250Hz.  This pretty much
> mimics the ppc64 patch from Anton Blanchard.

Why do we keep cranking up this clock frequency?  Do we really need
it running that fast?  Is it time for someone with RTOS experience to
implement a real scheduled clock queue in Linux instead of just
wasting interrupts decrementing a counter waiting for the next
event to expire?  :-)  If the user "ticks" are still 100 Hz, don't we 
need
something that is an integer multiple of that for at least an attempt
at getting it close to what a user would request?

Thanks.

	-- Dan
