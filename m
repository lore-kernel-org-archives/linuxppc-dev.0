Return-Path: <daniel.ng1234@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.236])
	by ozlabs.org (Postfix) with ESMTP id 87590DDDA2
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 18:09:34 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id g9so6587487rvb.1
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 23:09:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <547eba1b0902192101n323f51ceuf39b9d954b696225@mail.gmail.com>
References: <mailman.5.1233190802.9523.linuxppc-dev@ozlabs.org>
	<49810367.5000904@consentry.com>
	<547eba1b0902182247g66c8b83se0855ff048413c01@mail.gmail.com>
	<20090219184410.GB4180@ld0162-tx32.am.freescale.net>
	<547eba1b0902192101n323f51ceuf39b9d954b696225@mail.gmail.com>
Date: Wed, 25 Feb 2009 18:09:32 +1100
Message-ID: <547eba1b0902242309o2086dce2p49c59a9ea1b85b53@mail.gmail.com>
Subject: Re: How to bring up fs_enet on 2.6.27?
From: Daniel Ng <daniel.ng1234@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Mike Ditto <mditto@consentry.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi guys,

I was hoping to have gotten some form of comment by now...

Can anyone help out here, please?

Daniel

On Fri, Feb 20, 2009 at 4:01 PM, Daniel Ng <daniel.ng1234@gmail.com> wrote:
>
> Now, I'm seeing these boot messages:
>
> f0010d40:00 not found
> eth0: Could not attach to PHY
> IP-Config: Failed to open eth0
> IP-Config: Device `eth0' not found.
>
> Previous mailing list discussions suggest that I use the correct PHY,
> which I am sure about because my 8272-based board only has the one PHY
> ie. PHY0 with reg =3D <0x0>.
>
> Note the relevant parts of my Device Tree below. Currently, our PHY
> attributes eg. 'auto-negotiate' are not changeable, so we aren't
> actually using MDC+MDIO even the MDC+MDIO lines exist. Also, the PHY
> interrupt line is not wired up. Hence the PHY0 interrupts field is <0
> 8> (or should it be removed altogether?).
>
> I am usig FCC2.
>
> What might I need to change to get the ethernet driver working?
>
>
> =A0 =A0 =A0ethernet@11320 {
> =A0 =A0 =A0 =A0device_type =3D "network";
> =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8272-fcc-enet",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "fsl,cpm2-fcc-enet";
> =A0 =A0 =A0 =A0// FCC2-
> =A0 =A0 =A0 =A0reg =3D <0x11320 0x20 0x8500 0x100 0x113b0 0x1>;
> =A0 =A0 =A0 =A0local-mac-address =3D [ 00 00 00 00 00 00 ];
> =A0 =A0 =A0 =A0interrupts =3D <33 8>;
> =A0 =A0 =A0 =A0interrupt-parent =3D <&PIC>;
> =A0 =A0 =A0 =A0phy-handle =3D <&PHY0>;
> =A0 =A0 =A0 =A0linux,network-index =3D <0>;
> =A0 =A0 =A0 =A0fsl,cpm-command =3D <0x16200300>;
> =A0 =A0 =A0};
>
> =A0 =A0 =A0mdio@10d40 {
> =A0 =A0 =A0 =A0device_type =3D "mdio";
> =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8272ads-mdio-bitbang",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "fsl,mpc8272-mdio-bitbang",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "fsl,cpm2-mdio-bitbang";
> =A0 =A0 =A0 =A0reg =3D <0x10d40 0x14>;
> =A0 =A0 =A0 =A0#address-cells =3D <1>;
> =A0 =A0 =A0 =A0#size-cells =3D <0>;
> =A0 =A0 =A0 =A0fsl,mdio-pin =3D <5>;
> =A0 =A0 =A0 =A0fsl,mdc-pin =3D <19>;
>
> =A0 =A0 =A0 =A0PHY0: ethernet-phy@0 {
> =A0 =A0 =A0 =A0 =A0interrupt-parenn =3D <&PIC>;
> =A0 =A0 =A0 =A0 =A0interrupts =3D <0 8>;
> =A0 =A0 =A0 =A0 =A0reg =3D <0x0>;
> =A0 =A0 =A0 =A0 =A0device_type =3D "ethernet-phy";
> =A0 =A0 =A0 =A0};
> .
> .
> .
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PIC: interrupt-controller@10c00 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#interrupt-cells =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-controller;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x10c00 0x80>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc827=
2-pic", "fsl,cpm2-pic";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>
> Cheers,
> Daniel
>
