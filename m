Return-Path: <tobias.knutsson@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.170])
	by ozlabs.org (Postfix) with ESMTP id CDE25DDDE4
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Feb 2009 07:38:30 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 27so1002864wfd.15
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Feb 2009 12:38:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <498C3C81.7050500@matrix-vision.de>
References: <ccb913ac0902040853o395a7f25x855b477453c76c33@mail.gmail.com>
	<498C3C81.7050500@matrix-vision.de>
Date: Fri, 6 Feb 2009 21:38:28 +0100
Message-ID: <ccb913ac0902061238x336da2e4naa81729a38180b67@mail.gmail.com>
Subject: Re: MPC5200 PCI Issues
From: Tobias Knutsson <tobias.knutsson@gmail.com>
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Andre,

I started the development with 2.6.28. Thanks for all of your
suggestions but I managed to find the solution today. The problem was
that the PCI-cards did not have class specified. Adding a fixup hook
to the cards in quirks.c resolved the issue.

On Fri, Feb 6, 2009 at 14:34, Andre Schwarz
<andre.schwarz@matrix-vision.de> wrote:
> Tobias,
>
> are you starting with 2.6.28 or are you upgrading ?
> My system runs very fine with 2.6.27 ....
>
> Tobias Knutsson wrote:
>>
>> I am currently trying to get an MPC5200-based board to run Linux
>> 2.6.28. Most of the devices are working, however i have some issues
>> with the PCI-bus. More precisely, the issue is that all of
>> the cards' IO-regions are mapped to address 0x0.
>>  In my device tree I have the following:
>>
>>       pci@f0000d00 {
>>               #interrupt-cells =3D <1>;
>>               #size-cells =3D <2>;
>>               #address-cells =3D <3>;
>>               device_type =3D "pci";
>>               compatible =3D "fsl,mpc5200b-pci","fsl,mpc5200-pci";
>>               reg =3D <0xf0000d00 0x100>;
>>               interrupt-map-mask =3D <0xf800 0 0 7>;
>>               interrupt-map =3D <0xb000 0 0 1 &mpc5200_pic 0 0 3 // MPC5=
200
>>                                0xb000 0 0 2 &mpc5200_pic 0 0 3
>>                                0xb000 0 0 3 &mpc5200_pic 0 0 3
>>                                0xb000 0 0 4 &mpc5200_pic 0 0 3
>>
>
> What's this ? Is the MPC5200 interrupting itself ?

No, the PCI-bridge is connected to IRQ0

>>
>>                                0xb800 0 0 1 &mpc5200_pic 1 1 3 // c64x0
>>                                0xb800 0 0 2 &mpc5200_pic 1 1 3
>>                                0xb800 0 0 3 &mpc5200_pic 1 1 3
>>                                0xb800 0 0 4 &mpc5200_pic 1 1 3
>>
>
> Have you connected 4 IRQ lines to each c64x device ?

No, this is just some copy-paste leftovers that should be trimmed down
after some examination of the schematics.

>>
>>                                0xc000 0 0 1 &mpc5200_pic 1 1 3 // c64x1
>>                                0xc000 0 0 2 &mpc5200_pic 1 1 3
>>                                0xc000 0 0 3 &mpc5200_pic 1 1 3
>>                                0xc000 0 0 4 &mpc5200_pic 1 1 3
>>
>>                                0xc800 0 0 1 &mpc5200_pic 1 1 3 // c64x2
>>                                0xc800 0 0 2 &mpc5200_pic 1 1 3
>>                                0xc800 0 0 3 &mpc5200_pic 1 1 3
>>                                0xc800 0 0 4 &mpc5200_pic 1 1 3
>>
>>                                0xd000 0 0 1 &mpc5200_pic 1 1 3 // c64x3
>>                                0xd000 0 0 2 &mpc5200_pic 1 1 3
>>                                0xd000 0 0 3 &mpc5200_pic 1 1 3
>>                                0xd000 0 0 4 &mpc5200_pic 1 1 3
>>
>>                                0xd800 0 0 1 &mpc5200_pic 1 1 3 // c64x4
>>                                0xd800 0 0 2 &mpc5200_pic 1 1 3
>>                                0xd800 0 0 3 &mpc5200_pic 1 1 3
>>                                0xd800 0 0 4 &mpc5200_pic 1 1 3>;
>>
>>
>
> I'm using an external FPGA and an e1000 NIC connectedt to IRQ2 and IRQ3 :
>
>               interrupt-map =3D <0x5800 0 0 1 &mpc5200_pic 1 2 3
>                                                0x5000 0 0 1 &mpc5200_pic =
1 3
> 3>;
>
>
>>               clock-frequency =3D <0x1e84800>;  //<0>; // From boot load=
er
>>               interrupts =3D <2 8 0 2 9 0 2 10 0>;
>>               interrupt-parent =3D <&mpc5200_pic>;
>>               bus-range =3D <0 0>;
>>               ranges =3D <0x02000000 0 0x50000000 0x50000000 0 0x1000000=
0
>>                         0x01000000 0 0x00000000 0x60000000 0 0x01000000>=
;
>>       };
>>
>
> I'm using a 3 liner :
>
>               ranges =3D <0x42000000 0 0x80000000 0x80000000 0 0x20000000
>                       0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
>                       0x01000000 0 0x00000000 0xb0000000 0 0x01000000>;
>
>> The cards' memory regions are mapped out fine to different addresses
>> in the 0x50000000-0x60000000 range. However, the IO regions are all mapp=
ed
>> to zero.
>>
>>
>
> Are you c64x devices responding properly ? Is IO access enabled in the PC=
I
> command register ?
> Are they announcing a reasonable window ? How man KBytes ?
>>
>> Do you have any idea on what could be wrong or in which direction I
>> should be looking?
>>
>>
>>
>
> Hopefully something is useful to you.
>
> regards,
> Andre
>
>
> MATRIX VISION GmbH, Talstra=DFe 16, DE-71570 Oppenweiler
> Registergericht: Amtsgericht Stuttgart, HRB 271090
> Gesch=E4ftsf=FChrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner,
> Hans-Joachim Reich
>



--=20

H=E4lsningar/Regards
Tobias Knutsson
