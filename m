Return-Path: <Lixin.Yao@HSTX.com>
Received: from mail.hstx.com (mail.hstx.com [64.95.133.106])
	by ozlabs.org (Postfix) with ESMTP id 847F3DDE07
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Dec 2008 06:54:43 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C9596C.D788D86D"
Subject: Linux starting stuck at clockevent: decrementer
Date: Mon, 8 Dec 2008 11:40:36 -0800
Message-ID: <03D77CA4AC7F4D48A6AB5DA3F1001B3F10A3F1@exchtxus2.HSTX.global.vpn>
From: "Yao, Lixin " <Lixin.Yao@HSTX.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9596C.D788D86D
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C9596C.D788D86D"


------_=_NextPart_002_01C9596C.D788D86D
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi, All,

I am new to the mailing list. First time posting.

I am trying to run Linux-2.6.28-rc5 on a board with MPC8248 processor.
No PCI functions are used. The board is a known good board. It ran
vxWorks sucessfully before. I based my configuration on MPC8272ADS (the
Freescale board). I turned on early debugging. I use U-Boot to load
Linux image to 0x800000, and load DTB to 0xB00000. Total memory is 64MB.
A command line is passed to kernel for it to run NFS. Somehow, kernel
starting gets stuck after printing this line:
clockevent: decrementer mult[444] shift[16] cpu[0]

Does anybody have any hint?

Here is the starting printing:

Using FCC1 ETHERNET device
TFTP from server 10.15.34.196; our IP address is 172.20.16.150; sending
through
gateway 172.20.16.1
Filename 'eclipse/uImage'.
Load address: 0x800000
Loading:
#################################################################
         #####################################
done
Bytes transferred =3D 1491457 (16c201 hex)
Using FCC1 ETHERNET device
TFTP from server 10.15.34.196; our IP address is 172.20.16.150; sending
through
gateway 172.20.16.1
Filename 'eclipse/tr5000v2.dtb'.
Load address: 0xb00000
Loading: #
done
Bytes transferred =3D 2965 (b95 hex)
## Booting kernel from Legacy Image at 00800000 ...
   Image Name:   Linux-2.6.28-rc5-01296-g7b9a403-
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1491393 Bytes =3D  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Flattened Device Tree blob at 00b00000
   Booting using the fdt blob at 0xb00000
   Loading Device Tree to 007fc000, end 007ffb94 ... OK
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
Using HSTX tr5000v2 machine description
Linux version 2.6.28-rc5-01296-g7b9a403-dirty (lyao01@lyao01-desktop)
(gcc versi
on 4.2.2) #1 Mon Dec 8 12:02:39 EST 2008
console [udbg0] enabled
setup_arch: bootmem
tr5000v2_setup_arch()
tr5000v2_setup_arch(), finish
arch: exit
Top of RAM: 0x4000000, Total RAM: 0x4000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA      0x00000000 -> 0x00004000
  Normal   0x00004000 -> 0x00004000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00004000
On node 0 totalpages: 16384
free_area_init_node: node 0, pgdat c02fad10, node_mem_map c0323000
  DMA zone: 128 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 16256 pages, LIFO batch:3
  Normal zone: 0 pages used for memmap
  Movable zone: 0 pages used for memmap
Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
16256
Kernel command line: root=3D/dev/nfs rw
nfsroot=3D10.15.34.196:/home/lyao01/work/tar
get_odu_100
ip=3D172.20.16.150:10.15.34.196:172.20.16.1:255.255.255.0:tr5000v2:eth
0:off
PID hash table entries: 256 (order: 8, 1024 bytes)
time_init: decrementer frequency =3D 16.666666 MHz
time_init: processor frequency   =3D 266.666664 MHz
clocksource: timebase mult[f00000a] shift[22] registered
clockevent: decrementer mult[444] shift[16] cpu[0]

This is the dts file:

/dts-v1/;
/ {
	model =3D "TR5000V2";
	compatible =3D "fsl,tr5000v2";
	#address-cells =3D <1>;
	#size-cells =3D <1>;=09

	cpus {
		#address-cells =3D <1>;
		#size-cells =3D <0>;

		PowerPC,8248@0 {
			device_type =3D "cpu";
			reg =3D <0>;
			d-cache-line-size =3D <32>;
			i-cache-line-size =3D <32>;
			d-cache-size =3D <16384>;
			i-cache-size =3D <16384>;
			timebase-frequency =3D <0>;
			clock-frequency =3D <0>;
		};
	};
  =20
	memory {
		device_type =3D "memory";
		reg =3D <0 0>;
	};

	soc@f0000000 {
		#address-cells =3D <1>;
		#size-cells =3D <1>;
		compatible =3D "fsl,mpc8248-immr", "fsl,pq2-soc";
		ranges =3D <0x00000000 0xf0000000 0x00053000>;

		// Temporary until code stops depending on it.
		device_type =3D "soc";

		// Temporary -- will go away once kernel uses ranges for
get_immrbase().
		reg =3D <0xf0000000 0x00053000>;

		cpm@119c0 {
			#address-cells =3D <1>;
			#size-cells =3D <1>;
			#interrupt-cells =3D <2>;
			compatible =3D "fsl,mpc8248-cpm", "fsl,cpm2";
        // This is from EP8248E, MPC8272ADS does not use, don't use
either
			//             "simple-bus";
			reg =3D <0x119c0 0x30>;
			ranges;

			muram {
				#address-cells =3D <1>;
				#size-cells =3D <1>;
				ranges =3D <0 0 0x10000>;

				data@0 {
					compatible =3D
"fsl,cpm-muram-data";
					reg =3D <0 0x2000 0x9800 0x800>;
				};
			};

			brg@119f0 {
				compatible =3D "fsl,mpc8248-brg",
				             "fsl,cpm2-brg",
				             "fsl,cpm-brg";
				reg =3D <0x119f0 0x10 0x115f0 0x10>;
			};

			/* Monitor port/SMC1 */
			smc1: serial@11a80 {
				device_type =3D "serial";
				compatible =3D "fsl,mpc8248-smc-uart",
				             "fsl,cpm2-smc-uart";
				reg =3D <0x11a80 0x20 0x87fc 2>;
				interrupts =3D <4 8>;
				interrupt-parent =3D <&PIC>;
				fsl,cpm-brg =3D <7>;
				fsl,cpm-command =3D <0x1d000000>;
				linux,tr5000v2-label =3D "SMC1";
			};

			eth0: ethernet@11300 {
				device_type =3D "network";
				compatible =3D "fsl,mpc8248-fcc-enet",
				             "fsl,cpm2-fcc-enet";
				reg =3D <0x11300 0x20 0x8400 0x100 0x11390
1>;
				local-mac-address =3D [ 00 00 00 00 00 00
];
				interrupts =3D <32 8>;
				interrupt-parent =3D <&PIC>;
           // Don't use this for now
				// phy-handle =3D <&PHY0>; =20
				linux,network-index =3D <0>;
				fsl,cpm-command =3D <0x12000300>;
			};
		};

		PIC: interrupt-controller@10c00 {
			#interrupt-cells =3D <2>;
			interrupt-controller;
			reg =3D <0x10c00 0x80>;
        compatible =3D "fsl,mpc8248-pic", "fsl,cpm2-pic";
		};    =20
      =20
  chosen {
		linux,stdout-path =3D "/soc/cpm/serial@11a80";
	};
};

Attached is my .config.

 <<config>>=20
Thank you.

Lixin Yao

------_=_NextPart_002_01C9596C.D788D86D
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.59">
<TITLE>Linux starting stuck at clockevent: decrementer</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi, All,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I am new to the mailing list. First =
time posting.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I am trying to run Linux-2.6.28-rc5 on =
a board with MPC8248 processor. No PCI functions are used. The board is =
a known good board. It ran vxWorks sucessfully before. I based my =
configuration on MPC8272ADS (the Freescale board). I turned on early =
debugging. I use U-Boot to load Linux image to 0x800000, and load DTB to =
0xB00000. Total memory is 64MB. A command line is passed to kernel for =
it to run NFS. Somehow, kernel starting gets stuck after printing this =
line:</FONT></P>

<P><FONT FACE=3D"Courier New">clockevent: decrementer mult[444] =
shift[16] cpu[0]</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Does anybody have any hint?</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Here is the starting printing:</FONT>
</P>

<P><FONT FACE=3D"Courier New">Using FCC1 ETHERNET device<BR>
TFTP from server 10.15.34.196; our IP address is 172.20.16.150; sending =
through<BR>
gateway 172.20.16.1<BR>
Filename 'eclipse/uImage'.<BR>
Load address: 0x800000<BR>
Loading: =
#################################################################<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
#####################################<BR>
done<BR>
Bytes transferred =3D 1491457 (16c201 hex)<BR>
Using FCC1 ETHERNET device<BR>
TFTP from server 10.15.34.196; our IP address is 172.20.16.150; sending =
through<BR>
gateway 172.20.16.1<BR>
Filename 'eclipse/tr5000v2.dtb'.<BR>
Load address: 0xb00000<BR>
Loading: #<BR>
done<BR>
Bytes transferred =3D 2965 (b95 hex)<BR>
## Booting kernel from Legacy Image at 00800000 ...<BR>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; =
Linux-2.6.28-rc5-01296-g7b9a403-<BR>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip =
compressed)<BR>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1491393 Bytes =3D&nbsp; 1.4 =
MB<BR>
&nbsp;&nbsp; Load Address: 00000000<BR>
&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR>
&nbsp;&nbsp; Verifying Checksum ... OK<BR>
&nbsp;&nbsp; Uncompressing Kernel Image ... OK<BR>
## Flattened Device Tree blob at 00b00000<BR>
&nbsp;&nbsp; Booting using the fdt blob at 0xb00000<BR>
&nbsp;&nbsp; Loading Device Tree to 007fc000, end 007ffb94 ... OK<BR>
id mach(): done<BR>
MMU:enter<BR>
MMU:hw init<BR>
MMU:mapin<BR>
MMU:setio<BR>
MMU:exit<BR>
Using HSTX tr5000v2 machine description<BR>
Linux version 2.6.28-rc5-01296-g7b9a403-dirty (lyao01@lyao01-desktop) =
(gcc versi<BR>
on 4.2.2) #1 Mon Dec 8 12:02:39 EST 2008<BR>
console [udbg0] enabled<BR>
setup_arch: bootmem<BR>
tr5000v2_setup_arch()<BR>
tr5000v2_setup_arch(), finish<BR>
arch: exit<BR>
Top of RAM: 0x4000000, Total RAM: 0x4000000<BR>
Memory hole size: 0MB<BR>
Zone PFN ranges:<BR>
&nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000 -&gt; 0x00004000<BR>
&nbsp; Normal&nbsp;&nbsp; 0x00004000 -&gt; 0x00004000<BR>
Movable zone start PFN for each node<BR>
early_node_map[1] active PFN ranges<BR>
&nbsp;&nbsp;&nbsp; 0: 0x00000000 -&gt; 0x00004000<BR>
On node 0 totalpages: 16384<BR>
free_area_init_node: node 0, pgdat c02fad10, node_mem_map c0323000<BR>
&nbsp; DMA zone: 128 pages used for memmap<BR>
&nbsp; DMA zone: 0 pages reserved<BR>
&nbsp; DMA zone: 16256 pages, LIFO batch:3<BR>
&nbsp; Normal zone: 0 pages used for memmap<BR>
&nbsp; Movable zone: 0 pages used for memmap<BR>
Built 1 zonelists in Zone order, mobility grouping on.&nbsp; Total =
pages: 16256<BR>
Kernel command line: root=3D/dev/nfs rw =
nfsroot=3D10.15.34.196:/home/lyao01/work/tar<BR>
get_odu_100 =
ip=3D172.20.16.150:10.15.34.196:172.20.16.1:255.255.255.0:tr5000v2:eth<BR=
>
0:off<BR>
PID hash table entries: 256 (order: 8, 1024 bytes)<BR>
time_init: decrementer frequency =3D 16.666666 MHz<BR>
time_init: processor frequency&nbsp;&nbsp; =3D 266.666664 MHz<BR>
clocksource: timebase mult[f00000a] shift[22] registered<BR>
clockevent: decrementer mult[444] shift[16] cpu[0]</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">This is the dts file:</FONT>
</P>

<P><FONT FACE=3D"Courier New">/dts-v1/;<BR>
/ {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; model =3D =
&quot;TR5000V2&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;fsl,tr5000v2&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =3D =
&lt;1&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells =3D =
&lt;1&gt;;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpus {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =3D =
&lt;1&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells =3D =
&lt;0&gt;;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PowerPC,8248@0 {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type =3D =
&quot;cpu&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;0&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d-cache-line-size =3D =
&lt;32&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i-cache-line-size =3D =
&lt;32&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d-cache-size =3D =
&lt;16384&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i-cache-size =3D =
&lt;16384&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timebase-frequency =3D =
&lt;0&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock-frequency =3D =
&lt;0&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<BR>
&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memory {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type =3D =
&quot;memory&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;0 0&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; soc@f0000000 {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =3D =
&lt;1&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells =3D =
&lt;1&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;fsl,mpc8248-immr&quot;, &quot;fsl,pq2-soc&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges =3D &lt;0x00000000 =
0xf0000000 0x00053000&gt;;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Temporary until code stops =
depending on it.<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type =3D =
&quot;soc&quot;;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Temporary -- will go away =
once kernel uses ranges for get_immrbase().<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;0xf0000000 =
0x00053000&gt;;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpm@119c0 {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =3D =
&lt;1&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells =3D =
&lt;1&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #interrupt-cells =3D =
&lt;2&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;fsl,mpc8248-cpm&quot;, &quot;fsl,cpm2&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // This is from EP8248E, =
MPC8272ADS does not use, don't use either<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
//&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &quot;simple-bus&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;0x119c0 =
0x30&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; muram {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =3D =
&lt;1&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells =3D =
&lt;1&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges =3D &lt;0 0 =
0x10000&gt;;<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data@0 {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;fsl,cpm-muram-data&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;0 0x2000 0x9800 =
0x800&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; brg@119f0 {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;fsl,mpc8248-brg&quot;,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&quot;fsl,cpm2-brg&quot;,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&quot;fsl,cpm-brg&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;0x119f0 0x10 =
0x115f0 0x10&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Monitor port/SMC1 */<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smc1: serial@11a80 {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type =3D =
&quot;serial&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;fsl,mpc8248-smc-uart&quot;,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&quot;fsl,cpm2-smc-uart&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;0x11a80 0x20 =
0x87fc 2&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts =3D &lt;4 =
8&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent =3D =
&lt;&amp;PIC&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl,cpm-brg =3D =
&lt;7&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl,cpm-command =3D =
&lt;0x1d000000&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; linux,tr5000v2-label =3D =
&quot;SMC1&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eth0: ethernet@11300 {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type =3D =
&quot;network&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;fsl,mpc8248-fcc-enet&quot;,<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&quot;fsl,cpm2-fcc-enet&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;0x11300 0x20 =
0x8400 0x100 0x11390 1&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; local-mac-address =3D [ 00 00 =
00 00 00 00 ];<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts =3D &lt;32 =
8&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-parent =3D =
&lt;&amp;PIC&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Don't =
use this for now<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // phy-handle =3D =
&lt;&amp;PHY0&gt;;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; linux,network-index =3D =
&lt;0&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fsl,cpm-command =3D =
&lt;0x12000300&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PIC: =
interrupt-controller@10c00 {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #interrupt-cells =3D =
&lt;2&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-controller;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D &lt;0x10c00 =
0x80&gt;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compatible =3D =
&quot;fsl,mpc8248-pic&quot;, &quot;fsl,cpm2-pic&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
};&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
&nbsp; chosen {<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; linux,stdout-path =3D =
&quot;/soc/cpm/serial@11a80&quot;;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<BR>
};</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Attached is my .config.</FONT>
</P>

<P><FONT FACE=3D"Arial" SIZE=3D2 COLOR=3D"#000000"> =
&lt;&lt;config&gt;&gt; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Thank you.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Lixin Yao</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_002_01C9596C.D788D86D--

------_=_NextPart_001_01C9596C.D788D86D
Content-Type: application/octet-stream;
	name="config"
Content-Transfer-Encoding: base64
Content-Description: config
Content-Disposition: attachment;
	filename="config"

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIG1ha2UgY29uZmlnOiBkb24ndCBlZGl0CiMgTGlu
dXgga2VybmVsIHZlcnNpb246IDIuNi4yOC1yYzUKIyBNb24gRGVjICA4IDExOjUzOjAwIDIwMDgK
IwojIENPTkZJR19QUEM2NCBpcyBub3Qgc2V0CgojCiMgUHJvY2Vzc29yIHN1cHBvcnQKIwpDT05G
SUdfNnh4PXkKIyBDT05GSUdfUFBDXzg1eHggaXMgbm90IHNldAojIENPTkZJR19QUENfOHh4IGlz
IG5vdCBzZXQKIyBDT05GSUdfNDB4IGlzIG5vdCBzZXQKIyBDT05GSUdfNDR4IGlzIG5vdCBzZXQK
IyBDT05GSUdfRTIwMCBpcyBub3Qgc2V0CkNPTkZJR19QUENfRlBVPXkKIyBDT05GSUdfQUxUSVZF
QyBpcyBub3Qgc2V0CkNPTkZJR19QUENfU1REX01NVT15CkNPTkZJR19QUENfU1REX01NVV8zMj15
CiMgQ09ORklHX1BQQ19NTV9TTElDRVMgaXMgbm90IHNldAojIENPTkZJR19TTVAgaXMgbm90IHNl
dApDT05GSUdfUFBDMzI9eQpDT05GSUdfV09SRF9TSVpFPTMyCiMgQ09ORklHX0FSQ0hfUEhZU19B
RERSX1RfNjRCSVQgaXMgbm90IHNldApDT05GSUdfTU1VPXkKQ09ORklHX0dFTkVSSUNfQ01PU19V
UERBVEU9eQpDT05GSUdfR0VORVJJQ19USU1FPXkKQ09ORklHX0dFTkVSSUNfVElNRV9WU1lTQ0FM
TD15CkNPTkZJR19HRU5FUklDX0NMT0NLRVZFTlRTPXkKQ09ORklHX0dFTkVSSUNfSEFSRElSUVM9
eQojIENPTkZJR19IQVZFX1NFVFVQX1BFUl9DUFVfQVJFQSBpcyBub3Qgc2V0CkNPTkZJR19JUlFf
UEVSX0NQVT15CkNPTkZJR19TVEFDS1RSQUNFX1NVUFBPUlQ9eQpDT05GSUdfSEFWRV9MQVRFTkNZ
VE9QX1NVUFBPUlQ9eQpDT05GSUdfTE9DS0RFUF9TVVBQT1JUPXkKQ09ORklHX1JXU0VNX1hDSEdB
RERfQUxHT1JJVEhNPXkKQ09ORklHX0FSQ0hfSEFTX0lMT0cyX1UzMj15CkNPTkZJR19HRU5FUklD
X0hXRUlHSFQ9eQpDT05GSUdfR0VORVJJQ19DQUxJQlJBVEVfREVMQVk9eQpDT05GSUdfR0VORVJJ
Q19GSU5EX05FWFRfQklUPXkKQ09ORklHX0dFTkVSSUNfR1BJTz15CiMgQ09ORklHX0FSQ0hfTk9f
VklSVF9UT19CVVMgaXMgbm90IHNldApDT05GSUdfUFBDPXkKQ09ORklHX0VBUkxZX1BSSU5USz15
CkNPTkZJR19HRU5FUklDX05WUkFNPXkKQ09ORklHX1NDSEVEX05PX05PX09NSVRfRlJBTUVfUE9J
TlRFUj15CkNPTkZJR19BUkNIX01BWV9IQVZFX1BDX0ZEQz15CkNPTkZJR19QUENfT0Y9eQpDT05G
SUdfT0Y9eQojIENPTkZJR19QUENfVURCR18xNjU1MCBpcyBub3Qgc2V0CiMgQ09ORklHX0dFTkVS
SUNfVEJTWU5DIGlzIG5vdCBzZXQKQ09ORklHX0FVRElUX0FSQ0g9eQpDT05GSUdfR0VORVJJQ19C
VUc9eQpDT05GSUdfREVGQVVMVF9VSU1BR0U9eQojIENPTkZJR19QUENfRENSX05BVElWRSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1BQQ19EQ1JfTU1JTyBpcyBub3Qgc2V0CkNPTkZJR19ERUZDT05GSUdf
TElTVD0iL2xpYi9tb2R1bGVzLyRVTkFNRV9SRUxFQVNFLy5jb25maWciCgojCiMgR2VuZXJhbCBz
ZXR1cAojCiMgQ09ORklHX0VYUEVSSU1FTlRBTCBpcyBub3Qgc2V0CkNPTkZJR19CUk9LRU5fT05f
U01QPXkKQ09ORklHX0lOSVRfRU5WX0FSR19MSU1JVD0zMgpDT05GSUdfTE9DQUxWRVJTSU9OPSIi
CkNPTkZJR19MT0NBTFZFUlNJT05fQVVUTz15CkNPTkZJR19TV0FQPXkKQ09ORklHX1NZU1ZJUEM9
eQpDT05GSUdfU1lTVklQQ19TWVNDVEw9eQojIENPTkZJR19CU0RfUFJPQ0VTU19BQ0NUIGlzIG5v
dCBzZXQKIyBDT05GSUdfVEFTS1NUQVRTIGlzIG5vdCBzZXQKIyBDT05GSUdfQVVESVQgaXMgbm90
IHNldApDT05GSUdfSUtDT05GSUc9eQpDT05GSUdfSUtDT05GSUdfUFJPQz15CkNPTkZJR19MT0df
QlVGX1NISUZUPTE0CiMgQ09ORklHX0NHUk9VUFMgaXMgbm90IHNldApDT05GSUdfU1lTRlNfREVQ
UkVDQVRFRD15CkNPTkZJR19TWVNGU19ERVBSRUNBVEVEX1YyPXkKIyBDT05GSUdfUkVMQVkgaXMg
bm90IHNldAojIENPTkZJR19OQU1FU1BBQ0VTIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9J
TklUUkQgaXMgbm90IHNldApDT05GSUdfQ0NfT1BUSU1JWkVfRk9SX1NJWkU9eQpDT05GSUdfU1lT
Q1RMPXkKQ09ORklHX0VNQkVEREVEPXkKQ09ORklHX1NZU0NUTF9TWVNDQUxMPXkKQ09ORklHX0tB
TExTWU1TPXkKQ09ORklHX0tBTExTWU1TX0FMTD15CiMgQ09ORklHX0tBTExTWU1TX0VYVFJBX1BB
U1MgaXMgbm90IHNldApDT05GSUdfSE9UUExVRz15CkNPTkZJR19QUklOVEs9eQojIENPTkZJR19M
T0dCVUZGRVIgaXMgbm90IHNldApDT05GSUdfQlVHPXkKQ09ORklHX0VMRl9DT1JFPXkKQ09ORklH
X0NPTVBBVF9CUks9eQpDT05GSUdfQkFTRV9GVUxMPXkKQ09ORklHX0ZVVEVYPXkKQ09ORklHX0FO
T05fSU5PREVTPXkKQ09ORklHX0VQT0xMPXkKQ09ORklHX1NJR05BTEZEPXkKQ09ORklHX1RJTUVS
RkQ9eQpDT05GSUdfRVZFTlRGRD15CkNPTkZJR19TSE1FTT15CkNPTkZJR19BSU89eQpDT05GSUdf
Vk1fRVZFTlRfQ09VTlRFUlM9eQpDT05GSUdfU0xVQl9ERUJVRz15CiMgQ09ORklHX1NMQUIgaXMg
bm90IHNldApDT05GSUdfU0xVQj15CiMgQ09ORklHX1NMT0IgaXMgbm90IHNldAojIENPTkZJR19Q
Uk9GSUxJTkcgaXMgbm90IHNldAojIENPTkZJR19NQVJLRVJTIGlzIG5vdCBzZXQKQ09ORklHX0hB
VkVfT1BST0ZJTEU9eQpDT05GSUdfSEFWRV9FRkZJQ0lFTlRfVU5BTElHTkVEX0FDQ0VTUz15CkNP
TkZJR19IQVZFX0lPUkVNQVBfUFJPVD15CkNPTkZJR19IQVZFX0tQUk9CRVM9eQpDT05GSUdfSEFW
RV9LUkVUUFJPQkVTPXkKQ09ORklHX0hBVkVfQVJDSF9UUkFDRUhPT0s9eQpDT05GSUdfSEFWRV9D
TEs9eQojIENPTkZJR19IQVZFX0dFTkVSSUNfRE1BX0NPSEVSRU5UIGlzIG5vdCBzZXQKQ09ORklH
X1NMQUJJTkZPPXkKQ09ORklHX1JUX01VVEVYRVM9eQojIENPTkZJR19USU5ZX1NITUVNIGlzIG5v
dCBzZXQKQ09ORklHX0JBU0VfU01BTEw9MAojIENPTkZJR19NT0RVTEVTIGlzIG5vdCBzZXQKQ09O
RklHX0JMT0NLPXkKIyBDT05GSUdfTEJEIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9JT19U
UkFDRSBpcyBub3Qgc2V0CiMgQ09ORklHX0xTRiBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZf
SU5URUdSSVRZIGlzIG5vdCBzZXQKCiMKIyBJTyBTY2hlZHVsZXJzCiMKQ09ORklHX0lPU0NIRURf
Tk9PUD15CiMgQ09ORklHX0lPU0NIRURfQVMgaXMgbm90IHNldApDT05GSUdfSU9TQ0hFRF9ERUFE
TElORT15CiMgQ09ORklHX0lPU0NIRURfQ0ZRIGlzIG5vdCBzZXQKIyBDT05GSUdfREVGQVVMVF9B
UyBpcyBub3Qgc2V0CkNPTkZJR19ERUZBVUxUX0RFQURMSU5FPXkKIyBDT05GSUdfREVGQVVMVF9D
RlEgaXMgbm90IHNldAojIENPTkZJR19ERUZBVUxUX05PT1AgaXMgbm90IHNldApDT05GSUdfREVG
QVVMVF9JT1NDSEVEPSJkZWFkbGluZSIKQ09ORklHX0NMQVNTSUNfUkNVPXkKIyBDT05GSUdfRlJF
RVpFUiBpcyBub3Qgc2V0CgojCiMgUGxhdGZvcm0gc3VwcG9ydAojCkNPTkZJR19QUENfTVVMVElQ
TEFURk9STT15CkNPTkZJR19DTEFTU0lDMzI9eQojIENPTkZJR19QUENfQ0hSUCBpcyBub3Qgc2V0
CiMgQ09ORklHX01QQzUxMjFfQURTIGlzIG5vdCBzZXQKIyBDT05GSUdfTVBDNTEyMV9HRU5FUklD
IGlzIG5vdCBzZXQKIyBDT05GSUdfUFBDX01QQzUyeHggaXMgbm90IHNldAojIENPTkZJR19QUENf
UE1BQyBpcyBub3Qgc2V0CiMgQ09ORklHX1BQQ19DRUxMIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBD
X0NFTExfTkFUSVZFIGlzIG5vdCBzZXQKQ09ORklHX1BQQ184Mnh4PXkKIyBDT05GSUdfTUdDT0dF
IGlzIG5vdCBzZXQKIyBDT05GSUdfTVBDODI3Ml9BRFMgaXMgbm90IHNldAojIENPTkZJR19NVUFT
MzAwMSBpcyBub3Qgc2V0CiMgQ09ORklHX1BRMkZBRFMgaXMgbm90IHNldAojIENPTkZJR19FUDgy
NDhFIGlzIG5vdCBzZXQKQ09ORklHX1RSNTAwMFYyPXkKIyBDT05GSUdfUFEyQURTIGlzIG5vdCBz
ZXQKQ09ORklHXzgyNjA9eQpDT05GSUdfODI3Mj15CiMgQ09ORklHX1BQQ184M3h4IGlzIG5vdCBz
ZXQKIyBDT05GSUdfUFBDXzg2eHggaXMgbm90IHNldAojIENPTkZJR19FTUJFRERFRDZ4eCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lQSUMgaXMgbm90IHNldAojIENPTkZJR19NUElDIGlzIG5vdCBzZXQK
IyBDT05GSUdfTVBJQ19XRUlSRCBpcyBub3Qgc2V0CiMgQ09ORklHX1BQQ19JODI1OSBpcyBub3Qg
c2V0CiMgQ09ORklHX1BQQ19SVEFTIGlzIG5vdCBzZXQKIyBDT05GSUdfTU1JT19OVlJBTSBpcyBu
b3Qgc2V0CiMgQ09ORklHX1BQQ19NUEMxMDYgaXMgbm90IHNldAojIENPTkZJR19QUENfOTcwX05B
UCBpcyBub3Qgc2V0CiMgQ09ORklHX1BQQ19JTkRJUkVDVF9JTyBpcyBub3Qgc2V0CiMgQ09ORklH
X0dFTkVSSUNfSU9NQVAgaXMgbm90IHNldAojIENPTkZJR19DUFVfRlJFUSBpcyBub3Qgc2V0CiMg
Q09ORklHX1RBVSBpcyBub3Qgc2V0CiMgQ09ORklHX1FVSUNDX0VOR0lORSBpcyBub3Qgc2V0CkNP
TkZJR19DUE0yPXkKIyBDT05GSUdfRlNMX1VMSTE1NzUgaXMgbm90IHNldApDT05GSUdfQ1BNPXkK
CiMKIyBLZXJuZWwgb3B0aW9ucwojCiMgQ09ORklHX0hJR0hNRU0gaXMgbm90IHNldApDT05GSUdf
VElDS19PTkVTSE9UPXkKIyBDT05GSUdfTk9fSFogaXMgbm90IHNldApDT05GSUdfSElHSF9SRVNf
VElNRVJTPXkKQ09ORklHX0dFTkVSSUNfQ0xPQ0tFVkVOVFNfQlVJTEQ9eQojIENPTkZJR19IWl8x
MDAgaXMgbm90IHNldApDT05GSUdfSFpfMjUwPXkKIyBDT05GSUdfSFpfMzAwIGlzIG5vdCBzZXQK
IyBDT05GSUdfSFpfMTAwMCBpcyBub3Qgc2V0CkNPTkZJR19IWj0yNTAKQ09ORklHX1NDSEVEX0hS
VElDSz15CkNPTkZJR19QUkVFTVBUX05PTkU9eQojIENPTkZJR19QUkVFTVBUX1ZPTFVOVEFSWSBp
cyBub3Qgc2V0CiMgQ09ORklHX1BSRUVNUFQgaXMgbm90IHNldApDT05GSUdfQklORk1UX0VMRj15
CiMgQ09ORklHX0NPUkVfRFVNUF9ERUZBVUxUX0VMRl9IRUFERVJTIGlzIG5vdCBzZXQKIyBDT05G
SUdfSEFWRV9BT1VUIGlzIG5vdCBzZXQKQ09ORklHX0JJTkZNVF9NSVNDPXkKIyBDT05GSUdfSU9N
TVVfSEVMUEVSIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hfRU5BQkxFX01FTU9SWV9IT1RQTFVHPXkK
Q09ORklHX0FSQ0hfSEFTX1dBTEtfTUVNT1JZPXkKQ09ORklHX0FSQ0hfRU5BQkxFX01FTU9SWV9I
T1RSRU1PVkU9eQpDT05GSUdfQVJDSF9GTEFUTUVNX0VOQUJMRT15CkNPTkZJR19BUkNIX1BPUFVM
QVRFU19OT0RFX01BUD15CkNPTkZJR19GTEFUTUVNPXkKQ09ORklHX0ZMQVRfTk9ERV9NRU1fTUFQ
PXkKQ09ORklHX1BBR0VGTEFHU19FWFRFTkRFRD15CkNPTkZJR19TUExJVF9QVExPQ0tfQ1BVUz00
CkNPTkZJR19NSUdSQVRJT049eQojIENPTkZJR19SRVNPVVJDRVNfNjRCSVQgaXMgbm90IHNldAoj
IENPTkZJR19QSFlTX0FERFJfVF82NEJJVCBpcyBub3Qgc2V0CkNPTkZJR19aT05FX0RNQV9GTEFH
PTEKQ09ORklHX0JPVU5DRT15CkNPTkZJR19WSVJUX1RPX0JVUz15CkNPTkZJR19VTkVWSUNUQUJM
RV9MUlU9eQpDT05GSUdfRk9SQ0VfTUFYX1pPTkVPUkRFUj0xMQpDT05GSUdfUFJPQ19ERVZJQ0VU
UkVFPXkKIyBDT05GSUdfQ01ETElORV9CT09MIGlzIG5vdCBzZXQKQ09ORklHX0VYVFJBX1RBUkdF
VFM9IiIKIyBDT05GSUdfUE0gaXMgbm90IHNldAojIENPTkZJR19TRUNDT01QIGlzIG5vdCBzZXQK
Q09ORklHX0lTQV9ETUFfQVBJPXkKCiMKIyBCdXMgb3B0aW9ucwojCkNPTkZJR19aT05FX0RNQT15
CkNPTkZJR19GU0xfU09DPXkKQ09ORklHX1BQQ19QQ0lfQ0hPSUNFPXkKIyBDT05GSUdfUENJIGlz
IG5vdCBzZXQKIyBDT05GSUdfUENJX0RPTUFJTlMgaXMgbm90IHNldAojIENPTkZJR19QQ0lfU1lT
Q0FMTCBpcyBub3Qgc2V0CiMgQ09ORklHX0FSQ0hfU1VQUE9SVFNfTVNJIGlzIG5vdCBzZXQKIyBD
T05GSUdfUENDQVJEIGlzIG5vdCBzZXQKIyBDT05GSUdfSEFTX1JBUElESU8gaXMgbm90IHNldAoK
IwojIEFkdmFuY2VkIHNldHVwCiMKIyBDT05GSUdfQURWQU5DRURfT1BUSU9OUyBpcyBub3Qgc2V0
CgojCiMgRGVmYXVsdCBzZXR0aW5ncyBmb3IgYWR2YW5jZWQgY29uZmlndXJhdGlvbiBvcHRpb25z
IGFyZSB1c2VkCiMKQ09ORklHX0xPV01FTV9TSVpFPTB4MzAwMDAwMDAKQ09ORklHX1BBR0VfT0ZG
U0VUPTB4YzAwMDAwMDAKQ09ORklHX0tFUk5FTF9TVEFSVD0weGMwMDAwMDAwCkNPTkZJR19QSFlT
SUNBTF9TVEFSVD0weDAwMDAwMDAwCkNPTkZJR19UQVNLX1NJWkU9MHhjMDAwMDAwMApDT05GSUdf
TkVUPXkKCiMKIyBOZXR3b3JraW5nIG9wdGlvbnMKIwpDT05GSUdfUEFDS0VUPXkKIyBDT05GSUdf
UEFDS0VUX01NQVAgaXMgbm90IHNldApDT05GSUdfVU5JWD15CkNPTkZJR19YRlJNPXkKIyBDT05G
SUdfWEZSTV9VU0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUX0tFWSBpcyBub3Qgc2V0CkNPTkZJ
R19JTkVUPXkKQ09ORklHX0lQX01VTFRJQ0FTVD15CiMgQ09ORklHX0lQX0FEVkFOQ0VEX1JPVVRF
UiBpcyBub3Qgc2V0CkNPTkZJR19JUF9GSUJfSEFTSD15CkNPTkZJR19JUF9QTlA9eQpDT05GSUdf
SVBfUE5QX0RIQ1A9eQpDT05GSUdfSVBfUE5QX0JPT1RQPXkKIyBDT05GSUdfSVBfUE5QX1JBUlAg
aXMgbm90IHNldAojIENPTkZJR19ORVRfSVBJUCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9JUEdS
RSBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX01ST1VURSBpcyBub3Qgc2V0CkNPTkZJR19TWU5fQ09P
S0lFUz15CiMgQ09ORklHX0lORVRfQUggaXMgbm90IHNldAojIENPTkZJR19JTkVUX0VTUCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lORVRfSVBDT01QIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9YRlJN
X1RVTk5FTCBpcyBub3Qgc2V0CkNPTkZJR19JTkVUX1RVTk5FTD15CkNPTkZJR19JTkVUX1hGUk1f
TU9ERV9UUkFOU1BPUlQ9eQpDT05GSUdfSU5FVF9YRlJNX01PREVfVFVOTkVMPXkKQ09ORklHX0lO
RVRfWEZSTV9NT0RFX0JFRVQ9eQojIENPTkZJR19JTkVUX0xSTyBpcyBub3Qgc2V0CkNPTkZJR19J
TkVUX0RJQUc9eQpDT05GSUdfSU5FVF9UQ1BfRElBRz15CiMgQ09ORklHX1RDUF9DT05HX0FEVkFO
Q0VEIGlzIG5vdCBzZXQKQ09ORklHX1RDUF9DT05HX0NVQklDPXkKQ09ORklHX0RFRkFVTFRfVENQ
X0NPTkc9ImN1YmljIgpDT05GSUdfSVBWNj15CiMgQ09ORklHX0lQVjZfUFJJVkFDWSBpcyBub3Qg
c2V0CiMgQ09ORklHX0lQVjZfUk9VVEVSX1BSRUYgaXMgbm90IHNldAojIENPTkZJR19JTkVUNl9B
SCBpcyBub3Qgc2V0CiMgQ09ORklHX0lORVQ2X0VTUCBpcyBub3Qgc2V0CiMgQ09ORklHX0lORVQ2
X0lQQ09NUCBpcyBub3Qgc2V0CiMgQ09ORklHX0lORVQ2X1hGUk1fVFVOTkVMIGlzIG5vdCBzZXQK
IyBDT05GSUdfSU5FVDZfVFVOTkVMIGlzIG5vdCBzZXQKQ09ORklHX0lORVQ2X1hGUk1fTU9ERV9U
UkFOU1BPUlQ9eQpDT05GSUdfSU5FVDZfWEZSTV9NT0RFX1RVTk5FTD15CkNPTkZJR19JTkVUNl9Y
RlJNX01PREVfQkVFVD15CkNPTkZJR19JUFY2X1NJVD15CkNPTkZJR19JUFY2X05ESVNDX05PREVU
WVBFPXkKIyBDT05GSUdfSVBWNl9UVU5ORUwgaXMgbm90IHNldAojIENPTkZJR19ORVRXT1JLX1NF
Q01BUksgaXMgbm90IHNldApDT05GSUdfTkVURklMVEVSPXkKIyBDT05GSUdfTkVURklMVEVSX0RF
QlVHIGlzIG5vdCBzZXQKQ09ORklHX05FVEZJTFRFUl9BRFZBTkNFRD15CgojCiMgQ29yZSBOZXRm
aWx0ZXIgQ29uZmlndXJhdGlvbgojCiMgQ09ORklHX05FVEZJTFRFUl9ORVRMSU5LX1FVRVVFIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVSX05FVExJTktfTE9HIGlzIG5vdCBzZXQKIyBDT05G
SUdfTkZfQ09OTlRSQUNLIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVSX1hUQUJMRVMgaXMg
bm90IHNldAojIENPTkZJR19JUF9WUyBpcyBub3Qgc2V0CgojCiMgSVA6IE5ldGZpbHRlciBDb25m
aWd1cmF0aW9uCiMKIyBDT05GSUdfTkZfREVGUkFHX0lQVjQgaXMgbm90IHNldAojIENPTkZJR19J
UF9ORl9RVUVVRSBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX05GX0lQVEFCTEVTIGlzIG5vdCBzZXQK
IyBDT05GSUdfSVBfTkZfQVJQVEFCTEVTIGlzIG5vdCBzZXQKCiMKIyBJUHY2OiBOZXRmaWx0ZXIg
Q29uZmlndXJhdGlvbgojCiMgQ09ORklHX0lQNl9ORl9RVUVVRSBpcyBub3Qgc2V0CiMgQ09ORklH
X0lQNl9ORl9JUFRBQkxFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0FUTSBpcyBub3Qgc2V0CiMgQ09O
RklHX0JSSURHRSBpcyBub3Qgc2V0CiMgQ09ORklHX1ZMQU5fODAyMVEgaXMgbm90IHNldAojIENP
TkZJR19ERUNORVQgaXMgbm90IHNldAojIENPTkZJR19MTEMyIGlzIG5vdCBzZXQKIyBDT05GSUdf
SVBYIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRBTEsgaXMgbm90IHNldAojIENPTkZJR19ORVRfU0NI
RUQgaXMgbm90IHNldAoKIwojIE5ldHdvcmsgdGVzdGluZwojCiMgQ09ORklHX05FVF9QS1RHRU4g
aXMgbm90IHNldAojIENPTkZJR19IQU1SQURJTyBpcyBub3Qgc2V0CiMgQ09ORklHX0NBTiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0lSREEgaXMgbm90IHNldAojIENPTkZJR19CVCBpcyBub3Qgc2V0CiMg
Q09ORklHX1BIT05FVCBpcyBub3Qgc2V0CiMgQ09ORklHX1dJUkVMRVNTIGlzIG5vdCBzZXQKIyBD
T05GSUdfUkZLSUxMIGlzIG5vdCBzZXQKCiMKIyBEZXZpY2UgRHJpdmVycwojCgojCiMgR2VuZXJp
YyBEcml2ZXIgT3B0aW9ucwojCkNPTkZJR19VRVZFTlRfSEVMUEVSX1BBVEg9Ii9zYmluL2hvdHBs
dWciCkNPTkZJR19TVEFOREFMT05FPXkKQ09ORklHX1BSRVZFTlRfRklSTVdBUkVfQlVJTEQ9eQoj
IENPTkZJR19GV19MT0FERVIgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19EUklWRVIgaXMgbm90
IHNldAojIENPTkZJR19ERUJVR19ERVZSRVMgaXMgbm90IHNldAojIENPTkZJR19TWVNfSFlQRVJW
SVNPUiBpcyBub3Qgc2V0CiMgQ09ORklHX0NPTk5FQ1RPUiBpcyBub3Qgc2V0CkNPTkZJR19NVEQ9
eQojIENPTkZJR19NVERfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19NVERfQ09OQ0FUIGlzIG5v
dCBzZXQKIyBDT05GSUdfTVREX1BBUlRJVElPTlMgaXMgbm90IHNldAoKIwojIFVzZXIgTW9kdWxl
cyBBbmQgVHJhbnNsYXRpb24gTGF5ZXJzCiMKQ09ORklHX01URF9DSEFSPXkKQ09ORklHX01URF9C
TEtERVZTPXkKQ09ORklHX01URF9CTE9DSz15CiMgQ09ORklHX0ZUTCBpcyBub3Qgc2V0CiMgQ09O
RklHX05GVEwgaXMgbm90IHNldAojIENPTkZJR19JTkZUTCBpcyBub3Qgc2V0CiMgQ09ORklHX1JG
RF9GVEwgaXMgbm90IHNldAojIENPTkZJR19TU0ZEQyBpcyBub3Qgc2V0CiMgQ09ORklHX01URF9P
T1BTIGlzIG5vdCBzZXQKCiMKIyBSQU0vUk9NL0ZsYXNoIGNoaXAgZHJpdmVycwojCiMgQ09ORklH
X01URF9DRkkgaXMgbm90IHNldAojIENPTkZJR19NVERfSkVERUNQUk9CRSBpcyBub3Qgc2V0CkNP
TkZJR19NVERfTUFQX0JBTktfV0lEVEhfMT15CkNPTkZJR19NVERfTUFQX0JBTktfV0lEVEhfMj15
CkNPTkZJR19NVERfTUFQX0JBTktfV0lEVEhfND15CiMgQ09ORklHX01URF9NQVBfQkFOS19XSURU
SF84IGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX01BUF9CQU5LX1dJRFRIXzE2IGlzIG5vdCBzZXQK
IyBDT05GSUdfTVREX01BUF9CQU5LX1dJRFRIXzMyIGlzIG5vdCBzZXQKQ09ORklHX01URF9DRklf
STE9eQpDT05GSUdfTVREX0NGSV9JMj15CiMgQ09ORklHX01URF9DRklfSTQgaXMgbm90IHNldAoj
IENPTkZJR19NVERfQ0ZJX0k4IGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX1JBTSBpcyBub3Qgc2V0
CiMgQ09ORklHX01URF9ST00gaXMgbm90IHNldAojIENPTkZJR19NVERfQUJTRU5UIGlzIG5vdCBz
ZXQKCiMKIyBNYXBwaW5nIGRyaXZlcnMgZm9yIGNoaXAgYWNjZXNzCiMKIyBDT05GSUdfTVREX0NP
TVBMRVhfTUFQUElOR1MgaXMgbm90IHNldAojIENPTkZJR19NVERfUExBVFJBTSBpcyBub3Qgc2V0
CgojCiMgU2VsZi1jb250YWluZWQgTVREIGRldmljZSBkcml2ZXJzCiMKIyBDT05GSUdfTVREX1NM
UkFNIGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX1BIUkFNIGlzIG5vdCBzZXQKIyBDT05GSUdfTVRE
X01URFJBTSBpcyBub3Qgc2V0CiMgQ09ORklHX01URF9CTE9DSzJNVEQgaXMgbm90IHNldAoKIwoj
IERpc2stT24tQ2hpcCBEZXZpY2UgRHJpdmVycwojCiMgQ09ORklHX01URF9ET0MyMDAwIGlzIG5v
dCBzZXQKIyBDT05GSUdfTVREX0RPQzIwMDEgaXMgbm90IHNldAojIENPTkZJR19NVERfRE9DMjAw
MVBMVVMgaXMgbm90IHNldAojIENPTkZJR19NVERfTkFORCBpcyBub3Qgc2V0CiMgQ09ORklHX01U
RF9PTkVOQU5EIGlzIG5vdCBzZXQKCiMKIyBVQkkgLSBVbnNvcnRlZCBibG9jayBpbWFnZXMKIwoj
IENPTkZJR19NVERfVUJJIGlzIG5vdCBzZXQKQ09ORklHX09GX0RFVklDRT15CkNPTkZJR19PRl9H
UElPPXkKQ09ORklHX09GX0kyQz15CkNPTkZJR19PRl9TUEk9eQojIENPTkZJR19QQVJQT1JUIGlz
IG5vdCBzZXQKQ09ORklHX0JMS19ERVY9eQojIENPTkZJR19CTEtfREVWX0ZEIGlzIG5vdCBzZXQK
IyBDT05GSUdfQkxLX0RFVl9DT1dfQ09NTU9OIGlzIG5vdCBzZXQKQ09ORklHX0JMS19ERVZfTE9P
UD15CiMgQ09ORklHX0JMS19ERVZfQ1JZUFRPTE9PUCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19E
RVZfTkJEIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9SQU0gaXMgbm90IHNldAojIENPTkZJ
R19DRFJPTV9QS1RDRFZEIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRBX09WRVJfRVRIIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQkxLX0RFVl9IRCBpcyBub3Qgc2V0CiMgQ09ORklHX01JU0NfREVWSUNFUyBp
cyBub3Qgc2V0CkNPTkZJR19IQVZFX0lERT15CkNPTkZJR19JREU9eQoKIwojIFBsZWFzZSBzZWUg
RG9jdW1lbnRhdGlvbi9pZGUvaWRlLnR4dCBmb3IgaGVscC9pbmZvIG9uIElERSBkcml2ZXMKIwoj
IENPTkZJR19CTEtfREVWX0lERV9TQVRBIGlzIG5vdCBzZXQKQ09ORklHX0lERV9HRD15CkNPTkZJ
R19JREVfR0RfQVRBPXkKIyBDT05GSUdfSURFX0dEX0FUQVBJIGlzIG5vdCBzZXQKIyBDT05GSUdf
QkxLX0RFVl9JREVDRCBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfSURFVEFQRSBpcyBub3Qg
c2V0CiMgQ09ORklHX0lERV9UQVNLX0lPQ1RMIGlzIG5vdCBzZXQKQ09ORklHX0lERV9QUk9DX0ZT
PXkKCiMKIyBJREUgY2hpcHNldCBzdXBwb3J0L2J1Z2ZpeGVzCiMKIyBDT05GSUdfQkxLX0RFVl9Q
TEFURk9STSBpcyBub3Qgc2V0CiMgQ09ORklHX0JMS19ERVZfSURFRE1BIGlzIG5vdCBzZXQKCiMK
IyBTQ1NJIGRldmljZSBzdXBwb3J0CiMKIyBDT05GSUdfUkFJRF9BVFRSUyBpcyBub3Qgc2V0CiMg
Q09ORklHX1NDU0kgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0RNQSBpcyBub3Qgc2V0CiMgQ09O
RklHX1NDU0lfTkVUTElOSyBpcyBub3Qgc2V0CiMgQ09ORklHX0FUQSBpcyBub3Qgc2V0CiMgQ09O
RklHX01EIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFDSU5UT1NIX0RSSVZFUlMgaXMgbm90IHNldApD
T05GSUdfTkVUREVWSUNFUz15CiMgQ09ORklHX0RVTU1ZIGlzIG5vdCBzZXQKIyBDT05GSUdfQk9O
RElORyBpcyBub3Qgc2V0CiMgQ09ORklHX0VRVUFMSVpFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1RV
TiBpcyBub3Qgc2V0CiMgQ09ORklHX1ZFVEggaXMgbm90IHNldApDT05GSUdfUEhZTElCPXkKCiMK
IyBNSUkgUEhZIGRldmljZSBkcml2ZXJzCiMKIyBDT05GSUdfTUFSVkVMTF9QSFkgaXMgbm90IHNl
dAojIENPTkZJR19EQVZJQ09NX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX1FTRU1JX1BIWSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0xYVF9QSFkgaXMgbm90IHNldAojIENPTkZJR19DSUNBREFfUEhZIGlz
IG5vdCBzZXQKIyBDT05GSUdfVklURVNTRV9QSFkgaXMgbm90IHNldAojIENPTkZJR19TTVNDX1BI
WSBpcyBub3Qgc2V0CiMgQ09ORklHX0JST0FEQ09NX1BIWSBpcyBub3Qgc2V0CiMgQ09ORklHX0lD
UExVU19QSFkgaXMgbm90IHNldAojIENPTkZJR19SRUFMVEVLX1BIWSBpcyBub3Qgc2V0CiMgQ09O
RklHX0ZJWEVEX1BIWSBpcyBub3Qgc2V0CkNPTkZJR19NRElPX0JJVEJBTkc9eQojIENPTkZJR19N
RElPX09GX0dQSU8gaXMgbm90IHNldApDT05GSUdfTkVUX0VUSEVSTkVUPXkKQ09ORklHX01JST15
CiMgQ09ORklHX0lCTV9ORVdfRU1BQ19aTUlJIGlzIG5vdCBzZXQKIyBDT05GSUdfSUJNX05FV19F
TUFDX1JHTUlJIGlzIG5vdCBzZXQKIyBDT05GSUdfSUJNX05FV19FTUFDX1RBSCBpcyBub3Qgc2V0
CiMgQ09ORklHX0lCTV9ORVdfRU1BQ19FTUFDNCBpcyBub3Qgc2V0CiMgQ09ORklHX0lCTV9ORVdf
RU1BQ19OT19GTE9XX0NUUkwgaXMgbm90IHNldAojIENPTkZJR19JQk1fTkVXX0VNQUNfTUFMX0NM
Ul9JQ0lOVFNUQVQgaXMgbm90IHNldAojIENPTkZJR19JQk1fTkVXX0VNQUNfTUFMX0NPTU1PTl9F
UlIgaXMgbm90IHNldAojIENPTkZJR19CNDQgaXMgbm90IHNldApDT05GSUdfRlNfRU5FVD15CiMg
Q09ORklHX0ZTX0VORVRfSEFTX1NDQyBpcyBub3Qgc2V0CkNPTkZJR19GU19FTkVUX0hBU19GQ0M9
eQojIENPTkZJR19GU19FTkVUX01ESU9fRkNDIGlzIG5vdCBzZXQKQ09ORklHX05FVERFVl8xMDAw
PXkKIyBDT05GSUdfR0lBTkZBUiBpcyBub3Qgc2V0CiMgQ09ORklHX01WNjQzWFhfRVRIIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkVUREVWXzEwMDAwIGlzIG5vdCBzZXQKCiMKIyBXaXJlbGVzcyBMQU4K
IwojIENPTkZJR19XTEFOX1BSRTgwMjExIGlzIG5vdCBzZXQKIyBDT05GSUdfV0xBTl84MDIxMSBp
cyBub3Qgc2V0CiMgQ09ORklHX0lXTFdJRklfTEVEUyBpcyBub3Qgc2V0CiMgQ09ORklHX1dBTiBp
cyBub3Qgc2V0CkNPTkZJR19QUFA9eQojIENPTkZJR19QUFBfRklMVEVSIGlzIG5vdCBzZXQKQ09O
RklHX1BQUF9BU1lOQz15CkNPTkZJR19QUFBfU1lOQ19UVFk9eQpDT05GSUdfUFBQX0RFRkxBVEU9
eQojIENPTkZJR19QUFBfQlNEQ09NUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NMSVAgaXMgbm90IHNl
dApDT05GSUdfU0xIQz15CiMgQ09ORklHX05FVFBPTEwgaXMgbm90IHNldAojIENPTkZJR19ORVRf
UE9MTF9DT05UUk9MTEVSIGlzIG5vdCBzZXQKIyBDT05GSUdfSVNETiBpcyBub3Qgc2V0CiMgQ09O
RklHX1BIT05FIGlzIG5vdCBzZXQKCiMKIyBJbnB1dCBkZXZpY2Ugc3VwcG9ydAojCiMgQ09ORklH
X0lOUFVUIGlzIG5vdCBzZXQKCiMKIyBIYXJkd2FyZSBJL08gcG9ydHMKIwojIENPTkZJR19TRVJJ
TyBpcyBub3Qgc2V0CiMgQ09ORklHX0dBTUVQT1JUIGlzIG5vdCBzZXQKCiMKIyBDaGFyYWN0ZXIg
ZGV2aWNlcwojCiMgQ09ORklHX1ZUIGlzIG5vdCBzZXQKQ09ORklHX0RFVktNRU09eQojIENPTkZJ
R19TRVJJQUxfTk9OU1RBTkRBUkQgaXMgbm90IHNldAoKIwojIFNlcmlhbCBkcml2ZXJzCiMKIyBD
T05GSUdfU0VSSUFMXzgyNTAgaXMgbm90IHNldAoKIwojIE5vbi04MjUwIHNlcmlhbCBwb3J0IHN1
cHBvcnQKIwojIENPTkZJR19TRVJJQUxfVUFSVExJVEUgaXMgbm90IHNldApDT05GSUdfU0VSSUFM
X0NPUkU9eQpDT05GSUdfU0VSSUFMX0NPUkVfQ09OU09MRT15CkNPTkZJR19TRVJJQUxfQ1BNPXkK
Q09ORklHX1NFUklBTF9DUE1fQ09OU09MRT15CkNPTkZJR19VTklYOThfUFRZUz15CkNPTkZJR19M
RUdBQ1lfUFRZUz15CkNPTkZJR19MRUdBQ1lfUFRZX0NPVU5UPTI1NgojIENPTkZJR19JUE1JX0hB
TkRMRVIgaXMgbm90IHNldApDT05GSUdfSFdfUkFORE9NPXkKIyBDT05GSUdfTlZSQU0gaXMgbm90
IHNldAojIENPTkZJR19HRU5fUlRDIGlzIG5vdCBzZXQKIyBDT05GSUdfUjM5NjQgaXMgbm90IHNl
dAojIENPTkZJR19SQVdfRFJJVkVSIGlzIG5vdCBzZXQKIyBDT05GSUdfQk9PVENPVU5UIGlzIG5v
dCBzZXQKQ09ORklHX0kyQz15CkNPTkZJR19JMkNfQk9BUkRJTkZPPXkKIyBDT05GSUdfSTJDX0NI
QVJERVYgaXMgbm90IHNldApDT05GSUdfSTJDX0hFTFBFUl9BVVRPPXkKCiMKIyBJMkMgSGFyZHdh
cmUgQnVzIHN1cHBvcnQKIwoKIwojIEkyQyBzeXN0ZW0gYnVzIGRyaXZlcnMgKG1vc3RseSBlbWJl
ZGRlZCAvIHN5c3RlbS1vbi1jaGlwKQojCiMgQ09ORklHX0kyQ19DUE0gaXMgbm90IHNldAojIENP
TkZJR19JMkNfR1BJTyBpcyBub3Qgc2V0CiMgQ09ORklHX0kyQ19NUEMgaXMgbm90IHNldAojIENP
TkZJR19JMkNfU0lNVEVDIGlzIG5vdCBzZXQKCiMKIyBFeHRlcm5hbCBJMkMvU01CdXMgYWRhcHRl
ciBkcml2ZXJzCiMKIyBDT05GSUdfSTJDX1BBUlBPUlRfTElHSFQgaXMgbm90IHNldAoKIwojIE90
aGVyIEkyQy9TTUJ1cyBidXMgZHJpdmVycwojCiMgQ09ORklHX0kyQ19QQ0FfUExBVEZPUk0gaXMg
bm90IHNldAoKIwojIE1pc2NlbGxhbmVvdXMgSTJDIENoaXAgc3VwcG9ydAojCiMgQ09ORklHX1BD
Rjg1NzUgaXMgbm90IHNldAojIENPTkZJR19UUFM2NTAxMCBpcyBub3Qgc2V0CiMgQ09ORklHX0ky
Q19ERUJVR19DT1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0RFQlVHX0FMR08gaXMgbm90IHNl
dAojIENPTkZJR19JMkNfREVCVUdfQlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX0RFQlVHX0NI
SVAgaXMgbm90IHNldApDT05GSUdfU1BJPXkKIyBDT05GSUdfU1BJX0RFQlVHIGlzIG5vdCBzZXQK
Q09ORklHX1NQSV9NQVNURVI9eQoKIwojIFNQSSBNYXN0ZXIgQ29udHJvbGxlciBEcml2ZXJzCiMK
IyBDT05GSUdfU1BJX0JJVEJBTkcgaXMgbm90IHNldAoKIwojIFNQSSBQcm90b2NvbCBNYXN0ZXJz
CiMKIyBDT05GSUdfU1BJX0FUMjUgaXMgbm90IHNldAojIENPTkZJR19TUElfVExFNjJYMCBpcyBu
b3Qgc2V0CkNPTkZJR19BUkNIX1dBTlRfT1BUSU9OQUxfR1BJT0xJQj15CkNPTkZJR19BUkNIX1JF
UVVJUkVfR1BJT0xJQj15CkNPTkZJR19HUElPTElCPXkKIyBDT05GSUdfREVCVUdfR1BJTyBpcyBu
b3Qgc2V0CgojCiMgTWVtb3J5IG1hcHBlZCBHUElPIGV4cGFuZGVyczoKIwojIENPTkZJR19HUElP
X1hJTElOWCBpcyBub3Qgc2V0CgojCiMgSTJDIEdQSU8gZXhwYW5kZXJzOgojCiMgQ09ORklHX0dQ
SU9fTUFYNzMyWCBpcyBub3Qgc2V0CiMgQ09ORklHX0dQSU9fUENBOTUzWCBpcyBub3Qgc2V0CiMg
Q09ORklHX0dQSU9fUENGODU3WCBpcyBub3Qgc2V0CgojCiMgUENJIEdQSU8gZXhwYW5kZXJzOgoj
CgojCiMgU1BJIEdQSU8gZXhwYW5kZXJzOgojCiMgQ09ORklHX0dQSU9fTUFYNzMwMSBpcyBub3Qg
c2V0CiMgQ09ORklHX0dQSU9fTUNQMjNTMDggaXMgbm90IHNldAojIENPTkZJR19XMSBpcyBub3Qg
c2V0CiMgQ09ORklHX1BPV0VSX1NVUFBMWSBpcyBub3Qgc2V0CiMgQ09ORklHX0hXTU9OIGlzIG5v
dCBzZXQKIyBDT05GSUdfVEhFUk1BTCBpcyBub3Qgc2V0CiMgQ09ORklHX1RIRVJNQUxfSFdNT04g
aXMgbm90IHNldAojIENPTkZJR19XQVRDSERPRyBpcyBub3Qgc2V0CkNPTkZJR19TU0JfUE9TU0lC
TEU9eQoKIwojIFNvbmljcyBTaWxpY29uIEJhY2twbGFuZQojCiMgQ09ORklHX1NTQiBpcyBub3Qg
c2V0CgojCiMgTXVsdGlmdW5jdGlvbiBkZXZpY2UgZHJpdmVycwojCiMgQ09ORklHX01GRF9DT1JF
IGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1NNNTAxIGlzIG5vdCBzZXQKIyBDT05GSUdfSFRDX1BB
U0lDMyBpcyBub3Qgc2V0CiMgQ09ORklHX01GRF9UTUlPIGlzIG5vdCBzZXQKIyBDT05GSUdfUE1J
Q19EQTkwM1ggaXMgbm90IHNldAojIENPTkZJR19NRkRfV004NDAwIGlzIG5vdCBzZXQKIyBDT05G
SUdfTUZEX1dNODM1MF9JMkMgaXMgbm90IHNldAojIENPTkZJR19SRUdVTEFUT1IgaXMgbm90IHNl
dAoKIwojIE11bHRpbWVkaWEgZGV2aWNlcwojCgojCiMgTXVsdGltZWRpYSBjb3JlIHN1cHBvcnQK
IwojIENPTkZJR19WSURFT19ERVYgaXMgbm90IHNldAojIENPTkZJR19EVkJfQ09SRSBpcyBub3Qg
c2V0CiMgQ09ORklHX1ZJREVPX01FRElBIGlzIG5vdCBzZXQKCiMKIyBNdWx0aW1lZGlhIGRyaXZl
cnMKIwojIENPTkZJR19EQUIgaXMgbm90IHNldAoKIwojIEdyYXBoaWNzIHN1cHBvcnQKIwojIENP
TkZJR19WR0FTVEFURSBpcyBub3Qgc2V0CiMgQ09ORklHX1ZJREVPX09VVFBVVF9DT05UUk9MIGlz
IG5vdCBzZXQKIyBDT05GSUdfRkIgaXMgbm90IHNldAojIENPTkZJR19CQUNLTElHSFRfTENEX1NV
UFBPUlQgaXMgbm90IHNldAoKIwojIERpc3BsYXkgZGV2aWNlIHN1cHBvcnQKIwojIENPTkZJR19E
SVNQTEFZX1NVUFBPUlQgaXMgbm90IHNldAojIENPTkZJR19TT1VORCBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9TVVBQT1JUIGlzIG5vdCBzZXQKIyBDT05GSUdfTU1DIGlzIG5vdCBzZXQKIyBDT05G
SUdfTUVNU1RJQ0sgaXMgbm90IHNldAojIENPTkZJR19ORVdfTEVEUyBpcyBub3Qgc2V0CiMgQ09O
RklHX0FDQ0VTU0lCSUxJVFkgaXMgbm90IHNldAojIENPTkZJR19SVENfQ0xBU1MgaXMgbm90IHNl
dAojIENPTkZJR19ETUFERVZJQ0VTIGlzIG5vdCBzZXQKIyBDT05GSUdfVUlPIGlzIG5vdCBzZXQK
IyBDT05GSUdfU1RBR0lORyBpcyBub3Qgc2V0CkNPTkZJR19TVEFHSU5HX0VYQ0xVREVfQlVJTEQ9
eQoKIwojIEZpbGUgc3lzdGVtcwojCkNPTkZJR19FWFQyX0ZTPXkKIyBDT05GSUdfRVhUMl9GU19Y
QVRUUiBpcyBub3Qgc2V0CiMgQ09ORklHX0VYVDJfRlNfWElQIGlzIG5vdCBzZXQKQ09ORklHX0VY
VDNfRlM9eQpDT05GSUdfRVhUM19GU19YQVRUUj15CiMgQ09ORklHX0VYVDNfRlNfUE9TSVhfQUNM
IGlzIG5vdCBzZXQKIyBDT05GSUdfRVhUM19GU19TRUNVUklUWSBpcyBub3Qgc2V0CiMgQ09ORklH
X0VYVDRfRlMgaXMgbm90IHNldApDT05GSUdfSkJEPXkKQ09ORklHX0ZTX01CQ0FDSEU9eQojIENP
TkZJR19SRUlTRVJGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0pGU19GUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0ZTX1BPU0lYX0FDTCBpcyBub3Qgc2V0CkNPTkZJR19GSUxFX0xPQ0tJTkc9eQojIENP
TkZJR19YRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19PQ0ZTMl9GUyBpcyBub3Qgc2V0CkNPTkZJ
R19ETk9USUZZPXkKQ09ORklHX0lOT1RJRlk9eQpDT05GSUdfSU5PVElGWV9VU0VSPXkKIyBDT05G
SUdfUVVPVEEgaXMgbm90IHNldAojIENPTkZJR19BVVRPRlNfRlMgaXMgbm90IHNldApDT05GSUdf
QVVUT0ZTNF9GUz15CiMgQ09ORklHX0ZVU0VfRlMgaXMgbm90IHNldAoKIwojIENELVJPTS9EVkQg
RmlsZXN5c3RlbXMKIwojIENPTkZJR19JU085NjYwX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfVURG
X0ZTIGlzIG5vdCBzZXQKCiMKIyBET1MvRkFUL05UIEZpbGVzeXN0ZW1zCiMKIyBDT05GSUdfTVNE
T1NfRlMgaXMgbm90IHNldAojIENPTkZJR19WRkFUX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfTlRG
U19GUyBpcyBub3Qgc2V0CgojCiMgUHNldWRvIGZpbGVzeXN0ZW1zCiMKQ09ORklHX1BST0NfRlM9
eQpDT05GSUdfUFJPQ19LQ09SRT15CkNPTkZJR19QUk9DX1NZU0NUTD15CkNPTkZJR19QUk9DX1BB
R0VfTU9OSVRPUj15CkNPTkZJR19TWVNGUz15CkNPTkZJR19UTVBGUz15CiMgQ09ORklHX1RNUEZT
X1BPU0lYX0FDTCBpcyBub3Qgc2V0CiMgQ09ORklHX0hVR0VUTEJfUEFHRSBpcyBub3Qgc2V0CiMg
Q09ORklHX0NPTkZJR0ZTX0ZTIGlzIG5vdCBzZXQKCiMKIyBNaXNjZWxsYW5lb3VzIGZpbGVzeXN0
ZW1zCiMKIyBDT05GSUdfSEZTUExVU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1lBRkZTX0ZTIGlz
IG5vdCBzZXQKIyBDT05GSUdfSkZGUzJfRlMgaXMgbm90IHNldApDT05GSUdfQ1JBTUZTPXkKIyBD
T05GSUdfVlhGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX01JTklYX0ZTIGlzIG5vdCBzZXQKIyBD
T05GSUdfT01GU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hQRlNfRlMgaXMgbm90IHNldAojIENP
TkZJR19RTlg0RlNfRlMgaXMgbm90IHNldAojIENPTkZJR19ST01GU19GUyBpcyBub3Qgc2V0CiMg
Q09ORklHX1NZU1ZfRlMgaXMgbm90IHNldAojIENPTkZJR19VRlNfRlMgaXMgbm90IHNldApDT05G
SUdfTkVUV09SS19GSUxFU1lTVEVNUz15CkNPTkZJR19ORlNfRlM9eQpDT05GSUdfTkZTX1YzPXkK
IyBDT05GSUdfTkZTX1YzX0FDTCBpcyBub3Qgc2V0CkNPTkZJR19ST09UX05GUz15CiMgQ09ORklH
X05GU0QgaXMgbm90IHNldApDT05GSUdfTE9DS0Q9eQpDT05GSUdfTE9DS0RfVjQ9eQpDT05GSUdf
TkZTX0NPTU1PTj15CkNPTkZJR19TVU5SUEM9eQojIENPTkZJR19TTUJfRlMgaXMgbm90IHNldApD
T05GSUdfQ0lGUz15CiMgQ09ORklHX0NJRlNfU1RBVFMgaXMgbm90IHNldAojIENPTkZJR19DSUZT
X1dFQUtfUFdfSEFTSCBpcyBub3Qgc2V0CiMgQ09ORklHX0NJRlNfWEFUVFIgaXMgbm90IHNldAoj
IENPTkZJR19DSUZTX0RFQlVHMiBpcyBub3Qgc2V0CiMgQ09ORklHX05DUF9GUyBpcyBub3Qgc2V0
CiMgQ09ORklHX0NPREFfRlMgaXMgbm90IHNldAoKIwojIFBhcnRpdGlvbiBUeXBlcwojCkNPTkZJ
R19QQVJUSVRJT05fQURWQU5DRUQ9eQojIENPTkZJR19BQ09STl9QQVJUSVRJT04gaXMgbm90IHNl
dAojIENPTkZJR19PU0ZfUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfQU1JR0FfUEFSVElU
SU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRBUklfUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05G
SUdfTUFDX1BBUlRJVElPTiBpcyBub3Qgc2V0CkNPTkZJR19NU0RPU19QQVJUSVRJT049eQojIENP
TkZJR19CU0RfRElTS0xBQkVMIGlzIG5vdCBzZXQKIyBDT05GSUdfTUlOSVhfU1VCUEFSVElUSU9O
IGlzIG5vdCBzZXQKIyBDT05GSUdfU09MQVJJU19YODZfUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBD
T05GSUdfVU5JWFdBUkVfRElTS0xBQkVMIGlzIG5vdCBzZXQKIyBDT05GSUdfTERNX1BBUlRJVElP
TiBpcyBub3Qgc2V0CiMgQ09ORklHX1NHSV9QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19V
TFRSSVhfUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfU1VOX1BBUlRJVElPTiBpcyBub3Qg
c2V0CiMgQ09ORklHX0tBUk1BX1BBUlRJVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0VGSV9QQVJU
SVRJT04gaXMgbm90IHNldAojIENPTkZJR19TWVNWNjhfUEFSVElUSU9OIGlzIG5vdCBzZXQKQ09O
RklHX05MUz15CkNPTkZJR19OTFNfREVGQVVMVD0iaXNvODg1OS0xIgpDT05GSUdfTkxTX0NPREVQ
QUdFXzQzNz15CiMgQ09ORklHX05MU19DT0RFUEFHRV83MzcgaXMgbm90IHNldAojIENPTkZJR19O
TFNfQ09ERVBBR0VfNzc1IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg1MCBpcyBu
b3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NTIgaXMgbm90IHNldAojIENPTkZJR19OTFNf
Q09ERVBBR0VfODU1IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg1NyBpcyBub3Qg
c2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjAgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09E
RVBBR0VfODYxIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MiBpcyBub3Qgc2V0
CiMgQ09ORklHX05MU19DT0RFUEFHRV84NjMgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBB
R0VfODY0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg2NSBpcyBub3Qgc2V0CiMg
Q09ORklHX05MU19DT0RFUEFHRV84NjYgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0Vf
ODY5IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzkzNiBpcyBub3Qgc2V0CiMgQ09O
RklHX05MU19DT0RFUEFHRV85NTAgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTMy
IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzk0OSBpcyBub3Qgc2V0CiMgQ09ORklH
X05MU19DT0RFUEFHRV84NzQgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV84IGlzIG5v
dCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzEyNTAgaXMgbm90IHNldAojIENPTkZJR19OTFNf
Q09ERVBBR0VfMTI1MSBpcyBub3Qgc2V0CkNPTkZJR19OTFNfQVNDSUk9eQpDT05GSUdfTkxTX0lT
Tzg4NTlfMT15CiMgQ09ORklHX05MU19JU084ODU5XzIgaXMgbm90IHNldAojIENPTkZJR19OTFNf
SVNPODg1OV8zIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfNCBpcyBub3Qgc2V0CiMg
Q09ORklHX05MU19JU084ODU5XzUgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV82IGlz
IG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfNyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19J
U084ODU5XzkgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV8xMyBpcyBub3Qgc2V0CiMg
Q09ORklHX05MU19JU084ODU5XzE0IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfMTUg
aXMgbm90IHNldAojIENPTkZJR19OTFNfS09JOF9SIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0tP
SThfVSBpcyBub3Qgc2V0CkNPTkZJR19OTFNfVVRGOD15CgojCiMgTGlicmFyeSByb3V0aW5lcwoj
CkNPTkZJR19CSVRSRVZFUlNFPXkKQ09ORklHX0NSQ19DQ0lUVD15CiMgQ09ORklHX0NSQzE2IGlz
IG5vdCBzZXQKIyBDT05GSUdfQ1JDX1QxMERJRiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSQ19JVFVf
VCBpcyBub3Qgc2V0CkNPTkZJR19DUkMzMj15CiMgQ09ORklHX0NSQzcgaXMgbm90IHNldAojIENP
TkZJR19MSUJDUkMzMkMgaXMgbm90IHNldApDT05GSUdfWkxJQl9JTkZMQVRFPXkKQ09ORklHX1pM
SUJfREVGTEFURT15CkNPTkZJR19QTElTVD15CkNPTkZJR19IQVNfSU9NRU09eQpDT05GSUdfSEFT
X0lPUE9SVD15CkNPTkZJR19IQVNfRE1BPXkKQ09ORklHX0hBVkVfTE1CPXkKCiMKIyBLZXJuZWwg
aGFja2luZwojCiMgQ09ORklHX1BSSU5US19USU1FIGlzIG5vdCBzZXQKQ09ORklHX0VOQUJMRV9X
QVJOX0RFUFJFQ0FURUQ9eQpDT05GSUdfRU5BQkxFX01VU1RfQ0hFQ0s9eQpDT05GSUdfRlJBTUVf
V0FSTj0xMDI0CkNPTkZJR19NQUdJQ19TWVNSUT15CiMgQ09ORklHX1VOVVNFRF9TWU1CT0xTIGlz
IG5vdCBzZXQKIyBDT05GSUdfREVCVUdfRlMgaXMgbm90IHNldAojIENPTkZJR19IRUFERVJTX0NI
RUNLIGlzIG5vdCBzZXQKQ09ORklHX0RFQlVHX0tFUk5FTD15CiMgQ09ORklHX0RFQlVHX1NISVJR
IGlzIG5vdCBzZXQKQ09ORklHX0RFVEVDVF9TT0ZUTE9DS1VQPXkKIyBDT05GSUdfQk9PVFBBUkFN
X1NPRlRMT0NLVVBfUEFOSUMgaXMgbm90IHNldApDT05GSUdfQk9PVFBBUkFNX1NPRlRMT0NLVVBf
UEFOSUNfVkFMVUU9MAojIENPTkZJR19TQ0hFRF9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX1ND
SEVEU1RBVFMgaXMgbm90IHNldAojIENPTkZJR19USU1FUl9TVEFUUyBpcyBub3Qgc2V0CiMgQ09O
RklHX0RFQlVHX09CSkVDVFMgaXMgbm90IHNldAojIENPTkZJR19TTFVCX0RFQlVHX09OIGlzIG5v
dCBzZXQKIyBDT05GSUdfU0xVQl9TVEFUUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1JUX01V
VEVYRVMgaXMgbm90IHNldAojIENPTkZJR19SVF9NVVRFWF9URVNURVIgaXMgbm90IHNldAojIENP
TkZJR19ERUJVR19TUElOTE9DSyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX01VVEVYRVMgaXMg
bm90IHNldAojIENPTkZJR19ERUJVR19TUElOTE9DS19TTEVFUCBpcyBub3Qgc2V0CiMgQ09ORklH
X0RFQlVHX0xPQ0tJTkdfQVBJX1NFTEZURVNUUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX0tP
QkpFQ1QgaXMgbm90IHNldApDT05GSUdfREVCVUdfQlVHVkVSQk9TRT15CkNPTkZJR19ERUJVR19J
TkZPPXkKIyBDT05GSUdfREVCVUdfVk0gaXMgbm90IHNldAojIENPTkZJR19ERUJVR19XUklURUNP
VU5UIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfTUVNT1JZX0lOSVQgaXMgbm90IHNldAojIENP
TkZJR19ERUJVR19MSVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfU0cgaXMgbm90IHNldAoj
IENPTkZJR19CT09UX1BSSU5US19ERUxBWSBpcyBub3Qgc2V0CiMgQ09ORklHX1JDVV9UT1JUVVJF
X1RFU1QgaXMgbm90IHNldAojIENPTkZJR19SQ1VfQ1BVX1NUQUxMX0RFVEVDVE9SIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQkFDS1RSQUNFX1NFTEZfVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVH
X0JMT0NLX0VYVF9ERVZUIGlzIG5vdCBzZXQKIyBDT05GSUdfRkFVTFRfSU5KRUNUSU9OIGlzIG5v
dCBzZXQKIyBDT05GSUdfTEFURU5DWVRPUCBpcyBub3Qgc2V0CkNPTkZJR19TWVNDVExfU1lTQ0FM
TF9DSEVDSz15CkNPTkZJR19IQVZFX0ZVTkNUSU9OX1RSQUNFUj15CgojCiMgVHJhY2VycwojCiMg
Q09ORklHX0ZVTkNUSU9OX1RSQUNFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDSEVEX1RSQUNFUiBp
cyBub3Qgc2V0CiMgQ09ORklHX0NPTlRFWFRfU1dJVENIX1RSQUNFUiBpcyBub3Qgc2V0CiMgQ09O
RklHX0JPT1RfVFJBQ0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfU1RBQ0tfVFJBQ0VSIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRFlOQU1JQ19QUklOVEtfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19TQU1Q
TEVTIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfQVJDSF9LR0RCPXkKIyBDT05GSUdfREVCVUdfU1RB
Q0tPVkVSRkxPVyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1NUQUNLX1VTQUdFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfREVCVUdfUEFHRUFMTE9DIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09ERV9QQVRD
SElOR19TRUxGVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX0ZUUl9GSVhVUF9TRUxGVEVTVCBpcyBu
b3Qgc2V0CiMgQ09ORklHX01TSV9CSVRNQVBfU0VMRlRFU1QgaXMgbm90IHNldAojIENPTkZJR19Y
TU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfSVJRU1RBQ0tTIGlzIG5vdCBzZXQKQ09ORklHX0JESV9T
V0lUQ0g9eQojIENPTkZJR19CT09UWF9URVhUIGlzIG5vdCBzZXQKQ09ORklHX1BQQ19FQVJMWV9E
RUJVRz15CiMgQ09ORklHX1BQQ19FQVJMWV9ERUJVR19MUEFSIGlzIG5vdCBzZXQKIyBDT05GSUdf
UFBDX0VBUkxZX0RFQlVHX0c1IGlzIG5vdCBzZXQKIyBDT05GSUdfUFBDX0VBUkxZX0RFQlVHX1JU
QVNfUEFORUwgaXMgbm90IHNldAojIENPTkZJR19QUENfRUFSTFlfREVCVUdfUlRBU19DT05TT0xF
IGlzIG5vdCBzZXQKIyBDT05GSUdfUFBDX0VBUkxZX0RFQlVHX01BUExFIGlzIG5vdCBzZXQKIyBD
T05GSUdfUFBDX0VBUkxZX0RFQlVHX0lTRVJJRVMgaXMgbm90IHNldAojIENPTkZJR19QUENfRUFS
TFlfREVCVUdfUEFTX1JFQUxNT0RFIGlzIG5vdCBzZXQKIyBDT05GSUdfUFBDX0VBUkxZX0RFQlVH
X0JFQVQgaXMgbm90IHNldAojIENPTkZJR19QUENfRUFSTFlfREVCVUdfNDR4IGlzIG5vdCBzZXQK
IyBDT05GSUdfUFBDX0VBUkxZX0RFQlVHXzQweCBpcyBub3Qgc2V0CkNPTkZJR19QUENfRUFSTFlf
REVCVUdfQ1BNPXkKQ09ORklHX1BQQ19FQVJMWV9ERUJVR19DUE1fQUREUj0weGYwMDAwMDg4Cgoj
CiMgU2VjdXJpdHkgb3B0aW9ucwojCiMgQ09ORklHX0tFWVMgaXMgbm90IHNldAojIENPTkZJR19T
RUNVUklUWSBpcyBub3Qgc2V0CiMgQ09ORklHX1NFQ1VSSVRZRlMgaXMgbm90IHNldAojIENPTkZJ
R19TRUNVUklUWV9GSUxFX0NBUEFCSUxJVElFUyBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE89eQoK
IwojIENyeXB0byBjb3JlIG9yIGhlbHBlcgojCiMgQ09ORklHX0NSWVBUT19GSVBTIGlzIG5vdCBz
ZXQKQ09ORklHX0NSWVBUT19BTEdBUEk9eQpDT05GSUdfQ1JZUFRPX0FFQUQ9eQpDT05GSUdfQ1JZ
UFRPX0JMS0NJUEhFUj15CkNPTkZJR19DUllQVE9fSEFTSD15CkNPTkZJR19DUllQVE9fUk5HPXkK
Q09ORklHX0NSWVBUT19NQU5BR0VSPXkKIyBDT05GSUdfQ1JZUFRPX05VTEwgaXMgbm90IHNldAoj
IENPTkZJR19DUllQVE9fQ1JZUFREIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0FVVEhFTkMg
aXMgbm90IHNldAoKIwojIEF1dGhlbnRpY2F0ZWQgRW5jcnlwdGlvbiB3aXRoIEFzc29jaWF0ZWQg
RGF0YQojCiMgQ09ORklHX0NSWVBUT19DQ00gaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fR0NN
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NFUUlWIGlzIG5vdCBzZXQKCiMKIyBCbG9jayBt
b2RlcwojCkNPTkZJR19DUllQVE9fQ0JDPXkKIyBDT05GSUdfQ1JZUFRPX0NUUiBpcyBub3Qgc2V0
CiMgQ09ORklHX0NSWVBUT19DVFMgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPX0VDQj15CkNPTkZJ
R19DUllQVE9fUENCQz15CgojCiMgSGFzaCBtb2RlcwojCiMgQ09ORklHX0NSWVBUT19ITUFDIGlz
IG5vdCBzZXQKCiMKIyBEaWdlc3QKIwojIENPTkZJR19DUllQVE9fQ1JDMzJDIGlzIG5vdCBzZXQK
IyBDT05GSUdfQ1JZUFRPX01ENCBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fTUQ1PXkKIyBDT05G
SUdfQ1JZUFRPX01JQ0hBRUxfTUlDIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1JNRDEyOCBp
cyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19STUQxNjAgaXMgbm90IHNldAojIENPTkZJR19DUllQ
VE9fUk1EMjU2IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1JNRDMyMCBpcyBub3Qgc2V0CiMg
Q09ORklHX0NSWVBUT19TSEExIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NIQTI1NiBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TSEE1MTIgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9f
VEdSMTkyIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1dQNTEyIGlzIG5vdCBzZXQKCiMKIyBD
aXBoZXJzCiMKIyBDT05GSUdfQ1JZUFRPX0FFUyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19B
TlVCSVMgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQVJDNCBpcyBub3Qgc2V0CiMgQ09ORklH
X0NSWVBUT19CTE9XRklTSCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DQU1FTExJQSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DQVNUNSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19D
QVNUNiBpcyBub3Qgc2V0CkNPTkZJR19DUllQVE9fREVTPXkKIyBDT05GSUdfQ1JZUFRPX0ZDUllQ
VCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19LSEFaQUQgaXMgbm90IHNldAojIENPTkZJR19D
UllQVE9fU0VFRCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TRVJQRU5UIGlzIG5vdCBzZXQK
IyBDT05GSUdfQ1JZUFRPX1RFQSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19UV09GSVNIIGlz
IG5vdCBzZXQKCiMKIyBDb21wcmVzc2lvbgojCiMgQ09ORklHX0NSWVBUT19ERUZMQVRFIGlzIG5v
dCBzZXQKIyBDT05GSUdfQ1JZUFRPX0xaTyBpcyBub3Qgc2V0CgojCiMgUmFuZG9tIE51bWJlciBH
ZW5lcmF0aW9uCiMKIyBDT05GSUdfQ1JZUFRPX0FOU0lfQ1BSTkcgaXMgbm90IHNldAojIENPTkZJ
R19DUllQVE9fSFcgaXMgbm90IHNldApDT05GSUdfUFBDX0NMT0NLPXkKQ09ORklHX1BQQ19MSUJf
UkhFQVA9eQojIENPTkZJR19WSVJUVUFMSVpBVElPTiBpcyBub3Qgc2V0Cg==

------_=_NextPart_001_01C9596C.D788D86D--
