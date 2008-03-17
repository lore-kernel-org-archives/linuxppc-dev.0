Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 6533EDDF4B
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 03:13:56 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Interrupt handling documentation
Date: Mon, 17 Mar 2008 17:13:48 +0100
References: <200803111158.48540.laurentp@cse-semaphore.com>
	<1205283088.7544.8.camel@concordia.ozlabs.ibm.com>
	<200803131456.26722.laurentp@cse-semaphore.com>
In-Reply-To: <200803131456.26722.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4454140.YOZzAO1IO5";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803171713.51671.laurentp@cse-semaphore.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart4454140.YOZzAO1IO5
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 13 March 2008 14:56, Laurent Pinchart wrote:
> Hi Michael,
>
> On Wednesday 12 March 2008 01:51, Michael Ellerman wrote:
> > On Tue, 2008-03-11 at 11:58 +0100, Laurent Pinchart wrote:
> > > Hi everybody,
> > >
> > > is there any documentation describing interrupt handling for the
> > > powerpc architecture ? I'm writing a driver for a cascaded interrupt
> > > controller and the only source of information I found was the code.
> >
> > I don't think there's much documentation.
>
> I feared so :-)
>
> > You might want to look at arch/powerpc/platforms/cell/axon_msi.c, it's a
> > reasonably simple example of how to setup an irq_host and so on - well I
> > think so :D
>
> Thanks for the pointer.
>
> > > I'm particularly interested in information about irq hosts (allocation
> > > and initialisation, especially the map and unmap callbacks) and irq
> > > chaining. Different drivers seem to implement cascaded irqs different=
ly
> > > (for instance arch/powerpc/sysdev/uic.c uses setup_irq to register the
> > > cascaded irq handler, while
> > > arch/powerpc/platforms/82xx/pq2ads-pci-pic.c uses
> > > set_irq_chained_handler) so I'm a bit lost here.
> >
> > uic.c uses set_irq_chained_handler() now, so that probably answers that
> > question. I don't think it makes all that much difference if you set it
> > up by hand, but set_irq_chained_handler() is the neat way to do it.
>
> That pretty much answers my question. It's always a bit disturbing when
> different drivers use different APIs to accomplish the same task,
> especially when the lack of documentation doesn't clearly state which API
> should be used and which API is internal/deprecated.

I've been struggling with spurious interrupts related to my irq host for a=
=20
day. Now that I've been able to solve the problem I thought I'd share the=20
results here.

The PIC I am working with is linked to a falling-edge external irq on the=20
CPM2. When the first PIC interrupt was generated the kernel called the PIC=
=20
chained irq handler endlessly.

After some investigation it turned out the external interrupt bit in the CP=
M2=20
interrupt pending register never got cleared. set_irq_chained_handler()=20
registers the chained irq handler at the lowest level in the irq stack,=20
bypassing all the interrupt acknowledgement/masking logic.

The fix was easy, all I had to do was to call desc->chip->ack(irq) at the=20
beginning on the chained irq handler and desc->chip->eoi(irq) at the end.=20
However, I'm wondering if this really belongs in the PIC code, or if PICs=20
shouldn't be registered at a higher level (setup_irq or even request_irq) s=
o=20
that they would reuse the handle_*_irq handlers. Any opinion on this ?

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=C3=A9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart4454140.YOZzAO1IO5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH3pi/8y9gWxC9vpcRAmI2AJ9r3pSo8cdiKbjNhKl9U51HYCkLewCfdWjf
Jal8+8msRntzAcd/q7yjgfE=
=i26s
-----END PGP SIGNATURE-----

--nextPart4454140.YOZzAO1IO5--
