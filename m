Return-Path: <michael@ellerman.id.au>
Subject: Re: Interrupt handling documentation
From: Michael Ellerman <michael@ellerman.id.au>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200803111158.48540.laurentp@cse-semaphore.com>
References: <200803111158.48540.laurentp@cse-semaphore.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-u2Pjugs8wLBB6Nf8IlN4"
Date: Wed, 12 Mar 2008 11:51:28 +1100
Message-Id: <1205283088.7544.8.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-u2Pjugs8wLBB6Nf8IlN4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-03-11 at 11:58 +0100, Laurent Pinchart wrote:
> Hi everybody,
>=20
> is there any documentation describing interrupt handling for the powerpc=20
> architecture ? I'm writing a driver for a cascaded interrupt controller a=
nd=20
> the only source of information I found was the code.

I don't think there's much documentation.

You might want to look at arch/powerpc/platforms/cell/axon_msi.c, it's a
reasonably simple example of how to setup an irq_host and so on - well I
think so :D

> I'm particularly interested in information about irq hosts (allocation an=
d=20
> initialisation, especially the map and unmap callbacks) and irq chaining.=
=20
> Different drivers seem to implement cascaded irqs differently (for instan=
ce=20
> arch/powerpc/sysdev/uic.c uses setup_irq to register the cascaded irq=20
> handler, while arch/powerpc/platforms/82xx/pq2ads-pci-pic.c uses=20
> set_irq_chained_handler) so I'm a bit lost here.

uic.c uses set_irq_chained_handler() now, so that probably answers that
question. I don't think it makes all that much difference if you set it
up by hand, but set_irq_chained_handler() is the neat way to do it.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-u2Pjugs8wLBB6Nf8IlN4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH1ykQdSjSd0sB4dIRAnzgAKDEjqEQ1rkgYs2iIpumdTzZBKepaQCeMymC
xlF7FvMKpF6I6kMNbZfzAPQ=
=ZkC0
-----END PGP SIGNATURE-----

--=-u2Pjugs8wLBB6Nf8IlN4--
