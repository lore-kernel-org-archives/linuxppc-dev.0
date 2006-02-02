Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5D666689F9
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Feb 2006 21:44:18 +1100 (EST)
Date: Thu, 2 Feb 2006 02:44:15 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
Subject: Re: Yosemite/440EP why are readl()/ioread32() setup
	toreadlittle-endian?
Message-ID: <20060202104415.GC12810@gate.ebshome.net>
References: <35786B99AB3FDC45A8215724617919736D921D@gbrwgceumf01.eu.xerox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <35786B99AB3FDC45A8215724617919736D921D@gbrwgceumf01.eu.xerox.net>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Feb 02, 2006 at 10:28:05AM -0000, Jenkins, Clive wrote:
> And what about direct connection to the local bus of the processor chip?

What about it? It's _chip_ specific. And the way your "generic" stuff 
will be connected to it will be chip or even design specific (yeah, hw 
guys sometime wire it in some weird way). I fail to see how you can 
have _generic_ I/O accessors for this case.

>  
> > So basically, you have no _real_ life examples, so I'm wondering why 
> > people need this "arch-independent" non-PCI I/O accessors for 
> > something which doesn't exist.
> 
> I could draft a design of such an example, and I could realise that
> design
> by building it. But I don't want to spend the time and money doing it.
> Neither do I want to spend time researching _real_ examples.
> It is much easier to allow for obvious possibilities that _could_ exist
> and probably will exist if they don't already, than searching the world.

It's not as easy as you might think :). It must be 
arch/bus/device/board specific in the general case. 

You can try _specifying_ semantics for such generic accessors and 
_then_ we can discuss this and I will very likely give you _real_ 
world examples when they will not work.

> Why be PCI-centric now, when we have experienced no end of problems
> because Linux was x86-centric in the past?

Well, until there is another _standard_ bus which is used on 
different archs, having _generic_ cross-arch I/O accessors doesn't 
make any sense.

I don't understand your point about not being PCI specific. It's of no 
relevance what you or I think about PCI and x86. I have ported several 
"standard" bus drivers to chip specific interconnects (MIPS and PPC) 
and in every case code was bus or even board specific. I'm pretty much 
aware about problems and solutions. But this is not what is being 
discussed here. Until there is _standard_ for such interconnects (like 
PCI) everything else is just wishful thinking.

-- 
Eugene
