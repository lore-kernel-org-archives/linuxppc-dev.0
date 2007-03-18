Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D6865DDF0B
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 01:37:29 +1100 (EST)
Subject: Re: hibernate, suspend and s2both support
From: Johannes Berg <johannes@sipsolutions.net>
To: Tim Dijkstra <newsuser@famdijkstra.org>
In-Reply-To: <20070318144115.00ab8912@commensaal.drs.p>
References: <20070318010044.0b0bebf0@commensaal.drs.p>
	<1174208083.13027.36.camel@johannes.berg>
	<20070318144115.00ab8912@commensaal.drs.p>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-+bHpuVku/gvgvLG2FKbm"
Date: Sun, 18 Mar 2007 15:37:50 +0100
Message-Id: <1174228670.13027.46.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-+bHpuVku/gvgvLG2FKbm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2007-03-18 at 14:41 +0100, Tim Dijkstra wrote:

> So if I build a binary on ppc that first tries /dev/pmu (if it exists) an=
d then
> /sys/power/state, that would be safe?

Yeah, my current patchset will print a message that the /dev/pmu ioctl
will be removed but that may well not be present.

> I guess that the powerpcs that do not
> support suspend-to-ram will report that via the PMU_IOC_CAN_SLEEP ioctl

They either have no /dev/pmu device or return an error on the ioctl.

>  and
> they will lack 'mem' in /sys/power/state?

That's tricky. Up until I posted a patch *very* recently (unreleased as
of yet I think) the contents of /sys/power/state didn't reflect what was
supported, in fact if *nothing* was supported then "mem" and "standby"
would be shown. Also, up until that patch I cited in my previous mail,
mem and standby would, on powermac, kill the machine. On other machines,
mem and standby exist but return an error.

> > Yup; I've played with s2both a bit but it hangs the machine, I'm not
> > really sure why yet. It may be related to another slight bug I just
> > found yesterday though.
>=20
> Hmm, so 'echo disk > /s/p/state' and s2ram suspend OK, but s2both doesn't=
?

No, echo disk ... and s2ram both suspend ok, and I haven't tested your
s2both tool because I don't know what it does, it seemed to be a
userland suspend to disk for which I'd need special initramfs support. I
have tested the 'platform' powerdown method for suspend to disk support
in the kernel and that killed the machine due to a yet unidentified
problem.

> Oops, Yes that was the wrong way around... That's what you get if you
> don't have a Mac;) Did you try it with the obvious fix?

Yeah, it works and uses the pmu ioctl.

> Yes you need an initramfs, but I don't see any reason why if
> suspend-to-disk and suspend-to-ram work, s2both wouldn't.=20

I think I wasn't really clear on what I said, see above.

> If we get
> suspend-to-ram working I'll put up proper source package which you can
> dpkg-buildpackage. That will include hooks for initramfs-tools and will
> build an initramfs for you.

Do you really think that I let debian build my initramfs? :P
Have you documented somewhere in text form what pm-utils needs in the
initramfs?

johannes

--=-+bHpuVku/gvgvLG2FKbm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF/U69/ETPhpq3jKURAmtGAKCj2Q8vfl9ihQIce+q9V90KPvfdtwCfcuT9
3I8zti+VoAKcE51eH9Jm/Vw=
=vsbA
-----END PGP SIGNATURE-----

--=-+bHpuVku/gvgvLG2FKbm--
