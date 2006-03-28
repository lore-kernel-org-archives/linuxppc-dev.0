Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (unknown [213.151.39.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 46AF5679F9
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2006 23:15:09 +1100 (EST)
Subject: Re: snd-aoa & rates
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1143324396.6318.8.camel@localhost.localdomain>
References: <1143324396.6318.8.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-DoSctjuJoD8WeU/Wlgu+"
Date: Tue, 28 Mar 2006 14:15:00 +0200
Message-Id: <1143548101.13615.30.camel@localhost>
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


--=-DoSctjuJoD8WeU/Wlgu+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> Current snd-aoa blew up on me at module load btw ... anyway, that's not
> my point here :)

Yeah, keywest programming. Need help, see other mail.

> In fact, I would have been even nastier and only exposed the
> intersection of the above so I don't have to bother about rates that
> digital won't support :) But I suppose that if you really want to
> support 8k or 96k it might make sense to support others.
>=20
> Also, for the sample sizes, same comment. Number of bits are not that
> useful. I'd rather have a bitmask of formats: 8 bits, 16 bits msb, 24
> bits msb, maybe lsb versions if supported, ac3, floating point if
> supported, etc... That or an array. I'm sure Alsa already have constants
> defined for those no ? I would then have the codec have a function
> returning the required clocks for a given bitrate/format combination...
>=20
> That is all suggestions of course, if you feel that what you do is
> better, then stick to it :)

Yeah I'm doing pretty much exactly this now :)

> Another thing I wouldn't have bothered with is again with whatever
> digital supports or doesn't ... rather that trying to prevent some rates
> from being useable by alsa based on a control that users will typically
> not have means to set at the right time (what about a sound server
> running all the time keeping the drier running, you want to block the
> digital switch ?) what I would do is just "mute" the digital output if a
> format is selected that isn't supported for digital. I would let the
> user chose the formats they want at all time, and only clamp the digital
> enable/disable switch. On this switch, btw, you should then remember the
> user setting: if the user switches it off, remember off. If the user
> switches it on, remember on, If the user sets it on but you have to mute
> it, remember that so that when the sample size/format changes again,
> unmute.

Ok. This behaviour can be done in the codec itself now, there's a
callback :)

> Sames goes for things that may be supported by the digital output and
> not analog (ac3 ?). In this case, mute the analog outputs. The mutes of
> these are controlled externally via the amps so it may be a bit
> complicated, unless you define specific messages to the core for that,
> or maybe just clamp the master volume down in the codec driver.

There have to be callbacks anyway for microphone-detect since that is a
switch on the onyx, not the external amps.

johannes

--=-DoSctjuJoD8WeU/Wlgu+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARCkow6Vg1VMiehFYAQLadhAAkjTsgMwCFm+QBptvapktYKnYm/a9NYzz
WUazyLUhdt2RD27UOLc6c1O1QPBlRjKiMrfQmFK1oI3NQesJ90smvMgkjJ0VDhXw
PpdHNOlNRE8mRmpgNtabdxE7iWJwHe6kXeuNB9fgj15mOAqhdW0WBYsSxaT46qte
C4TPspnj3g22hyRLW85bMj40sdlrF9cwL6x+GYX81jEY9yqWhpqgHCVGVkOESA7C
5adft9DTwow5QqlyzWU0rNTE1wpnibT5FrF7AC7HFRxjMn22p+iB45bZokXFYDuT
iSbXVkRUgo1lJXs9rtY5xn7MfirwFB/2YGwyrdLS2uH9CPFH7oXOtINRGOcw4eyC
6DbqXCv6JJGIiMJFbbaAdIl2KfQFHZwzRUPSMO12UMsXPnLaJ5fHN/iiKzp527T8
fJXuQ3GWixdx4cHCkdaZ+nyzSsSa+jqgVPUlnuFnddAtiYWTI/IeEhuRJi75zP+M
Rn0g7qTHBdqlHsOwPF4eNXyofk6fquenPHuCdGmCDTJyh8PD5Lq7xa9hdFIDodG1
0U6zFJUbkGgl08F3LqNUs+Kp82xJnM+Hc8QIseF1ZK+/566P8UErArXKh/SWEWRJ
R4g/QERef6QfWXenlAz7jUvzrZIRWKc/HWpvCVqswzh1k5zCclVwzhway6zDzzk5
1Fpztu2kw4E=
=2b5z
-----END PGP SIGNATURE-----

--=-DoSctjuJoD8WeU/Wlgu+--
