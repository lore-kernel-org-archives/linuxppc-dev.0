Return-Path: <eric.lee@hp.com>
From: "Lee, Eric" <eric.lee@hp.com>
To: Junita Ajith <ajijuni@gmail.com>
Date: Wed, 9 Dec 2009 18:12:40 +0000
Subject: RE: dts file for MPC8343EA - cuImage doesn't boot , but uImage with
	DTS 	shows serial output
Message-ID: <507B57E36B7C3A48BD1B90EFA80A782E5372EE795D@GVW0433EXB.americas.hpqcorp.net>
References: <72d214170912090957g3743c63bq48836f6faa4b8269@mail.gmail.com>
In-Reply-To: <72d214170912090957g3743c63bq48836f6faa4b8269@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="_000_507B57E36B7C3A48BD1B90EFA80A782E5372EE795DGVW0433EXBame_"
MIME-Version: 1.0
Cc: "Linuxppc-dev@lists.ozlabs.org" <Linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_507B57E36B7C3A48BD1B90EFA80A782E5372EE795DGVW0433EXBame_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

two things; I had better luck with the mpc8349mds (? don't remember exact f=
ile name) dts as opposed to the itx.  I had to remove the bcsr section or e=
lse the kernel hung during initialization .  also, your u-boot is not passi=
ng the correct kernel commandline:

"Kernel command line: root=3D/dev/nfs rw nfsroot=3D192.168.200.230:/nfsroot=
/rootfs i0IPIC (128 IRQ sources) at fdffc700"

you're trying to run a ramdisk and with tty I expect:

"root=3D/dev/ram rw console=3DttyS0,115200  "

check your environment variable bootargs in u-boot



From: Junita Ajith [mailto:ajijuni@gmail.com]
Sent: Wednesday, December 09, 2009 10:58 AM
To: Lee, Eric
Cc: Linuxppc-dev@lists.ozlabs.org
Subject: dts file for MPC8343EA - cuImage doesn't boot , but uImage with DT=
S shows serial output

Hi Eric,

I am building the linux kernel V-2.6.27  based on MPC8349miTXGP dts file.
I am still not able to boot the cuImage.

But, I see serial outuput from kernel when I try to boot with <kernel> <ram=
disk> <dtb file>

Still the kernel hangs after "Dentry cache hash table entries: 32768 (order=
: 5, 131072 bytes)".

Any clues ..?? We have DDR2 in this board and we are initializing it in U-B=
oot.

Please find the screen dump below:

Thanks,
Junita

Screen shot:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
u-boot> bootm 0x2000000 0x3000000 0x4000000
## Booting image at 02000000 ...
   Image Name:   Linux-2.6.27.18-svn52-dirty8
   Created:      2009-12-08  23:49:28 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1416039 Bytes =3D  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x0FF9BD48 =3D> set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFFA6
bd address  =3D 0x0FF9BFC4
memstart    =3D 0x00000000
memsize     =3D 0x10000000
flashstart  =3D 0xFE000000
flashsize   =3D 0x00080000
flashoffset =3D 0x00034000
sramstart   =3D 0x00000000
sramsize    =3D 0x00000000
bootflags   =3D 0x00000001
intfreq     =3D 399.999 MHz
busfreq     =3D 266.666 MHz
ethaddr     =3D 00:E0:0C:00:8C:01
IP addr     =3D 192.168.201.199
baudrate    =3D 115200 bps
Not skipping initrd
## Loading RAMDisk Image at 03000000 ...
   Image Name:   uboot ext2 ramdisk rootfs
   Created:      2009-10-30  20:15:22 UTC
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    3889103 Bytes =3D  3.7 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Booting using the fdt at 0x4000000
## initrd at 0x03000040 ... 0x033B580E (len=3D3889103=3D0x3B57CF)
   Loading Ramdisk to 0fbe5000, end 0ff9a7cf ... OK
## device tree at 0x04000000 ... 0x04002FFF (len=3D12288=3D0x3000)
   Loading Device Tree to 007fc000, end 007fefff ... OK
Updating property '/soc8349@e0000000/ethernet@24000/mac-address' =3D  00 e0=
 0c 001Updating property '/soc8349@e0000000/ethernet@24000/local-mac-addres=
s' =3D  00 e01Updating property 'timebase-frequency' =3D  03 f9 40 aa
Updating property 'bus-frequency' =3D  0f e5 02 a8
Updating property 'clock-frequency' =3D  17 d7 83 fc
Updating property 'bus-frequency' =3D  0f e5 02 a8
Updating property 'clock-frequency' =3D  0f e5 02 a8
## Transferring control to Linux (at address 00000000) ...
Using MPC834x ITX machine description
Linux version 2.6.27.18-svn52-dirty8 (root@localhost.localdomain) (gcc vers=
ion 9Found initrd at 0xcfbe5000:0xcff9a7cf
console [udbg0] enabled
setup_arch: bootmem
mpc834x_itx_setup_arch()
arch: exit
Zone PFN ranges:
  DMA      0x00000000 -> 0x00010000
  Normal   0x00010000 -> 0x00010000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00010000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: root=3D/dev/nfs rw nfsroot=3D192.168.200.230:/nfsroot/=
rootfs i0IPIC (128 IRQ sources) at fdffc700
PID hash table entries: 1024 (order: 10, 4096 bytes)
clocksource: timebase mult[3c00001] shift[22] registered
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)




On 12/9/09, Lee, Eric <eric.lee@hp.com<mailto:eric.lee@hp.com>> wrote:
I would probably remove the bcsr region.  this was some cpld I believe on a=
 reference board.  with this dts it'll try to write to some hardware regist=
ers that do not exist or are not mapped to the same area.




-----Original Message-----
From: linuxppc-dev-bounces+eric.lee=3Dhp.com<http://hp.com>@lists.ozlabs.or=
g<http://lists.ozlabs.org> [mailto:linuxppc-dev-bounces+eric.lee<mailto:lin=
uxppc-dev-bounces%2Beric.lee>=3Dhp.com<http://hp.com>@lists.ozlabs.org<http=
://lists.ozlabs.org>] On Behalf Of ajijuni@gmail.com<mailto:ajijuni@gmail.c=
om>
Sent: Sunday, December 06, 2009 11:41 PM
To: Linuxppc-dev@lists.ozlabs.org<mailto:Linuxppc-dev@lists.ozlabs.org>
Subject: dts file for MPC8343EA

Hi

We have an MPC8343EA based custom board.

I am not able to get Linux up and running in this. No serial output to debu=
g further.
  U-boot shows correct 'bdinfo' & 'clocks' output.
inux hangs at machine_probe.


I doubt the DTS file in Linux. anyone has DTS file for MPC8343??

u-boot version - 1.3.2
linux-2.6.27
The board base files are drived from MPC8349Imtx-GP since we have the refer=
ence board in which we tested the linux image.

My current DTS file
/dts-v1/;

/ {
        model =3D "MPC8343";
        compatible =3D "MPC8349EMDS", "MPC834xMDS", "MPC83xxMDS";
        linux,phandle =3D <0x100>;
        #size-cells =3D <0x1>;
        #address-cells =3D <0x1>;

        aliases {
                ethernet0 =3D &enet0;
                ethernet1 =3D &enet1;
                serial0 =3D &serial0;
                serial1 =3D &serial1;
                pci0 =3D &pci0;
                pci1 =3D &pci1;
        };
         cpus {
                linux,phandle =3D <0x200>;
                #cpus =3D <0x1>;
                #address-cells =3D <1>;
                #size-cells =3D <0>;

  PowerPC,8343EA@0 {
                        device_type =3D "cpu";
                        reg =3D <0x0>;
                        d-cache-line-size =3D <20>;
                        i-cache-line-size =3D <20>;
                        d-cache-size =3D <8000>;
                        i-cache-size =3D <8000>;
                        timebase-frequency =3D <0>;       // from bootloade=
r
                        bus-frequency =3D <0>;            // from bootloade=
r
                        clock-frequency =3D <0>;          // from bootloade=
r
                        32-bit;
                };
        };


        memory {
                device_type =3D "memory";
                reg =3D <0x00000000 0x10000000>;  // 256MB at 0
        };

        bcsr@e2400000 {
                device_type =3D "board-control";
                reg =3D <0xe2400000 0x8000>;
        };
        soc8343@e0000000 {
                bus-frequency =3D <0x1>;
                reg =3D <0xe0000000 0x200>;
                ranges =3D <0x0 0xe0000000 0x100000>;
                device_type =3D "soc";
                #interrupt-cells =3D <0x2>;
                #size-cells =3D <0x1>;
                #address-cells =3D <0x1>;

                wdt@200 {
                        device_type =3D "watchdog";
                        compatible =3D "mpc83xx_wdt";
                        reg =3D <0x200 0x100>;
                };

i2c@3000 {
                        #address-cells =3D <1>;
                        #size-cells =3D <0>;
                        cell-index =3D <0>;
                        compatible =3D "fsl-i2c";
                        reg =3D <0x3000 0x100>;
                        interrupts =3D <14 0x8>;
                        interrupt-parent =3D <&ipic>;
                        dfsrr;

                        rtc@68 {
                                compatible =3D "dallas,ds1374";
                                reg =3D <0x68>;
                        };
                };

                i2c@3100 {
                        #address-cells =3D <1>;
                        #size-cells =3D <0>;
                        cell-index =3D <1>;
                        compatible =3D "fsl-i2c";
                        reg =3D <0x3100 0x100>;
                        interrupts =3D <15 0x8>;
                        interrupt-parent =3D <&ipic>;
                        dfsrr;
                };

                spi@7000 {
                        cell-index =3D <0>;
                        compatible =3D "fsl,spi";
                        reg =3D <0x7000 0x1000>;
                        interrupts =3D <16 0x8>;
                        interrupt-parent =3D <&ipic>;
                        mode =3D "cpu";
                };

dma@82a8 {
                        #address-cells =3D <1>;
                        #size-cells =3D <1>;
                        compatible =3D "fsl,mpc8349-dma", "fsl,elo-dma";
                        reg =3D <0x82a8 4>;
                        ranges =3D <0 0x8100 0x1a8>;
                        interrupt-parent =3D <&ipic>;
                        interrupts =3D <71 8>;
                        cell-index =3D <0>;
                        dma-channel@0 {
                                compatible =3D "fsl,mpc8349-dma-channel", "=
fsl,elo-dma-channel";
                                reg =3D <0 0x80>;
                                interrupt-parent =3D <&ipic>;
                                interrupts =3D <71 8>;
                        };
                        dma-channel@80 {
                                compatible =3D "fsl,mpc8349-dma-channel", "=
fsl,elo-dma-channel";
                                reg =3D <0x80 0x80>;
                                interrupt-parent =3D <&ipic>;
                                interrupts =3D <71 8>;
                        };
                        dma-channel@100 {
                                compatible =3D "fsl,mpc8349-dma-channel", "=
fsl,elo-dma-channel";
                                reg =3D <0x100 0x80>;
                                interrupt-parent =3D <&ipic>;
                                interrupts =3D <71 8>;
                        };
                        dma-channel@180 {
                                compatible =3D "fsl,mpc8349-dma-channel", "=
fsl,elo-dma-channel";
                                reg =3D <0x180 0x28>;
                                interrupt-parent =3D <&ipic>;
                                interrupts =3D <71 8>;
                        };
                };
/* phy type (ULPI or SERIAL) are only types supported for MPH */
                /* port =3D 0 or 1 */
                usb@22000 {
                        compatible =3D "fsl-usb2-mph";
                        reg =3D <0x22000 0x1000>;
                        #address-cells =3D <1>;
                        #size-cells =3D <0>;
                        interrupt-parent =3D <&ipic>;
                        interrupts =3D <39 0x8>;
                        phy_type =3D "ulpi";
                        port1;
                };
                /* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
                usb@23000 {
                        compatible =3D "fsl-usb2-dr";
                        reg =3D <0x23000 0x1000>;
                        #address-cells =3D <1>;
                        #size-cells =3D <0>;
                        interrupt-parent =3D <&ipic>;
                        interrupts =3D <38 0x8>;
                        dr_mode =3D "otg";
                        phy_type =3D "ulpi";
                };

                mdio@24520 {
                        #address-cells =3D <1>;
                        #size-cells =3D <0>;
                        compatible =3D "fsl,gianfar-mdio";
                        reg =3D <0x24520 0x20>;

                        phy0: ethernet-phy@0 {
                                interrupt-parent =3D <&ipic>;
                                interrupts =3D <17 0x8>;
                                reg =3D <0x0>;
                                device_type =3D "ethernet-phy";
                        };
                        phy1: ethernet-phy@1 {
                                interrupt-parent =3D <&ipic>;
                                interrupts =3D <18 0x8>;
                                reg =3D <0x1>;
                                device_type =3D "ethernet-phy";
                        };
enet0: ethernet@24000 {
                        cell-index =3D <0>;
                        device_type =3D "network";
                        model =3D "TSEC";
                        compatible =3D "gianfar";
                        reg =3D <0x24000 0x1000>;
                        local-mac-address =3D [ 00 00 00 00 00 00 ];
                        interrupts =3D <32 0x8 33 0x8 34 0x8>;
                        interrupt-parent =3D <&ipic>;
                        phy-handle =3D <&phy0>;
                        linux,network-index =3D <0>;
                };

                enet1: ethernet@25000 {
                        cell-index =3D <1>;
                        device_type =3D "network";
                        model =3D "TSEC";
                        compatible =3D "gianfar";
                        reg =3D <0x25000 0x1000>;
                        local-mac-address =3D [ 00 00 00 00 00 00 ];
                        interrupts =3D <35 0x8 36 0x8 37 0x8>;
                        interrupt-parent =3D <&ipic>;
                        phy-handle =3D <&phy1>;
                        linux,network-index =3D <1>;
                };

serial0: serial@4500 {
                        cell-index =3D <0>;
                        device_type =3D "serial";
                        compatible =3D "ns16550";
                        reg =3D <0x4500 0x100>;
                        clock-frequency =3D <0>;
                        interrupts =3D <9 0x8>;
                        interrupt-parent =3D <&ipic>;
                };

                serial1: serial@4600 {
                        cell-index =3D <1>;
                        device_type =3D "serial";
                        compatible =3D "ns16550";
                        reg =3D <0x4600 0x100>;
                        clock-frequency =3D <0>;
                        interrupts =3D <10 0x8>;
                        interrupt-parent =3D <&ipic>;
                };

                crypto@30000 {
                        compatible =3D "fsl,sec2.0";
                        reg =3D <0x30000 0x10000>;
                        interrupts =3D <11 0x8>;
                        interrupt-parent =3D <&ipic>;
                        fsl,num-channels =3D <4>;
                        fsl,channel-fifo-len =3D <24>;
                        fsl,exec-units-mask =3D <0x7e>;
                        fsl,descriptor-types-mask =3D <0x01010ebf>;
                };

Thanks,
agnel

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org<mailto:Linuxppc-dev@lists.ozlabs.org>
https://lists.ozlabs.org/listinfo/linuxppc-dev


--_000_507B57E36B7C3A48BD1B90EFA80A782E5372EE795DGVW0433EXBame_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" xmlns:p=3D"urn:schemas-m=
icrosoft-com:office:powerpoint" xmlns:a=3D"urn:schemas-microsoft-com:office=
:access" xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:s=3D"=
uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882" xmlns:rs=3D"urn:schemas-microsof=
t-com:rowset" xmlns:z=3D"#RowsetSchema" xmlns:b=3D"urn:schemas-microsoft-co=
m:office:publisher" xmlns:ss=3D"urn:schemas-microsoft-com:office:spreadshee=
t" xmlns:c=3D"urn:schemas-microsoft-com:office:component:spreadsheet" xmlns=
:odc=3D"urn:schemas-microsoft-com:office:odc" xmlns:oa=3D"urn:schemas-micro=
soft-com:office:activation" xmlns:html=3D"http://www.w3.org/TR/REC-html40" =
xmlns:q=3D"http://schemas.xmlsoap.org/soap/envelope/" xmlns:rtc=3D"http://m=
icrosoft.com/officenet/conferencing" xmlns:D=3D"DAV:" xmlns:Repl=3D"http://=
schemas.microsoft.com/repl/" xmlns:mt=3D"http://schemas.microsoft.com/share=
point/soap/meetings/" xmlns:x2=3D"http://schemas.microsoft.com/office/excel=
/2003/xml" xmlns:ppda=3D"http://www.passport.com/NameSpace.xsd" xmlns:ois=
=3D"http://schemas.microsoft.com/sharepoint/soap/ois/" xmlns:dir=3D"http://=
schemas.microsoft.com/sharepoint/soap/directory/" xmlns:ds=3D"http://www.w3=
.org/2000/09/xmldsig#" xmlns:dsp=3D"http://schemas.microsoft.com/sharepoint=
/dsp" xmlns:udc=3D"http://schemas.microsoft.com/data/udc" xmlns:xsd=3D"http=
://www.w3.org/2001/XMLSchema" xmlns:sub=3D"http://schemas.microsoft.com/sha=
repoint/soap/2002/1/alerts/" xmlns:ec=3D"http://www.w3.org/2001/04/xmlenc#"=
 xmlns:sp=3D"http://schemas.microsoft.com/sharepoint/" xmlns:sps=3D"http://=
schemas.microsoft.com/sharepoint/soap/" xmlns:xsi=3D"http://www.w3.org/2001=
/XMLSchema-instance" xmlns:udcs=3D"http://schemas.microsoft.com/data/udc/so=
ap" xmlns:udcxf=3D"http://schemas.microsoft.com/data/udc/xmlfile" xmlns:udc=
p2p=3D"http://schemas.microsoft.com/data/udc/parttopart" xmlns:wf=3D"http:/=
/schemas.microsoft.com/sharepoint/soap/workflow/" xmlns:dsss=3D"http://sche=
mas.microsoft.com/office/2006/digsig-setup" xmlns:dssi=3D"http://schemas.mi=
crosoft.com/office/2006/digsig" xmlns:mdssi=3D"http://schemas.openxmlformat=
s.org/package/2006/digital-signature" xmlns:mver=3D"http://schemas.openxmlf=
ormats.org/markup-compatibility/2006" xmlns:m=3D"http://schemas.microsoft.c=
om/office/2004/12/omml" xmlns:mrels=3D"http://schemas.openxmlformats.org/pa=
ckage/2006/relationships" xmlns:spwp=3D"http://microsoft.com/sharepoint/web=
partpages" xmlns:ex12t=3D"http://schemas.microsoft.com/exchange/services/20=
06/types" xmlns:ex12m=3D"http://schemas.microsoft.com/exchange/services/200=
6/messages" xmlns:pptsl=3D"http://schemas.microsoft.com/sharepoint/soap/Sli=
deLibrary/" xmlns:spsl=3D"http://microsoft.com/webservices/SharePointPortal=
Server/PublishedLinksService" xmlns:Z=3D"urn:schemas-microsoft-com:" xmlns:=
st=3D"&#1;" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.gmailquote
	{mso-style-name:gmail_quote;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'>two things; I had better luck with the mpc8349mds (? don&#82=
17;t
remember exact file name) dts as opposed to the itx.&nbsp; I had to remove =
the bcsr
section or else the kernel hung during initialization .&nbsp; also, your u-=
boot is
not passing the correct kernel commandline:<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'>&#8220;</span>Kernel command line: root=3D/dev/nfs rw
nfsroot=3D192.168.200.230:/nfsroot/rootfs i0IPIC (128 IRQ sources) at fdffc=
700&#8221;<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>you&#8217;re trying to run a ramdisk and with tty I ex=
pect:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'>&#8220;root=3D/dev/ram rw console=3DttyS0,115200&nbsp; &#822=
0;<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'>check your environment variable bootargs in u-boot<o:p></o:p=
></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:11.0pt;font-family:"Calibri",=
"sans-serif";
color:#1F497D'><o:p>&nbsp;</o:p></span></p>

<div style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in'>

<p class=3DMsoNormal><b><span style=3D'font-size:10.0pt;font-family:"Tahoma=
","sans-serif"'>From:</span></b><span
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'> Junita Ajith
[mailto:ajijuni@gmail.com] <br>
<b>Sent:</b> Wednesday, December 09, 2009 10:58 AM<br>
<b>To:</b> Lee, Eric<br>
<b>Cc:</b> Linuxppc-dev@lists.ozlabs.org<br>
<b>Subject:</b> dts file for MPC8343EA - cuImage doesn't boot , but uImage =
with
DTS shows serial output<o:p></o:p></span></p>

</div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'>Hi Eric,<br>
<br>
I am building the linux kernel V-2.6.27&nbsp; based on MPC8349miTXGP dts fi=
le.<br>
I am still not able to boot the cuImage.<br>
<br>
But, I see serial outuput from kernel when I try to boot with &lt;kernel&gt=
;
&lt;ramdisk&gt; &lt;dtb file&gt;<br>
<br>
Still the kernel hangs after &quot;Dentry cache hash table entries: 32768
(order: 5, 131072 bytes)&quot;.<br>
<br>
Any clues ..?? We have DDR2 in this board and we are initializing it in U-B=
oot.
<br>
<br>
Please find the screen dump below:<br>
<br>
Thanks,<br>
Junita<br>
<br>
Screen shot:<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
u-boot&gt; bootm 0x2000000 0x3000000 0x4000000<br>
## Booting image at 02000000 ...<br>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.27.18-svn52-dirty8<br>
&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2009-12-08&nbsp; 23:49:=
28
UTC<br>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip
compressed)<br>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1416039 Bytes =3D&nbsp; 1.4 MB<br=
>
&nbsp;&nbsp; Load Address: 00000000<br>
&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>
&nbsp;&nbsp; Verifying Checksum ... OK<br>
&nbsp;&nbsp; Uncompressing Kernel Image ... OK<br>
## Current stack ends at 0x0FF9BD48 =3D&gt; set upper limit to 0x00800000<b=
r>
## cmdline at 0x007FFF00 ... 0x007FFFA6<br>
bd address&nbsp; =3D 0x0FF9BFC4<br>
memstart&nbsp;&nbsp;&nbsp; =3D 0x00000000<br>
memsize&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x10000000<br>
flashstart&nbsp; =3D 0xFE000000<br>
flashsize&nbsp;&nbsp; =3D 0x00080000<br>
flashoffset =3D 0x00034000<br>
sramstart&nbsp;&nbsp; =3D 0x00000000<br>
sramsize&nbsp;&nbsp;&nbsp; =3D 0x00000000<br>
bootflags&nbsp;&nbsp; =3D 0x00000001<br>
intfreq&nbsp;&nbsp;&nbsp;&nbsp; =3D 399.999 MHz<br>
busfreq&nbsp;&nbsp;&nbsp;&nbsp; =3D 266.666 MHz<br>
ethaddr&nbsp;&nbsp;&nbsp;&nbsp; =3D 00:E0:0C:00:8C:01<br>
IP addr&nbsp;&nbsp;&nbsp;&nbsp; =3D 192.168.201.199<br>
baudrate&nbsp;&nbsp;&nbsp; =3D 115200 bps<br>
Not skipping initrd<br>
## Loading RAMDisk Image at 03000000 ...<br>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; uboot ext2 ramdisk rootfs<br>
&nbsp;&nbsp; Created:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2009-10-30&nbsp; 20:15:=
22
UTC<br>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux RAMDisk Image (gzip
compressed)<br>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 3889103 Bytes =3D&nbsp; 3.7 MB<br=
>
&nbsp;&nbsp; Load Address: 00000000<br>
&nbsp;&nbsp; Entry Point:&nbsp; 00000000<br>
&nbsp;&nbsp; Verifying Checksum ... OK<br>
&nbsp;&nbsp; Booting using the fdt at 0x4000000<br>
## initrd at 0x03000040 ... 0x033B580E (len=3D3889103=3D0x3B57CF)<br>
&nbsp;&nbsp; Loading Ramdisk to 0fbe5000, end 0ff9a7cf ... OK<br>
## device tree at 0x04000000 ... 0x04002FFF (len=3D12288=3D0x3000)<br>
&nbsp;&nbsp; Loading Device Tree to 007fc000, end 007fefff ... OK<br>
Updating property '/soc8349@e0000000/ethernet@24000/mac-address' =3D&nbsp; =
00 e0
0c 001Updating property '/soc8349@e0000000/ethernet@24000/local-mac-address=
'
=3D&nbsp; 00 e01Updating property 'timebase-frequency' =3D&nbsp; 03 f9 40 a=
a<br>
Updating property 'bus-frequency' =3D&nbsp; 0f e5 02 a8<br>
Updating property 'clock-frequency' =3D&nbsp; 17 d7 83 fc<br>
Updating property 'bus-frequency' =3D&nbsp; 0f e5 02 a8<br>
Updating property 'clock-frequency' =3D&nbsp; 0f e5 02 a8<br>
## Transferring control to Linux (at address 00000000) ...<br>
Using MPC834x ITX machine description<br>
Linux version 2.6.27.18-svn52-dirty8 (root@localhost.localdomain) (gcc vers=
ion
9Found initrd at 0xcfbe5000:0xcff9a7cf<br>
console [udbg0] enabled<br>
setup_arch: bootmem<br>
mpc834x_itx_setup_arch()<br>
arch: exit<br>
Zone PFN ranges:<br>
&nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000 -&gt; 0x00010000<br>
&nbsp; Normal&nbsp;&nbsp; 0x00010000 -&gt; 0x00010000<br>
Movable zone start PFN for each node<br>
early_node_map[1] active PFN ranges<br>
&nbsp;&nbsp;&nbsp; 0: 0x00000000 -&gt; 0x00010000<br>
Built 1 zonelists in Zone order, mobility grouping on.&nbsp; Total pages: 6=
5024<br>
Kernel command line: root=3D/dev/nfs rw nfsroot=3D192.168.200.230:/nfsroot/=
rootfs
i0IPIC (128 IRQ sources) at fdffc700<br>
PID hash table entries: 1024 (order: 10, 4096 bytes)<br>
clocksource: timebase mult[3c00001] shift[22] registered<br>
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)<br>
<br>
<br>
<br>
<br>
<o:p></o:p></p>

<div>

<p class=3DMsoNormal><span class=3Dgmailquote>On 12/9/09, <b>Lee, Eric</b> =
&lt;<a
href=3D"mailto:eric.lee@hp.com">eric.lee@hp.com</a>&gt; wrote:</span><o:p><=
/o:p></p>

<p class=3DMsoNormal>I would probably remove the bcsr region.&nbsp;&nbsp;th=
is was
some cpld I believe on a reference board.&nbsp;&nbsp;with this dts it'll tr=
y to
write to some hardware registers that do not exist or are not mapped to the
same area.<br>
<br>
<br>
<br>
<br>
-----Original Message-----<br>
From: linuxppc-dev-bounces+eric.lee=3D<a href=3D"http://hp.com">hp.com</a>@=
<a
href=3D"http://lists.ozlabs.org">lists.ozlabs.org</a> [mailto:<a
href=3D"mailto:linuxppc-dev-bounces%2Beric.lee">linuxppc-dev-bounces+eric.l=
ee</a>=3D<a
href=3D"http://hp.com">hp.com</a>@<a href=3D"http://lists.ozlabs.org">lists=
.ozlabs.org</a>]
On Behalf Of <a href=3D"mailto:ajijuni@gmail.com">ajijuni@gmail.com</a><br>
Sent: Sunday, December 06, 2009 11:41 PM<br>
To: <a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozl=
abs.org</a><br>
Subject: dts file for MPC8343EA<br>
<br>
Hi<br>
<br>
We have an MPC8343EA based custom board.<br>
<br>
I am not able to get Linux up and running in this. No serial output to debu=
g
further.<br>
&nbsp;&nbsp;U-boot shows correct 'bdinfo' &amp; 'clocks' output.<br>
inux hangs at machine_probe.<br>
<br>
<br>
I doubt the DTS file in Linux. anyone has DTS file for MPC8343??<br>
<br>
u-boot version - 1.3.2<br>
linux-2.6.27<br>
The board base files are drived from MPC8349Imtx-GP since we have the refer=
ence
board in which we tested the linux image.<br>
<br>
My current DTS file<br>
/dts-v1/;<br>
<br>
/ {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;model =3D &quot;MPC8343&quo=
t;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;compatible =3D
&quot;MPC8349EMDS&quot;, &quot;MPC834xMDS&quot;, &quot;MPC83xxMDS&quot;;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;linux,phandle =3D &lt;0x100=
&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#size-cells =3D &lt;0x1&gt;=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#address-cells =3D &lt;0x1&=
gt;;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;aliases {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;ethernet0
=3D &amp;enet0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;ethernet1
=3D &amp;enet1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;serial0
=3D &amp;serial0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;serial1
=3D &amp;serial1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;pci0
=3D &amp;pci0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;pci1
=3D &amp;pci1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpus {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;linux,phandle
=3D &lt;0x200&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;#cpus
=3D &lt;0x1&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;#address-cells
=3D &lt;1&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;#size-cells
=3D &lt;0&gt;;<br>
<br>
&nbsp;&nbsp;PowerPC,8343EA@0 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;device=
_type
=3D &quot;cpu&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg
=3D &lt;0x0&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;d-cach=
e-line-size
=3D &lt;20&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i-cach=
e-line-size
=3D &lt;20&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;d-cach=
e-size
=3D &lt;8000&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i-cach=
e-size
=3D &lt;8000&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;timeba=
se-frequency
=3D &lt;0&gt;;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // from bootloader<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bus-fr=
equency
=3D
&lt;0&gt;;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;//
from bootloader<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;clock-=
frequency
=3D &lt;0&gt;;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/=
/ from
bootloader<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;32-bit=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;};<br>
<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;memory {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;device_type
=3D &quot;memory&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;reg
=3D &lt;0x00000000 0x10000000&gt;;&nbsp;&nbsp;// 256MB at 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;};<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bcsr@e2400000 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;device_type
=3D &quot;board-control&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;reg
=3D &lt;0xe2400000 0x8000&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;soc8343@e0000000 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;bus-frequency
=3D &lt;0x1&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;reg
=3D &lt;0xe0000000 0x200&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;ranges
=3D &lt;0x0 0xe0000000 0x100000&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;device_type
=3D &quot;soc&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;#interrupt-cells
=3D &lt;0x2&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;#size-cells
=3D &lt;0x1&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;#address-cells
=3D &lt;0x1&gt;;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;wdt@200
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;device=
_type
=3D &quot;watchdog&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;compat=
ible
=3D &quot;mpc83xx_wdt&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg
=3D &lt;0x200 0x100&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;};<br>
<br>
i2c@3000 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#addre=
ss-cells
=3D &lt;1&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#size-=
cells
=3D &lt;0&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cell-i=
ndex
=3D &lt;0&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;compat=
ible
=3D &quot;fsl-i2c&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg
=3D &lt;0x3000 0x100&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interr=
upts
=3D &lt;14 0x8&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interr=
upt-parent
=3D &lt;&amp;ipic&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dfsrr;=
<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rtc@68
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;compatible
=3D &quot;dallas,ds1374&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg
=3D &lt;0x68&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;};<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;i2c@3100
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#addre=
ss-cells
=3D &lt;1&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#size-=
cells
=3D &lt;0&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cell-i=
ndex
=3D &lt;1&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;compat=
ible
=3D &quot;fsl-i2c&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg
=3D &lt;0x3100 0x100&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interr=
upts
=3D &lt;15 0x8&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interr=
upt-parent
=3D &lt;&amp;ipic&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dfsrr;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;};<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;spi@7000
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cell-i=
ndex
=3D &lt;0&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;compat=
ible
=3D &quot;fsl,spi&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg
=3D &lt;0x7000 0x1000&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interr=
upts
=3D &lt;16 0x8&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interr=
upt-parent
=3D &lt;&amp;ipic&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;mode
=3D &quot;cpu&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;};<br>
<br>
dma@82a8 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#addre=
ss-cells
=3D &lt;1&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#size-=
cells
=3D &lt;1&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;compat=
ible
=3D &quot;fsl,mpc8349-dma&quot;, &quot;fsl,elo-dma&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg
=3D &lt;0x82a8 4&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ranges
=3D &lt;0 0x8100 0x1a8&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interr=
upt-parent
=3D &lt;&amp;ipic&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interr=
upts
=3D &lt;71 8&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cell-i=
ndex
=3D &lt;0&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dma-ch=
annel@0
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;compatible
=3D &quot;fsl,mpc8349-dma-channel&quot;, &quot;fsl,elo-dma-channel&quot;;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg
=3D &lt;0 0x80&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interrupt-parent
=3D &lt;&amp;ipic&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interrupts
=3D &lt;71 8&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dma-ch=
annel@80
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;compatible
=3D &quot;fsl,mpc8349-dma-channel&quot;, &quot;fsl,elo-dma-channel&quot;;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg
=3D &lt;0x80 0x80&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interrupt-parent
=3D &lt;&amp;ipic&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interrupts
=3D &lt;71 8&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dma-ch=
annel@100
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;compatible
=3D &quot;fsl,mpc8349-dma-channel&quot;, &quot;fsl,elo-dma-channel&quot;;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg
=3D &lt;0x100 0x80&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interrupt-parent
=3D &lt;&amp;ipic&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interrupts
=3D &lt;71 8&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dma-ch=
annel@180
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;compatible
=3D &quot;fsl,mpc8349-dma-channel&quot;, &quot;fsl,elo-dma-channel&quot;;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg
=3D &lt;0x180 0x28&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interrupt-parent
=3D &lt;&amp;ipic&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interrupts
=3D &lt;71 8&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;};<br>
/* phy type (ULPI or SERIAL) are only types supported for MPH */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;/*
port =3D 0 or 1 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;usb@22000
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;compat=
ible
=3D &quot;fsl-usb2-mph&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg
=3D &lt;0x22000 0x1000&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#addre=
ss-cells
=3D &lt;1&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#size-=
cells
=3D &lt;0&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interr=
upt-parent
=3D &lt;&amp;ipic&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interr=
upts
=3D &lt;39 0x8&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;phy_ty=
pe
=3D &quot;ulpi&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;port1;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;/*
phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;usb@23000
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;compat=
ible
=3D &quot;fsl-usb2-dr&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg
=3D &lt;0x23000 0x1000&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#addre=
ss-cells
=3D &lt;1&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#size-=
cells
=3D &lt;0&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interr=
upt-parent
=3D &lt;&amp;ipic&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interr=
upts
=3D &lt;38 0x8&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dr_mod=
e
=3D &quot;otg&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;phy_ty=
pe
=3D &quot;ulpi&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;};<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;mdio@24520
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#addre=
ss-cells
=3D &lt;1&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#size-=
cells
=3D &lt;0&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;compat=
ible
=3D &quot;fsl,gianfar-mdio&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg
=3D &lt;0x24520 0x20&gt;;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;phy0:
ethernet-phy@0 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interrupt-parent
=3D &lt;&amp;ipic&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interrupts
=3D &lt;17 0x8&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg
=3D &lt;0x0&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;device_type
=3D &quot;ethernet-phy&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;phy1:
ethernet-phy@1 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interrupt-parent
=3D &lt;&amp;ipic&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interrupts
=3D &lt;18 0x8&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg
=3D &lt;0x1&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;device_type
=3D &quot;ethernet-phy&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;};<br>
enet0: ethernet@24000 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cell-i=
ndex
=3D &lt;0&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;device=
_type
=3D &quot;network&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;model
=3D &quot;TSEC&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;compat=
ible
=3D &quot;gianfar&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg
=3D &lt;0x24000 0x1000&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;local-=
mac-address
=3D [ 00 00 00 00 00 00 ];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interr=
upts
=3D &lt;32 0x8 33 0x8 34 0x8&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interr=
upt-parent
=3D &lt;&amp;ipic&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;phy-ha=
ndle
=3D &lt;&amp;phy0&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;linux,=
network-index
=3D &lt;0&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;};<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;enet1:
ethernet@25000 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cell-i=
ndex
=3D &lt;1&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;device=
_type
=3D &quot;network&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;model
=3D &quot;TSEC&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;compat=
ible
=3D &quot;gianfar&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg
=3D &lt;0x25000 0x1000&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;local-=
mac-address
=3D [ 00 00 00 00 00 00 ];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interr=
upts
=3D &lt;35 0x8 36 0x8 37 0x8&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interr=
upt-parent
=3D &lt;&amp;ipic&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;phy-ha=
ndle
=3D &lt;&amp;phy1&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;linux,=
network-index
=3D &lt;1&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;};<br>
<br>
serial0: serial@4500 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cell-i=
ndex
=3D &lt;0&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;device=
_type
=3D &quot;serial&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;compat=
ible
=3D &quot;ns16550&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg
=3D &lt;0x4500 0x100&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;clock-=
frequency
=3D &lt;0&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interr=
upts
=3D &lt;9 0x8&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interr=
upt-parent
=3D &lt;&amp;ipic&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;};<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;serial1:
serial@4600 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cell-i=
ndex
=3D &lt;1&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;device=
_type
=3D &quot;serial&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;compat=
ible
=3D &quot;ns16550&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg
=3D &lt;0x4600 0x100&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;clock-=
frequency
=3D &lt;0&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interr=
upts
=3D &lt;10 0x8&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interr=
upt-parent
=3D &lt;&amp;ipic&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;};<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;crypto@30000
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;compat=
ible
=3D &quot;fsl,sec2.0&quot;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reg
=3D &lt;0x30000 0x10000&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interr=
upts
=3D &lt;11 0x8&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;interr=
upt-parent
=3D &lt;&amp;ipic&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fsl,nu=
m-channels
=3D &lt;4&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fsl,ch=
annel-fifo-len
=3D &lt;24&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fsl,ex=
ec-units-mask
=3D &lt;0x7e&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;fsl,de=
scriptor-types-mask
=3D &lt;0x01010ebf&gt;;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;};<br>
<br>
Thanks,<br>
agnel<br>
<br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.=
org</a><br>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lists.oz=
labs.org/listinfo/linuxppc-dev</a><o:p></o:p></p>

</div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

--_000_507B57E36B7C3A48BD1B90EFA80A782E5372EE795DGVW0433EXBame_--
