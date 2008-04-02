Return-Path: <johannes@sipsolutions.net>
Subject: printk time confusion?
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-3JeSYEiXnoMEseu38aVg"
Date: Wed, 02 Apr 2008 16:23:06 +0200
Message-Id: <1207146186.3957.11.camel@johannes.berg>
Mime-Version: 1.0
Cc: Arnd Bergmann <arndb@de.ibm.com>, Benjamin Herrenschmidt <benh@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-3JeSYEiXnoMEseu38aVg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Not sure whether the lockdep patches or something else is causing this
as I haven't checked w/o the patches yet, but I seem to be having some
confusion of printk timestamps:

[...]
[  176.440255] iwl4965: No space for Tx
[...]
[  147.983705] ioctl32(gnome-terminal:6361): Unknown cmd fd(25) cmd(0000530=
b){t:'S';sz:0} arg(0fd7bbe0) on /dev/pts/2
[...]
[  173.589209] BUG kmalloc-2048: Poison overwritten
[...]
[  208.385226] ioctl32(gnome-terminal:6498): Unknown cmd fd(29) cmd(0000530=
b){t:'S';sz:0} arg(0fd7bbe0) on /dev/pts/6
[...]
[  139.026724] ioctl32(gnome-terminal:6521): Unknown cmd fd(30) cmd(0000530=
b){t:'S';sz:0} arg(0fd7bbe8) on /dev/pts/7
[...]
[  155.982345] ioctl32(gnome-terminal:6543): Unknown cmd fd(31) cmd(0000530=
b){t:'S';sz:0} arg(0fd7bbe0) on /dev/pts/8
[...]
[  218.918388] tg3: eth0: Link is down.
[...]

Yes, these entries really were printed in that order. Btw, what's with
the unknown ioctls?

Kernel version is 2.6.25-rc8-wl-04519-g6648ff7-dirty where -wl/-dirty
refers to wireless patches and the lockdep patches and otherwise it's
just -rc8.

johannes

--=-3JeSYEiXnoMEseu38aVg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR/OWyKVg1VMiehFYAQKbgA/9E2QIYRE9ewITvjxaYdpzQyyWWhncd3Kz
JPrI8Sl4/KB15Xj3wDqyVDvmgWvTKjrnLnURhZ8GzoD9h/YytH1rSIga0E1AzBRY
eKi5fDLP4MLRgzgjdSsuEk+7oWvJcplcpNHTfFb0Jo8+81AL6KCAsTi3IC3sgiVw
crsbI9S8ME44nGhyFNjYD2OqvIBv63PQjjAm9PuY4jSbJb2Pw4GklhjQcJbc2Meb
Yo0XzKWbicvUWI9k5cB/IBsMMIB1zYXrm+IoEDsCDpX2HsxqMIFm3p9SxjYMZA8g
qxFzSrUxwA3CESEfgy9WQQG4OUPLgAvlLpsCVALmPE9d2CTGcgyjaBoWGCLwdjAi
B76kqhCQFP0gQTnadL0ikiS+NQ8bf5iYRKkVLRbDVjyuKKBnxWRKALZUaF/IfdgX
gWYO2CvCA+PwgYnYnI/kz6glZxT2fWIjiANFm/z24j48CrDObIYAFMmnka0Mx4Jw
/B+m3aGKNHHKaq1BS7paMQeStVN2vjH7RGipeLPt2AZw3PRyrkjeSjwYALmIXb9a
LcYK3zuYKYAhAhFVbDgNcUuDWlBxXKxyOCkE8S3gXwRKLHh74iIyifyVLpVXlI/X
xTuQv+OpWuWytDhgYWQuvAuOsiIzVrolDYMM03k7kfy9Xg71aCia8agTsghd+tzr
yEvXWYxWO2Q=
=FHNd
-----END PGP SIGNATURE-----

--=-3JeSYEiXnoMEseu38aVg--
