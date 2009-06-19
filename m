Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6BBEDB7255
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Jun 2009 01:31:56 +1000 (EST)
MIME-Version: 1.0
In-Reply-To: <20090619132501.GA10886@oksana.dev.rtsoft.ru>
References: <4A39DC80.7030906@arvoo.nl>
	<20090618130955.GA1369@oksana.dev.rtsoft.ru>
	<EEB9B7B7-5456-4AE9-8BB9-96DA04320697@kernel.crashing.org>
	<c384c5ea0906190445u130a4fedv14c22c7f9abdb9d8@mail.gmail.com>
	<20090619132501.GA10886@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 19 Jun 2009 09:31:33 -0600
Message-ID: <fa686aa40906190831t2532e978pc1ec647d39e69b8d@mail.gmail.com>
Subject: Re: [PATCH -mm][POWERPC] mpc8xxx : allow SPI without cs.
To: avorontsov@ru.mvista.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net, Rini van Zetten <rini@arvoo.nl>,
	linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 19, 2009 at 7:25 AM, Anton
Vorontsov<avorontsov@ru.mvista.com> wrote:
> Surely we can hide the bridge into the SPI controller driver,
> but I think it would be beneficial to "factor-out" it to a
> stand-alone entity, so that other SPI controllers could work
> with this setup without any modifications (oh and btw, we could
> also create a bridge called "gpio-chipselects-bridge", and
> factor out all GPIO stuff from the drivers).
>
> There are two options of how we can factor out chip-select
> machines... the bad and the ugly. :-) No, the first one is bad,
> but the second should be OK.
[...]
> 2. Another option (which I like more), is to create "SPI chip-
> =A0 select machine driver framework", so we could (finally)
> =A0 separate two SPI entities: SPI IO and SPI chip-select machine.
> =A0 CS machines of different flavours: GPIO, built-in, and
> =A0 board-specific (!) with a lot of demuxing magic.

I agree, I think your option 2 is the way to go.  It would probably
need to be implemented as some form of logical bridge so that SPI
requests don't go straight to the IO driver, but first go through the
CS machine so that the CS driver can do funky stuff like inserting or
modifying SPI requests before they go to the hardware.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
