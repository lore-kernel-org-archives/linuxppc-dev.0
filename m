Return-Path: <dan@embeddedalley.com>
Received: from smtp105.biz.mail.re2.yahoo.com (smtp105.biz.mail.re2.yahoo.com
	[206.190.52.174]) by ozlabs.org (Postfix) with SMTP id 912E5DDDE7
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Feb 2007 05:04:05 +1100 (EST)
In-Reply-To: <1171075021.20494.0.camel@localhost.localdomain>
References: <989B956029373F45A0B8AF02970818900D444B@zch01exm26.fsl.freescale.net>
	<45CB28A6.3050607@freescale.com>
	<712E63F6-23D6-45EB-92F0-95656FF38BC4@embeddedalley.com>
	<1171075021.20494.0.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6CDAEEF1-B0ED-42E6-AA2C-6FD1CFCF462C@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: Discussion about iopa()
Date: Sat, 10 Feb 2007 13:04:03 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 9, 2007, at 9:37 PM, Benjamin Herrenschmidt wrote:

> We are fairly careful about not bloating fast path in general.

This isn't any fast path code, and the way the
exception handlers are growing it doesn't
seem to be a concern anyway.

> ....  It's more
> than a couple of memory accesses, especially with PTEs in highmem  
> where
> it involves kmap.

It is only a couple of memory accesses, even
less code than the TLB exception handlers.
Using highmem has a price any time it's
configured into a system, it's not unique in
this case.  In fact, in this case highmem
shouldn't be a concern any different than
the TLB exceptions.

I just don't understand how such a trivial
and useful function that does exactly what
we need in a very clean way generates so
much polarized discussion.  I'm beginning
to think it's just personal, since the only
argument against it is "I don't like it" when
the alternatives are just hacks at best that
still need to be "fixed up someday." :-)

The Linux VM implementation just sucks.
The majority of systems running this software
aren't servers and desktop PCs, it's embedded
SOCs with application specific peripherals.
They have attributes and are mapped in ways
that don't fit the "memory at 0" or "IO" model.
We have to find solutions to this, together.

Thanks.

	-- Dan
