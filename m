Date: Sat, 20 May 2000 06:45:27 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Steven Hanley <sjh@wibble.net>
Cc: Ethan Benson <erbenson@alaska.net>,
        Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Paul's 2.2.15 does not boot a 7200
Message-ID: <20000520064527.D7243@plato.local.lan>
References: <20000520002947.A6452@plato.local.lan> <3926A313.3AB13BBA@wibble.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
In-Reply-To: <3926A313.3AB13BBA@wibble.net>; from sjh@wibble.net on Sun, May 21, 2000 at 12:37:07AM +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Sun, May 21, 2000 at 12:37:07AM +1000, Steven Hanley wrote:
> Ethan
>=20
> I think it may actually be booting, if it is hooked up to a netwrok try
> pinging it or sshing into it, I also had this problem with the 2.2.14

both were tried, also it is set to dail ppp on boot, so it is quite
obvious when it sucessfully boots since the modem starts screeching ;-)

> pre series from linuxcare on my 7200/200 with a normal atyfb, the
> problem was the thing's video was blank after the bootx sequence
> finished loding it and the kernal ran. 2.2.10 was fine so I wanted to
> know what the problem with the graphics was/is, it seems some change in
> 2.2.* recently made it detect the graphics capabilities incorectly and
> not use the right mode.=20

hmm, this could explain why the screen stays black, but it is
certainly panicing or otherwise dying since it never becomes pingable
or dials ppp... =20

under 2.2.14 dmesg shows this for the framebuffer:

Total VRAM =3D 1MB 0001
Monitor sense value =3D 0x62b, using video mode 6 and color mode 0.
Console: switching to colour frame buffer device 80x30
fb0: platinum frame buffer device

> so the fix is to put something like video=3Datyfb:vmode:5 on the kernel

is this correct for the above framebuffer? =20

> command line and it will boot with text displauyed, I still am somewhat
> annmoyed as 2.2.10 the thing auto detected and displayed 100x40 or osme
> similarly sized mode, and now it only does 80x50, which I find way too
> large (even on the 14" monitor I have with this machine (heck I happily
> run 160x60 console on 15" monitors on my x86 boxen)

well this machine runs headless anyway so it really does not matter if
it has a usable console much just so it boots.  the console does work
fine without any kernel arguments for 2.2.14 (paul's tree)

> Anyway try forcing a specific video mode ont he kernel command line and
> you may get a display. I was able to work with the machine with no
> display quite happily using only ssh and such and was thus able to try
> different kernels.

exactly how the box is managed, it only gets a monitor attached to see
why the kernel is failling to boot, but unfortunatly that is not
happening :(

ill see about forcing the video mode to at least see if we can get
more info as to what is going wrong (kernel panic, freeze, etc)

any other ideas?=20

thanks

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkmpQcACgkQJKx7GixEevxYfQCfajYSXFbYH+HFrd3zzBE71sSP
zakAn1H865njz9k1MXpRMtFFOCG+TYMK
=SgC7
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
