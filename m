Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A202867F88
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Aug 2005 14:58:38 +1000 (EST)
In-Reply-To: <20050823022011.GE9667@dmt.cnet>
References: <20050823022011.GE9667@dmt.cnet>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f45653d49c79423af587cff97181ac74@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 23 Aug 2005 00:58:21 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Enabling 8xx debug mode
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 22, 2005, at 10:20 PM, Marcelo Tosatti wrote:

> I know now that the BDI automatically enables debug mode by asserting
> the DSCK signal (available through the JTAG port). Is there any way
> to enable debugging mode purely via software?

I'm not sure I really understand the question, but I'll give some
answers anyway :-)  The 8xx has the development/debug support,
which is a bunch of registers that allow setting instruction/data
breakpoints and so on.  These are accessible from software, along
with other standard PowerPC debug (like single step).

The DSCK is a BDM/JTAG clock signal, and along with the other
signals allow the clocking of instructions and data through the BDM
pins.  One of the things you can do is strobe in instructions that will
set these same breakpoint or other debug registers as are accessible
from software running on the part.

So, if you have software running on the processor, you can do the
same things.  Obviously, if you are stuck someplace you need to
get the attention of the processor.  You can do this with some interrupt
like kgdb does, then use the debug interface to help.

Does this make sense?

Thanks.

	-- Dan
