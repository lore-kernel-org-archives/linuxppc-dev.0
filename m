Return-Path: <FENKES@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 12271DDE24
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 11:21:49 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id l1I0LjPW016954
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 00:21:45 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l1I0LjhI1650770
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 01:21:45 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l1I0LiqJ010374
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 01:21:44 +0100
In-Reply-To: <1171749399.5644.145.camel@localhost.localdomain>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2.6.21-rc1] powerpc: Make of_device_uevent()
	compatible	with ibmebus
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OF8D0E4DD6.8DF18C46-ON85257286.00002C8B-85257286.0001FC97@de.ibm.com>
Date: Sat, 17 Feb 2007 19:21:42 -0500
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
16:56:39:

> On Sat, 2007-02-17 at 17:28 +0100, Hoang-Nam Nguyen wrote:
> > ibmebus has a fake root device that's not associated with an ofdt=20
node.
> > Filter out any such devices in of=5Fdevice=5Fuevent().
>=20
> Doh ! You are creating an of=5Fdevice with no attached device-node ? That
> is totally evil ! Why do you need that ?

The driver creates a fake "ibmebus" device so all ibmebus based devices=20
have
a common parent device -- the vio bus does the same.

What do you think about linking this device to the device tree "/" node?=20
All
ibmebus-based devices are linked to dt nodes residing directly beneath=20
"/",
so the mapping would fit.

Cheers,
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
