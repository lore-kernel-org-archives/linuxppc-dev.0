Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] irq: move some interrupt arch_* functions into struct
	irq_chip.
From: Michael Ellerman <michael@ellerman.id.au>
To: ijc@hellion.org.uk
In-Reply-To: <1268218559-26784-2-git-send-email-ijc@hellion.org.uk>
References: <1268218524.11737.68547.camel@zakaz.uk.xensource.com>
	<1268218559-26784-2-git-send-email-ijc@hellion.org.uk>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-KHbI5v622dW6ZPGlHLT3"
Date: Thu, 11 Mar 2010 09:07:18 +1100
Message-ID: <1268258838.21103.6.camel@concordia>
Mime-Version: 1.0
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
	Ian Campbell <ian.campbell@citrix.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
	Yinghai Lu <yinghai@kernel.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-KHbI5v622dW6ZPGlHLT3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-03-10 at 10:55 +0000, ijc@hellion.org.uk wrote:
> From: Ian Campbell <ian.campbell@citrix.com>
>=20
> Move arch_init_copy_chip_data and arch_free_chip_data into function
> pointers in struct irq_chip since they operate on irq_desc->chip_data.
>=20
> arch_init_chip_data cannot be moved into struct irq_chip at this time
> because irq_desc->chip is not known at the time the irq_desc is
> setup. For now rename arch_init_chip_data to arch_init_irq_desc (for
> PowerPC, the only other user, whose usage better matches the new name)
> and on x86 convert arch_init_chip_data to ioapic_init_chip_data and
> call this whenever the IO APIC code allocates a new IRQ.

Ack on the name change, it should be called arch_init_irq_desc(), the
existing name clearly comes from the fact that sparse IRQ was
implemented first on x86, and on x86 that routine init's the chip data
for a new irq_desc.

But semantically arch_init_irq_desc() is the right name, I was just too
lazy to change it when I enabled sparse IRQ for powerpc.

Can't comment on the rest of the patch.

cheers


--=-KHbI5v622dW6ZPGlHLT3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkuYGBMACgkQdSjSd0sB4dLN/ACfWZPfIkahPG9Z8x+qpcPmosQV
dtMAoLEFx5ac475xxZcQm6j/Kym1XVck
=oYQ0
-----END PGP SIGNATURE-----

--=-KHbI5v622dW6ZPGlHLT3--
