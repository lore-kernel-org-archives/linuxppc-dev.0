Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] fix compile warning in pseries xics
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070529142715.GA29108@lixom.net>
References: <27973.1180417829@neuling.org>
	<1180417937.5313.6.camel@concordia.ozlabs.ibm.com>
	<4564.1180422112@neuling.org>  <20070529142715.GA29108@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-6BhY03cteTgJ3SXdARbC"
Date: Wed, 30 May 2007 10:28:12 +1000
Message-Id: <1180484892.5355.6.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-6BhY03cteTgJ3SXdARbC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-05-29 at 09:27 -0500, Olof Johansson wrote:
> On Tue, May 29, 2007 at 05:01:52PM +1000, Michael Neuling wrote:
> > @@ -762,11 +763,12 @@ void xics_request_IPIs(void)
> >  	 */
> >  	set_irq_handler(ipi, handle_percpu_irq);
> >  	if (firmware_has_feature(FW_FEATURE_LPAR))
> > -		request_irq(ipi, xics_ipi_action_lpar, IRQF_DISABLED,
> > -			    "IPI", NULL);
> > +		rc =3D request_irq(ipi, xics_ipi_action_lpar, IRQF_DISABLED,
> > +				"IPI", NULL);
> >  	else
> > -		request_irq(ipi, xics_ipi_action_direct, IRQF_DISABLED,
> > -			    "IPI", NULL);
> > +		rc =3D request_irq(ipi, xics_ipi_action_direct, IRQF_DISABLED,
> > +				"IPI", NULL);
> > +	BUG_ON(rc);
>=20
> Is this late enough during boot that you actually get useful information
> out of a BUG()?  It might be better to spit out an error and keep on
> going if that's the case (I'm afraid I don't have hardware at hand to
> test with right now).

It's way late:

start_kernel()
  rest_init()
    kernel_init()
      smp_prepare_cpus()
        smp_ops->probe()
          smp_xics_probe()
            xics_request_IPIs()

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-6BhY03cteTgJ3SXdARbC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGXMUbdSjSd0sB4dIRAkE8AKDBk3LEWhxePX/yeyaF17vqWS8L8ACgg3Y8
mwcimAQSA3VaSBxObeuC5nU=
=GonN
-----END PGP SIGNATURE-----

--=-6BhY03cteTgJ3SXdARbC--
