Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5FD30DDF74
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 08:17:40 +1000 (EST)
Subject: Re: MMIO and gcc re-ordering issue
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthew Wilcox <matthew@wil.cx>
In-Reply-To: <20080527214241.GA22636@parisc-linux.org>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<1211859542.3286.46.camel@pasglop>
	<alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
	<1211922621.3286.80.camel@pasglop>
	<alpine.LFD.1.10.0805271421570.2958@woody.linux-foundation.org>
	<1211924335.3286.89.camel@pasglop>
	<20080527214241.GA22636@parisc-linux.org>
Content-Type: text/plain
Date: Wed, 28 May 2008 08:17:16 +1000
Message-Id: <1211926636.3286.100.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	tpiepho@freescale.com, linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-05-27 at 15:42 -0600, Matthew Wilcox wrote:
> On Wed, May 28, 2008 at 07:38:55AM +1000, Benjamin Herrenschmidt wrote:
> > A problem with __raw_ though is that they -also- don't do byteswap,
> > which is a pain in the neck as people use them for either one reason
> > (relaxed ordering) or the other (no byteswap) without always knowing the
> > consequences of doing so...
> 
> That's why there's __readl() which does byteswap, but doesn't do
> ordering ...

Ah, that one is news to me. I don't think we ever had it on powerpc :-)

> > I'm happy to say that __raw is purely about ordering and make them
> > byteswap on powerpc tho (ie, make them little endian like the non-raw
> > counterpart).
> 
> That would break a lot of drivers.

How many actually use __raw_ * ?

> > Some archs started providing writel_be etc... I added those to powerpc a
> > little while ago, and I tend to prefer that approach for the byteswap
> > issue.

> Those are for people who use big endian chips on little endian
> architectures.

Why limit them to LE architecture ? There is nothing fundamentally
speicifc to LE architectures here, and it's wrong to provide accessors
on some archs and not others. The endianness is a property of the device
registers. Current writel/readl are basically writel_le/readl_le. It
thus makes sense to have the opposite, ie, readl_be/writel_be, which
thus byteswaps on LE platforms and not on BE platforms, which is what I
provided on powerpc a while ago.

Ben.
