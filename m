Return-Path: <daniel.schnell@marel.com>
Received: from mail.marel.com (mail.marel.com [213.167.134.96])
	by ozlabs.org (Postfix) with ESMTP id 7A361DDEBA
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Jun 2007 22:15:00 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Where is initial console initialized ?
Date: Fri, 1 Jun 2007 12:14:57 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB01FAEBE0@is-hdq-exchange.marel.net>
In-Reply-To: <20070601063507.GA23294@moe.telargo.com>
References: <DD39B5C3F4963040ADC9768BE7E430CB01F550A7@is-hdq-exchange.marel.net>
	<20070601063507.GA23294@moe.telargo.com>
From: "Daniel Schnell" <daniel.schnell@marel.com>
To: "Domen Puncer" <domen.puncer@telargo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hmm, this is a bug in the U-Boot print-data() function. Normally you =
should see a 8 bytes field for "reg =3D  ", so I changed that function =
to dump the hexadecimal contents when data length is =3D=3D 8 and these =
reg =3D values look much better now:


Still no go to boot Linux.


Booting using flat device tree at 0x400000
 {
    model =3D "v38c";
    compatible =3D [76 33 38 63 00 6d 70 63 35 32 30 30 62 00 6d 70 63 =
35 32 78 78 00];
    #address-cells =3D <1>;
    #size-cells =3D <1>;
    cpus {
        #cpus =3D <1>;
        #address-cells =3D <1>;
        #size-cells =3D <0>;
        PowerPC,5200@0 {
            device_type =3D "cpu";
            reg =3D <0>;
            d-cache-line-size =3D <20>;
            i-cache-line-size =3D <20>;
            d-cache-size =3D <4000>;
            i-cache-size =3D <4000>;
            timebase-frequency =3D <1f78a40>;
            bus-frequency =3D <7de2900>;
            clock-frequency =3D <179a7b00>;
            32-bit;
        };
    };
    memory {
        device_type =3D "memory";
        reg =3D [00 00 00 00 08 00 00 00];
    };
    soc5200@f0000000 {
        #interrupt-cells =3D <3>;
        device_type =3D "soc";
        ranges =3D [00 00 00 00 f0 00 00 00 f0 01 00 00];
        reg =3D [f0 00 00 00 00 01 00 00];
        bus-frequency =3D <3ef1480>;
        cdm@200 {
            compatible =3D [6d 70 63 35 32 30 30 62 2d 63 64 6d 00 6d 70 =
63 35 32 78 78 2d 63 64 6d 00];
            reg =3D [00 00 02 00 00 00 00 38];
        };
        pic@500 {
            linux,phandle =3D <500>;
            interrupt-controller;
            #interrupt-cells =3D <3>;
            device_type =3D "interrupt-controller";
            compatible =3D [6d 70 63 35 32 30 30 62 2d 70 69 63 00 6d 70 =
63 35 32 78 78 2d 70 69 63 00];
            reg =3D [00 00 05 00 00 00 00 80];
            built-in;
        };
        gpt@600 {
            compatible =3D [6d 70 63 35 32 30 30 62 2d 67 70 74 00 6d 70 =
63 35 32 78 78 2d 67 70 74 00];
            device_type =3D "gpt";
            reg =3D [00 00 06 00 00 00 00 10];
            interrupts =3D [00 00 00 01 00 00 00 09 00 00 00 00];
            interrupt-parent =3D <500>;
        };
        gpt@610 {
            compatible =3D [6d 70 63 35 32 30 30 62 2d 67 70 74 00 6d 70 =
63 35 32 78 78 2d 67 70 74 00];
            device_type =3D "gpt";
            reg =3D [00 00 06 10 00 00 00 10];
            interrupts =3D [00 00 00 01 00 00 00 0a 00 00 00 00];
            interrupt-parent =3D <500>;
        };
        gpt@620 {
            compatible =3D [6d 70 63 35 32 30 30 62 2d 67 70 74 00 6d 70 =
63 35 32 78 78 2d 67 70 74 00];
            device_type =3D "gpt";
            reg =3D [00 00 06 20 00 00 00 10];
            interrupts =3D [00 00 00 01 00 00 00 0b 00 00 00 00];
            interrupt-parent =3D <500>;
        };
        gpt@630 {
            compatible =3D [6d 70 63 35 32 30 30 62 2d 67 70 74 00 6d 70 =
63 35 32 78 78 2d 67 70 74 00];
            device_type =3D "gpt";
            reg =3D [00 00 06 30 00 00 00 10];
            interrupts =3D [00 00 00 01 00 00 00 0c 00 00 00 00];
            interrupt-parent =3D <500>;
        };
        gpt@640 {
            compatible =3D [6d 70 63 35 32 30 30 62 2d 67 70 74 00 6d 70 =
63 35 32 78 78 2d 67 70 74 00];
            device_type =3D "gpt";
            reg =3D [00 00 06 40 00 00 00 10];
            interrupts =3D [00 00 00 01 00 00 00 0d 00 00 00 00];
            interrupt-parent =3D <500>;
        };
        gpt@650 {
            compatible =3D [6d 70 63 35 32 30 30 62 2d 67 70 74 00 6d 70 =
63 35 32 78 78 2d 67 70 74 00];
            device_type =3D "gpt";
            reg =3D [00 00 06 50 00 00 00 10];
            interrupts =3D [00 00 00 01 00 00 00 0e 00 00 00 00];
            interrupt-parent =3D <500>;
        };
        gpt@660 {
            compatible =3D [6d 70 63 35 32 30 30 62 2d 67 70 74 00 6d 70 =
63 35 32 78 78 2d 67 70 74 00];
            device_type =3D "gpt";
            reg =3D [00 00 06 60 00 00 00 10];
            interrupts =3D [00 00 00 01 00 00 00 0f 00 00 00 00];
            interrupt-parent =3D <500>;
        };
        gpt@670 {
            compatible =3D [6d 70 63 35 32 30 30 62 2d 67 70 74 00 6d 70 =
63 35 32 78 78 2d 67 70 74 00];
            device_type =3D "gpt";
            reg =3D [00 00 06 70 00 00 00 10];
            interrupts =3D [00 00 00 01 00 00 00 10 00 00 00 00];
            interrupt-parent =3D <500>;
        };
        rtc@800 {
            compatible =3D [6d 70 63 35 32 30 30 62 2d 72 74 63 00 6d 70 =
63 35 32 78 78 2d 72 74 63 00];
            device_type =3D "rtc";
            reg =3D [00 00 08 00 00 00 01 00];
            interrupts =3D [00 00 00 01 00 00 00 05 00 00 00 00 00 00 00 =
01 00 00 00 06 00 00 00 00];
            interrupt-parent =3D <500>;
        };
        mscan@900 {
            device_type =3D "mscan";
            compatible =3D [6d 70 63 35 32 30 30 62 2d 6d 73 63 61 6e 00 =
6d 70 63 35 32 78 78 2d 6d 73 63 61 6e 00];
            interrupts =3D [00 00 00 02 00 00 00 11 00 00 00 00];
            interrupt-parent =3D <500>;
            reg =3D [00 00 09 00 00 00 00 80];
        };
        mscan@980 {
            device_type =3D "mscan";
            compatible =3D [6d 70 63 35 32 30 30 62 2d 6d 73 63 61 6e 00 =
6d 70 63 35 32 78 78 2d 6d 73 63 61 6e 00];
            interrupts =3D [00 00 00 02 00 00 00 12 00 00 00 00];
            interrupt-parent =3D <500>;
            reg =3D [00 00 09 80 00 00 00 80];
        };
        gpio@b00 {
            compatible =3D [6d 70 63 35 32 30 30 62 2d 67 70 69 6f 00 6d =
70 63 35 32 78 78 2d 67 70 69 6f 00];
            reg =3D [00 00 0b 00 00 00 00 40];
            interrupts =3D [00 00 00 01 00 00 00 07 00 00 00 00];
            interrupt-parent =3D <500>;
        };
        gpio-wkup@b00 {
            compatible =3D [6d 70 63 35 32 30 30 62 2d 67 70 69 6f 2d 77 =
6b 75 70 00 6d 70 63 35 32 78 78 2d 67 70 69 6f 2d 77 6b 75 70 00];
            reg =3D [00 00 0c 00 00 00 00 40];
            interrupts =3D [00 00 00 01 00 00 00 08 00 00 00 00 00 00 00 =
00 00 00 00 03 00 00 00 00];
            interrupt-parent =3D <500>;
        };
        pci@0d00 {
            #interrupt-cells =3D <1>;
            #size-cells =3D <2>;
            #address-cells =3D <3>;
            device_type =3D "pci";
            compatible =3D [6d 70 63 35 32 30 30 62 2d 70 63 69 00 6d 70 =
63 35 32 78 78 2d 70 63 69 00];
            reg =3D [00 00 0d 00 00 00 01 00];
            interrupt-map-mask =3D [00 00 f8 00 00 00 00 00 00 00 00 00 =
00 00 00 07];
            interrupt-map =3D [00 00 c0 00 00 00 00 00 00 00 00 00 00 00 =
00 01 00 00 05 00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 c0 00 00 00 =
00 00 00 00 00 00 00 00 00 02 00 00 05 00 00 00 00 01 00 00 00 01 00 00 =
00 03 00 00 c0 00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 05 00 00 00 =
00 01 00 00 00 02 00 00 00 03 00 00 c0 00 00 00 00 00 00 00 00 00 00 00 =
00 04 00 00 05 00 00 00 00 01 00 00 00 03 00 00 00 03 00 00 c8 00 00 00 =
00 00 00 00 00 00 00 00 00 01 00 00 05 00 00 00 00 01 00 00 00 01 00 00 =
00 03 00 00 c8 00 00 00 00 00 00 00 00 00 00 00 00 02 00 00 05 00 00 00 =
00 01 00 00 00 02 00 00 00 03 00 00 c8 00 00 00 00 00 00 00 00 00 00 00 =
00 03 00 00 05 00 00 00 00 01 00 00 00 03 00 00 00 03 00 00 c8 00 00 00 =
00 00 00 00 00 00 00 00 00 04 00 00 05 00 00 00 00 00 00 00 00 00 00 00 =
00 03];
            clock-frequency =3D <0>;
            interrupts =3D [00 00 00 02 00 00 00 08 00 00 00 00 00 00 00 =
02 00 00 00 09 00 00 00 00 00 00 00 02 00 00 00 0a 00 00 00 00];
            interrupt-parent =3D <500>;
            bus-range =3D [00 00 00 00 00 00 00 00];
            ranges =3D [42 00 00 00 00 00 00 00 80 00 00 00 80 00 00 00 =
00 00 00 00 20 00 00 00 02 00 00 00 00 00 00 00 a0 00 00 00 a0 00 00 00 =
00 00 00 00 10 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 b0 00 00 00 =
00 00 00 00 01 00 00 00];
        };
        spi@f00 {
            device_type =3D "spi";
            compatible =3D [6d 70 63 35 32 30 30 62 2d 73 70 69 00 6d 70 =
63 35 32 78 78 2d 73 70 69 00];
            reg =3D [00 00 0f 00 00 00 00 20];
            interrupts =3D [00 00 00 02 00 00 00 0d 00 00 00 00 00 00 00 =
02 00 00 00 0e 00 00 00 00];
            interrupt-parent =3D <500>;
        };
        usb@1000 {
            device_type =3D "usb-ohci-be";
            compatible =3D [6d 70 63 35 32 30 30 62 2d 6f 68 63 69 00 6d =
70 63 35 32 78 78 2d 6f 68 63 69 00 6f 68 63 69 2d 62 65 00];
            reg =3D [00 00 10 00 00 00 00 ff];
            interrupts =3D [00 00 00 02 00 00 00 06 00 00 00 00];
            interrupt-parent =3D <500>;
        };
        bestcomm@1200 {
            device_type =3D "dma-controller";
            compatible =3D [6d 70 63 35 32 30 30 62 2d 62 65 73 74 63 6f =
6d 6d 00 6d 70 63 35 32 78 78 2d 62 65 73 74 63 6f 6d 6d 00];
            reg =3D [00 00 12 00 00 00 00 80];
            interrupts =3D [00 00 00 03 00 00 00 00 00 00 00 00 00 00 00 =
03 00 00 00 01 00 00 00 00 00 00 00 03 00 00 00 02 00 00 00 00 00 00 00 =
03 00 00 00 03 00 00 00 00 00 00 00 03 00 00 00 04 00 00 00 00 00 00 00 =
03 00 00 00 05 00 00 00 00 00 00 00 03 00 00 00 06 00 00 00 00 00 00 00 =
03 00 00 00 07 00 00 00 00 00 00 00 03 00 00 00 08 00 00 00 00 00 00 00 =
03 00 00 00 09 00 00 00 00 00 00 00 03 00 00 00 0a 00 00 00 00 00 00 00 =
03 00 00 00 0b 00 00 00 00 00 00 00 03 00 00 00 0c 00 00 00 00 00 00 00 =
03 00 00 00 0d 00 00 00 00 00 00 00 03 00 00 00 0e 00 00 00 00 00 00 00 =
03 00 00 00 0f 00 00 00 00];
            interrupt-parent =3D <500>;
        };
        xlb@1f00 {
            compatible =3D [6d 70 63 35 32 30 30 62 2d 78 6c 62 00 6d 70 =
63 35 32 78 78 2d 78 6c 62 00];
            reg =3D [00 00 1f 00 00 00 01 00];
        };
        serial@2000 {
            device_type =3D "serial";
            compatible =3D [6d 70 63 35 32 30 30 62 2d 70 73 63 2d 75 61 =
72 74 00 6d 70 63 35 32 78 78 2d 70 73 63 2d 75 61 72 74 00];
            port-number =3D <0>;
            reg =3D [00 00 20 00 00 00 01 00];
            interrupts =3D [00 00 00 02 00 00 00 01 00 00 00 00];
            interrupt-parent =3D <500>;
        };
        ethernet@3000 {
            device_type =3D "network";
            compatible =3D [6d 70 63 35 32 30 30 62 2d 66 65 63 00 6d 70 =
63 35 32 78 78 2d 66 65 63 00];
            reg =3D [00 00 30 00 00 00 08 00];
            mac-address =3D [00 e0 ee 00 28 0d];
            interrupts =3D [00 00 00 02 00 00 00 05 00 00 00 00];
            interrupt-parent =3D <500>;
        };
        i2c@3d00 {
            device_type =3D "i2c";
            compatible =3D [6d 70 63 35 32 30 30 62 2d 69 32 63 00 6d 70 =
63 35 32 78 78 2d 69 32 63 00];
            reg =3D [00 00 3d 00 00 00 00 40];
            interrupts =3D [00 00 00 02 00 00 00 0f 00 00 00 00];
            interrupt-parent =3D <500>;
        };
        i2c@3d40 {
            device_type =3D "i2c";
            compatible =3D [6d 70 63 35 32 30 30 62 2d 69 32 63 00 6d 70 =
63 35 32 78 78 2d 69 32 63 00];
            reg =3D [00 00 3d 40 00 00 00 40];
            interrupts =3D [00 00 00 02 00 00 00 10 00 00 00 00];
            interrupt-parent =3D <500>;
        };
        sram@8000 {
            device_type =3D "sram";
            compatible =3D [6d 70 63 35 32 30 30 62 2d 73 72 61 6d 00 6d =
70 63 35 32 78 78 2d 73 72 61 6d 00 73 72 61 6d 00];
            reg =3D [00 00 80 00 00 00 40 00];
        };
    };
    chosen {
        name =3D "chosen";
        bootargs =3D "console=3DttyPSC0,115200 root=3D/dev/nfs ip=3Ddhcp =
nfsroot=3D10.100.11.96:/home/danielsch/downloads/OSELAS.BSP-Phytec-phyCOR=
E-MPC5200B-tiny-5/root,v3,tcp";
        linux,platform =3D <600>;
        linux,stdout-path =3D "/soc5200@f0000000/serial@2000";
    };
};



-----Original Message-----
From: Domen Puncer [mailto:domen.puncer@telargo.com]=20
Sent: 1. j=FAn=ED 2007 06:35
To: Daniel Schnell
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Where is initial console initialized ?

On 31/05/07 13:42 -0000, Daniel Schnell wrote:
> Hi,
> =20
> I am trying to bring up 2.6.20.3 on a MPC5200B based custom board.=20
> This Kernel is based on the Phytec phyCore MPC5200B Mini BSP kernel=20
> and adapted to my board.
> So far I have troubles to get console output working when booting =
Linux.
> Uboot console output is fine. Linux begins to run (I can set=20
> breakpoints with the BDI2000 in the early initialization code) so I=20
> probably have a misconfiguration of the console output inside the fdt.
>=20
> The major difference between the Phytec phyCore 5200B mini fdt and=20
> mine is that we use PSC1 instead of PSC3/6 for serial. Accordingly I=20
> changed the fdt (or dts) values.
>=20
> To get some more insights, I would like to know, in which Linux=20
> function the console output is initialised ?
>=20
>=20
...
> If I dump the flat device tree inside uboot, I get the following
> entries:=20
...
the dump with:

         reg =3D <8>;

in most of nodes, which looks just wrong.


	Domen
