Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay009.isp.belgacom.be (mailrelay009.isp.belgacom.be
	[195.238.6.176]) by ozlabs.org (Postfix) with ESMTP id 147EEDDE42
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 02:28:40 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: avorontsov@ru.mvista.com
Subject: Re: CPM2 USB host driver
Date: Fri, 30 Nov 2007 16:28:27 +0100
References: <200711301145.52926.laurentp@cse-semaphore.com>
	<200711301330.25100.laurentp@cse-semaphore.com>
	<20071130124801.GA13141@localhost.localdomain>
In-Reply-To: <20071130124801.GA13141@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1253608.uRCErA5FLE";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200711301628.33526.laurentp@cse-semaphore.com>
Cc: mike@compulab.co.il, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1253608.uRCErA5FLE
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 30 November 2007 13:48, Anton Vorontsov wrote:
> On Fri, Nov 30, 2007 at 01:30:18PM +0100, Laurent Pinchart wrote:
> > On Friday 30 November 2007 12:16, Vitaly Bordug wrote:
> > > On Fri, 30 Nov 2007 11:45:49 +0100
> > >
> > > Laurent Pinchart wrote:
> > > > Hi everybody,
> > > >
> > > > Linux USB host support for the CPM, CPM2 and CPM2 pro is far from
> > > > complete. Many people showed interest on this list (and on
> > > > linuxppc-embedded) in the past, but nobody managed to complete a
> > > > driver and get it merged.
> > >
> > > that is mainly because of its semi-software nature. However, any
> > > approach would be helpful I beleive.
> >
> > The CPM/CPM2 USB host controller does indeed put some pressure on the
> > CPU. The PowerQuick III family is much better in that respect as its USB
> > host controller is EHCI compliant.
>
> I didn't yet compare with CPM/CPM2, but I wonder if PQIIPro (MPC8360E)
> USB controller is similar to cpms?..

If I'm not mistaken it is very similar to the CPM2 USB host controller, wit=
h=20
the added ability to generate SOF packets automatically.

The CPM has a packet-level USB host controller. CPM2 introduced a=20
transaction-level mode (it still supports packet-level mode). CPM2 pro fixe=
s=20
the SOF packets generation issue that wakes the CPU once per millisecond wi=
th=20
CPM and CPM2.

Some members of the PQ2 and PQ2 pro families don't have a CPM but include a=
=20
USB EHCI controller. I suppose those processors are less versatile (as the=
=20
communication controllers are hardware-based instead of software-based) but=
=20
offer more communication performance.

If I'm not mistaken, the only processor to support USB in the PQ3 family is=
=20
the MPC8555E. Its USB host controller is similar to the CPM2 as it supports=
=20
both packet-level and transaction-level modes, but doesn't generate SOF=20
packets automatically. I assume the PQ3 integrates a CPM2 and not a CPM2 pr=
o.

To summarize the issue (and I'd appreciate if someone could confirm this), =
a=20
packet-level FHCI driver would work with CPM, CPM2 and CPM2 pro based=20
processors. A transaction-level FHCI driver would work with the CPM2 and CP=
M2=20
pro based processors. For CPM2 pro based processors, SOF packet generation=
=20
can be handled by the CPM.

> I tried to forward-port FHCI from Freescale 2.6.11 kernels. Twice.
> But these efforts always stumbled over more important tasks.

Do you think I start from the FHCI driver provided by Freescale for 2.6.11,=
=20
from the cpm2usb driver or from scratch ?

Both the cpm2usb and FHCI drivers seem to use the packet-level interface. I=
s=20
there any reason not to use the transaction-level interface ?

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=C3=A9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1253608.uRCErA5FLE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBHUCwh8y9gWxC9vpcRAnM3AJ9AXs6magCh+qapZSTTxnKRUAXEMQCgucz0
nzxYZfccclrHMIAITd5lSzE=
=Nja6
-----END PGP SIGNATURE-----

--nextPart1253608.uRCErA5FLE--
