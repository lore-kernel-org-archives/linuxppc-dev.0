Return-Path: <stuart.yoder@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 7513CDDEA2
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 05:57:34 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l1JIvSCa019528
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Feb 2007 11:57:28 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l1JIvR0e017711
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Feb 2007 12:57:27 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: macros and dtc
Date: Mon, 19 Feb 2007 11:57:26 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302A1C2F1@az33exm25.fsl.freescale.net>
In-Reply-To: <F408B146-AC76-43F5-9D9D-0094BAF14941@embeddedalley.com>
References: <729E7ED6-D601-4D4C-B110-F951409BAE2B@kernel.crashing.org>
	<F408B146-AC76-43F5-9D9D-0094BAF14941@embeddedalley.com>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Dan Malek" <dan@embeddedalley.com>,
	"Kumar Gala" <galak@kernel.crashing.org>
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>, Jon Loeliger <jdl@jdl.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: linuxppc-dev-bounces+b08248=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+b08248=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of Dan Malek
> Sent: Monday, February 19, 2007 12:08 PM
> To: Kumar Gala
> Cc: Linux PPC Dev ML; Jon Loeliger; David Gibson
> Subject: Re: macros and dtc
>=20
>=20
> On Feb 18, 2007, at 11:58 AM, Kumar Gala wrote:
>=20
> > After spending some time this weekend cleaning up dts files=20
> I figured
> > it would be nice if we can some to consensus on how we are going to
> > do macro support.
>=20
> I'm not sure I'd like to use macros.  I can understand the case
> today where we are still changing too many things that a
> macro would be nice, but at some point this has to settle down.
> There isn't that much information in the file, and I prefer to
> see all of it clearly rather than locating macros to wonder
> how they need to be invoked.
>=20
> > There is clearly a lot of duplication between
> > dts's and it only gets worse when you add in slight variations for
> > revs of boards.
>=20
> Of the few boards for which I've had to create new dts
> files, I wonder how the macros would work.  Although the
> variations are slight, there are many variables.  A macro
> is going to have to allow nearly all of the property information
> as parameters, so what's the big savings?  If you are
> just using them to avoid syntax, then perhaps we should
> have chosen a different syntax? :-)  I think a macro with
> lots of parameters is more confusing than the syntax
> we currently use.
>=20
> I could envision using something like cpp with #include
> to get some standard SOC block properties, but macros
> that try to account for board variations could be quite
> complex.

Heavy use of parameterized macros could make reading
device trees more difficult.

But for basic things like #include and #define constants it
would be a good thing.

bus-frequency =3D <33MHZ> is much better than
bus-frequency =3D <13ab6680>

Same would go for interrupts, interrupt-map, etc.

There are lot's of hardcoded constants floating around
in the dts files that for clarity should be #defined (or
whatever the m4 equivalent is) at the top of the file.

Stuart
