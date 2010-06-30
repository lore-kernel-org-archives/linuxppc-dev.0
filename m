Return-Path: <shawnxjin@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 88FAFB6F0C
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jul 2010 08:25:59 +1000 (EST)
Received: by iwn36 with SMTP id 36so1003659iwn.15
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 15:25:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C2B6DF5.7030403@freescale.com>
References: <AANLkTinA2ghLxBU41aFAsLM1oXQ8HMASx1eQMDVvi56n@mail.gmail.com>
	<20100629185617.GA24285@schlenkerla.am.freescale.net>
	<AANLkTik48Ht-jeq_U1yh9c9WzFYE8yYpALiz_N8SzF4N@mail.gmail.com>
	<4C2B6DF5.7030403@freescale.com>
Date: Wed, 30 Jun 2010 15:25:57 -0700
Message-ID: <AANLkTinYnoqfZAJWlYg633VbVyjWXhvFk2p406eP3o0c@mail.gmail.com>
Subject: Re: machine check in kernel for a mpc870 board
From: Shawn Jin <shawnxjin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

> Does u-boot on your board put IMMR somewhere other than 0xff000000? =A0If=
 so,
> you'll need to update the device tree to reflect this.

Thanks a lot. I think you got something here. Please bear with me.
This is the first dts file I'm creating. I have some question
regarding to dts first. BTW, My IMMR is at 0xfa200000.

How do I find the address, reg, and range for nodes like localbus,
soc, eth0, cpm, serial etc.? Do the addresses of localbus and soc
relate to IMMR? So my localbus and soc should be as follows?

        localbus@fa200100 {
                compatible =3D "fsl,mpc885-localbus", "fsl,pq1-localbus",
                             "simple-bus";
                #address-cells =3D <2>;
                #size-cells =3D <1>;
                reg =3D <0xfa200100 0x40>;

                ranges =3D <
                        0 0 0xfe000000 0x01000000    // I'm not sure about =
this?
                >;
        };

        soc@fa200000 {
                compatible =3D "fsl,mpc875-immr", "fsl,pq1-soc", "simple-bu=
s";
                #address-cells =3D <1>;
                #size-cells =3D <1>;
                ranges =3D <0 0xfa200000 0x00004000>;

                // Temporary until code stops depending on it.
                device_type =3D "soc";

                // Temporary until get_immrbase() is fixed.
                reg =3D <0xfa200000 0x4000>;
        };

Thanks again,
-Shawn.
