Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id A5D35DDDF9
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 02:23:04 +1000 (EST)
Date: Tue, 25 Sep 2007 20:22:57 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Nethra <nethra_gmit@yahoo.co.in>
Subject: Re: jffs2 file system on MPC8272ADS board
Message-ID: <20070925202257.559a78c5@ru.mvista.com>
In-Reply-To: <12873530.post@talk.nabble.com>
References: <12873530.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_tWV/vmGpI8w3Jzk9uuW6E.u";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_tWV/vmGpI8w3Jzk9uuW6E.u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Nethra,

On Mon, 24 Sep 2007 22:47:38 -0700 (PDT)
Nethra wrote:

>=20
> hi everyone,
>=20
> I m using custom board similar to MPC8272ADS board...
>=20
> 1) For the first time it boots up properly in case if we overwrite any
> existing binaries using nfs mounted file system on the board, after
> rebooting it displays fallowing message...
>=20
> Further such events for this erase block will not be printed
> Eep. Child "null" (ino #1346) of dir ino #3 doesn't exist!
> Eep. Child "autocomm" (ino #463) of dir ino #461 doesn't exist!
> Eep. Child "calibration" (ino #464) of dir ino #461 doesn't exist!
> Eep. Child "coredsp_driver.ko" (ino #939) of dir ino #336 doesn't exist!
> Inode #1307 was a directory with children - removing those too...
> Inode #564 was a directory with children - removing those too...
> Inode #565 was a directory with children - removing those too...
> Inode #1112 was a directory with children - removing those too...
> Inode #1115 was a directory with children - removing those too...
> Inode #1118 was a directory with children - removing those too...
> Inode #1123 was a directory with children - removing those too...
>=20
> after this board boots up properly....but it not be having overwritten fi=
les
>=20
Have you created jffs2 file system on flash prior to mounting it?

> 2) while booting up for the first time itself it will display the falowing
> message..
>=20
> modprobe: FATAL: Could not load
> /lib/modules/2.6.10_mvl401-8272ads/modules.dep: No such file or dire
> ctory
>=20
> but after this also board boots up properly
>=20
You are missing modules.dep, since haven't run depmod. Issue in from target=
 and it will get cured.

> 3) when board is running properly in between it starts printing on console
> repeatedly...
>=20

Do the proper MTD partitions setup, erase the partition and create jffs2 fi=
lesystem on it.
If after all those steps you're still getting output, that is prolly flakey=
 flash.
> Header CRC failed on REF_PRISTINE node at 0x00638a6c: Read 0xffffffff,
> calculated 0x44660075
> Node totlen on flash (0xffffffff) !=3D totlen from node ref (0x00000254)
> Header CRC failed on REF_PRISTINE node at 0x00638cc0: Read 0xffffffff,
> calculated 0x44660075
[...]
>  and=20
>=20
> file system is created using fallowing command..
>=20
> mkfs.jffs2 -r RFS_NEW/ -e 0x20000 -o /tftpboot/jffs2_img -b
>=20
I am recalling playing with the options upper also cured the jffs2 warnings=
 (not as many as yours but anyway)

> do we need padding or not..?
I'd say that we do not. but it depends

--
Vitaly

--Sig_tWV/vmGpI8w3Jzk9uuW6E.u
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG+TXhe8XNc4YXvvgRAnHDAJ9n37AWJlfMQvim5V85prTPkU8bGwCdE9l9
iqKTXAygLslD234Pht9jeTo=
=0N8R
-----END PGP SIGNATURE-----

--Sig_tWV/vmGpI8w3Jzk9uuW6E.u--
