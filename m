Date: Wed, 24 May 2000 22:50:02 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Tom <tdilling@mac.com>
Cc: linuxppc-dev@lists.linuxppc.org, linuxppc-users@lists.linuxppc.org
Subject: Re: yaboot problems (still -- suggestions welcome!)
Message-ID: <20000524225002.O383@plato.local.lan>
References: <392C4F17.61D04687@mac.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j3zO+32zXj6UcJCE"
In-Reply-To: <392C4F17.61D04687@mac.com>; from tdilling@mac.com on Wed, May 24, 2000 at 05:52:23PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--j3zO+32zXj6UcJCE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2000 at 05:52:23PM -0400, Tom wrote:
> I've been struggling with it for over a week now, but am still unable to
>=20
> yaboot (though I think I've made some minimal progress).
>=20
> I have a G4/500 with linux on a dedicated external scsi drive (Adaptec
> 2906 card).
>=20
> Per OF, the card corresponds to:
> /pci@f2000000/pci-bridge@d/pci9004,7850@2/@2  (It is device 2 on the
> scsi chain, or at least that's what the back of the hard drive implies.)
>=20
> pdisk says the bootstrap partition is #2:
> Partition map (with 512 byte blocks) on '/dev/sda'
>  #:                type name                   length   base    ( size )
>=20
>  1:    Apple_UNIX_SVR2 /            7785303 @ 204     (  3.7G)
>  2:    Apple_HFS "bootstrap"         65638 @ 7785507 ( 32.0M)

this is a waste of space, since your swap partition is right below
perhaps you would want to delete them both and create the bootstrap
partition as 800K and the swap partition as 544. =20

you should at the very least delete it and recreate it with the
correct Apple_Bootstrap partition type, otherwise macos will screw it
up.=20

>  3:    Apple_UNIX_SVR2 swap    1048592 @ 7851145 (512.0M)
>  [rest deleted]
>=20
> Set the relevant line in /boot/ofboot.b (which is cp'd from the
> menu_ofboot.b):
> " Booting Yaboot ..." cr " boot sd:2,yaboot" eval
>=20
> My /etc/yaboot.conf is as follows:
> --------------
> default=3DLinux-Stable
>=20
> ## change to your bootstrap partition ie /dev/hda2
> boot=3D/dev/sda2
> device=3Dsd:
> timeout=3D20
> install=3D/boot/yaboot
> magicboot=3D/boot/ofboot.b
>=20
> image=3D/boot/vmlinux
>  label=3DLinux-Stable
>  root=3D/dev/sda1
>  read-only
>  partition=3D2
>=20
> append=3D "video=3Daty128fb:vmode:17;cmode:24"
> -----------------
>=20
> Now, in OF, when I try to set sd as a devalias, it tells me the nvramrc
> isn't valid.  When I printenv, I don't see it showing up anywhere (but
> maybe I don't know what to look for, exactly?).

nvalias is the proper command to create an alias, though i find it
simpler to just enter the full path in yaboot.conf and ofboot.b.  that
way you 1) don't have to fsck with OF.  and 2) don't have to fsck with
OF if your nvram gets erased.

> When in OF and I try to boot directly by providing the OF path manually,
>=20
> I get this error:
> method <open> not found ; ihandle=3Dff9c4980 phandle=3Dff8a9708 method
> <close> not found ihandle=3Dff9c4980 phandle=3Dff8a9708 can't OPEN:
> /pci@f2000000/.... {etc}.
> I don't know what this means or what to do with this information.
> (Anyone have any idea?)

exactly what boot command did you use? it should be as follows:

boot /pci@f2000000/pci-bridge@d/pci9004,7850@2/@2:2,yaboot

you can put that in ofboot.b.

if that is what you used then it looks to me like the scsi card is not
really OF supported, can you boot macos off of it?  (if you have macos)

> One last thing: I have managed in the past week to get ybin working (my
> bootstrap was mounted in the mtab).

yes you bootstrap partition should never be mounted anywhere, not in
linux, not in macos.  treat it like a bootblock that is all it is.
your kernels belong in your ext2 root filesystem.

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--j3zO+32zXj6UcJCE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkszRoACgkQJKx7GixEevzcuwCfTe03ubQFwu4i4vHJHMXswsce
8QwAoJaEHn7OlcQa35/SlXZyaJMMrr9k
=30e0
-----END PGP SIGNATURE-----

--j3zO+32zXj6UcJCE--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
