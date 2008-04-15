Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ABE82DE14D
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 18:23:33 +1000 (EST)
Received: from themisto.extern.pengutronix.de ([83.236.181.29] helo=localhost)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <jbe@pengutronix.de>) id 1Jlg8M-00045a-Lo
	for linuxppc-dev@ozlabs.org; Tue, 15 Apr 2008 10:03:24 +0200
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Date: Tue, 15 Apr 2008 10:03:17 +0200
References: <47FDEF9B.5000506@semihalf.com> <47FF135E.2060003@246tnt.com>
In-Reply-To: <47FF135E.2060003@246tnt.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804151003.17865.jbe@pengutronix.de>
Subject: Re: State of the MPC5200 PSC AC97 driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 11 April 2008 09:29, Sylvain Munaut wrote:
> > Last year you have posted a MPC5200 PSC AC97 driver patch
> > "[PATCH 9/9] sound: Add support for Freescale MPC5200 AC97 interface."
> >
> > with the following comment:
> >> Not quite a clean driver, but it get things done (well, mostly).
> >> Only included to be able to test functionalityi/usage of
> >> the BestComm driver.
>
> Yes ... and it still applies.
>
> > There are various FIXMEs and commented out code here and there.
> > Could you elaborate a bit on the overall state of the driver's
> > functionality,
> > which areas need improvement and attention?
>
> It's a minimum boiler plate.
> I filled the function at the minimum to get some sound output and being
> able to hear music coming out of it :)
> I also completely skipped the 5200 (not B) support ...
>
> At first there was no DMA at all (full software copy). I added some
> simple DMA later just to prove it could work and how to use the API.
>
> I just wrote it to get some sound, prove the interface could work under
> linux and to show how to use DMA. I had hoped someone else would finish
> it ... (yeah, I know ... big mistake).
>
> > Seems that you mainly tested BestComm with this driver, what was the
> > overall
> > BestComm performance, any issues here? Did you use any specific test
> > setup involving some dedicated application, etc.?
>
> My test was listening to Gorrillaz "Feel Good inc" using mplayer ...
>
> > Did anyone else tried it and/or has a updated version or can share
> > experience?
>
> At the time several other people tried it and it worked ... unless you
> did lots of harddrive IO and then it crumbled ...

Currently it fails to play anything with an external Wolfson WM9712 connect=
ed=20
to it. It seems the current AC97 reset sequence switches the WM9712 into=20
testmode due to SDATA_OUT and Sync are not held low while the reset is=20
active. Any idea to solve this? Switching both signals to GPIO and force th=
em=20
to low level while reset is active? How to cover PSC1 and PSC2 with differe=
nt=20
GPIOs for this case?

Juergen
=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
