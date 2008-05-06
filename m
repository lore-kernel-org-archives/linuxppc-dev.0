Return-Path: <ron_madrid@hotmail.com>
Received: from bay0-omc3-s22.bay0.hotmail.com (bay0-omc3-s22.bay0.hotmail.com
	[65.54.246.222]) by ozlabs.org (Postfix) with ESMTP id 752FFDDF7F
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 07:24:49 +1000 (EST)
Message-ID: <BAY114-W46AEF8E266395E333E7FCF4D60@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_05e3a848-ba53-45af-866c-d19a689830c5_"
From: Ronald Madrid <ron_madrid@hotmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: ifconfig MPC8313
Date: Tue, 6 May 2008 14:24:48 -0700
In-Reply-To: <4820CB5D.3000703@freescale.com>
References: <BAY114-W949ADEBC809E7A60716CCF4D60@phx.gbl>
	<4820CB5D.3000703@freescale.com>
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--_05e3a848-ba53-45af-866c-d19a689830c5_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I'm guessing by device tree you mean the .dts file?  I'm using a modified v=
ersion of the mpc8313erdb.dts with minor changes (to the local bus only).  =
Here is a copy of it./* * MPC8313E RDB Device Tree Source * * Copyright 200=
5, 2006, 2007 Freescale Semiconductor Inc. * * This program is free softwar=
e; you can redistribute  it and/or modify it * under  the terms of  the GNU=
 General  Public License as published by the * Free Software Foundation;  e=
ither version 2 of the  License, or (at your * option) any later version. *=
//dts-v1/;/ {    model =3D "MPC8313ERDB";    compatible =3D "MPC8313ERDB", =
"MPC831xRDB", "MPC83xxRDB";    #address-cells =3D <1>;    #size-cells =3D <=
1>;    aliases {        ethernet0 =3D &enet0;        ethernet1 =3D &enet1; =
       serial0 =3D &serial0;        serial1 =3D &serial1;        pci0 =3D &=
pci0;    };    cpus {        #address-cells =3D <1>;        #size-cells =3D=
 <0>;        PowerPC,8313@0 {            device_type =3D "cpu";            =
reg =3D <0x0>;            d-cache-line-size =3D <32>;            i-cache-li=
ne-size =3D <32>;            d-cache-size =3D <16384>;            i-cache-s=
ize =3D <16384>;            timebase-frequency =3D <0>;    // from bootload=
er            bus-frequency =3D <0>;        // from bootloader            c=
lock-frequency =3D <0>;        // from bootloader        };    };    memory=
 {        device_type =3D "memory";        reg =3D <0x00000000 0x08000000>;=
    // 128MB at 0    };    localbus@e0005000 {        #address-cells =3D <2=
>;        #size-cells =3D <1>;        compatible =3D "fsl,mpc8313-elbc", "f=
sl,elbc", "simple-bus";        reg =3D <0xe0005000 0x1000>;        interrup=
ts =3D <77 0x8>;        interrupt-parent =3D <&ipic>;        // CS0 and CS1=
 are swapped when        // booting from nand, but the        // addresses =
are the same.//        ranges =3D <0x0 0x0 0xfe000000 0x00800000//         =
         0x1 0x0 0xe2800000 0x00008000//                  0x2 0x0 0xf000000=
0 0x00020000//                  0x3 0x0 0xfa000000 0x00008000>;        rang=
es =3D <0x0 0x0 0xe2800000 0x00008000>;//        flash@0,0 {//            #=
address-cells =3D <1>;//            #size-cells =3D <1>;//            compa=
tible =3D "cfi-flash";//            reg =3D <0x0 0x0 0x800000>;//          =
  bank-width =3D <2>;//            device-width =3D <1>;//        };//     =
   nand@1,0 {        nand@0,0 {            #address-cells =3D <1>;         =
   #size-cells =3D <1>;            compatible =3D "fsl,mpc8313-fcm-nand",  =
                       "fsl,elbc-fcm-nand";//            reg =3D <0x1 0x0 0=
x2000>;            reg =3D <0x0 0x0 0x2000>;            u-boot@0 {         =
       reg =3D <0x0 0x100000>;                read-only;            };     =
       kernel@100000 {                reg =3D <0x100000 0x300000>;         =
   };            fs@400000 {                reg =3D <0x400000 0x1c00000>;  =
          };        };    };    soc8313@e0000000 {        #address-cells =
=3D <1>;        #size-cells =3D <1>;        device_type =3D "soc";        c=
ompatible =3D "simple-bus";        ranges =3D <0x0 0xe0000000 0x00100000>; =
       reg =3D <0xe0000000 0x00000200>;        bus-frequency =3D <0>;      =
  wdt@200 {            device_type =3D "watchdog";            compatible =
=3D "mpc83xx_wdt";            reg =3D <0x200 0x100>;        };        i2c@3=
000 {            #address-cells =3D <1>;            #size-cells =3D <0>;   =
         cell-index =3D <0>;            compatible =3D "fsl-i2c";          =
  reg =3D <0x3000 0x100>;            interrupts =3D <14 0x8>;            in=
terrupt-parent =3D <&ipic>;            dfsrr;            rtc@68 {          =
      compatible =3D "dallas,ds1339";                reg =3D <0x68>;       =
     };        };        i2c@3100 {            #address-cells =3D <1>;     =
       #size-cells =3D <0>;            cell-index =3D <1>;            compa=
tible =3D "fsl-i2c";            reg =3D <0x3100 0x100>;            interrup=
ts =3D <15 0x8>;            interrupt-parent =3D <&ipic>;            dfsrr;=
        };        spi@7000 {            cell-index =3D <0>;            comp=
atible =3D "fsl,spi";            reg =3D <0x7000 0x1000>;            interr=
upts =3D <16 0x8>;            interrupt-parent =3D <&ipic>;            mode=
 =3D "cpu";        };        /* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */=
        usb@23000 {            compatible =3D "fsl-usb2-dr";            reg=
 =3D <0x23000 0x1000>;            #address-cells =3D <1>;            #size-=
cells =3D <0>;            interrupt-parent =3D <&ipic>;            interrup=
ts =3D <38 0x8>;            phy_type =3D "utmi_wide";        };        mdio=
@24520 {            #address-cells =3D <1>;            #size-cells =3D <0>;=
            compatible =3D "fsl,gianfar-mdio";            reg =3D <0x24520 =
0x20>;            phy1: ethernet-phy@1 {                interrupt-parent =
=3D <&ipic>;                interrupts =3D <19 0x8>;                reg =3D=
 <0x1>;                device_type =3D "ethernet-phy";            };       =
     phy4: ethernet-phy@4 {                interrupt-parent =3D <&ipic>;   =
             interrupts =3D <20 0x8>;                reg =3D <0x4>;        =
        device_type =3D "ethernet-phy";            };        };        enet=
0: ethernet@24000 {            cell-index =3D <0>;            device_type =
=3D "network";            model =3D "eTSEC";            compatible =3D "gia=
nfar";            reg =3D <0x24000 0x1000>;            local-mac-address =
=3D [ 00 00 00 00 00 00 ];            interrupts =3D <37 0x8 36 0x8 35 0x8>=
;            interrupt-parent =3D <&ipic>;            phy-handle =3D < &phy=
1 >;        };        enet1: ethernet@25000 {            cell-index =3D <1>=
;            device_type =3D "network";            model =3D "eTSEC";      =
      compatible =3D "gianfar";            reg =3D <0x25000 0x1000>;       =
     local-mac-address =3D [ 00 00 00 00 00 00 ];            interrupts =3D=
 <34 0x8 33 0x8 32 0x8>;            interrupt-parent =3D <&ipic>;          =
  phy-handle =3D < &phy4 >;        };        serial0: serial@4500 {        =
    cell-index =3D <0>;            device_type =3D "serial";            com=
patible =3D "ns16550";            reg =3D <0x4500 0x100>;            clock-=
frequency =3D <0>;            interrupts =3D <9 0x8>;            interrupt-=
parent =3D <&ipic>;        };        serial1: serial@4600 {            cell=
-index =3D <1>;            device_type =3D "serial";            compatible =
=3D "ns16550";            reg =3D <0x4600 0x100>;            clock-frequenc=
y =3D <0>;            interrupts =3D <10 0x8>;            interrupt-parent =
=3D <&ipic>;        };        crypto@30000 {            device_type =3D "cr=
ypto";            model =3D "SEC2";            compatible =3D "talitos";   =
         reg =3D <0x30000 0x7000>;            interrupts =3D <11 0x8>;     =
       interrupt-parent =3D <&ipic>;            /* Rev. 2.2 */            n=
um-channels =3D <1>;            channel-fifo-len =3D <24>;            exec-=
units-mask =3D <0x0000004c>;            descriptor-types-mask =3D <0x012200=
3f>;        };        /* IPIC         * interrupts cell =3D <intr #, sense>=
         * sense values match linux IORESOURCE_IRQ_* defines:         * sen=
se =3D=3D 8: Level, low assertion         * sense =3D=3D 2: Edge, high-to-l=
ow change         */        ipic: pic@700 {            interrupt-controller=
;            #address-cells =3D <0>;            #interrupt-cells =3D <2>;  =
          reg =3D <0x700 0x100>;            device_type =3D "ipic";        =
};    };    pci0: pci@e0008500 {        cell-index =3D <1>;        interrup=
t-map-mask =3D <0xf800 0x0 0x0 0x7>;        interrupt-map =3D <            =
    /* IDSEL 0x0E -mini PCI */                 0x7000 0x0 0x0 0x1 &ipic 18 =
0x8                 0x7000 0x0 0x0 0x2 &ipic 18 0x8                 0x7000 =
0x0 0x0 0x3 &ipic 18 0x8                 0x7000 0x0 0x0 0x4 &ipic 18 0x8   =
             /* IDSEL 0x0F - PCI slot */                 0x7800 0x0 0x0 0x1=
 &ipic 17 0x8                 0x7800 0x0 0x0 0x2 &ipic 18 0x8              =
   0x7800 0x0 0x0 0x3 &ipic 17 0x8                 0x7800 0x0 0x0 0x4 &ipic=
 18 0x8>;        interrupt-parent =3D <&ipic>;        interrupts =3D <66 0x=
8>;        bus-range =3D <0x0 0x0>;        ranges =3D <0x02000000 0x0 0x900=
00000 0x90000000 0x0 0x10000000              0x42000000 0x0 0x80000000 0x80=
000000 0x0 0x10000000              0x01000000 0x0 0x00000000 0xe2000000 0x0=
 0x00100000>;        clock-frequency =3D <66666666>;        #interrupt-cell=
s =3D <1>;        #size-cells =3D <2>;        #address-cells =3D <3>;      =
  reg =3D <0xe0008500 0x100>;        compatible =3D "fsl,mpc8349-pci";     =
   device_type =3D "pci";    };};Ron> Date: Tue, 6 May 2008 16:19:25 -0500>=
 From: scottwood@freescale.com> To: ron_madrid@hotmail.com> CC: linuxppc-de=
v@ozlabs.org> Subject: Re: ifconfig MPC8313> > Ronald Madrid wrote:> > Hell=
o all,> > > > I am working on porting linux 2.6.25 with a custom MPC8313 ba=
sed board, > > but am having a little bit of trouble with the ethernet, mor=
e > > specifically ifconfig.> > > > after typing "ifconfig eth0 10.196.31.8=
4" I receive the following error> > ifconfig: SIOCSIFFLAGS: Cannot assign r=
equested address> > > > after entering a MAC address via "ifconfig eth0 hw =
ether"  I receive > > this error.> > e0024520:01 not found> > eth0: Could n=
ot attach to PHY> > ifconfig: SIOCSIFFLAGS: No such device> > It can't find=
 the PHY for eth0.  What does your device tree look like, > and what is the=
 relevant PHY address?> > -Scott
_________________________________________________________________
Windows Live SkyDrive lets you share files with faraway friends.
http://www.windowslive.com/skydrive/overview.html?ocid=3DTXT_TAGLM_WL_Refre=
sh_skydrive_052008=

--_05e3a848-ba53-45af-866c-d19a689830c5_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class=3D'hmmessage'><div style=3D"text-align: left;">I'm guessing by =
device tree you mean the .dts file?&nbsp; I'm using a modified version of t=
he mpc8313erdb.dts with minor changes (to the local bus only).&nbsp; Here i=
s a copy of it.<br><br>/*<br>&nbsp;* MPC8313E RDB Device Tree Source<br>&nb=
sp;*<br>&nbsp;* Copyright 2005, 2006, 2007 Freescale Semiconductor Inc.<br>=
&nbsp;*<br>&nbsp;* This program is free software; you can redistribute&nbsp=
; it and/or modify it<br>&nbsp;* under&nbsp; the terms of&nbsp; the GNU Gen=
eral&nbsp; Public License as published by the<br>&nbsp;* Free Software Foun=
dation;&nbsp; either version 2 of the&nbsp; License, or (at your<br>&nbsp;*=
 option) any later version.<br>&nbsp;*/<br><br>/dts-v1/;<br><br>/ {<br>&nbs=
p;&nbsp;&nbsp; model =3D "MPC8313ERDB";<br>&nbsp;&nbsp;&nbsp; compatible =
=3D "MPC8313ERDB", "MPC831xRDB", "MPC83xxRDB";<br>&nbsp;&nbsp;&nbsp; #addre=
ss-cells =3D &lt;1&gt;;<br>&nbsp;&nbsp;&nbsp; #size-cells =3D &lt;1&gt;;<br=
><br>&nbsp;&nbsp;&nbsp; aliases {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
ethernet0 =3D &amp;enet0;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ethernet=
1 =3D &amp;enet1;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; serial0 =3D &amp=
;serial0;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; serial1 =3D &amp;serial1=
;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; pci0 =3D &amp;pci0;<br>&nbsp;&nb=
sp;&nbsp; };<br><br>&nbsp;&nbsp;&nbsp; cpus {<br>&nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; #address-cells =3D &lt;1&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; #size-cells =3D &lt;0&gt;;<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; PowerPC,8313@0 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; device_type =3D "cpu";<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; reg =3D &lt;0x0&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; d-cache-line-size =3D &lt;32&gt;;<br>&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; i-cache-line-size =3D &lt;32&gt;;<b=
r>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; d-cache-size =3D=
 &lt;16384&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 i-cache-size =3D &lt;16384&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; timebase-frequency =3D &lt;0&gt;;&nbsp;&nbsp;&nbsp; // fr=
om bootloader<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; b=
us-frequency =3D &lt;0&gt;;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; // from bo=
otloader<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; clock-=
frequency =3D &lt;0&gt;;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; // from bootl=
oader<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<br>&nbsp;&nbsp;&nbsp; };<=
br><br>&nbsp;&nbsp;&nbsp; memory {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 device_type =3D "memory";<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D=
 &lt;0x00000000 0x08000000&gt;;&nbsp;&nbsp;&nbsp; // 128MB at 0<br>&nbsp;&n=
bsp;&nbsp; };<br><br>&nbsp;&nbsp;&nbsp; localbus@e0005000 {<br>&nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; #address-cells =3D &lt;2&gt;;<br>&nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; #size-cells =3D &lt;1&gt;;<br>&nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; compatible =3D "fsl,mpc8313-elbc", "fsl,elbc", "simple-bus";=
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;0xe0005000 0x1000&gt;=
;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupts =3D &lt;77 0x8&gt;;<b=
r>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-parent =3D &lt;&amp;ipic&=
gt;;<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; // CS0 and CS1 are swappe=
d when<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; // booting from nand, but t=
he<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; // addresses are the same.<br>/=
/&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ranges =3D &lt;0x0 0x0 0xfe000000 0x=
00800000<br>//&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1 0x0 0xe2800000 0x00008000<br>//&nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x2 0x0 0xf0000000 0x00020000<br>//&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3 0x0 0xfa=
000000 0x00008000&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ranges =3D =
&lt;0x0 0x0 0xe2800000 0x00008000&gt;;<br><br>//&nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; flash@0,0 {<br>//&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; #address-cells =3D &lt;1&gt;;<br>//&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; #size-cells =3D &lt;1&gt;;<br>//&nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible =3D "cfi-flash";<br>//&=
nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;0x0 0x0=
 0x800000&gt;;<br>//&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; bank-width =3D &lt;2&gt;;<br>//&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; device-width =3D &lt;1&gt;;<br>//&nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; };<br><br>//&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; nand@1,0 {<br>=
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; nand@0,0 {<br>&nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #address-cells =3D &lt;1&gt;;<br>&nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #size-cells =3D &lt;1&gt;;=
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible =3D=
 "fsl,mpc8313-fcm-nand",<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; "fsl,elbc-fcm-nand";<br>//&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp; reg =3D &lt;0x1 0x0 0x2000&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp=
;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;0x0 0x0 0x2000&gt;;<br><br>&nb=
sp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; u-boot@0 {<br>&nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =
=3D &lt;0x0 0x100000&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; read-only;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; };<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; kernel@100000 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;0x100000 0x300000&gt;;<br=
>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<br><br>&nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; fs@400000 {<br>&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &=
lt;0x400000 0x1c00000&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; };<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<br>&nbsp;&nbsp;&=
nbsp; };<br><br>&nbsp;&nbsp;&nbsp; soc8313@e0000000 {<br>&nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; #address-cells =3D &lt;1&gt;;<br>&nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp; #size-cells =3D &lt;1&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp; device_type =3D "soc";<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; co=
mpatible =3D "simple-bus";<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ranges =
=3D &lt;0x0 0xe0000000 0x00100000&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; reg =3D &lt;0xe0000000 0x00000200&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; bus-frequency =3D &lt;0&gt;;<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp; wdt@200 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; device_type =3D "watchdog";<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; compatible =3D "mpc83xx_wdt";<br>&nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;0x200 0x100&gt;;<br>&nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; };<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
i2c@3000 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #add=
ress-cells =3D &lt;1&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; #size-cells =3D &lt;0&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; cell-index =3D &lt;0&gt;;<br>&nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible =3D "fsl-i2c";<br>&nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;0x3000 0x100&gt;;<=
br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupts =3D =
&lt;14 0x8&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 interrupt-parent =3D &lt;&amp;ipic&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; dfsrr;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; rtc@68 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible =3D "dallas,ds1339";<br>&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D =
&lt;0x68&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }=
;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<br><br>&nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp; i2c@3100 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; #address-cells =3D &lt;1&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; #size-cells =3D &lt;0&gt;;<br>&nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; cell-index =3D &lt;1&gt;;<br>&nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible =3D "fsl-i2c";=
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;0x=
3100 0x100&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 interrupts =3D &lt;15 0x8&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; interrupt-parent =3D &lt;&amp;ipic&gt;;<br>&nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dfsrr;<br>&nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; };<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; spi@7000 {<b=
r>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; cell-index =3D &=
lt;0&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compa=
tible =3D "fsl,spi";<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; reg =3D &lt;0x7000 0x1000&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; interrupts =3D &lt;16 0x8&gt;;<br>&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-parent =3D &lt;&amp;ipic&gt=
;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; mode =3D "cp=
u";<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<br><br>&nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; /* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */<br>&nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; usb@23000 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; compatible =3D "fsl-usb2-dr";<br>&nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;0x23000 0x1000&gt;;<=
br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #address-cells =
=3D &lt;1&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
#size-cells =3D &lt;0&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; interrupt-parent =3D &lt;&amp;ipic&gt;;<br>&nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupts =3D &lt;38 0x8&gt;;<br>&nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; phy_type =3D "utmi_wid=
e";<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<br><br>&nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; mdio@24520 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp; #address-cells =3D &lt;1&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #size-cells =3D &lt;0&gt;;<br>&nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible =3D "fsl,gianfar-mdio=
";<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;=
0x24520 0x20&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p; phy1: ethernet-phy@1 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-parent =3D &lt;&amp;ipic&gt;;<br>&n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; i=
nterrupts =3D &lt;19 0x8&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;0x1&gt;;<br>&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; device_type =3D =
"ethernet-phy";<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 };<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; phy4: ether=
net-phy@4 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp; interrupt-parent =3D &lt;&amp;ipic&gt;;<br>&nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupts =3D =
&lt;20 0x8&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; reg =3D &lt;0x4&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; device_type =3D "ethernet-phy"=
;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<br>&nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; enet0: ethernet@24000 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; cell-index =3D &lt;0&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; device_type =3D "network";<br>&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; model =3D "eTSEC";<br>&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible =3D "gianfar";<br>&nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;0x24000 0x10=
00&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; local-m=
ac-address =3D [ 00 00 00 00 00 00 ];<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; interrupts =3D &lt;37 0x8 36 0x8 35 0x8&gt;;<br>&nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-parent =3D &=
lt;&amp;ipic&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p; phy-handle =3D &lt; &amp;phy1 &gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; };<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; enet1: ethernet@25000 =
{<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; cell-index =
=3D &lt;1&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
device_type =3D "network";<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; model =3D "eTSEC";<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp; compatible =3D "gianfar";<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;0x25000 0x1000&gt;;<br>&nbsp;&nbsp;&=
nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; local-mac-address =3D [ 00 00 0=
0 00 00 00 ];<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; i=
nterrupts =3D &lt;34 0x8 33 0x8 32 0x8&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-parent =3D &lt;&amp;ipic&gt;;<br>&nb=
sp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; phy-handle =3D &lt; &=
amp;phy4 &gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<br><br>&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; serial0: serial@4500 {<br>&nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; cell-index =3D &lt;0&gt;;<br>&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; device_type =3D "serial";<b=
r>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible =3D "=
ns16550";<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =
=3D &lt;0x4500 0x100&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; clock-frequency =3D &lt;0&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; interrupts =3D &lt;9 0x8&gt;;<br>&nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-parent =3D &lt;&amp;ipi=
c&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<br><br>&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; serial1: serial@4600 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; cell-index =3D &lt;1&gt;;<br>&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; device_type =3D "serial";<br>&nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible =3D "ns16550"=
;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;0=
x4600 0x100&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; clock-frequency =3D &lt;0&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; interrupts =3D &lt;10 0x8&gt;;<br>&nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-parent =3D &lt;&amp;ipic&gt;;<b=
r>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<br><br>&nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; crypto@30000 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; device_type =3D "crypto";<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; model =3D "SEC2";<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; compatible =3D "talitos";<br>&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;0x30000 0x7000&gt;;<br>&n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupts =3D &lt;1=
1 0x8&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; inte=
rrupt-parent =3D &lt;&amp;ipic&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; /* Rev. 2.2 */<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; num-channels =3D &lt;1&gt;;<br>&nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; channel-fifo-len =3D &lt;24&gt;;<br>&nbsp=
;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; exec-units-mask =3D &lt=
;0x0000004c&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; descriptor-types-mask =3D &lt;0x0122003f&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp=
;&nbsp;&nbsp; };<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* IPIC<br>&n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;* interrupts cell =3D &lt;intr #,=
 sense&gt;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;* sense values ma=
tch linux IORESOURCE_IRQ_* defines:<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; &nbsp;* sense =3D=3D 8: Level, low assertion<br>&nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; &nbsp;* sense =3D=3D 2: Edge, high-to-low change<br>&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;*/<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p; ipic: pic@700 {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; interrupt-controller;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; #address-cells =3D &lt;0&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; #interrupt-cells =3D &lt;2&gt;;<br>&nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;0x700 0x100&gt;;<br>=
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; device_type =3D "i=
pic";<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<br>&nbsp;&nbsp;&nbsp; };<=
br><br>&nbsp;&nbsp;&nbsp; pci0: pci@e0008500 {<br>&nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; cell-index =3D &lt;1&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; interrupt-map-mask =3D &lt;0xf800 0x0 0x0 0x7&gt;;<br>&nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; interrupt-map =3D &lt;<br><br>&nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* IDSEL 0x0E -mini PC=
I */<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp; &nbsp;0x7000 0x0 0x0 0x1 &amp;ipic 18 0x8<br>&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;0x7000 0x0 0x0=
 0x2 &amp;ipic 18 0x8<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;0x7000 0x0 0x0 0x3 &amp;ipic 18 0x8<br>&nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nb=
sp;0x7000 0x0 0x0 0x4 &amp;ipic 18 0x8<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* IDSEL 0x0F - PCI slot */<=
br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; &nbsp;0x7800 0x0 0x0 0x1 &amp;ipic 17 0x8<br>&nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;0x7800 0x0 0x0 0x2 =
&amp;ipic 18 0x8<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; &nbsp;0x7800 0x0 0x0 0x3 &amp;ipic 17 0x8<br>&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;0x=
7800 0x0 0x0 0x4 &amp;ipic 18 0x8&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; interrupt-parent =3D &lt;&amp;ipic&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; interrupts =3D &lt;66 0x8&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; bus-range =3D &lt;0x0 0x0&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; ranges =3D &lt;0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000<br>=
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; 0x42000000 =
0x0 0x80000000 0x80000000 0x0 0x10000000<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; 0x01000000 0x0 0x00000000 0xe2000000 0x0 0=
x00100000&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; clock-frequency =3D=
 &lt;66666666&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #interrupt-cell=
s =3D &lt;1&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #size-cells =3D &=
lt;2&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #address-cells =3D &lt;3=
&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;0xe0008500 0x100=
&gt;;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible =3D "fsl,mpc8349-=
pci";<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; device_type =3D "pci";<br>&n=
bsp;&nbsp;&nbsp; };<br>};<br><br></div><br>Ron<br><br><hr id=3D"stopSpellin=
g">&gt; Date: Tue, 6 May 2008 16:19:25 -0500<br>&gt; From: scottwood@freesc=
ale.com<br>&gt; To: ron_madrid@hotmail.com<br>&gt; CC: linuxppc-dev@ozlabs.=
org<br>&gt; Subject: Re: ifconfig MPC8313<br>&gt; <br>&gt; Ronald Madrid wr=
ote:<br>&gt; &gt; Hello all,<br>&gt; &gt; <br>&gt; &gt; I am working on por=
ting linux 2.6.25 with a custom MPC8313 based board, <br>&gt; &gt; but am h=
aving a little bit of trouble with the ethernet, more <br>&gt; &gt; specifi=
cally ifconfig.<br>&gt; &gt; <br>&gt; &gt; after typing "ifconfig eth0 10.1=
96.31.84" I receive the following error<br>&gt; &gt; ifconfig: SIOCSIFFLAGS=
: Cannot assign requested address<br>&gt; &gt; <br>&gt; &gt; after entering=
 a MAC address via "ifconfig eth0 hw ether"  I receive <br>&gt; &gt; this e=
rror.<br>&gt; &gt; e0024520:01 not found<br>&gt; &gt; eth0: Could not attac=
h to PHY<br>&gt; &gt; ifconfig: SIOCSIFFLAGS: No such device<br>&gt; <br>&g=
t; It can't find the PHY for eth0.  What does your device tree look like, <=
br>&gt; and what is the relevant PHY address?<br>&gt; <br>&gt; -Scott<br><b=
r /><hr />Windows Live SkyDrive lets you share files with faraway friends. =
<a href=3D'http://www.windowslive.com/skydrive/overview.html?ocid=3DTXT_TAG=
LM_WL_Refresh_skydrive_052008' target=3D'_new'>Start sharing.</a></body>
</html>=

--_05e3a848-ba53-45af-866c-d19a689830c5_--
