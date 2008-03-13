Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 0DC0EDDEF6
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 00:56:30 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: michael@ellerman.id.au
Subject: Re: Interrupt handling documentation
Date: Thu, 13 Mar 2008 14:56:22 +0100
References: <200803111158.48540.laurentp@cse-semaphore.com>
	<1205283088.7544.8.camel@concordia.ozlabs.ibm.com>
In-Reply-To: <1205283088.7544.8.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1289909.h732PCNTiH";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803131456.26722.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1289909.h732PCNTiH
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Michael,

On Wednesday 12 March 2008 01:51, Michael Ellerman wrote:
> On Tue, 2008-03-11 at 11:58 +0100, Laurent Pinchart wrote:
> > Hi everybody,
> >
> > is there any documentation describing interrupt handling for the powerpc
> > architecture ? I'm writing a driver for a cascaded interrupt controller
> > and the only source of information I found was the code.
>
> I don't think there's much documentation.

I feared so :-)

> You might want to look at arch/powerpc/platforms/cell/axon_msi.c, it's a
> reasonably simple example of how to setup an irq_host and so on - well I
> think so :D

Thanks for the pointer.

> > I'm particularly interested in information about irq hosts (allocation
> > and initialisation, especially the map and unmap callbacks) and irq
> > chaining. Different drivers seem to implement cascaded irqs differently
> > (for instance arch/powerpc/sysdev/uic.c uses setup_irq to register the
> > cascaded irq handler, while arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
> > uses set_irq_chained_handler) so I'm a bit lost here.
>
> uic.c uses set_irq_chained_handler() now, so that probably answers that
> question. I don't think it makes all that much difference if you set it
> up by hand, but set_irq_chained_handler() is the neat way to do it.

That pretty much answers my question. It's always a bit disturbing when=20
different drivers use different APIs to accomplish the same task, especiall=
y=20
when the lack of documentation doesn't clearly state which API should be us=
ed=20
and which API is internal/deprecated.

Thanks for your answer.

Cheers,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=C3=A9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1289909.h732PCNTiH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH2TKK8y9gWxC9vpcRArx7AKDJ+4Hzo9C5zAYV/lbvZMesIRTrkgCfWXNW
OiEhAhLgEnvUbh9yRq9owRg=
=AxYq
-----END PGP SIGNATURE-----

--nextPart1289909.h732PCNTiH--
