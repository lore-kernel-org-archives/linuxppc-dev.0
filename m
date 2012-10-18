Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 36D2C2C0092
 for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2012 10:26:26 +1100 (EST)
Message-ID: <1350602739.2476.18.camel@pasglop>
Subject: Re: PROBLEM: Linux 3.6.2 fails to boot on IBM Cell
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 19 Oct 2012 10:25:39 +1100
In-Reply-To: <CACxGe6uehfQZOxhtBfUYR47mQq+620A=pvpRM=9O8FoUX9eg7w@mail.gmail.com>
References: <5521875.6lkx8Qvfk5@ernie> <2594570.cnhHoOP5cq@ernie>
 <CACxGe6tdpCiZtpvrb7VUz9=mc6DqG6wO-Z5axaBMzuU2Y14GmA@mail.gmail.com>
 <3999612.yr3XeWjcOk@ernie>
 <CACxGe6uehfQZOxhtBfUYR47mQq+620A=pvpRM=9O8FoUX9eg7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Dennis Schridde <devurandom@gmx.net>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-10-18 at 23:44 +0100, Grant Likely wrote:
> Also, it should be noted that the irq does actually get set up by
> irqdomain.c, but because everything above 0x1ff is larger than the
> lookup table, it complains. The new code complains loudly (as you
> discovered) if someone tries to use a hwirq larger than the map where
> the old code didn't.
> 
> Looks to me like the fix is to change for_each_node() to something as
> simple as "for (i = 0; i < 2; i++)"

I think somebody was expecting for_each_node() to iterate only present
nodes or something ... Not all Cell systems have both nodes btw, so we
might want to be a tiny bit smarter than that .... or not :-)

Cheers,
Ben.
