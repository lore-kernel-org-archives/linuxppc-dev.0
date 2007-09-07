Return-Path: <Leonid@a-k-a.net>
Received: from mis011-1.exch011.intermedia.net
	(mis011-1.exch011.intermedia.net [64.78.21.128])
	by ozlabs.org (Postfix) with ESMTP id 199B9DDF19
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 12:13:43 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: RE: Re: PCI target implementation on AMCC PPC CPUs
Date: Thu, 6 Sep 2007 19:13:32 -0700
Message-ID: <406A31B117F2734987636D6CCC93EE3C022418FF@ehost011-3.exch011.intermedia.net>
In-Reply-To: <46E0B178.00C522.05513@m5-81.163.com>
References: <46E0B178.00C522.05513@m5-81.163.com>
From: "Leonid" <Leonid@a-k-a.net>
To: "sdeven.lee" <sdeven.lee@163.com>, "David Hawkins" <dwh@ovro.caltech.edu>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi:

You want to say  PPC440GP cannot be PCI slave without this =
non-transparent bridge because as David said its "interrupt pin register =
hardwired to zero" or there other reasons?=20
I'm trying to use PPC440ep(or epx) and from its datasheet I don't see =
anything about this zero hardwiring. Does it mean "vanilla" PPC440ep =
will work?

And what did you use for PCI Host?

Also, is your code available somwhere?

Thanks,

Leonid.
-----Original Message-----
From: sdeven.lee [mailto:sdeven.lee@163.com]=20
Sent: Thursday, September 06, 2007 7:04 PM
To: David Hawkins
Cc: Leonid; linuxppc-embedded
Subject: Re: Re: PCI target implementation on AMCC PPC CPUs

David Hawkins,=C4=FA=BA=C3=A3=A1

	I have been finished an application using AMCC PPC440GP as PCI =
target(slave) in the last 2 month.I use a non-transparent bridge(AMCC =
PCI6466) to make the device a target(slave) like david has said.

=3D=3D=3D=3D=3D=3D=3D 2007-09-07 04:26:01 =
=C4=FA=D4=DA=C0=B4=D0=C5=D6=D0=D0=B4=B5=C0=A3=BA=3D=3D=3D=3D=3D=3D=3D

>Hi Leonid,
>
>In case they are not in the document:
>
>There are several fundamental problems with the AMCC 440EP acting as a=20
>PCI target/slave;
>
>1. As a PCI target, there is only one way to generate
>    an interrupt to a host; you basically toggle the
>    interrupt pin. This makes it tricky to develop a
>    host-to-slave communications protocol, eg. its
>    hard to use the single interrupt to indicate various
>    interrupt states, eg. target-to-host buffer has
>    data versus host-to-target buffer has been emptied.
>    Ideally AMCC should have implemented mailboxes and/or
>    doorbell registers like any other sane PCI target
>    device (eg. some the Freescale processors, or any of
>    the PLX technologies chips).
>
>2. Look in the data sheet and see if you can figure out
>    how the host processor can generate an interrupt to
>    the PowerPC core ... oops, you can't. That kind of
>    makes it difficult to work with doesn't it.
>
>    A work around would be to have the host write to the
>    GPIO register and wire a GPIO pin back to an external
>    interrupt pin. Then you would not be able to use any
>    other GPIO pin in that GPIO register since there is
>    no way to arbitrate host access versus PowerPC core
>    access.
>
>This was the other reason I ditched the AMCC part in favor of the=20
>Freescale part.
>
>If you are looking at other parts, make sure you look in the PCI=20
>configuration space of the processor reference manual. Many processors=20
>have the interrupt pin register hardwired to zero, i.e., they can not=20
>be used as target devices, only hosts. In that case you'd have to add=20
>an intel 21555 non-transparent bridge to make the device a target.
>
>Cheers,
>Dave
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded

=3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =3D =
=3D =3D
		=09

=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=D6=C2
=C0=F1=A3=A1
=20
				=20
=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1sdeven.lee
=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1sdeven.lee@163.com
=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A12007-09-07
