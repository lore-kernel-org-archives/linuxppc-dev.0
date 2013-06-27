Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id EF0CC2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 16:59:38 +1000 (EST)
Date: Thu, 27 Jun 2013 16:59:29 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 3/8] vfio: add external user support
Message-Id: <20130627165929.3828c261c957845a549ad95b@canb.auug.org.au>
In-Reply-To: <1372309356-28320-4-git-send-email-aik@ozlabs.ru>
References: <1372309356-28320-1-git-send-email-aik@ozlabs.ru>
 <1372309356-28320-4-git-send-email-aik@ozlabs.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__27_Jun_2013_16_59_29_+1000_lhv7FzSatZX_6IAt"
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alexander Graf <agraf@suse.de>, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__27_Jun_2013_16_59_29_+1000_lhv7FzSatZX_6IAt
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alexy,

On Thu, 27 Jun 2013 15:02:31 +1000 Alexey Kardashevskiy <aik@ozlabs.ru> wro=
te:
>
> +/* Allows an external user (for example, KVM) to unlock an IOMMU group */
> +static void vfio_group_del_external_user(struct file *filep)
> +{
> +	struct vfio_group *group =3D filep->private_data;
> +
> +	BUG_ON(filep->f_op !=3D &vfio_group_fops);

We usually reserve BUG_ON for situations where there is no way to
continue running or continuing will corrupt the running kernel.  Maybe
WARN_ON() and return?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Thu__27_Jun_2013_16_59_29_+1000_lhv7FzSatZX_6IAt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJRy+LZAAoJEECxmPOUX5FEYCIP/21qKXlYUTvY0xw0rl4Ala7J
eqhHdErKg4yTxIJuIK6QKK6T5EaM4leNYbLmWkzOasbFO1ERQgCRPxlW9DMRfhJX
SoW/MIEwbvWniRKR+EtWaDnRqV2nfyztrsNHhU1hMiaJYMMbFIOtMD0XOJX+jEw3
xOkfObdOilbfQDwto0X0OY6tHH5MRnVhMzpBFYLdsTVNdbJmy9WiwztHjLOEMeaV
UJkF1cI0Css8Hjw5y6JVIpGwERAwRYjTQOGzZGAbGr3+YmzEqHLWa+woICeIj5fp
/V91/ZO2FiGdTnROZ6PgrSRedOOaGEqiH8dfxvGBemOUOKBWCqAxfGholyhTj2Xp
CNgQpgKBO0MHX7n8zUJmknwtLKDXqWNFNYf7ctha4Oui1MaAXxgXagUR52WCXf+W
IqfHWzDsRwJNbmVXQ1tcqkN7ot4BWi9LCJHbwz8X1Ud85MbS5gCAJvQwWcxqjh6A
vBq9MX3KRXOoyO85AtP/BV4WKnc+i2VbdQB9o3GinhpdnfieafpknofDxg0eIT8S
iZ2CzXatOt/imGPDOsudmlKldfUgJ6p7EeRKysLSzQIx3Gz/Cz2y/GrOw6+xkoRN
/d/m7bsMNeNzACB2UcJhbVVemSVXYukC9F1P4yZWExiHXlDQUuSVjUB1rhIG9I9f
xg1aWdoHMdtCbOt2LqsR
=mBSd
-----END PGP SIGNATURE-----

--Signature=_Thu__27_Jun_2013_16_59_29_+1000_lhv7FzSatZX_6IAt--
