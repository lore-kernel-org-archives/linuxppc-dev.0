Return-Path: <Clive.Jenkins@xerox.com>
Received: from wbmler3.mail.xerox.com (wbmler3.mail.xerox.com [13.13.138.218])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "wbmler3.mail.xerox.com",
	Issuer "wbmler3.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7DDDA68A73
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Feb 2006 22:28:09 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Yosemite/440EP why are readl()/ioread32()
	setuptoreadlittle-endian?
Date: Thu, 2 Feb 2006 11:26:22 -0000
Message-ID: <35786B99AB3FDC45A8215724617919736D921E@gbrwgceumf01.eu.xerox.net>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: "Eugene Surovegin" <ebs@ebshome.net>
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

I'm not sure all this fuss is justified in response to:

> What is the preferred way of accessing non-PCI devices then?
> Direct pointer access?
> Bye, Peter Korsgaard

Regardless of what standards or hardware might exist, I would be
happy if Linux provided alternatives to readl()... that converted
between big-endian and cpu-endian, so that I could write in my
driver, for example:

static inline my_readl(...)
{
#if (my interconnect is PCI or other little-endian)
    return(readl(...));
#else
    return(readl_be(...));
#endif
}

That must make my driver more portable in future circumstances.

Clive


-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Eugene
Surovegin
Sent: 02 February 2006 10:44
To: Jenkins, Clive
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Yosemite/440EP why are readl()/ioread32()
setuptoreadlittle-endian?


On Thu, Feb 02, 2006 at 10:28:05AM -0000, Jenkins, Clive wrote:
> And what about direct connection to the local bus of the processor
chip?

What about it? It's _chip_ specific. And the way your "generic" stuff=20
will be connected to it will be chip or even design specific (yeah, hw=20
guys sometime wire it in some weird way). I fail to see how you can=20
have _generic_ I/O accessors for this case.

> =20
> > So basically, you have no _real_ life examples, so I'm wondering why

> > people need this "arch-independent" non-PCI I/O accessors for=20
> > something which doesn't exist.
>=20
> I could draft a design of such an example, and I could realise that
> design
> by building it. But I don't want to spend the time and money doing it.
> Neither do I want to spend time researching _real_ examples.
> It is much easier to allow for obvious possibilities that _could_
exist
> and probably will exist if they don't already, than searching the
world.

It's not as easy as you might think :). It must be=20
arch/bus/device/board specific in the general case.=20

You can try _specifying_ semantics for such generic accessors and=20
_then_ we can discuss this and I will very likely give you _real_=20
world examples when they will not work.

> Why be PCI-centric now, when we have experienced no end of problems
> because Linux was x86-centric in the past?

Well, until there is another _standard_ bus which is used on=20
different archs, having _generic_ cross-arch I/O accessors doesn't=20
make any sense.

I don't understand your point about not being PCI specific. It's of no=20
relevance what you or I think about PCI and x86. I have ported several=20
"standard" bus drivers to chip specific interconnects (MIPS and PPC)=20
and in every case code was bus or even board specific. I'm pretty much=20
aware about problems and solutions. But this is not what is being=20
discussed here. Until there is _standard_ for such interconnects (like=20
PCI) everything else is just wishful thinking.

--=20
Eugene

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
