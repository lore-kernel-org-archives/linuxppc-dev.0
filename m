Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] mm: Check we have the right vma in access_process_vm()
From: Michael Ellerman <michael@ellerman.id.au>
To: Michel Lespinasse <walken@google.com>
In-Reply-To: <BANLkTi=RJ2GHvHQ3mZiQ-L-MTVUQH-V-eA@mail.gmail.com>
References: <c4f5166f98cb703742191eb74f583bb8011f9cdf.1301984663.git.michael@ellerman.id.au>
	<BANLkTi=RJ2GHvHQ3mZiQ-L-MTVUQH-V-eA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-nLXr8uPyUESvFTc0bAW4"
Date: Fri, 08 Apr 2011 17:17:03 +1000
Message-ID: <1302247023.5744.44.camel@concordia>
Mime-Version: 1.0
Cc: aarcange@redhat.com, Andrew Morton <akpm@osdl.org>, riel@redhat.com,
	linuxppc-dev@ozlabs.org, hughd@google.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-nLXr8uPyUESvFTc0bAW4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2011-04-04 at 23:42 -0700, Michel Lespinasse wrote:
> On Mon, Apr 4, 2011 at 11:24 PM, Michael Ellerman
> <michael@ellerman.id.au> wrote:
> > In access_process_vm() we need to check that we have found the right
> > vma, not the following vma, before we try to access it. Otherwise
> > we might call the vma's access routine with an address which does
> > not fall inside the vma.
> >
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>=20
> Please note that the code has moved into __access_remote_vm() in
> current linus tree.

Ah good point, if git hadn't done such a good job of merging it I would
have noticed :)

I'll send a new version with a corrected changelog.

> Also, should len be truncated before calling vma->vm_ops->access() so
> that we can guarantee it won't overflow past the end of the vma ?

The access implementations I've looked at check len, but I guess it
could be truncated on the way in. But maybe that's being paranoid, I
dunno.

cheers


--=-nLXr8uPyUESvFTc0bAW4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk2etmoACgkQdSjSd0sB4dKa0gCguGfnLjk1m+jsQBXWGJWeIegS
tYAAoI4Pp5TyVwDtf/QAbqtYI8HwWzsd
=wPcR
-----END PGP SIGNATURE-----

--=-nLXr8uPyUESvFTc0bAW4--
