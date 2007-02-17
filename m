Return-Path: <FENKES@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 108DADDDF3
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 13:24:52 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id l1H2Oia1137042
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 02:24:44 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l1H2OiGs1081562
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 03:24:44 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l1H2OiZk016524
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 03:24:44 +0100
In-Reply-To: <45D4BE7E.7000109@246tNt.com>
To: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2.6.21-rc1] ibmebus: Support dynamic addition and removal
	of adapters
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OFD4D98910.EB8251E4-ON85257285.000A5EF1-85257285.000D3F8C@de.ibm.com>
Date: Fri, 16 Feb 2007 21:24:43 -0500
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

Sylvain Munaut <tnt@246tNt.com> wrote on 15.02.2007 15:11:42:

> Mmmh, I posted a patch that added a common uevent interface for all
> of=5Fdevice based bus. And that kinda clash with this one.

Oops, I was not aware of this. I had a look at your patch and yes, it's a=20
nice
and generic interface. I concur that using your generic function is the=20
better
approach.

> But as "ibm,loc=5Fcode" is local to this bus it's not handled by my code.
> Is it necessary to match the correct driver ?

The intention of adding the location code was to include a device property
into the environment that's unique to each device. Actually, the DEVPATH=20
variable
provides exactly this: For ebus devices, it points to the ebus device=20
itself,
which natually is unique.

If a userspace tool really needs the location code, the "devspec"=20
attribute of
the ebus device will point it to the device tree node, which in turn=20
contains the
location code property.

So I think there's nothing preventing me from using your function. Thanks=20
for
pointing this out.

Regards,
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
