Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E3B5B1A0133
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 12:47:50 +1100 (AEDT)
Date: Thu, 12 Mar 2015 11:57:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] drivers/vfio: Support EEH error injection
Message-ID: <20150312005721.GP11973@voom.redhat.com>
References: <1426055651-22925-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1426055651-22925-2-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="WKQ7zUpzoH2KEHMN"
In-Reply-To: <1426055651-22925-2-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, linuxppc-dev@ozlabs.org, alex.williamson@redhat.com,
 agraf@suse.de, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--WKQ7zUpzoH2KEHMN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2015 at 05:34:11PM +1100, Gavin Shan wrote:
> The patch adds one more EEH sub-command (VFIO_EEH_PE_INJECT_ERR)
> to inject the specified EEH error, which is represented by
> (struct vfio_eeh_pe_err), to the indicated PE for testing purpose.
>=20
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  Documentation/vfio.txt        | 47 ++++++++++++++++++++++++++++++-------=
------
>  drivers/vfio/vfio_spapr_eeh.c | 14 +++++++++++++
>  include/uapi/linux/vfio.h     | 34 ++++++++++++++++++++++++++++++-
>  3 files changed, 80 insertions(+), 15 deletions(-)
>=20
> diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
> index 96978ec..2e7f736 100644
> --- a/Documentation/vfio.txt
> +++ b/Documentation/vfio.txt
> @@ -328,7 +328,13 @@ So 4 additional ioctls have been added:
> =20
>  The code flow from the example above should be slightly changed:
> =20
> -	struct vfio_eeh_pe_op pe_op =3D { .argsz =3D sizeof(pe_op), .flags =3D =
0 };
> +	struct vfio_eeh_pe_op *pe_op;
> +	struct vfio_eeh_pe_err *pe_err;
> +
> +	pe_op =3D malloc(sizeof(*pe_op) + sizeof(*pe_err));
> +	pe_err =3D (void *)pe_op + sizeof(*pe_op);
> +	pe_op->argsz =3D sizeof(*pe_op) + sizeof(*pe_err);

Surely that argsz can't be correct for most of the operations.  The
extended structure should only be there for the error inject ioctl,
yes?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WKQ7zUpzoH2KEHMN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVAORwAAoJEGw4ysog2bOSNtgP/2ZUiXDw7BDvDM7vohRk6THv
1oIseA5xjUM8u2KPtWXX12v0hmh3XZtH49nq2K/SiBaagVypnCWBjq2LLQ9Zzde7
p1lTJ1hnh0ikwuzGyLsVzc17oKd/mdq6NDu2wbXgWlawtfyGgGFoC19zY62ZDJ+N
bbwWe+XR0YAcm7N87QAt+jRoNdsxYhITdoWUW6IPVDfj3w/uW8J81F66FJml79ZK
mmV/WFdtsEBqtPVGKR4t6L7WbwTGiZzu1WfvELEz9XLGYytbM7uDgJfM15HVZstX
ugYcUfIaUV3R7xxYVB1h7HXcA5I4Z92pFV0z34Bg+mnon+3Nx5ElNNw2A7ispHZ4
tZV2TgdqPDD5Rlh9OBpSfY/62gsyCg9I6ve+sQuwgAkmEv7PZ6tl20iF+NbztQNK
NQ5RURF4o75mbUR4eXOYH22Vkq74BRCup/PNbO9uJv6BsvZ9D+lbVDvGLcAUy36F
ad3S7EPoktFjUwaHDdAIitxxB/BPjC6l9zQGl29yjmHGUl/jVZfnaISrV3TQtsjk
gubVWgG2iOjEXQeYVqYZTxz9w0YUZTnJzq+/6oaTnaUzwJHo2mFY9Elltca6CZ89
C/LdXO3F8V+6weta9KcusxQ+mVp8NgM/ELoMEDjkIY0T+yksBhjKDRxUKmFLSUT2
k+Vwp13HCO6v/+ajg+8j
=PoVE
-----END PGP SIGNATURE-----

--WKQ7zUpzoH2KEHMN--
