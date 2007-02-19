Return-Path: <FENKES@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5AA31DDE05
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 03:36:30 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id l1JGaPvL127118
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Feb 2007 16:36:25 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l1JGaP4h1925332
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Feb 2007 17:36:25 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l1JGaOFa005981
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Feb 2007 17:36:25 +0100
In-Reply-To: <1171759045.5644.148.camel@localhost.localdomain>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2.6.21-rc1] powerpc: Make
	of_device_uevent()	compatible	with ibmebus
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OF18F067AE.FF85D78B-ON85257287.005ADAC3-85257287.005B37D9@de.ibm.com>
Date: Mon, 19 Feb 2007 11:36:23 -0500
Content-Type: text/plain; charset="ISO-8859-1"
Cc: pmac@au1.ibm.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>,
	johnrose@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 17.02.2007=20
19:37:25:

> > > Doh ! You are creating an of=5Fdevice with no attached device-node ? =

That
> > > is totally evil ! Why do you need that ?
> >=20
> > The driver creates a fake "ibmebus" device so all ibmebus based=20
devices=20
> > have
> > a common parent device -- the vio bus does the same.
> >=20
> > What do you think about linking this device to the device tree "/"=20
node?=20
> > All
> > ibmebus-based devices are linked to dt nodes residing directly beneath =


> > "/",
> > so the mapping would fit.
>=20
> No. If you do that, it shouldn't be an of=5Fdevice based device.
>=20
> If you want then to be below a common parent, then create that parent of
> a basic struct device type, that sort of thing. You should never
> instanciate an of=5Fdevice that has a NULL device node.

If I make the root device a basic struct device, it can't be part of=20
ibmebus any
longer. If we could create a busless device, we wouldn't have a problem,=20
but I
doubt that is possible.

Do you have any creative ideas?
=20
> It's a generic problem with sysfs, I agree it somewhat sucks.

With ya.

Later,
  Joachim

---
Joachim Fenkes  --  eHCA Linux Driver Developer and Hardware Tamer=20
extraordinaire
IBM Deutschland Entwicklung GmbH  --  Dept. 3627 (I/O Firmware Development =

2)
Schoenaicher Strasse 220  --  71032 Boeblingen  --  Germany
eMail: fenkes@de.ibm.com  --  Phone: +49 7031 16 1239=20

Vorsitzender des Aufsichtsrats: Johann Weihen  --  Gesch=E4ftsf=FChrung:=20
Herbert Kircher
Sitz der Gesellschaft: B=F6blingen  --  Registergericht: Amtsgericht=20
Stuttgart, HRB 243294
