Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 30137DDE02
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 16:20:09 +1100 (EST)
Date: Fri, 4 Apr 2008 00:29:55 -0500
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] PowerPC: MPIC ack interrupts at mpic_teardown_this_cpu()
Message-ID: <20080404052955.GC11799@lixom.net>
References: <20080403190943.GA16446@ru.mvista.com>
	<1207259436.10388.337.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1207259436.10388.337.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 04, 2008 at 08:50:36AM +1100, Benjamin Herrenschmidt wrote:
> 
> On Thu, 2008-04-03 at 23:09 +0400, Valentine Barshak wrote:
> > We really need to ack interrupts at mpic_teardown, since
> > not all platforms reset mpic at kernel start-up. For example,
> > kexec'ed kernel hangs on P.A. Semi if mpic_eoi() isn't called.
> > 
> > Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> > ---
> 
> Would be interesting to find out why it hangs tho... it shouldn't .

I haven't reproduced the problem and looked at hardware state yet, but I
would expect it to be because the openpic won't send another interrupt
until the previous is EOI'd, and the IPI is never EOI'd as far as I
can tell.

The XICS code does it explicitly already. I'm surprised it doesn't break
on the 970-based platforms actually...


-Olof
