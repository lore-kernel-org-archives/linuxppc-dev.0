Return-Path: <michael@ellerman.id.au>
Subject: Re: [Fastboot] [PATCH] kdump: don't call __ioremap() for pfn = 0
From: Michael Ellerman <michael@ellerman.id.au>
To: vgoyal@in.ibm.com
In-Reply-To: <20060921141049.GB1542@in.ibm.com>
References: <451216EE.8010404@in.ibm.com>
	<1158836557.7062.52.camel@localhost.localdomain>
	<20060921141049.GB1542@in.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-9F5Pl93yBDFbGVidZ/06"
Date: Fri, 22 Sep 2006 16:55:46 +1000
Message-Id: <1158908146.9761.23.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Fastboot mailing list <fastboot@lists.osdl.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-9F5Pl93yBDFbGVidZ/06
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-09-21 at 10:10 -0400, Vivek Goyal wrote:
> On Thu, Sep 21, 2006 at 09:02:37PM +1000, Michael Ellerman wrote:
> > +
> > +static size_t copy_oldmem_vaddr(void *vaddr, char *buf, size_t csize,
> > +				unsigned long offset, int userbuf)
> > +{
> > +	if (userbuf) {
> > +		if (copy_to_user((char __user *)buf, (vaddr + offset), csize)) {
> > +			return -EFAULT;
> > +		}
>=20
> Probably you can get rid of above pair of braces as there is only single
> statement under if.

Yep.

> > =20
> > -	if (userbuf) {
> > -		if (copy_to_user((char __user *)buf, (vaddr + offset), csize)) {
> > -			iounmap(vaddr);
> > -			return -EFAULT;
> > -		}
> > -	} else
> > -		memcpy(buf, (vaddr + offset), csize);
> > +	if (pfn < max_pfn) {
>=20
> Should this be (pfn <=3D max_pfn) ?

No, max_pfn is badly named. It seems to actually be the total number of
pages =3D=3D the first pfn past the end of the linear mapping.

But it'd be cleaner to use page_is_ram(), I'll do a new patch.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-9F5Pl93yBDFbGVidZ/06
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFE4jydSjSd0sB4dIRAohMAJ4/ondk2ElAPLzx3I0Y8GQnfyYX0ACgoR0p
Yy1sjC3NcC4uxpvyJyIfZko=
=dsL5
-----END PGP SIGNATURE-----

--=-9F5Pl93yBDFbGVidZ/06--
