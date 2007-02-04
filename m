Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 82F9CDDE42
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Feb 2007 10:50:10 +1100 (EST)
Subject: Re: [PATCH] [3/9] pasemi: Machine check handler
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070202045508.119282000@lixom.net>>
References: <20070202045448.145851000@lixom.net> >
	<20070202045508.119282000@lixom.net>>
Content-Type: text/plain
Date: Mon, 05 Feb 2007 10:49:57 +1100
Message-Id: <1170632998.2620.50.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-02-01 at 22:54 -0600, Olof Johansson wrote:
> plain text document attachment (pasemi-machine-check)
> Print out decoded machine check information on PA6T.
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

Not specific to your patch, but in general, Machine Check might happen
while MSR:EE is off... which means the kernel might dislike printk being
called from the MC handler under some circumstances (for example,
re-entering printk itself in places it doesn't expect to be).

Might be worth, when the MC is recoverable, to try to "defer" the
printout to some real irq or timer irq 

Ben.
