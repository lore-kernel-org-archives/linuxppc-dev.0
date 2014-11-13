Return-Path: <wsa@the-dreams.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A4ADE1A0185
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Nov 2014 00:09:05 +1100 (AEDT)
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3530E14003E
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2014 00:09:04 +1100 (AEDT)
Date: Thu, 13 Nov 2014 14:10:14 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] i2c: Driver to expose PowerNV platform i2c busses
Message-ID: <20141113131014.GA8025@katana>
References: <20141110060424.9407.2498.stgit@localhost.localdomain>
 <20141113075817.GA1288@katana>
 <1415876169.666.2.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
In-Reply-To: <1415876169.666.2.camel@kernel.crashing.org>
Cc: Neelesh Gupta <neelegup@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Please sort the includes.
>=20
> Ugh ? Since when do we do that ? :-)

Since I realised it is more readable and reduces likeliness of
duplicated includes.

> > > +	rc =3D opal_i2c_request(token, bus_id, req);
> > > +	if (rc !=3D OPAL_ASYNC_COMPLETION) {
> > > +		rc =3D -EIO;
> > > +		goto exit;
> > > +	}
> > > +
> > > +	rc =3D opal_async_wait_response(token, &msg);
> > > +	if (rc) {
> > > +		rc =3D -EIO;
> > > +		goto exit;
> >=20
> > Is it really -EIO? Maybe -ETIMEDOUT?
>=20
> No, there is no timeout, if that fails something went quite wrong, it
> could almost be a BUG_ON (basically we passed a wrong token or a NULL
> msg).

OK. I'd think it at least makes sense to use error codes which
distinguish I2C bus errors from OPAL interface errors. Always using -EIO
seems very generic :)

> > I don't think you should offer I2C_FUNC_I2C with those limitations. Is
> > there a case you really needs this?
>=20
> Yes there is, and it's pretty common :-) I actually added this to
> Neelesh original driver, it's the "smbus" style but with 2 bytes offset.
> Typically what we need for driver such as at24. They use normal raw i2c
> writes for writes but need the 2-bytes write + read combo without stop
> for reads.

Understood. So, basically something like I2C_SMBUS_WORD_I2C_BLOCK_DATA
is missing where the 'command' argument is not u8 but u16? Brainstorming
here, not relevant for this driver now.

> > > +	adapter =3D kzalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
> >=20
> > devm_kzalloc?
>=20
> Ah, I never got the knack of using the new devm stuff, Neelesh, can you
> take care of this ?

New? :D This would be a dead simple exercise to learn about it ;)

>=20
> > > +	adapter->dev.parent =3D &pdev->dev;
> > > +	adapter->dev.of_node =3D of_node_get(pdev->dev.of_node);
> > > +	pname =3D of_get_property(pdev->dev.of_node, "port-name", NULL);
> >=20
> > I have never seen this binding before, it looks fishy. Where is it docu=
mented?
>=20
> We made it up, like pretty every SoC vendor out there. What's fishy
> about it ? It's a very good way to get fixed i2c port names on the
> system, the firmware defines them.

But the SoC vendors prefix it with their company name and add
documentation for the binding.

Furthermore, this is just wrong, too. The adapter name is the name of
the IP core or chip or whatever which does the I2C bus. It is not the
functional name of the bus. It should be plain "Opal I2C" or similar.

Regards,

   Wolfram

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZK22AAoJEBQN5MwUoCm2WaIP/0VGO2mgNG9ZZlvhcJ9PyrkB
juNZ5cn3bPdJvYGzBkDWPjsAI6u/ab2axUkgdNXgvuHfAm6OYhq/hP6jC1zmfrAE
rqI8H0nEj8fh9InBVxHJfghrXdRJrVy3OG1CBv1nVtOSuvHX6Z1CQUl4PqTtO5yS
Om0JIwriT7HpSgmmtnO6d1tBiWJlaM/FMHJbOVvdXVEls+n6bm3ToPM9w7mKL0Kb
Tuy3St2+gplDM3drfF+XPzemKGN8leExpdwIMzEkcLcqUIOxnEk9PhFvqvI6Bsed
2K9X6i8/Z4mQElpctde6HRY+bTNheJ/AHc3ODYKnDGbwNqUPS83Br4POM8gD4hdw
336uoCwWLq32++SDRwqltKVX9KDK5UKbmKm53SLT7Z9Kof7Pn5b7Jnus0wvO3UZE
FQ8GGd0FGuj1aYwPSFiHgY96u6yzV4r1XtKOfMX+nR7zDlHwBwPxqFU+YUZwLscy
f4sC1AAXEPXIyLor2b0BoMpIpMaJBo6zAGStFd/St98VAMyElmYfGitHZ02nbfiE
px+jVD54Qm3061HLweOIf7F58vPYeHP/nNskiqiJ2UKda478OZzxHJ7GaXtE8v6/
uRhaeuKq1ce/ZHIoeARVQfzNzfF0SVLii1v3NvYCfi49Ux3uz0Q3sVghVyHjd7HP
moplG5YJOVHsupAwfUAz
=wPC+
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
