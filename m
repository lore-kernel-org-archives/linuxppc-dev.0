Date: Sun, 14 Jan 2001 16:54:54 -0800
From: Keith Clayton <clay-ton@pacbell.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Fighting with Sonnet g3/l2 upgrade
Message-ID: <20010114165454.A443@yoda>
References: <20010113125616.A478@yoda> <19341209055331.21808@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
In-Reply-To: <19341209055331.21808@smtp.wanadoo.fr>; from benh@kernel.crashing.org on Sun, Jan 14, 2001 at 01:21:47PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Nope, the Sonnet card isn't providing an IDE interface.  But that got me
thinking.  Is it possible that the l2 card is grabbing the interrupt in
question? Is there some way to check what interrupt values are being used
in the MacOS?  I can't check the Sonnet card in linux b/c linux won't boot
with it activated.  I do know that my ide interface is using interrupt 13.

Ohare based bridge.  I did some checking in the ide-pmac.c code and it
it appears that 13 is "picked out of the air".  Could this be the source of
the problem . . that the card utilizes an interrupt that matches the ide
interface?  Since the card isn't on the pci bus any sort of resource
management is out the window.

Now, supposing I were to go into ide-pmac and hard code an interrupt of 14
for the ohare bridge, rather than 13.  Are there other places in the code
that I need to worry about this (14 is a free irq according to
/proc/interrupts when I boot sans Sonnet card).

Thanks for taking the time to help figure out what's up with this.

Cheers,
Keith


On Sun, Jan 14, 2001 at 01:21:47PM +0100, Benjamin Herrenschmidt wrote:
> >Also, while this is probably a BAD idea, is it possible to create a BootX
> >build
> >where the g_l2cr_available (i think that's right) flag is set to true
> from the
> >start so that the Set G3 cache option is available for me?  Using the
> >powerlogix util I can find the G3 Cache value and I can use resedit to s=
et it
> >by hand in the BootX Settings file. Then maybe have a bunch of debugging
> >output or something.
> >
> >I don't expect this to be a magic bullet or anything but I'm hoping to
> >understand where things are going wrong and see if it can be worked arou=
nd.
> >
> >Sorry to bug you Ben . . if I had CodeWarrior myself, I'd be able to do =
more
> >experimentation myself first.
>=20
> The hda: lost interrupt problems and the G3/L2 cache issues are 2
> different things.
>=20
> Is your Sonet card also providing an IDE interface ? In this case, it's
> possible that the chipset on this card is not supported by 2.2.18 without
> the big IDE patch (which need to be fixed for powerpc).
>=20
> For the G3, I'd rather figure out the correct L2CR value and "fix" it
> from userland (via /proc)
>=20
> Ben.

--=20
<><><><><><><><><><><><>
Keith Clayton
clay-ton@pacbell.net

"If you don't trust me with your source code,
            why should I trust you with my computer?"

GPG key: http://home.pacbell.net/clay-ton/keith_public_key.html        =20
         http://www.keyserver.net                            =20
=20
GPG fingerprint: 0C47 F1A1 0434 588C 9457  D53F D86A 5449 43F6 09A0 =20



--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature
Content-Disposition: inline


--OgqxwSJOaUobr8KG--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
