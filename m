Date: Thu, 6 Apr 2000 05:40:42 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Mark Steer <mark@insanely-great.co.uk>
Cc: Olaf Hering <olh@suse.de>, Tim Wojtulewicz <Tim.Wojtulewicz@nau.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Setting up yaboot
Message-ID: <20000406054042.E2099@plato.localdomain.local>
References: <20000406133706.D10753@suse.de> <B5124E69.C45%mark@insanely-great.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vv4Sf/kQfcwinyKX"
In-Reply-To: <B5124E69.C45%mark@insanely-great.co.uk>; from mark@insanely-great.co.uk on Thu, Apr 06, 2000 at 02:23:38PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--vv4Sf/kQfcwinyKX
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2000 at 02:23:38PM +0100, Mark Steer wrote:

> I've recently setup my new Pismo/400 with Linux and, as of this morning,
> Darwin 1.0 and I think I'm going to require a hard drive upgrade about 6
> months sooner than I'd planned for...

;-)

> I can confirm that you do need to add the PowerBook3,1 line into the
> <COMPATIBLE> section before the Pismo will use the os chooser script
> correctly.

thought so...

> One thing I noticed, at least with this machine, is that the line:-
>=20
> boot hd:10,\\yaboot
>=20
> will fail unless I rewrite it as:-
>=20
> boot hd:10,yaboot

that line means boot yaboot from the root directory, certianly the
most reliable method i have found other then hd:,\\:tbxi (which only
works on CHRP scripts with a properly blessed directory)=20

the first notation means to load the file from the blessed directory,
which if there isn't one will fail.  macos tends to remove the
blessing from non-macos directories.

> This is the first new world machine that I have setup with Linux so I don=
't
> know if this is right for others or if my configuration may be different.
> I'm going to be upgrading :-) an iMac DV with Linux this afternoon so I'll
> report back what that one does with regard to the os chooser script.
>=20
> Now I'm off to try and rewrite the script so that I can choose Darwin as
> well...

does darwin still use UFS or ffs for its default filesystem?  if so it
probably uses a bootstrap partition of type Apple_Bootstrap or
Apple_BootROM setup pretty much the same way i advocate (that is where
i got the idea, from OSX server) if it does still use this partition
you should be able to add a reference to it like so:

hd:6,\\:tbxi =20

to your chooser script.  where 6 is the real partition number of the
darwin bootstrap partition.

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--vv4Sf/kQfcwinyKX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjjsk9oACgkQJKx7GixEevyNNgCfVLC8hPZKb1WYcH0JPqJ6GIWZ
troAn02Jrh3Nc2p3WIWY69bNScQhdW5C
=8QNB
-----END PGP SIGNATURE-----

--vv4Sf/kQfcwinyKX--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
