Date: Wed, 16 May 2001 03:00:13 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: kernel lockup
Message-ID: <20010516030013.N14546@plato.local.lan>
References: <20010516010328.D19015@llama.nslug.ns.ca> <20010516092154.16870@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Vj8lTl3Roa4E9STX"
In-Reply-To: <20010516092154.16870@mailhost.mipsys.com>; from benh@kernel.crashing.org on Wed, May 16, 2001 at 11:21:54AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Vj8lTl3Roa4E9STX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 16, 2001 at 11:21:54AM +0200, Benjamin Herrenschmidt wrote:
>=20
> >bigfoot:~# kbdrate -h
> >kbdrate: invalid option -- h

thats interesting, kbdrate -h gives a usage message for me.. like it
should. =20

> >Machine check in kernel mode.
> >Caused by (from SRR1=3Dc9030): Unknown values in msr
> >
> > What do I do to debug this?
> >
> > The machine is totally locked, not even the SysRQ combination does
> >anything.  (control+command+power still resets though, since it is handl=
ed
> >in hardware on oldworlds.)
>=20
> Well, I guess that kbdrate is yet another dumb x86'ism that will
> directly tap the hardware of a PC's keyboard controller...

according to the man page it trys to be portable:

[...]
       All this is very architecture dependent.  Nowadays kbdrate
       first tries the KDKBDREP and KIOCSRATE ioctls.  (The  for-
       mer  usually  works  on  an  m68k  machine, the latter for
       SPARC.)  When these ioctls fail an ioport interface as  on
       i386 is assumed.

FILES
       /etc/rc.local
       /dev/port

Linux 1.1.19               22 June 1994                         2

that fallback is probably the bugger though. =20

> Well, I may be wrong, but machine check usually means that you are
> trying to access non-existing hardware.

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--Vj8lTl3Roa4E9STX
Content-Type: application/pgp-signature
Content-Disposition: inline


--Vj8lTl3Roa4E9STX--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
