Date: Fri, 22 Sep 2000 17:54:44 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MacOS X and yaboot wars.
Message-ID: <20000922175444.P30638@plato.local.lan>
References: <20000921214002.N30638@plato.local.lan> <19340817093546.32417@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LwbuP8dfxhLLLUfV"
In-Reply-To: <19340817093546.32417@mailhost.mipsys.com>; from bh40@calva.net on Fri, Sep 22, 2000 at 06:04:02PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--LwbuP8dfxhLLLUfV
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2000 at 06:04:02PM +0200, Benjamin Herrenschmidt wrote:
>=20
> Their installer does something weird, indeed. It tends to randomly make
> another partition of the target disk "vanish". The partition (typically,
> the HFS "exchange" partition people keep around) does not appear any more
> in the MacOS 9 Finder nor in the file selection dialogs. It still mounts
> in Linux and MacOS X.

another thing i thought of, does OSX still use a bootstrap partition
of its own? (it must if you choose UFS instead of HFS+) perhaps its
reordering the partition table to make its partition first instead of
ours?  this can be changed back in mac-fisk/pdisk with the `r'
command.  then again it could just be doing the same inspect and
debless crap macos is notorious for, a rerun of ybin will fix that.
(if the BSD layer remains sufficiently intact in OSX final i may see
about getting ybin working from the OSX side, but that depends on
whether i can get access to OSX or not)

> Apparently, the problem seem to be related to the installer setting the
> "invisible" bit of the toplevel (root) directory entry of the HFS volume.
> The partition is actually mounted, but invisible. I "fixed" mine using
> Norton Disk Editor (Norton Utilities), but there might be other ways.

hmount /dev/foo
hattrib -i :
humount /dev/foo

will fix that from the linux side.  though linux ignores that bit.

that is odd and disconcerting that its tampering with other partitions
like that, i hope its a bug that will be removed in the next beta
rather then intentional. =20

as for the invisible bit on the root, macos still mounts the disk, but
since the root directory is invisable it does not show it anywhere.  i
used to do this to people's floppies as a joke ;-)

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--LwbuP8dfxhLLLUfV
Content-Type: application/pgp-signature


--LwbuP8dfxhLLLUfV--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
