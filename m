Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by ozlabs.org (Postfix) with ESMTP id 5EBB8B7D8C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Jun 2010 09:15:02 +1000 (EST)
Received: by gwb20 with SMTP id 20so444315gwb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Jun 2010 16:15:00 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <162C87D14617439384076F797228B1EF@kos>
References: <57F24E98919C4D22A784127E6CF1C9DA@kos>
	<AANLkTimArb-UjJMe84Qrd4iNquGHEehbGW1Uciq_zGYm@mail.gmail.com>
	<EBEDB9C789D344D9A8D459B6FCB1A0AD@kos>
	<AANLkTinBJgwL9qcw0Ouzuvc55C1Gs2KtIoY2NbBy34V2@mail.gmail.com>
	<162C87D14617439384076F797228B1EF@kos>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 16 Jun 2010 17:14:39 -0600
Message-ID: <AANLkTim8kD9PH7BqOIV0GvElIfOgUDMw1VfWcOJhj-8r@mail.gmail.com>
Subject: Re: Porting a driver to powerpc using FDT
To: Chris Alfred <c.alfred@internode.on.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 16, 2010 at 4:48 PM, Chris Alfred <c.alfred@internode.on.net> w=
rote:
>>> dsa_of_init is successfully called; but dsa_of_probe is not called.
>>
>> That means the node is not being used to register an of_device. =A0I
>> need some more information to suggest how best to fix this.
>
>> What SoC are you using?
>> What file in arch/powerpc/platforms/* is used to setup your machine?
>
> We are using the MPC5200. Very similar to the Lite5200.

So you're board is driver by arch/powerpc/platforms/52xx/mpc5200_simple.c t=
hen?

>
>> It would help to have a copy of your full .dts file.
>
> /*
> =A0* jkc5200n8 board Device Tree Source
> =A0*
> =A0* Copyright 2006-2007 Secret Lab Technologies Ltd.
> =A0* Grant Likely <grant.likely@secretlab.ca>
> =A0*
> =A0* This program is free software; you can redistribute =A0it and/or
> modify it
> =A0* under =A0the terms of =A0the GNU General =A0Public License as publis=
hed
> by the
> =A0* Free Software Foundation; =A0either version 2 of the =A0License, or =
(at
> your
> =A0* option) any later version.
> =A0*/
>
> /dts-v1/;
>
> / {
> =A0model =3D "fsl,jkc5200n8";
> =A0compatible =3D "fsl,jkc5200n8";

Replace these two instances of 'fsl,' with this vendor name of this
board.  fsl means freescale, and I'm guessing freescale didn't design
this board.

> =A0#address-cells =3D <1>;
> =A0#size-cells =3D <1>;
> =A0interrupt-parent =3D <&mpc5200_pic>;
>
> =A0cpus {
> =A0#address-cells =3D <1>;
> =A0#size-cells =3D <0>;
>
> =A0PowerPC,5200@0 {
> =A0 device_type =3D "cpu";
> =A0 reg =3D <0>;
> =A0 d-cache-line-size =3D <32>;
> =A0 i-cache-line-size =3D <32>;
> =A0 d-cache-size =3D <0x4000>; // L1, 16K
> =A0 i-cache-size =3D <0x4000>; // L1, 16K
> =A0 timebase-frequency =3D <0>; // from bootloader
> =A0 bus-frequency =3D <0>; =A0// from bootloader
> =A0 clock-frequency =3D <0>; =A0// from bootloader
> =A0};
> =A0};
>
> =A0memory {
> =A0device_type =3D "memory";
> =A0reg =3D <0x00000000 0x10000000>; // 256MB
> =A0};
>
> =A0dsa {
> =A0compatible =3D "dsa-of";
> =A0reg =3D <0 0>; =A0 // unused

As mentioned, drop the reg property and be more specific in the
compatible value.

Okay, so the problem is that the 5200 board support doesn't understand
that this device is a real device.  The solution (and this isn't
perfect, but I'm working to make this better) is to put the node in a
place where the platform code actually processes it.  If you do the
following, then it should start working:

virtual-devices {
        compatible =3D "simple-bus";
        dsa {
              compatible =3D "<vendor>,jkc5200n8-dsa";
        };
};

Note that I've encoded the board name in the compatible value.  Until
(when/if) there is a 'generic' binding for DSA devices, you should
just use a string that is board specific.

You can look under /sys/devices to see if your device actually gets
registered or not.

This is *not* ideal.  The support code should pick up the device even
as a child of the root node, but I've got to make some changes to the
registration code to make it work correctly.

Cheers,
g.
