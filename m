Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 222FDDDF47
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Mar 2008 15:45:45 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m234jgnd027213
	for <linuxppc-dev@ozlabs.org>; Sun, 2 Mar 2008 23:45:42 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m234jgN1198942
	for <linuxppc-dev@ozlabs.org>; Sun, 2 Mar 2008 21:45:42 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m234jgJ4008444
	for <linuxppc-dev@ozlabs.org>; Sun, 2 Mar 2008 21:45:42 -0700
Date: Sun, 2 Mar 2008 22:43:17 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2 v2] [POWERPC] Ignore disabled serial ports
Message-ID: <20080302224317.15f259ca@zod.rchland.ibm.com>
In-Reply-To: <200803030443.43346.arnd@arndb.de>
References: <20080301081600.74598ce4@zod.rchland.ibm.com>
	<20080301081746.689a0a17@zod.rchland.ibm.com>
	<200803030443.43346.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 3 Mar 2008 04:43:42 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> On Saturday 01 March 2008, Josh Boyer wrote:
> > --- linux-2.6.orig/drivers/serial/of_serial.c
> > +++ linux-2.6/drivers/serial/of_serial.c
> > @@ -72,6 +72,11 @@ static int __devinit of_platform_serial_
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int port_type;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!of_device_is_available(=
ofdev->node)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0dev_info(&ofdev->dev, "Disabled serial port. =C2=A0Ign=
ored\n");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -ENODEV;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (of_find_property(of=
dev->node, "used-by-rtas", NULL))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EBUSY;
>=20
> I wonder whether we should move the check for "used-by-rtas" into the
> of_device_is_available function. I understand that used-by-rtas is
> another way of expressing the idea that the kernel is not supposed to
> access the specific device. In this case, the device is physically
> present, but is not available to the OS.

I'd rather not at the moment.  My intention was to only look at the
status property for now.  I'd like to avoid this function growing into
a huge switch statement for $random_firmware's way of flagging
something as "don't touch".

josh
