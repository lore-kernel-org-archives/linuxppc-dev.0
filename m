Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7BF4F67CBD
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 00:33:24 +1100 (EST)
Subject: Re: [linux-pm] [RFC 3/3] suspend to disk on powermac G5
From: Johannes Berg <johannes@sipsolutions.net>
To: Pavel Machek <pavel@suse.cz>
In-Reply-To: <20061212132023.GD5190@ucw.cz>
References: <20061211230208.526233000@sipsolutions.net> >
	<20061211230754.979775000@sipsolutions.net>
	<20061212132023.GD5190@ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-dkrmx+CWt00xFBbWNoNs"
Date: Tue, 12 Dec 2006 14:33:11 +0100
Message-Id: <1165930392.22338.31.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Torrance <torrance123@gmail.com>,
	Michael Buesch <mb@bu3sch.de>, linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-dkrmx+CWt00xFBbWNoNs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> Does aoa module load/unload help? Does making it build-in help? Also
> try playing with aumix after resume.

Yeah, I tried all of that except making it built-in. It's rather strange
but I suppose I'm to blame since I wrote aoa :) I'll need to look a bit
further. The odd thing is that everything works, I can play, change
volumes etc. just don't get any sound. I'm thinking something is wrong
with the onyx codec programming but haven't really looked yet. i2sbus
should be fine since it suspends/resume ok on my powerbook.

> > +	/* phew. suckers. this 16MB area is left unmapped
> > +	 * at another place but they don't bother to mark it so */
> > +	for (i =3D 0; i < (1<<24); i+=3D PAGE_SIZE)
> > +		SetPageNosave(virt_to_page((void*)((unsigned long)dart_tablebase + i=
)));
> > +
>=20
> Can you move that marking where it belongs?

Where does it belong? The reservation is done so early that
SetPageNosave can't work yet (IIRC, I've been sitting on this code too
long.)

> > +	if (dart_tablebase =3D=3D 0 || dart_tablesize =3D=3D 0)
> > +		return;
> > +
> > +	p =3D alloc_pages(GFP_KERNEL, 9);
> > +	BUG_ON(!p);
> > +	dart_copy =3D page_address(p);
> > +}
>=20
> Not sure how likely is 2MB allocation to succeed. You may need to
> prealocate it... And you definitely will need to handle error here.

Good points. I suppose I'll just preallocate it or try mapping the dart
table after all and not doing anything special with it during
suspend/resume... need to think about it more.

> > --- linux-2.6-git.orig/kernel/power/snapshot.c	2006-12-11 23:34:46.7187=
16759 +0100
> > +++ linux-2.6-git/kernel/power/snapshot.c	2006-12-11 23:38:00.152716759=
 +0100
> > @@ -707,6 +707,8 @@ static struct page *saveable_page(unsign
> >  		return NULL;
> >  	if (PageNosaveFree(page))
> >  		return NULL;
> > +	if (!page_is_ram(pfn))
> > +		return NULL;
> > =20
> >  	return page;
> >  }
>=20
> Could this get some testing in -mm?

I'd be much happier with it if I knew why it was necessary. On the
powermac we have a 2G memory hole: first 2G memory, then a 2G hole and
then the rest of the memory. It seems like the suspend code doesn't
handle any memory holes at the moment but that seems strange to me.

Thanks for your comments!

johannes

--=-dkrmx+CWt00xFBbWNoNs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFfq+X/ETPhpq3jKURAsRjAJoDxve0rva14qKgT1JCZMIR7JFmwQCfcE67
eaHK71ukzHsEuE2ViO1p1hQ=
=/Pwj
-----END PGP SIGNATURE-----

--=-dkrmx+CWt00xFBbWNoNs--
