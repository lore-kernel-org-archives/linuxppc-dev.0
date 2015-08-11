Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DEF791A039F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 21:30:51 +1000 (AEST)
Received: from mail-pd0-x22a.google.com (mail-pd0-x22a.google.com
 [IPv6:2607:f8b0:400e:c02::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 582891402B6
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2015 21:30:51 +1000 (AEST)
Received: by pdrh1 with SMTP id h1so64752051pdr.0
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2015 04:30:49 -0700 (PDT)
Message-ID: <1439292157.24419.37.camel@axtens.net>
Subject: Re: [PATCH v2 08/10] cxl: Allow the kernel to trust that an image
 won't change on PERST.
From: Daniel Axtens <dja@axtens.net>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, "Matthew R. Ochs"
 <mrochs@linux.vnet.ibm.com>, imunsie@au.ibm.com, Manoj Kumar
 <kumarmn@us.ibm.com>
Date: Tue, 11 Aug 2015 21:22:37 +1000
In-Reply-To: <20150811171538.477c3842@camb691>
References: <1438061323-20710-1-git-send-email-dja@axtens.net>
 <1438061323-20710-9-git-send-email-dja@axtens.net>
 <20150811171538.477c3842@camb691>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-kv7pf47Fyvoo+v8KbeAQ"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-kv7pf47Fyvoo+v8KbeAQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


> So I'm not super all over the putting all sorts of code inside CONFIG_CXL=
_EEH,
> I understand that there is another driver being merged and they'll use
> CONFIG_CXL_EEH so that both this driver and the other driver can go in th=
e same
> merge window but does this mean you need to put it around everything here=
?
>=20
> I may have misunderstood what you've told me but if the other driver depe=
nds on
> work done in this one (and not the other way around), if they depend on
> CONFIG_CXL_EEH which you create in the last patch, then they cannot be bu=
ilt
> until this series exists, so they can't have issues.
>=20
> The one catch is that this series as is waits untill the last patch to ac=
tually
> create the symbol, and therefore compile everything so lets be sure you d=
on't
> break bisecting. You might need to rethink the order of things in 8/10 an=
d 9/10,
> I can't see anything obvious if it helps...
>=20

Yeah, so you're right. I've taken the guards off everything except the
new API function. I still want to leave the patch that adds the symbol
at the end: that way you don't get the function unless it is actually
going to make a difference in the EEH process.=20

The other driver (cxlflash) just guards the API function, inserting a
stub if it's not defined. So this setup will make our code cleaner and
will still let their code merge cleanly.

Thanks again for the review.

--=20
Regards,
Daniel

--=-kv7pf47Fyvoo+v8KbeAQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVydr+AAoJEPC3R3P2I92FCAgQAIjGRzyaE+5J6/cBIU63mhaC
VwA2fxdwm/iBODQisnHuTkrPHUVHH2q/XEaxmUVNXOadyteeIs77QJxyGWzuozS8
c2ps5vXcnDHOBuoJw2uJ9151H+nt0yLpx67/w1+vSSU1lxE6J8thIBzDaC+oB2Lj
3ejVexl3XOTH4daNAvwCkynC7dwVRrsFoq2HSfskqLvRYiLuvy7GYSrgVZFI9/y/
P8UchIGNCs7zn28FYZ9XNZhJyr7z7miwrkTO9TZXgCKpCBNCH3MYUN7CjXVh5qqp
2GWfpB+VmqNTp6Feos1pLZ3cp8Bofv5GrKCZObrT+qgnKpjHREyaNt0NPyLISQTX
SU/JVD8CEFWtWPGjpVLvsotOsD8cr6W1awC1aKnMCDnd3hTDpOxTjyEXTqONH3JK
5dwSiCboYM4SIL0zPCEXb/RjWMwAogJWFeLfx+IpTxDpmq+glsrSR1+nyO0b65qR
eZrjMI7Iloo5z69kCAd1HziqOXrEbGiyaIHBuk6oc7wjTEZ+5V7tVixcIgbuHzDp
lK3a8+BaQFhxPx8BsysurUDmzdBbCPyzjCoqFBkCJEJOIbHarmAF6mlthHVoWDaP
QRft4wZCUaH2cJBdFtBQSNIrIhqhYZPU5Qj6eTJyHwpNQPLuR7MzcOrBTb1VcAWQ
L+1kBRTchAGT0wDSuXmg
=d+u/
-----END PGP SIGNATURE-----

--=-kv7pf47Fyvoo+v8KbeAQ--
