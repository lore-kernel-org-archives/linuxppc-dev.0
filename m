Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 07FA81A0018
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 14:13:53 +1000 (AEST)
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E8BD414031D
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2015 14:13:50 +1000 (AEST)
Received: by pawu10 with SMTP id u10so154751648paw.1
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2015 21:13:49 -0700 (PDT)
Message-ID: <1439266290.24419.18.camel@axtens.net>
Subject: Re: [PATCH v2 01/10] cxl: Drop commands if the PCI channel is not
 in normal state
From: Daniel Axtens <dja@axtens.net>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, imunsie@au.ibm.com
Date: Tue, 11 Aug 2015 14:11:30 +1000
In-Reply-To: <20150811133158.4576a716@camb691>
References: <1438061323-20710-1-git-send-email-dja@axtens.net>
 <1438061323-20710-2-git-send-email-dja@axtens.net>
 <20150811133158.4576a716@camb691>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-PBriVJis7iql4rIQYqCN"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-PBriVJis7iql4rIQYqCN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Hey Daniel, keeping in mind I can't exactly test it, and that I don't kno=
w the
> ins and outs of CAPI, the code looks nice and it makes sence to me.
>=20
Thanks!

> Some very minor points,
>=20
> Otherwise
>=20
> Acked-by: Cyril Bur <cyrilbur@gmail.com>
>=20

> > =20
> > +static inline bool cxl_adapter_link_ok(struct cxl *cxl)
> > +{
> > +	struct pci_dev *pdev;
> > +
> > +	pdev =3D to_pci_dev(cxl->dev.parent);
> > +	return (pdev->error_state =3D=3D pci_channel_io_normal);
> > +}
> > +
>=20
> In the process of reviewing these patches I read the style guide in furth=
ur
> detail and (it doesn't 100% commit one way or the other but) it suggests =
it may
> be wise to get GCC choose if it should inline or not, unless you have an =
reason=20
> (the macro replacment below being a good example)... Just a thought.
>=20

This sits in a bunch of hot paths and tight loops... and it's a
glorified macro. I will bear this in mind for the future: I hadn't
thought through the tradeoffs.


>=20
> So a birdy has informed me these are going to become inlines, you can
> therefore disregard those comments. I am much more in favour of inlines!
>=20
Yep, they're going to become inlines. yay for inlines.

> > +	/* We could be asked to terminate when the hw is down.  That
>=20
>                                                                ^
> I'm notoriously bad for having a low care threshhold but I do have a high=
 care
> threshhold for consistency. Double space after period? Are you sure?
>=20
Fixed.

--=20
Regards,
Daniel

--=-PBriVJis7iql4rIQYqCN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVyXXzAAoJEPC3R3P2I92FfucP/3QSCFIEM/whDCNuWI7ILQ0w
zWMfl0jqja4Sdz5CgxVQgH6FBghHNoSSyJeyhL2FDQx9JZKNX/vdiGljJ/MOo6dm
tKf0iHmK3XT/3LaM1PnxDWuKbbv10+nc7NBITYWnSsQQavQwDXWThvIKL/Ao/8yg
T8ofASFjVGo8p0/6I3e0oleFdZOBZPC3x4NLI09ubCTHep12DRh5uJiXFpFzZczk
h8U3UtKY6ZCXSCmOgyNhtZ0al6MCnBypY3tMYC2KLVe/zIQ3pRLppkN947Ezu9ip
H3JR8zcO6/jpVA6G4/ADl8i+4NiUJuEplzKDewSK8uQD9xLEu9px+R2pjDxwwI8o
8zVt3yiqdGyd7xV6n2zhayiutWuTP52LB596jUlVVPR0vorjHuj+PLbpTU48lkT/
90StKjgZI1kxvBysXc7mFNKXTVafME7YqCcoYlKg5fu9FS62/A+t39fLV+FLefMm
8R1p4YpVBBQu8ihZv/rTY4dDQCvui1525xpFT9cyM8Puuz1K1PFau7gEe9WLpL5I
y7D+mrc/6ZEekZEKGSQelKCP6+fahe/87GkLwq9Q1JjdYBcyClQdStIJYFNfYXzO
zYjlI7ia2q+CmUFTrTtpJ9Wm1igBmb7RUIZ1s1+JAZmaw/UZ/bNt60YCLqdncS2K
n/mySDP1nCQl3+ToIlvT
=523N
-----END PGP SIGNATURE-----

--=-PBriVJis7iql4rIQYqCN--
