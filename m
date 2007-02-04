Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 22AA7DDE37
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Feb 2007 10:45:11 +1100 (EST)
Subject: Re: [Cbe-oss-dev] spidernet: dynamic phy setup code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jens Osterkamp <jens@de.ibm.com>
In-Reply-To: <200702011204.30526.jens@de.ibm.com>
References: <200702010805.l11853LX014768@toshiba.co.jp>
	<200702011204.30526.jens@de.ibm.com>
Content-Type: text/plain
Date: Mon, 05 Feb 2007 10:44:32 +1100
Message-Id: <1170632672.2620.47.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, jgarzik@pobox.com,
	jim@jklewis.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-02-01 at 12:04 +0100, Jens Osterkamp wrote:
> Ishizaki-san,
> 
> > This patch partially works on celleb but remains 
> > following several problems.
> > 1. It doesn't recover once an ethernet cable which is
> >    connected to a spider_net card is unpluged. 
> 
> My understanding is that you are using the LINK interrupt to detect this.
> For the blade this is not connected but reenabling it wont hurt, I hope.

I would suggest just polling from a delayed work or a timer like sungem
does.

> I still dont see why you need different settings for different speed switches.
> This is getting to a point where access to some hardware would be handy.
> What exact phy are using anyway ?

Yeah, same question...

> > Furthermore, we have a problem that poll_link() may succeed even when
> > the auto-neg initial setting is for different network switch type,
> > and the network card does not work on this case. We retry auto-neg
> > with the another initial setting on this case.
> 
> See above, could you give some more details why this is the case. Or maybe Ben
> knows more about this ?

No, I'm surprised too.

Ben.
