Return-Path: <FENKES@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D648BDDDF5
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 09:36:22 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id l1KMaIWE091418
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 22:36:18 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l1KMaI1i1532074
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 23:36:18 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l1KMaHIe009567
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 23:36:18 +0100
In-Reply-To: <1171992306.22669.5.camel@sinatra.austin.ibm.com>
To: John Rose <johnrose@austin.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2.6.21-rc1] ibmebus: Support dynamic addition	and	removal
	of adapters
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OF11FDFA50.7BF76A97-ON85257288.006AC46B-85257288.007C2AD7@de.ibm.com>
Date: Tue, 20 Feb 2007 17:36:16 -0500
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Paul Mackerras <pmac@au1.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
	External List <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>,
	Me Notes <johnrose@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

John Rose <johnrose@austin.ibm.com> wrote on 20.02.2007 12:25:06:

> > If the probe operation succeeds, the respective device will show up=20
> > beneath
> > /sys/bus/ibmebus/devices.
>=20
> This approach is not particularly synchronous.  Take the case of an add
> failure: how long would an application wait before deciding that the new
> device is not going to appear?
>
> It might be preferable to have the write to the probe function fail.=20
> For example, if we can't find the device node, return -EINVAL or
> something.

Can be done, sure. Just a matter of putting some more sophisticated error
handling into my code. Patch follows in a bit.
=20
> > This is already taken care of by of=5Fdevice=5Fregister().
>=20
> If we are scrapping the use of of=5Fdevice for ibmebus devices, can we
> still create a devspec file for OF correlation purposes?

We don't. My recent patch only changes the fake root device.
Ibmebus-based devices will still be of=5Fdevices, of course.

Regards,
  Joachim

---
Joachim Fenkes  --  eHCA Linux Driver Developer and Hardware Tamer
IBM Deutschland Entwicklung GmbH  --  Dept. 3627 (I/O Firmware Dev. 2)
Schoenaicher Strasse 220  --  71032 Boeblingen  --  Germany
eMail: fenkes@de.ibm.com  --  Phone: +49 7031 16 1239=20

Sitz der Gesellschaft: B=F6blingen  --  Geschftsfhrung: Herbert Kircher
Vorsitzender des Aufsichtsrats: Johann Weihen
Registergericht: Amtsgericht Stuttgart, HRB 243294
