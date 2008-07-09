Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B1BD3DDFDB
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 21:39:50 +1000 (EST)
Subject: Re: PReP residual to device-tree converter
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1215602952.3670.39.camel@johannes.berg>
References: <18490.22494.511244.977267@cargo.ozlabs.ibm.com>
	<1215600470.3670.35.camel@johannes.berg>
	<1215602952.3670.39.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Hjifaj30Rtee14q6aRyM"
Date: Wed, 09 Jul 2008 13:39:01 +0200
Message-Id: <1215603541.3670.44.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Milton Miller <miltonm@bga.com>,
	David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Hjifaj30Rtee14q6aRyM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-07-09 at 13:29 +0200, Johannes Berg wrote:
> On Wed, 2008-07-09 at 12:48 +0200, Johannes Berg wrote:
> > > I would like people that have PReP machines to take a copy of
> > > /proc/residual, run this program on it, and check that the output is
> > > sane.  If it isn't, or if it is missing bits, send me the residual
> > > blob with a description of what's wrong in the generated dts.
> >=20
> > Here's the output from qemu:
> [...]
>=20
> Milton wanted iomem and ioports, I didn't manage to get userspace
> working so I printed them in the kernel (hopefully correctly):

I printed them far too early. After letting it probe drivers first, I
get:

iomem:
c0000000-feffffff : PCI host bridge
  c0000000-c000000f : 0000:00:03.0
  c1100000-c110000f : 0000:00:02.0
  c80000f0-c80000ff : 0000:00:01.0

ioport:
00000000-007fffff : PCI host bridge
  00000000-0000001f : dma1
  00000020-00000021 : 8259 (master)
  00000040-0000005f : timer
  00000080-0000008f : dma page reg
  000000a0-000000a1 : 8259 (slave)
  000000c0-000000df : dma2
  000001f0-000001f7 : ide0
  000003f2-000003f5 : floppy
  000003f6-000003f6 : ide0
  000003f7-000003f7 : floppy DIR
  000003f8-000003ff : serial
  000004d0-000004d1 : 8259 edge control

which was with usb too:

qemu-system-ppc -initrd initrd  -kernel linux/arch/ppc/boot/images/zImage.p=
rep -M prep -cpu 604 -serial stdio -net nic,model=3Dne2k_pci -usb

johannes

--=-Hjifaj30Rtee14q6aRyM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJIdKNRAAoJEKVg1VMiehFYQYgQAKq5RUSpMGaQs9TZbx1ukCZE
xo7Fl+y1ljxqtEZrAI3LKtN/5i0chkiBoUobW1tOfA4rau4RpO24H4P9FO2xMWth
NRLGZE994WcUw3H/Rkmb23BsEzIKq34O+HjpGBndTdvIaw+X5Sduwf8JP1wP3NN2
v9zyCvTBZLU9VVqIqff696CjTn77t1+nT7i2tReqBXwYNtBHlcH96klqKf4y+enQ
hYdQom63Zq6SigXNz3NfUHtGzTsPJ0dK9TgYqTlmMgqr9Iru3rA8qUKqv31catgW
R/5rbbl08utLzQqWqFT7QHRfd7Hy46hqQWEx+SqXndC+TNfT3SqwJ3KC7uoXQiua
ecGSskeKgZ8NgaCc82T/vs/tQXq2GBxugik9nMYUM4AQ2OwZ8FkvBECihWAYslXJ
3vdqDKouNSiZ0dWCoL9L5Mr99PIYa38HWGAfXrdKk6/9f8CoHGn6hXa4Dbi3jcUR
oVLYiKb7Naio53VCh9GTRqoKYyK592v+kvn7wQHIYWiezuwXMhfP366qWg/MMvoG
KMns2/KZhbbUboREpt7aJLNy61HYBaQ9s4VW9BUU80LJodxtNW28dcHPUE7g7ifj
m7pNyEIU7I/LyfCF13Nk1nMhBvLakAuyvrhYqSn/BJkG02/PNWEeNguuVw2GYux2
T9ameVAuBp2x/VkOx/vj
=cBA8
-----END PGP SIGNATURE-----

--=-Hjifaj30Rtee14q6aRyM--
