Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id B02DCDDFA9
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 22:37:23 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 19 Jun 2007 14:37:21 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <81b5cc3c799c9ec65df04468d4d9051e@kernel.crashing.org>
Message-ID: <20070619123721.202110@gmx.net>
MIME-Version: 1.0
References: <20070618185715.321010@gmx.net>
	<20070619054232.GB32039@localhost.localdomain>
	<20070619084015.202120@gmx.net>
	<73aafd0955b8ea695af9221b48aaa3f1@kernel.crashing.org>
	<20070619095251.202080@gmx.net>
	<81b5cc3c799c9ec65df04468d4d9051e@kernel.crashing.org>
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
Datum: Tue, 19 Jun 2007 12:08:06 +0200
Von: Segher Boessenkool <segher@kernel.crashing.org>
An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
CC: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
Betreff: Re: [RFC] Device tree for new desktop platform in arch/powerpc

> > I guess I can define both of them or do they conflict (IIRC
> > the two hardware revision should be compatible)?
> 
> Use one or the other, not both.  Perhaps you'll need
> to add the pnpPNP,500 and pnpPNP,501 entries to the
> generic OF serial code, should be trivial to do.
I guess I stick with compatible = "serial" for now, as it should
also work with the generic serial console support code.

> The 16550A supports something the 16550 doesn't (don't
> ask me what, I forgot :-) ), so don't say it is an A
> when it isn't; the other way around is fine though.
> 
> And it doesn't matter much for Linux anyway currently,
> the "generic" kernel driver will do its own wacky probing.
Yes, that's why the current AmigaOne kernels (2.6.16) detect 3 serial
ports, whereas there should be only 2 (the first two are detected by
probing for the VIA southbridge and the last one IIRC is registered by
request_region()). I hope the device tree fixes this.

> > Where are all this "pnpPNP,xxx" identifiers specified (except
> > for serial parallel, fdc, keyboard, mouse)?
> 
> They are defined by the vendor of the devices; for
> vendor "PNP", i.e. legacy non-PNP PC devices, that
> is MicroSoft.
Downloaded the file you pointed to and the OF generic names document. I
thought the OF core specification defines them, but it's not available
freely.

Thanks a lot!

Gerhard
-- 
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! 
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
