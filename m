Date: Thu, 6 Apr 2000 04:34:50 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Olaf Hering <olh@suse.de>
Cc: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Setting up yaboot
Message-ID: <20000406043450.B2099@plato.localdomain.local>
References: <200004040459.XAA03713@lists.linuxppc.org> <38EA7D15.C453ED94@uncc.edu> <38EACD97.113001FE@dana.ucc.nau.edu> <20000405083212.B7710@suse.de> <a04301800b510a9fc6322@[134.114.64.240]> <20000405041655.B421@plato.localdomain.local> <20000406133706.D10753@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
In-Reply-To: <20000406133706.D10753@suse.de>; from olh@suse.de on Thu, Apr 06, 2000 at 01:37:06PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2000 at 01:37:06PM +0200, Olaf Hering wrote:
>=20
> This is exactly the question I had now, so it seems we all have to
> update the os-chooser script and add PowerBook3,1 to it.

yup, ben made be aware of this recently..  it might be possible to do
away with that part altogether but that would mean alot of testing,
that i can't really do.=20

> I will update the suseboot.hqx today, it includes more funny AppleScript
> files for automate the setup process. SCSI Booting is still an issue,
> the only way is to boot directly into yaboot. It works here on many
> differnt machines.=20
> Why should ELF loading not work?

elf booting works so long as you don't try to call the yaboot file by
its type (hd:,\\:tbxi) for some bizzare reason OF barfs if a tbxi file
is not a CHRP script.  just for kicks go open a MacOSROM file in a
text editor to see how they worked around this.  (about 80 lines of
nasty Forth code)

> boot hd:9,\\yaboot in the os-chooser script should be the same like
> hd:9,\\yaboot in boot-device for the OF.

yup, but the fact is people hate screwing with OF, so if i use a CHRP
wrapper they should be able to zap OF to its default settings and
still have it automagically boot into the yaboot menu.  (if they
followed my recommendations for how to setup the bootstrap partition)

your failure occured when OF tried to load the CHRP script, not
yaboot. i would think it would output a less obfuscated error then
that if the COMPATIBLE tag was wrong...

> Yes, there is macboot on newer machine, I had no problems so far.

mac-boot works the same as boot, the only difference is it searches
for bootable partitions like the old hardware ROMs did.  but it trys
to load blah:,\\:tbxi=20

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjjshGoACgkQJKx7GixEevxiLgCfRshEEmOCf4QNDIVY21tQ3xOv
yyQAnieMQrRVkzQqyWddQ/S1VO/hsaep
=JqSq
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
