Return-Path: <pppeterpppan@gmail.com>
Received: from mail-qy0-f189.google.com (mail-qy0-f189.google.com
	[209.85.221.189]) by ozlabs.org (Postfix) with ESMTP id 05987B7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Apr 2010 11:56:51 +1000 (EST)
Received: by qyk27 with SMTP id 27so3555914qyk.23
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Apr 2010 18:56:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4BD0834A.3020508@freescale.com>
References: <q2g48abf2c21004212341oe37ed471g63c646ae12914ab3@mail.gmail.com>
	<4BD0834A.3020508@freescale.com>
Date: Fri, 23 Apr 2010 09:56:49 +0800
Message-ID: <l2x48abf2c21004221856t63786e04o9dc0599b9335e12c@mail.gmail.com>
Subject: Re: How to support scc-enet on MPC8247 in Linux 2.6.32.6
From: Peter Pan <pppeterpppan@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is an MDIO used by FCC, but the SCC is connected with LXT905,
which is Ethernet Interface Adapter. So I think the SCC should be
fixed-link. But how can I set the fixed-link property? I searched
through the Document directory, there is nothing about the fixed-link
property.

2010/4/23 Scott Wood <scottwood@freescale.com>:
> Peter Pan wrote:
>>
>> I'm porting Linux 2.6.32.6 to our MPC8247 based board. We use SCC3 and
>> SCC4 as ethernet port. These two ports are connect with LXT905 PHY
>> chip.
>> I'm now using fs_enet driver, how should I config the scc port in dtc
>> file. I copied from mgcoge.dts file, and my dtc file of scc enet is
>> follows:
>>
>> =A0 =A0 =A0 =A0 =A0 =A0eth2: ethernet@11a40 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "network";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8247-scc-enet",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "fsl,cpm2-scc-en=
et";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x11a40 0x20 0x8200 0x100 0x1139=
0 0x1>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0local-mac-address =3D [ 00 00 00 00 00 00=
 ]; /* filled
>> by U-Boot */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <42 8>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <&PIC>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0linux,network-index =3D <0x2>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fsl,cpm-command =3D <0x8c00000>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fixed-link =3D < 0 0 10 0 0 >;
>> =A0 =A0 =A0 =A0 =A0 =A0};
>> But i does not working. Linux says that PHY 0:00 is not found. I dive
>> into the code, and that's according to the fixed-link property.
>> I'm wondering how to support scc-enet in my situation.
>
> Do you really want fixed-link, or does the board have a working MDIO
> interface? =A0If the latter, you need a phy-handle property instead, poin=
ting
> to a PHY node under an MDIO bus node that represents how MDIO is wired on
> your board.
>
> -Scott
>
