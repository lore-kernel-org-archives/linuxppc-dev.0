Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 8F0BBDDE31
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Feb 2007 15:11:54 +1100 (EST)
Date: Sun, 4 Feb 2007 22:19:19 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] [3/9] pasemi: Machine check handler
Message-ID: <20070205041919.GA4719@lixom.net>
References: <20070202045448.145851000@lixom.net>
	<20070202045508.119282000@lixom.net>>
	<1170632998.2620.50.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1170632998.2620.50.camel@localhost.localdomain>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 05, 2007 at 10:49:57AM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2007-02-01 at 22:54 -0600, Olof Johansson wrote:
> > plain text document attachment (pasemi-machine-check)
> > Print out decoded machine check information on PA6T.
> > 
> > 
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> Not specific to your patch, but in general, Machine Check might happen
> while MSR:EE is off... which means the kernel might dislike printk being
> called from the MC handler under some circumstances (for example,
> re-entering printk itself in places it doesn't expect to be).
> 
> Might be worth, when the MC is recoverable, to try to "defer" the
> printout to some real irq or timer irq 

Right. There are some other fixups to be done too that I will look at
later, for example all machine checks are still passed through a 32-bit
decoder after the ppc_md one. It can be quite confusing and should
probably be moved out to ppc_machdep handlers on all platforms instead.

I'll try to have some cleanup of the generic code for 2.6.22. Meanwhile
I think this can go in.


-Olof
