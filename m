Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 846591A0196
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Feb 2016 12:08:31 +1100 (AEDT)
Date: Tue, 2 Feb 2016 12:08:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: paulus@samba.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 aik@ozlabs.ru, lvivier@redhat.com, thuth@redhat.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFCv2 3/9] arch/powerpc: Handle removing maybe-present bolted
 HPTEs
Message-ID: <20160202010811.GD15080@voom.fritz.box>
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <1454045043-25545-4-git-send-email-david@gibson.dropbear.id.au>
 <56AEF41E.9050105@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GyRA7555PLgSTuth"
In-Reply-To: <56AEF41E.9050105@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--GyRA7555PLgSTuth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 01, 2016 at 11:28:54AM +0530, Anshuman Khandual wrote:
> On 01/29/2016 10:53 AM, David Gibson wrote:
> > At the moment the hpte_removebolted callback in ppc_md returns void and
> > will BUG_ON() if the hpte it's asked to remove doesn't exist in the fir=
st
> > place.  This is awkward for the case of cleaning up a mapping which was
> > partially made before failing.
> >=20
> > So, we add a return value to hpte_removebolted, and have it return ENOE=
NT
> > in the case that the HPTE to remove didn't exist in the first place.
> >=20
> > In the (sole) caller, we propagate errors in hpte_removebolted to its
> > caller to handle.  However, we handle ENOENT specially, continuing to
> > complete the unmapping over the specified range before returning the er=
ror
> > to the caller.
> >=20
> > This means that htab_remove_mapping() will work sanely on a partially
> > present mapping, removing any HPTEs which are present, while also retur=
ning
> > ENOENT to its caller in case it's important there.
>=20
> Yeah makes sense.
>=20
> >=20
> > There are two callers of htab_remove_mapping():
> >    - In remove_section_mapping() we already WARN_ON() any error return,
> >      which is reasonable - in this case the mapping should be fully
> >      present
>=20
> Right.
>=20
> >    - In vmemmap_remove_mapping() we BUG_ON() any error.  We change that=
 to
> >      just a WARN_ON() in the case of ENOENT, since failing to remove a
> >      mapping that wasn't there in the first place probably shouldn't be
> >      fatal.
>=20
> Provided the caller of vmemmap_remove_mapping() which is memory hotplug
> path must be handling the returned -ENOENT error correctly.

vmemmap_remove_mapping() is void, so there's no -ENOENT returned, just
the WARN_ON().

> Just curious
> and want to make sure that any of the memory sections or pages inside the
> section must not be left in a state which makes the next call in the
> hotplug path fail.

So, this situation shouldn't happen - the mapping should be complete -
but there's nothing obvious that the caller should do extra.  It asked
that the mapping be removed, and we discovered that some of it wasn't
there to begin with.  Whether we can continue safely depends on
what exactly caused the mapping not to be fully present in the first
place, and whether that had other conseuqences, but we have no way of
knowing that here.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GyRA7555PLgSTuth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWsAF6AAoJEGw4ysog2bOSzJcQALjJs5ZC//5sJ8qJ59H3g3e8
uPayFfYe+8yuCfIXiEWf3gq4e27JuxDyd2WYacwTgOTMZwdiOyTlF+c7FLYofzDW
wB/rc5h3A2yqwIr64/0yGbm3lGnwaZjfl94jR+I4RzpvNYxp0tIq1QIR+A1aTsmJ
iDsPzK52ZhQ38vciwcklOmBwmW6Wr7O4+w6Yiz1z/pqSWR9YHHSpbYuUxL5lqVtE
a9NcffcL1p25YKbHsmeypKG6dMHrVMxEomjKK0ACSzjHplXtStY0ru9j0/3W2Vl9
yxFvaLi202QepMjzPZSIUCRERacrBvwaeaBzxDGtAXmQNjpbdksZv0ZIhz8ZiPnU
LAW+RRYQlTV8Q1VOox1V0Lv1+M47jssW7xK/mPl/eLka4yA9AZ/7wxOOvpRqfljc
QYTTgKjZoOaOU9Pd4r0jeFuL23kd00ZB7MasBBfHGNy97Uf+mgdX729RTtdLx5Z9
nF4WNpjU0hsKD2S5C/QvSu4w0t3ZaLh9Va7s842061mSbmQu2k9tCh3s6D2cSWum
Dg+U6mTGzkiBF/F5QQO/TjqazyKoaua2qMDXzglrRCTeFzNjzdoBtGdffgqwxwlZ
vSQOs1LQAzoTmGMipcO2gGyOd8GdvMbye5H/hIgEyl0Jm4Ipw60rQpR8vLR930u9
zusoXQ1t515LQpudLPo7
=o1hn
-----END PGP SIGNATURE-----

--GyRA7555PLgSTuth--
