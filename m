Return-Path: <Farrukh_Arshad@mentor.com>
From: "Arshad, Farrukh" <Farrukh_Arshad@mentor.com>
To: "Linuxppc-dev@lists.ozlabs.org" <Linuxppc-dev@lists.ozlabs.org>
Subject: Multi-OS on P1022RDK Failing 
Date: Wed, 7 Dec 2011 14:57:18 +0000
Message-ID: <93CD5F41FDBC6042A6B449764F3B35CC050C38FB@EU-MBX-03.mgc.mentorg.com>
Content-Type: multipart/mixed;
 boundary="_005_93CD5F41FDBC6042A6B449764F3B35CC050C38FBEUMBX03mgcmento_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_005_93CD5F41FDBC6042A6B449764F3B35CC050C38FBEUMBX03mgcmento_
Content-Type: multipart/alternative;
	boundary="_000_93CD5F41FDBC6042A6B449764F3B35CC050C38FBEUMBX03mgcmento_"

--_000_93CD5F41FDBC6042A6B449764F3B35CC050C38FBEUMBX03mgcmento_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Greetings All,

I am trying to boot multi-OS on P1022RDK platform. As per my understating I=
 only need to partition peripherals in DTS file of both kernels and configu=
re memory start address of the kernel and load each kernel from uboot. No s=
pecific kernel configuration is required or any specific patch is required =
for this.

Given is my configuration

Core0: Linux kernel 1
Core1: Linux kernel 2

I compiled two different kernels with following configuration (rest is defa=
ult for P1022RDK comes in LTIB)

Core 0 kernel
CONFIG_LOWMEM_SIZE =3D 0x10000000
CONFIG_PHYSICAL_START =3D 0x00000000

Core 1 kernel
CONFIG_LOWMEM_SIZE =3D 0x10000000
CONFIG_PHYSICAL_START =3D 0x10000000

In the DTS file I have partitioned peripherals & cpu to each kernel. Cpu 0 =
to Core 0 kernel & cpu 1 to Core 1 kernel and compiled DTS file with -b 1 s=
witch of Core 1 DTB. My DTS files are attached. Given is my Uboot script wh=
ich I am using to boot both cores.

-------------- Uboot load script -----------------
# General environment setting
setenv consoledev0   ttyS0

# Set kernel loading environment
setenv core1kernelbase     0x00000000
setenv core0kernelbase     0x10000000
setenv kernelsize          0x10000000
setenv kerneloffset        0x1000000
setenv fdtoffset           0x00c00000

setexpr load0addr          $core0kernelbase + $kerneloffset
setexpr fdt0addr           $core0kernelbase + $fdtoffset
setexpr load1addr          $core1kernelbase + $kerneloffset
setexpr fdt1addr           $core1kernelbase + $fdtoffset

setenv core0kernel   uImage-custom-mel-p1022rdk-core0.bin
setenv core1kernel   uImage-custom-ltib-p1022rdk-core1.bin
setenv core0fdt      p1022rdk-core0.dtb
setenv core1fdt      p1022rdk-core1.dtb
setenv core0rootfs   /home/farshad/melfs/core0
setenv core1rootfs   /home/farshad/melfs/core1

# Boot from NFS
setenv core0nfsbootargs root=3D/dev/nfs nfsroot=3D$serverip:/$core0rootfs i=
p=3D<dev_ip>::<nfs_server_ip>:::eth0:off rw debug console=3D$consoledev0,$b=
audrate maxcpus=3D1
setenv core1nfsbootargs root=3D/dev/nfs nfsroot=3D$serverip:/$core1rootfs i=
p=3D<dev_ip_2>::<nfs_server_ip>:::eth0:off rw debug console=3D$consoledev0,=
$baudrate maxcpus=3D1

echo =3D=3D Transfer images on board =3D=3D
tftp $load0addr $core0kernel
tftp $fdt0addr  $core0fdt
tftp $load1addr $core1kernel
tftp $fdt1addr  $core1fdt

echo =3D=3D Start loading Core 1 with LTIB Kernel =3D=3D
setenv bootm_low $core1kernelbase
setenv bootm_size $kernelsize
setenv bootargs $core1nfsbootargs
interrupts off
bootm start $load1addr - $fdt1addr
bootm loados
bootm fdt
fdt boardsetup
fdt chosen
bootm prep
cpu 1 release $load1addr - $fdt1addr -

echo =3D=3D Start loading Core 0 with MEL Kernel =3D=3D
setenv bootargs $core0nfsbootargs
setenv bootm_low $core0kernelbase
setenv bootm_size $kernelsize
bootm $load0addr - $fdt0addr
-------------- Uboot load script ends -----------------


My problem is Core 0 kernel is booting successfully but Core 1 kernel hangs=
 after uncompressing kernel image, and after that I don't see anything on t=
he console.

Any thoughts on what I am missing or doing incorrect?

Best Regards

Farrukh Arshad
Sr. Software Development Engineer
Mentor Graphics Pakistan
Ph:   +92 - 423 - 609 - 92 - 09
Cell: +92 - 303 - 444 - 77 - 05


--_000_93CD5F41FDBC6042A6B449764F3B35CC050C38FBEUMBX03mgcmento_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Felix Titling";
	panose-1:4 6 5 5 6 2 2 2 10 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Greetings All,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am trying to boot multi-OS on P1022RDK platform. A=
s per my understating I only need to partition peripherals in DTS file of b=
oth kernels and configure memory start address of the kernel and load each =
kernel from uboot. No specific kernel
 configuration is required or any specific patch is required for this. <o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Given is my configuration<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Core0: Linux kernel 1<o:p></o:p></p>
<p class=3D"MsoNormal">Core1: Linux kernel 2<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I compiled two different kernels with following conf=
iguration (rest is default for P1022RDK comes in LTIB)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Core 0 kernel<o:p></o:p></p>
<p class=3D"MsoNormal">CONFIG_LOWMEM_SIZE =3D 0x10000000<o:p></o:p></p>
<p class=3D"MsoNormal">CONFIG_PHYSICAL_START =3D 0x00000000<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Core 1 kernel<o:p></o:p></p>
<p class=3D"MsoNormal">CONFIG_LOWMEM_SIZE =3D 0x10000000<o:p></o:p></p>
<p class=3D"MsoNormal">CONFIG_PHYSICAL_START =3D 0x10000000<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">In the DTS file I have partitioned peripherals &amp;=
 cpu to each kernel. Cpu 0 to Core 0 kernel &amp; cpu 1 to Core 1 kernel an=
d compiled DTS file with &#8211;b 1 switch of Core 1 DTB. My DTS files are =
attached. Given is my Uboot script which I am using
 to boot both cores.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-------------- Uboot load script -----------------<o=
:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
# General environment setting<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
setenv consoledev0&nbsp;&nbsp; ttyS0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
<o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
# Set kernel loading environment<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
setenv core1kernelbase&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
setenv core0kernelbase&nbsp;&nbsp;&nbsp;&nbsp; 0x10000000<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
setenv kernelsize&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1=
0000000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
setenv kerneloffset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1000000<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
setenv fdtoffset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0x00c00000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
<o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
setexpr load0addr &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $core0ke=
rnelbase &#43; $kerneloffset&nbsp;&nbsp;&nbsp;&nbsp;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
setexpr fdt0addr&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $co=
re0kernelbase &#43; $fdtoffset<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
setexpr load1addr &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $core1ke=
rnelbase &#43; $kerneloffset<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
setexpr fdt1addr&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $co=
re1kernelbase &#43; $fdtoffset<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
<o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
setenv core0kernel &nbsp; uImage-custom-mel-p1022rdk-core0.bin<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
setenv core1kernel&nbsp;&nbsp; uImage-custom-ltib-p1022rdk-core1.bin<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
setenv core0fdt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p1022rdk-core0.dtb<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
setenv core1fdt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p1022rdk-core1.dtb<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
setenv core0rootfs&nbsp;&nbsp; /home/farshad/melfs/core0<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
setenv core1rootfs&nbsp;&nbsp; /home/farshad/melfs/core1<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
<o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
# Boot from NFS<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
setenv core0nfsbootargs root=3D/dev/nfs nfsroot=3D$serverip:/$core0rootfs i=
p=3D&lt;dev_ip&gt;::&lt;nfs_server_ip&gt;:::eth0:off rw debug console=3D$co=
nsoledev0,$baudrate maxcpus=3D1
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
setenv core1nfsbootargs root=3D/dev/nfs nfsroot=3D$serverip:/$core1rootfs i=
p=3D&lt;dev_ip_2&gt;::&lt;nfs_server_ip&gt;:::eth0:off rw debug console=3D$=
consoledev0,$baudrate maxcpus=3D1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
<o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
echo =3D=3D Transfer images on board =3D=3D<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
tftp $load0addr $core0kernel<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
tftp $fdt0addr&nbsp; $core0fdt<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
tftp $load1addr $core1kernel<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
tftp $fdt1addr&nbsp; $core1fdt<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
<o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
echo =3D=3D Start loading Core 1 with LTIB Kernel =3D=3D<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
setenv bootm_low $core1kernelbase<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
setenv bootm_size $kernelsize<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
setenv bootargs $core1nfsbootargs<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
interrupts off<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
bootm start $load1addr - $fdt1addr<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
bootm loados<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
bootm fdt<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
fdt boardsetup<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
fdt chosen<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
bootm prep<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
cpu 1 release $load1addr - $fdt1addr -<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
<o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
echo =3D=3D Start loading Core 0 with MEL Kernel =3D=3D<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
setenv bootargs $core0nfsbootargs<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
setenv bootm_low $core0kernelbase<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
setenv bootm_size $kernelsize<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
bootm $load0addr - $fdt0addr<o:p></o:p></span></p>
<p class=3D"MsoNormal">-------------- Uboot load script ends --------------=
---<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">My problem is Core 0 kernel is booting successfully =
but Core 1 kernel hangs after uncompressing kernel image, and after that I =
don&#8217;t see anything on the console.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Any thoughts on what I am missing or doing incorrect=
?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best Regards<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Felix Titling&quot;;color:#943634">Farrukh</span></b><b><span style=3D"fon=
t-size:10.0pt;font-family:&quot;Felix Titling&quot;"> Arshad<o:p></o:p></sp=
an></b></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">Sr. Software Development Engineer<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">Mentor Graphics Pakistan<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">Ph:&nbsp;&nbsp; &#43;92 &#8211; 423 &#8211; 609 &#8211; 92=
 - 09<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">Cell: &#43;92 &#8211; 303 &#8211; 444 &#8211; 77 &#8211; 0=
5<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_93CD5F41FDBC6042A6B449764F3B35CC050C38FBEUMBX03mgcmento_--

--_005_93CD5F41FDBC6042A6B449764F3B35CC050C38FBEUMBX03mgcmento_
Content-Type: application/octet-stream; name="p1022rdk-core0.dts"
Content-Description: p1022rdk-core0.dts
Content-Disposition: attachment; filename="p1022rdk-core0.dts"; size=15610;
	creation-date="Wed, 07 Dec 2011 01:41:54 GMT";
	modification-date="Wed, 07 Dec 2011 01:41:54 GMT"
Content-Transfer-Encoding: base64

LyoKICogUDEwMjIgUkRLIC0gQ29yZSAwIERldmljZSBUcmVlIFNvdXJjZQogKgogKi8KCi9kdHMt
djEvOwovIHsKCW1vZGVsID0gImZzbCxQMTAyMiI7Cgljb21wYXRpYmxlID0gImZzbCxQMTAyMkRT
IjsKCSNhZGRyZXNzLWNlbGxzID0gPDI+OwoJI3NpemUtY2VsbHMgPSA8Mj47CgoJYWxpYXNlcyB7
CgkJZXRoZXJuZXQwID0gJmVuZXQwOwoJCXNlcmlhbDAgPSAmc2VyaWFsMTsKCQltc2dyLWJsb2Nr
MCA9ICZtc2dyX2Jsb2NrMDsKCX07CgoJY3B1cyB7CgkJI2FkZHJlc3MtY2VsbHMgPSA8MT47CgkJ
I3NpemUtY2VsbHMgPSA8MD47CgoJCVBvd2VyUEMsUDEwMjJAMCB7CgkJCWRldmljZV90eXBlID0g
ImNwdSI7CgkJCXJlZyA9IDwweDA+OwoJCQluZXh0LWxldmVsLWNhY2hlID0gPCZMMj47CgkJfTsK
CX07CgoJbWVtb3J5IHsKCQlkZXZpY2VfdHlwZSA9ICJtZW1vcnkiOwoJfTsKCgltY29tbSB7CgkJ
Y29tcGF0aWJsZSA9ICJtZW50LG1jb21tIjsKCQkvL3JlZyA9IDwwIDB4NzAwMDAwMDAgMCAweDEw
MDAwMDAwPjsKCQkvL3JlZyA9IDwwIDB4MTgwMDAwMDAgMCAweDA4MDAwMDAwMD47CgkJcmVnID0g
PDAgMHgxODAwMDAwMCAwIDB4MDA4MDAwMDAwPjsKCQlub3RpZmljYXRpb25zID0gPAoJCQkxIDEJ
Ly8gQ29yZSAxLCBNc2cgUmVnIDEKCQkJMCAwCS8vIENvcmUgMCwgTXNnIFJlZyAwCgkJPjsKCX07
CgoJLy9sb2NhbGJ1c0BmZmUwNTAwMCB7CgkvLwkjYWRkcmVzcy1jZWxscyA9IDwyPjsKCS8vCSNz
aXplLWNlbGxzID0gPDE+OwoJLy8JY29tcGF0aWJsZSA9ICJmc2wscDEwMjItZWxiYyIsICJmc2ws
ZWxiYyIsICJzaW1wbGUtYnVzIjsKCS8vCXJlZyA9IDwwIDB4ZmZlMDUwMDAgMCAweDEwMDA+OwoJ
Ly8JaW50ZXJydXB0cyA9IDwxOSAyPjsKCS8vCWludGVycnVwdC1wYXJlbnQgPSA8Jm1waWM+OwoK
CS8vCXJhbmdlcyA9IDwweDAgMHgwIDB4MCAweGU4MDAwMDAwIDB4MDgwMDAwMDAKCS8vCQkgIDB4
MSAweDAgMHgwIDB4ZTAwMDAwMDAgMHgwODAwMDAwMAoJLy8JCSAgMHgyIDB4MCAweDAgMHhmZmEw
MDAwMCAweDAwMDQwMDAwCgkvLwkJICAweDMgMHgwIDB4MCAweGZmZGYwMDAwIDB4MDAwMDgwMDA+
OwoKCS8vCW5vckAwLDAgewoJLy8JCSNhZGRyZXNzLWNlbGxzID0gPDE+OwoJLy8JCSNzaXplLWNl
bGxzID0gPDE+OwoJLy8JCWNvbXBhdGlibGUgPSAiY2ZpLWZsYXNoIjsKCS8vCQlyZWcgPSA8MHgw
IDB4MCAweDgwMDAwMDA+OwoJLy8JCWJhbmstd2lkdGggPSA8Mj47CgkvLwkJZGV2aWNlLXdpZHRo
ID0gPDE+OwoKCS8vCQlwYXJ0aXRpb25AMCB7CgkvLwkJCXJlZyA9IDwweDAgMHgwMzAwMDAwMD47
CgkvLwkJCWxhYmVsID0gInJhbWRpc2stbm9yIjsKCS8vCQkJcmVhZC1vbmx5OwoJLy8JCX07CgoJ
Ly8JCXBhcnRpdGlvbkAzMDAwMDAwIHsKCS8vCQkJcmVnID0gPDB4MDMwMDAwMDAgMHgwMGUwMDAw
MD47CgkvLwkJCWxhYmVsID0gImRpYWdub3N0aWMtbm9yIjsKCS8vCQkJcmVhZC1vbmx5OwoJLy8J
CX07CgoJLy8JCXBhcnRpdGlvbkAzZTAwMDAwIHsKCS8vCQkJcmVnID0gPDB4MDNlMDAwMDAgMHgw
MDIwMDAwMD47CgkvLwkJCWxhYmVsID0gImRpbmstbm9yIjsKCS8vCQkJcmVhZC1vbmx5OwoJLy8J
CX07CgoJLy8JCXBhcnRpdGlvbkA0MDAwMDAwIHsKCS8vCQkJcmVnID0gPDB4MDQwMDAwMDAgMHgw
MDQwMDAwMD47CgkvLwkJCWxhYmVsID0gImtlcm5lbC1ub3IiOwoJLy8JCQlyZWFkLW9ubHk7Cgkv
LwkJfTsKCgkvLwkJcGFydGl0aW9uQDQ0MDAwMDAgewoJLy8JCQlyZWcgPSA8MHgwNDQwMDAwMCAw
eDAzYjAwMDAwPjsKCS8vCQkJbGFiZWwgPSAiamZmczItbm9yIjsKCS8vCQl9OwoKCS8vCQlwYXJ0
aXRpb25AN2YwMDAwMCB7CgkvLwkJCXJlZyA9IDwweDA3ZjAwMDAwIDB4MDAwODAwMDA+OwoJLy8J
CQlsYWJlbCA9ICJkdGItbm9yIjsKCS8vCQkJcmVhZC1vbmx5OwoJLy8JCX07CgoJLy8JCXBhcnRp
dGlvbkA3ZjgwMDAwIHsKCS8vCQkJcmVnID0gPDB4MDdmODAwMDAgMHgwMDA4MDAwMD47CgkvLwkJ
CWxhYmVsID0gInUtYm9vdC1ub3IiOwoJLy8JCQlyZWFkLW9ubHk7CgkvLwkJfTsKCS8vCX07CgoJ
Ly8JbmFuZEAyLDAgewoJLy8JCSNhZGRyZXNzLWNlbGxzID0gPDE+OwoJLy8JCSNzaXplLWNlbGxz
ID0gPDE+OwoJLy8JCWNvbXBhdGlibGUgPSAiZnNsLGVsYmMtZmNtLW5hbmQiOwoJLy8JCXJlZyA9
IDwweDIgMHgwIDB4NDAwMDA+OwoKCS8vCQlwYXJ0aXRpb25AMCB7CgkvLwkJCXJlZyA9IDwweDAg
MHgwMjAwMDAwMD47CgkvLwkJCWxhYmVsID0gInUtYm9vdC1uYW5kIjsKCS8vCQkJcmVhZC1vbmx5
OwoJLy8JCX07CgoJLy8JCXBhcnRpdGlvbkAyMDAwMDAwIHsKCS8vCQkJcmVnID0gPDB4MDIwMDAw
MDAgMHgxMDAwMDAwMD47CgkvLwkJCWxhYmVsID0gImpmZnMyLW5hbmQiOwoJLy8JCX07CgoJLy8J
CXBhcnRpdGlvbkAxMjAwMDAwMCB7CgkvLwkJCXJlZyA9IDwweDEyMDAwMDAwIDB4MTAwMDAwMDA+
OwoJLy8JCQlsYWJlbCA9ICJyYW1kaXNrLW5hbmQiOwoJLy8JCQlyZWFkLW9ubHk7CgkvLwkJfTsK
CgkvLwkJcGFydGl0aW9uQDIyMDAwMDAwIHsKCS8vCQkJcmVnID0gPDB4MjIwMDAwMDAgMHgwNDAw
MDAwMD47CgkvLwkJCWxhYmVsID0gImtlcm5lbC1uYW5kIjsKCS8vCQl9OwoKCS8vCQlwYXJ0aXRp
b25AMjYwMDAwMDAgewoJLy8JCQlyZWcgPSA8MHgyNjAwMDAwMCAweDAxMDAwMDAwPjsKCS8vCQkJ
bGFiZWwgPSAiZHRiLW5hbmQiOwoJLy8JCQlyZWFkLW9ubHk7CgkvLwkJfTsKCgkvLwkJcGFydGl0
aW9uQDI3MDAwMDAwIHsKCS8vCQkJcmVnID0gPDB4MjcwMDAwMDAgMHgxOTAwMDAwMD47CgkvLwkJ
CWxhYmVsID0gInJlc2VydmVkLW5hbmQiOwoJLy8JCX07CgkvLwl9OwoJLy99OwoKCXNvY0BmZmUw
MDAwMCB7CgkJI2FkZHJlc3MtY2VsbHMgPSA8MT47CgkJI3NpemUtY2VsbHMgPSA8MT47CgkJZGV2
aWNlX3R5cGUgPSAic29jIjsKCQljb21wYXRpYmxlID0gImZzbCxwMTAyMi1pbW1yIiwgInNpbXBs
ZS1idXMiOwoJCXJhbmdlcyA9IDwweDAgMCAweGZmZTAwMDAwIDB4MTAwMDAwPjsKCQlidXMtZnJl
cXVlbmN5ID0gPDA+OwkJLy8gRmlsbGVkIG91dCBieSB1Ym9vdC4KCgkJLy9lY20tbGF3QDAgewoJ
CS8vCWNvbXBhdGlibGUgPSAiZnNsLGVjbS1sYXciOwoJCS8vCXJlZyA9IDwweDAgMHgxMDAwPjsK
CQkvLwlmc2wsbnVtLWxhd3MgPSA8MTI+OwoJCS8vfTsKCgkJLy9lY21AMTAwMCB7CgkJLy8JY29t
cGF0aWJsZSA9ICJmc2wscDEwMjItZWNtIiwgImZzbCxlY20iOwoJCS8vCXJlZyA9IDwweDEwMDAg
MHgxMDAwPjsKCQkvLwlpbnRlcnJ1cHRzID0gPDE2IDI+OwoJCS8vCWludGVycnVwdC1wYXJlbnQg
PSA8Jm1waWM+OwoJCS8vfTsKCgkJLy9tZW1vcnktY29udHJvbGxlckAyMDAwIHsKCQkvLwljb21w
YXRpYmxlID0gImZzbCxwMTAyMi1tZW1vcnktY29udHJvbGxlciI7CgkJLy8JcmVnID0gPDB4MjAw
MCAweDEwMDA+OwoJCS8vCWludGVycnVwdC1wYXJlbnQgPSA8Jm1waWM+OwoJCS8vCWludGVycnVw
dHMgPSA8MTYgMj47CgkJLy99OwoKCQkvL2kyY0AzMDAwIHsKCQkvLwkjYWRkcmVzcy1jZWxscyA9
IDwxPjsKCQkvLwkjc2l6ZS1jZWxscyA9IDwwPjsKCQkvLwljZWxsLWluZGV4ID0gPDA+OwoJCS8v
CWNvbXBhdGlibGUgPSAiZnNsLWkyYyI7CgkJLy8JcmVnID0gPDB4MzAwMCAweDEwMD47CgkJLy8J
aW50ZXJydXB0cyA9IDw0MyAyPjsKCQkvLwlpbnRlcnJ1cHQtcGFyZW50ID0gPCZtcGljPjsKCQkv
LwlkZnNycjsKCQkvL307CgoJCS8vc3NpQDE1MDAwIHsKCQkvLwljb21wYXRpYmxlID0gImZzbCxw
MTAyMi1zc2kiOwoJCS8vCWNlbGwtaW5kZXggPSA8MD47CgkJLy8JcmVnID0gPDB4MTUwMDAgMHgx
MDA+OwoJCS8vCWludGVycnVwdC1wYXJlbnQgPSA8Jm1waWM+OwoJCS8vCWludGVycnVwdHMgPSA8
NzUgMj47CgkJLy8JZnNsLG1vZGUgPSAiaTJzLXNsYXZlIjsKCQkvLwljb2RlYy1oYW5kbGUgPSA8
JndtODc3Nj47CgkJLy8JZnNsLHBsYXliYWNrLWRtYSA9IDwmZG1hMDA+OwoJCS8vCWZzbCxjYXB0
dXJlLWRtYSA9IDwmZG1hMDE+OwoJCS8vCWZzbCxmaWZvLWRlcHRoID0gPDE1PjsKCQkvLwlmc2ws
c3NpLWFzeW5jaHJvbm91cyA9IDwxPjsKCQkvL307CgoJCS8vaTJjQDMxMDAgewoJCS8vCSNhZGRy
ZXNzLWNlbGxzID0gPDE+OwoJCS8vCSNzaXplLWNlbGxzID0gPDA+OwoJCS8vCWNlbGwtaW5kZXgg
PSA8MT47CgkJLy8JY29tcGF0aWJsZSA9ICJmc2wtaTJjIjsKCQkvLwlyZWcgPSA8MHgzMTAwIDB4
MTAwPjsKCQkvLwlpbnRlcnJ1cHRzID0gPDQzIDI+OwoJCS8vCWludGVycnVwdC1wYXJlbnQgPSA8
Jm1waWM+OwoJCS8vCWRmc3JyOwoJCS8vCXJ0Y0A2OHsKCQkvLwkJY29tcGF0aWJsZSA9ICJkYWxs
YXMsZHMzMjMyIjsKCQkvLwkJcmVnID0gPDB4Njg+OwoJCS8vCQlpbnRlcnJ1cHRzID0gPDE2IDB4
Mj47CgkJLy8JCWludGVycnVwdC1wYXJlbnQgPSA8Jm1waWM+OwoJCS8vCX07CgkJLy8JYWR0NzQ2
MUA0Y3sKCQkvLwkJY29tcGF0aWJsZSA9ICJhZGksYWR0NzQ2MSI7CgkJLy8JCXJlZyA9IDwweDRj
PjsKCQkvLwl9OwoJCS8vCXpsNjEwMEAyMXsKCQkvLwkJY29tcGF0aWJsZSA9ICJpbnRlcnNpbCx6
bDYxMDAiOwoJCS8vCQlyZWcgPSA8MHgyMT47CgkJLy8JfTsKCQkvLwl6bDYxMDBAMjR7CgkJLy8J
CWNvbXBhdGlibGUgPSAiaW50ZXJzaWwsemw2MTAwIjsKCQkvLwkJcmVnID0gPDB4MjQ+OwoJCS8v
CX07CgkJLy8Jemw2MTAwQDI2ewoJCS8vCQljb21wYXRpYmxlID0gImludGVyc2lsLHpsNjEwMCI7
CgkJLy8JCXJlZyA9IDwweDI2PjsKCQkvLwl9OwoJCS8vCXpsNjEwMEAyOXsKCQkvLwkJY29tcGF0
aWJsZSA9ICJpbnRlcnNpbCx6bDYxMDAiOwoJCS8vCQlyZWcgPSA8MHgyOT47CgkJLy8JfTsKCQkv
Lwl3bTg3NzY6Y29kZWNAMWEgewoJCS8vCQljb21wYXRpYmxlID0gIndvbGZzb24sd204Nzc2IjsK
CQkvLwkJcmVnID0gPDB4MWE+OwoJCS8vCQljbG9jay1mcmVxdWVuY3kgPSA8MHhiYjgwMDA+OwoJ
CS8vCX07CgkJLy99OwoKCQkvL3NlcmlhbDA6IHNlcmlhbEA0NTAwIHsKCQkvLwljZWxsLWluZGV4
ID0gPDA+OwoJCS8vCWRldmljZV90eXBlID0gInNlcmlhbCI7CgkJLy8JY29tcGF0aWJsZSA9ICJu
czE2NTUwIjsKCQkvLwlyZWcgPSA8MHg0NTAwIDB4MTAwPjsKCQkvLwljbG9jay1mcmVxdWVuY3kg
PSA8MD47CgkJLy8JaW50ZXJydXB0cyA9IDw0MiAyPjsKCQkvLwlpbnRlcnJ1cHQtcGFyZW50ID0g
PCZtcGljPjsKCQkvL307CgoJCXNlcmlhbDE6IHNlcmlhbEA0NjAwIHsKCQkJY2VsbC1pbmRleCA9
IDwxPjsKCQkJZGV2aWNlLXR5cGUgPSAic2VyaWFsIjsKCQkJY29tcGF0aWJsZSA9ICJuczE2NTUw
IjsKCQkJcmVnID0gPDB4NDYwMCAweDEwMD47CgkJCWNsb2NrLWZyZXF1ZW5jeSA9IDwwPjsKCQkJ
aW50ZXJydXB0cyA9IDw0MiAyPjsKCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmbXBpYz47CgkJfTsK
CgkJLy9zcGlANzAwMCB7CgkJLy8JY2VsbC1pbmRleCA9IDwwPjsKCQkvLwkjYWRkcmVzcy1jZWxs
cyA9IDwxPjsKCQkvLwkjc2l6ZS1jZWxscyA9IDwwPjsKCQkvLwljb21wYXRpYmxlID0gImZzbCxl
c3BpIjsKCQkvLwlyZWcgPSA8MHg3MDAwIDB4MTAwMD47CgkJLy8JaW50ZXJydXB0cyA9IDw1OSAw
eDI+OwoJCS8vCWludGVycnVwdC1wYXJlbnQgPSA8Jm1waWM+OwoJCS8vCWVzcGksbnVtLXNzLWJp
dHMgPSA8ND47CgkJLy8JbW9kZSA9ICJjcHUiOwoKCQkvLwlmc2xfbTI1cDgwQDAgewoJCS8vCQkj
YWRkcmVzcy1jZWxscyA9IDwxPjsKCQkvLwkJI3NpemUtY2VsbHMgPSA8MT47CgkJLy8JCWNvbXBh
dGlibGUgPSAiZnNsLGVzcGktZmxhc2giOwoJCS8vCQlyZWcgPSA8MD47CgkJLy8JCWxpbnV4LG1v
ZGFsaWFzID0gImZzbF9tMjVwODAiOwoJCS8vCQlzcGktbWF4LWZyZXF1ZW5jeSA9IDw0MDAwMDAw
MD47IC8qIGlucHV0IGNsb2NrICovCgkJLy8JCXBhcnRpdGlvbkAwIHsKCQkvLwkJCWxhYmVsID0g
InUtYm9vdC1zcGkiOwoJCS8vCQkJcmVnID0gPDB4MDAwMDAwMDAgMHgwMDEwMDAwMD47CgkJLy8J
CQlyZWFkLW9ubHk7CgkJLy8JCX07CgkJLy8JCXBhcnRpdGlvbkAxMDAwMDAgewoJCS8vCQkJbGFi
ZWwgPSAia2VybmVsLXNwaSI7CgkJLy8JCQlyZWcgPSA8MHgwMDEwMDAwMCAweDAwNTAwMDAwPjsK
CQkvLwkJCXJlYWQtb25seTsKCQkvLwkJfTsKCQkvLwkJcGFydGl0aW9uQDYwMDAwMCB7CgkJLy8J
CQlsYWJlbCA9ICJkdGItc3BpIjsKCQkvLwkJCXJlZyA9IDwweDAwNjAwMDAwIDB4MDAxMDAwMDA+
OwoJCS8vCQkJcmVhZC1vbmx5OwoJCS8vCQl9OwoJCS8vCQlwYXJ0aXRpb25ANzAwMDAwIHsKCQkv
LwkJCWxhYmVsID0gImZpbGUgc3lzdGVtLXNwaSI7CgkJLy8JCQlyZWcgPSA8MHgwMDcwMDAwMCAw
eDAwOTAwMDAwPjsKCQkvLwkJfTsKCQkvLwl9OwoJCS8vfTsKCgkJLy9ncGlvOiBncGlvLWNvbnRy
b2xsZXJAZjAwMCB7CgkJLy8JI2dwaW8tY2VsbHMgPSA8Mj47CgkJLy8JY29tcGF0aWJsZSA9ICJm
c2wsbXBjODU3Mi1ncGlvIjsKCQkvLwlyZWcgPSA8MHhmMDAwIDB4MTAwPjsKCQkvLwlpbnRlcnJ1
cHRzID0gPDQ3IDB4Mj47CgkJLy8JaW50ZXJydXB0LXBhcmVudCA9IDwmbXBpYz47CgkJLy8JZ3Bp
by1jb250cm9sbGVyOwoJCS8vfTsKCgkJTDI6IGwyLWNhY2hlLWNvbnRyb2xsZXJAMjAwMDAgewoJ
CQljb21wYXRpYmxlID0gImZzbCxwMTAyMi1sMi1jYWNoZS1jb250cm9sbGVyIjsKCQkJcmVnID0g
PDB4MjAwMDAgMHgxMDAwPjsKCQkJY2FjaGUtbGluZS1zaXplID0gPDMyPjsJLy8gMzIgYnl0ZXMK
CQkJY2FjaGUtc2l6ZSA9IDwweDQwMDAwPjsgLy8gTDIsIDI1NksKCQkJaW50ZXJydXB0LXBhcmVu
dCA9IDwmbXBpYz47CgkJCWludGVycnVwdHMgPSA8MTYgMj47CgkJfTsKCgkJLy9kbWFAMjEzMDAg
ewoJCS8vCSNhZGRyZXNzLWNlbGxzID0gPDE+OwoJCS8vCSNzaXplLWNlbGxzID0gPDE+OwoJCS8v
CWNvbXBhdGlibGUgPSAiZnNsLGVsb3BsdXMtZG1hIjsKCQkvLwlyZWcgPSA8MHgyMTMwMCAweDQ+
OwoJCS8vCXJhbmdlcyA9IDwweDAgMHgyMTEwMCAweDIwMD47CgkJLy8JY2VsbC1pbmRleCA9IDww
PjsKCQkvLwlkbWEwMDogZG1hLWNoYW5uZWxAMCB7CgkJLy8JCWNvbXBhdGlibGUgPSAiZnNsLHNz
aS1kbWEtY2hhbm5lbCI7CgkJLy8JCXJlZyA9IDwweDAgMHg4MD47CgkJLy8JCWNlbGwtaW5kZXgg
PSA8MD47CgkJLy8JCWludGVycnVwdC1wYXJlbnQgPSA8Jm1waWM+OwoJCS8vCQlpbnRlcnJ1cHRz
ID0gPDIwIDI+OwoJCS8vCX07CgkJLy8JZG1hMDE6IGRtYS1jaGFubmVsQDgwIHsKCQkvLwkJY29t
cGF0aWJsZSA9ICJmc2wsc3NpLWRtYS1jaGFubmVsIjsKCQkvLwkJcmVnID0gPDB4ODAgMHg4MD47
CgkJLy8JCWNlbGwtaW5kZXggPSA8MT47CgkJLy8JCWludGVycnVwdC1wYXJlbnQgPSA8Jm1waWM+
OwoJCS8vCQlpbnRlcnJ1cHRzID0gPDIxIDI+OwoJCS8vCX07CgkJLy8JZG1hLWNoYW5uZWxAMTAw
IHsKCQkvLwkJY29tcGF0aWJsZSA9ICJmc2wsZWxvcGx1cy1kbWEtY2hhbm5lbCI7CgkJLy8JCXJl
ZyA9IDwweDEwMCAweDgwPjsKCQkvLwkJY2VsbC1pbmRleCA9IDwyPjsKCQkvLwkJaW50ZXJydXB0
LXBhcmVudCA9IDwmbXBpYz47CgkJLy8JCWludGVycnVwdHMgPSA8MjIgMj47CgkJLy8JfTsKCQkv
LwlkbWEtY2hhbm5lbEAxODAgewoJCS8vCQljb21wYXRpYmxlID0gImZzbCxlbG9wbHVzLWRtYS1j
aGFubmVsIjsKCQkvLwkJcmVnID0gPDB4MTgwIDB4ODA+OwoJCS8vCQljZWxsLWluZGV4ID0gPDM+
OwoJCS8vCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZtcGljPjsKCQkvLwkJaW50ZXJydXB0cyA9IDwy
MyAyPjsKCQkvLwl9OwoJCS8vfTsKCgkJLy91c2JAMjIwMDAgewoJCS8vCSNhZGRyZXNzLWNlbGxz
ID0gPDE+OwoJCS8vCSNzaXplLWNlbGxzID0gPDA+OwoJCS8vCWNvbXBhdGlibGUgPSAiZnNsLXVz
YjItZHIiOwoJCS8vCXJlZyA9IDwweDIyMDAwIDB4MTAwMD47CgkJLy8JaW50ZXJydXB0LXBhcmVu
dCA9IDwmbXBpYz47CgkJLy8JaW50ZXJydXB0cyA9IDwyOCAweDI+OwoJCS8vCXBoeV90eXBlID0g
InVscGkiOwoJCS8vfTsKCgkJbWRpb0AyNDAwMCB7CgkJCSNhZGRyZXNzLWNlbGxzID0gPDE+OwoJ
CQkjc2l6ZS1jZWxscyA9IDwwPjsKCQkJY29tcGF0aWJsZSA9ICJmc2wsZXRzZWMyLW1kaW8iOwoJ
CQlyZWcgPSA8MHgyNDAwMCAweDEwMDAgMHhiMDAzMCAweDQ+OwoKCQkJcGh5MDogZXRoZXJuZXQt
cGh5QDAgewoJCQkJaW50ZXJydXB0cyA9IDwzIDE+OwoJCQkJcmVnID0gPDB4MT47CgkJCX07CgkJ
CS8vcGh5MTogZXRoZXJuZXQtcGh5QDEgewoJCQkvLwlpbnRlcnJ1cHRzID0gPDkgMT47CgkJCS8v
CXJlZyA9IDwweDI+OwoJCQkvL307CgkJfTsKCgkJLy9tZGlvQDI1MDAwIHsKCQkvLwkjYWRkcmVz
cy1jZWxscyA9IDwxPjsKCQkvLwkjc2l6ZS1jZWxscyA9IDwwPjsKCQkvLwljb21wYXRpYmxlID0g
ImZzbCxldHNlYzItbWRpbyI7CgkJLy8JcmVnID0gPDB4MjUwMDAgMHgxMDAwIDB4YjEwMzAgMHg0
PjsKCQkvL307CgoJCWVuZXQwOiBldGhlcm5ldEBCMDAwMCB7CgkJCSNhZGRyZXNzLWNlbGxzID0g
PDE+OwoJCQkjc2l6ZS1jZWxscyA9IDwxPjsKCQkJY2VsbC1pbmRleCA9IDwwPjsKCQkJZGV2aWNl
X3R5cGUgPSAibmV0d29yayI7CgkJCW1vZGVsID0gImVUU0VDIjsKCQkJY29tcGF0aWJsZSA9ICJm
c2wsZXRzZWMyIjsKCQkJZnNsLG51bV9yeF9xdWV1ZXMgPSA8MHg4PjsKCQkJZnNsLG51bV90eF9x
dWV1ZXMgPSA8MHg4PjsKCQkJZnNsLG1hZ2ljLXBhY2tldDsKCQkJZnNsLHdha2Utb24tZmlsZXI7
CgkJCWNsay1oYW5kbGUgPSA8JmV0c2VjMV9jbGs+OwoJCQlsb2NhbC1tYWMtYWRkcmVzcyA9IFsg
MDAgMDAgMDAgMDAgMDAgMDAgXTsKCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmbXBpYz47CgkJCXBo
eS1oYW5kbGUgPSA8JnBoeTA+OwoJCQlwaHktY29ubmVjdGlvbi10eXBlID0gInJnbWlpLWlkIjsK
CQkJcXVldWUtZ3JvdXBAMHsKCQkJCSNhZGRyZXNzLWNlbGxzID0gPDE+OwoJCQkJI3NpemUtY2Vs
bHMgPSA8MT47CgkJCQlyZWcgPSA8MHhCMDAwMCAweDEwMDA+OwoJCQkJaW50ZXJydXB0cyA9IDwy
OSAyIDMwIDIgMzQgMj47CgkJCX07CgkJCXF1ZXVlLWdyb3VwQDF7CgkJCQkjYWRkcmVzcy1jZWxs
cyA9IDwxPjsKCQkJCSNzaXplLWNlbGxzID0gPDE+OwoJCQkJcmVnID0gPDB4QjQwMDAgMHgxMDAw
PjsKCQkJCWludGVycnVwdHMgPSA8MTcgMiAxOCAyIDI0IDI+OwoJCQl9OwoJCX07CgoJCS8vc2Ro
Y2lAMmUwMDAgewoJCS8vCWNvbXBhdGlibGUgPSAiZnNsLHAxMDIyLWVzZGhjIiwgImZzbCxlc2Ro
YyI7CgkJLy8JcmVnID0gPDB4MmUwMDAgMHgxMDAwPjsKCQkvLwlpbnRlcnJ1cHRzID0gPDcyIDB4
Mj47CgkJLy8JaW50ZXJydXB0LXBhcmVudCA9IDwmbXBpYz47CgkJLy8JZnNsLHNkaGNpLWF1dG8t
Y21kMTI7CgkJLy8JLyogRmlsbGVkIGluIGJ5IFUtQm9vdCAqLwoJCS8vCWNsb2NrLWZyZXF1ZW5j
eSA9IDwwPjsKCQkvL307CgoJCS8vY3J5cHRvQDMwMDAwIHsKCQkvLwljb21wYXRpYmxlID0gImZz
bCxzZWMzLjEiLCAiZnNsLHNlYzMuMCIsICJmc2wsc2VjMi40IiwKCQkvLwkJICAgICAiZnNsLHNl
YzIuMiIsICJmc2wsc2VjMi4xIiwgImZzbCxzZWMyLjAiOwoJCS8vCXJlZyA9IDwweDMwMDAwIDB4
MTAwMDA+OwoJCS8vCWludGVycnVwdHMgPSA8NDUgMiA1OCAyPjsKCQkvLwlpbnRlcnJ1cHQtcGFy
ZW50ID0gPCZtcGljPjsKCQkvLwlmc2wsbnVtLWNoYW5uZWxzID0gPDQ+OwoJCS8vCWZzbCxjaGFu
bmVsLWZpZm8tbGVuID0gPDI0PjsKCQkvLwlmc2wsZXhlYy11bml0cy1tYXNrID0gPDB4YmZlPjsK
CQkvLwlmc2wsZGVzY3JpcHRvci10eXBlcy1tYXNrID0gPDB4M2FiMGViZj47CgkJLy8JZnNsLG11
bHRpLWhvc3QtbW9kZSA9ICJwcmltYXJ5IjsKCQkvLwlmc2wsY2hhbm5lbC1yZW1hcCA9IDwweDM+
OwoJCS8vfTsKCgkJLy9zYXRhQDE4MDAwIHsKCQkvLwljb21wYXRpYmxlID0gImZzbCxtcGM4NTM2
LXNhdGEiLCAiZnNsLHBxLXNhdGEiOwoJCS8vCXJlZyA9IDwweDE4MDAwIDB4MTAwMD47CgkJLy8J
Y2VsbC1pbmRleCA9IDwxPjsKCQkvLwlpbnRlcnJ1cHRzID0gPDc0IDB4Mj47CgkJLy8JaW50ZXJy
dXB0LXBhcmVudCA9IDwmbXBpYz47CgkJLy99OwoKCQkvL3NhdGFAMTkwMDAgewoJCS8vCWNvbXBh
dGlibGUgPSAiZnNsLG1wYzg1MzYtc2F0YSIsICJmc2wscHEtc2F0YSI7CgkJLy8JcmVnID0gPDB4
MTkwMDAgMHgxMDAwPjsKCQkvLwljZWxsLWluZGV4ID0gPDI+OwoJCS8vCWludGVycnVwdHMgPSA8
NDEgMHgyPjsKCQkvLwlpbnRlcnJ1cHQtcGFyZW50ID0gPCZtcGljPjsKCQkvL307CgoJCS8vZGlz
cGxheUAxMDAwMCB7CgkJLy8JY29tcGF0aWJsZSA9ICJmc2wsZGl1IiwgImZzbCxwMTAyMi1kaXUi
OwoJCS8vCXJlZyA9IDwweDEwMDAwIDEwMDA+OwoJCS8vCWludGVycnVwdHMgPSA8NjQgMj47CgkJ
Ly8JaW50ZXJydXB0LXBhcmVudCA9IDwmbXBpYz47CgkJLy99OwoKCQlwb3dlckBlMDA3MHsKCQkJ
Y29tcGF0aWJsZSA9ICJmc2wsbXBjODUzNi1wbWMiLCAiZnNsLG1wYzg1NDgtcG1jIiwKCQkJCSAg
ICAgImZzbCxwMTAyMi1wbWMiOwoJCQlyZWcgPSA8MHhlMDA3MCAweDIwPjsKCQkJZXRzZWMxX2Ns
azogc29jLWNsa0BCMHsKCQkJCWZzbCxwbWNkci1tYXNrID0gPDB4MDAwMDAwODA+OwoJCQl9OwoJ
CQlldHNlYzJfY2xrOiBzb2MtY2xrQEIxewoJCQkJZnNsLHBtY2RyLW1hc2sgPSA8MHgwMDAwMDA0
MD47CgkJCX07CgkJfTsKCgkJLy90aW1lckA0MTEwMCB7CgkJLy8JY29tcGF0aWJsZSA9ICJmc2ws
bXBpYy1nbG9iYWwtdGltZXIiOwoJCS8vCXJlZyA9IDwweDQxMTAwIDB4MjA0PjsKCQkvLwlpbnRl
cnJ1cHRzID0gPDB4ZjcgMHgyPjsKCQkvLwlpbnRlcnJ1cHQtcGFyZW50ID0gPCZtcGljPjsKCQkv
L307CgoJCW1waWM6IHBpY0A0MDAwMCB7CgkJCWludGVycnVwdC1jb250cm9sbGVyOwoJCQkjYWRk
cmVzcy1jZWxscyA9IDwwPjsKCQkJI2ludGVycnVwdC1jZWxscyA9IDwyPjsKCQkJcmVnID0gPDB4
NDAwMDAgMHg0MDAwMD47CgkJCWNvbXBhdGlibGUgPSAiY2hycCxvcGVuLXBpYyI7CgkJCWRldmlj
ZV90eXBlID0gIm9wZW4tcGljIjsKCQkJcGljLW5vLXJlc2V0OwoJCQlwcm90ZWN0ZWQtc291cmNl
cyA9IDwKCQkJCTE5CQkvLyBsb2NhbGJ1c0BmZmUwNTAwCgkJCQk0MgkJLy8gc2VyaWFsQDQ2MDAK
CQkJCTE2CQkvLyBlY21AMTAwMAoJCQkJCQkvLyBtZW1vcnktY29udHJvbGxlckAyMDAwMAoJCQkJ
CQkvLyBydGNANjgKCQkJCTQzCQkvLyBpMmNAMzAwMCwgaTJjQDMxMDAKCQkJCTc1CQkvLyBzc2lA
MTUwMDAKCQkJCTU5CQkvLyBzcGlANzAwMAoJCQkJNDcJCS8vIGdwaW9AZjAwMAoJCQkJMjAJCS8v
IGRtYS1jaGFubmVsQDAKCQkJCTIxCQkvLyBkbWEtY2hhbm5lbEA4MAoJCQkJMjIJCS8vIGRtYS1j
aGFubmVsQDEwMAoJCQkJMjMJCS8vIGRtYS1jaGFubmVsQDE4MAoJCQkJMjgJCS8vIHVzYkAyMjAw
MAoJCQkJOQkJLy8gZXRoZXJuZXQtcGh5QDEKCQkJCTM1IDM2IDQwCS8vIHF1ZXVlLWdyb3VwQDAK
CQkJCTUxIDUyIDY3CS8vIHF1ZXVlLWdyb3VwQDEKCQkJCTU4CQkvLyBjcnlwdG9AMzAwMDAKCQkJ
CTQxCQkvLyBzYXRhQDE5MDAwCgkJCQk3NAkJLy8gc2F0YUAxODAwMAoJCQkJNjQJCS8vIGRpc3Bs
YXlAMTAwMDAKCQkJCTB4RjcJLy8gdGltZXJANDExMDAKCQkJCTB4YjEJCQkJCS8vIG1lc3NhZ2VA
NDE0MDAKCQkJCTE2CQkJCQkJLy8gcGNpQGZmZTA5MDAwCgkJCQkJCQkJCQkvLyBwY2lAZmZlMGEw
MDAKCQkJCQkJCQkJCS8vIHBjaUBmZmUwYjAwMAoJCQkJMHhlMCAweGUxIDB4ZTIgMHhlMwkJLy8g
bXNpQDQxNjAwCgkJCT47CgkJfTsKCgkJbXNncl9ibG9jazA6IG1lc3NhZ2VANDE0MDAgewoJCQlj
b21wYXRpYmxlID0gImZzbCxwMTAyMi1tc2ciLCJmc2wsbXBpYy1tc2ciLAoJCQkJICAgICAiZnNs
LG1waWMtdjMuMS1tc2dyIjsKCQkJcmVnID0gPDB4NDE0MDAgMHgyMDA+OwoJCQljZWxsLWluZGV4
ID0gPDE+OwoJCQlpbnRlcnJ1cHRzID0gPDB4YjAgMiAweGIyIDIgMHhiMyAyPjsKCQkJbXNnLXJl
Y2VpdmUtbWFzayA9IDwweGQ+OwoJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCAmbXBpYyA+OwoJCX07
CgkJLy9tc2dyX2Jsb2NrMDogbWVzc2FnZUA0MTQwMCB7CgkJLy8JY29tcGF0aWJsZSA9ICJmc2ws
cDEwMjItbXNnIiwiZnNsLG1waWMtbXNnIiwKCQkvLwkJCQkgImZzbCxtcGljLXYzLjEtbXNnciI7
CgkJLy8JcmVnID0gPDB4NDE0MDAgMHgyMDA+OwoJCS8vCWludGVycnVwdHMgPSA8MHhiMCAweDIg
MHhiMSAweDIgMHhiMiAweDIgMHhiMyAyPjsKCQkvLwlpbnRlcnJ1cHQtcGFyZW50ID0gPCAmbXBp
YyA+OwoJCS8vfTsKCgkJLy9tc2lANDE2MDAgewoJCS8vCWNvbXBhdGlibGUgPSAiZnNsLG1waWMt
bXNpIjsKCQkvLwlyZWcgPSA8MHg0MTYwMCAweDgwPjsKCQkvLwltc2ktYXZhaWxhYmxlLXJhbmdl
cyA9IDwwIDB4MTAwPjsKCQkvLwlpbnRlcnJ1cHRzID0gPAoJCS8vCQkweGUwIDAKCQkvLwkJMHhl
MSAwCgkJLy8JCTB4ZTIgMAoJCS8vCQkweGUzIDAKCQkvLwkJMHhlNCAwCgkJLy8JCTB4ZTUgMAoJ
CS8vCQkweGU2IDAKCQkvLwkJMHhlNyAwPjsKCQkvLwlpbnRlcnJ1cHQtcGFyZW50ID0gPCZtcGlj
PjsKCQkvL307CgoJCS8vZ2xvYmFsLXV0aWxpdGllc0BlMDAwMCB7CS8vZ2xvYmFsIHV0aWxpdGll
cyBibG9jawoJCS8vCWNvbXBhdGlibGUgPSAiZnNsLHAxMDIyLWd1dHMiOwoJCS8vCXJlZyA9IDww
eGUwMDAwIDB4MTAwMD47CgkJLy8JZnNsLGhhcy1yc3RjcjsKCQkvL307Cgl9OwoKCS8vcGNpMDog
cGNpZUBmZmUwOTAwMCB7CgkvLwljZWxsLWluZGV4ID0gPDI+OwoJLy8JY29tcGF0aWJsZSA9ICJm
c2wscDEwMjItcGNpZSI7CgkvLwlkZXZpY2VfdHlwZSA9ICJwY2kiOwoJLy8JI2ludGVycnVwdC1j
ZWxscyA9IDwxPjsKCS8vCSNzaXplLWNlbGxzID0gPDI+OwoJLy8JI2FkZHJlc3MtY2VsbHMgPSA8
Mz47CgkvLwlyZWcgPSA8MCAweGZmZTA5MDAwIDAgMHgxMDAwPjsKCS8vCWJ1cy1yYW5nZSA9IDww
IDI1NT47CgkvLwlyYW5nZXMgPSA8MHgyMDAwMDAwIDB4MCAweGEwMDAwMDAwIDAgMHhhMDAwMDAw
MCAweDAgMHgyMDAwMDAwMAoJLy8JCSAgMHgxMDAwMDAwIDB4MCAweDAwMDAwMDAwIDAgMHhmZmMx
MDAwMCAweDAgMHgxMDAwMD47CgkvLwljbG9jay1mcmVxdWVuY3kgPSA8MzMzMzMzMzM+OwoJLy8J
aW50ZXJydXB0LXBhcmVudCA9IDwmbXBpYz47CgkvLwlpbnRlcnJ1cHRzID0gPDE2IDI+OwoJLy8J
aW50ZXJydXB0LW1hcC1tYXNrID0gPDB4ZjgwMCAwIDAgNz47CgkvLwlpbnRlcnJ1cHQtbWFwID0g
PAoJLy8JCS8qIElEU0VMIDB4MCAqLwoJLy8JCTAwMDAgMCAwIDEgJm1waWMgNCAxCgkvLwkJMDAw
MCAwIDAgMiAmbXBpYyA1IDEKCS8vCQkwMDAwIDAgMCAzICZtcGljIDYgMQoJLy8JCTAwMDAgMCAw
IDQgJm1waWMgNyAxCgkvLwkJPjsKCS8vCXBjaWVAMCB7CgkvLwkJcmVnID0gPDB4MCAweDAgMHgw
IDB4MCAweDA+OwoJLy8JCSNzaXplLWNlbGxzID0gPDI+OwoJLy8JCSNhZGRyZXNzLWNlbGxzID0g
PDM+OwoJLy8JCWRldmljZV90eXBlID0gInBjaSI7CgkvLwkJcmFuZ2VzID0gPDB4MjAwMDAwMCAw
eDAgMHhhMDAwMDAwMAoJLy8JCQkgIDB4MjAwMDAwMCAweDAgMHhhMDAwMDAwMAoJLy8JCQkgIDB4
MCAweDIwMDAwMDAwCgoJLy8JCQkJICAweDEwMDAwMDAgMHgwIDB4MAoJLy8JCQkgIDB4MTAwMDAw
MCAweDAgMHgwCgkvLwkJCSAgMHgwIDB4MTAwMDAwPjsKCS8vCX07CgkvL307CgoJLy9wY2kxOiBw
Y2llQGZmZTBhMDAwIHsKCS8vCWNlbGwtaW5kZXggPSA8MT47CgkvLwljb21wYXRpYmxlID0gImZz
bCxwMTAyMi1wY2llIjsKCS8vCWRldmljZV90eXBlID0gInBjaSI7CgkvLwkjaW50ZXJydXB0LWNl
bGxzID0gPDE+OwoJLy8JI3NpemUtY2VsbHMgPSA8Mj47CgkvLwkjYWRkcmVzcy1jZWxscyA9IDwz
PjsKCS8vCXJlZyA9IDwwIDB4ZmZlMGEwMDAgMCAweDEwMDA+OwoJLy8JYnVzLXJhbmdlID0gPDAg
MjU1PjsKCS8vCXJhbmdlcyA9IDwweDIwMDAwMDAgMHgwIDB4YzAwMDAwMDAgMCAweGMwMDAwMDAw
IDB4MCAweDIwMDAwMDAwCgkvLwkJICAweDEwMDAwMDAgMHgwIDB4MDAwMDAwMDAgMCAweGZmYzIw
MDAwIDB4MCAweDEwMDAwPjsKCS8vCWNsb2NrLWZyZXF1ZW5jeSA9IDwzMzMzMzMzMz47CgkvLwlp
bnRlcnJ1cHQtcGFyZW50ID0gPCZtcGljPjsKCS8vCWludGVycnVwdHMgPSA8MTYgMj47CgkvLwlp
bnRlcnJ1cHQtbWFwLW1hc2sgPSA8MHhmODAwIDAgMCA3PjsKCS8vCWludGVycnVwdC1tYXAgPSA8
CgkvLwkJLyogSURTRUwgMHgwICovCgkvLwkJMDAwMCAwIDAgMSAmbXBpYyAwIDEKCS8vCQkwMDAw
IDAgMCAyICZtcGljIDEgMQoJLy8JCTAwMDAgMCAwIDMgJm1waWMgMiAxCgkvLwkJMDAwMCAwIDAg
NCAmbXBpYyAzIDEKCS8vCQk+OwoJLy8JcGNpZUAwIHsKCS8vCQlyZWcgPSA8MHgwIDB4MCAweDAg
MHgwIDB4MD47CgkvLwkJI3NpemUtY2VsbHMgPSA8Mj47CgkvLwkJI2FkZHJlc3MtY2VsbHMgPSA8
Mz47CgkvLwkJZGV2aWNlX3R5cGUgPSAicGNpIjsKCS8vCQlyYW5nZXMgPSA8MHgyMDAwMDAwIDB4
MCAweGMwMDAwMDAwCgkvLwkJCSAgMHgyMDAwMDAwIDB4MCAweGMwMDAwMDAwCgkvLwkJCSAgMHgw
IDB4MjAwMDAwMDAKCgkvLwkJCQkgIDB4MTAwMDAwMCAweDAgMHgwCgkvLwkJCSAgMHgxMDAwMDAw
IDB4MCAweDAKCS8vCQkJICAweDAgMHgxMDAwMDA+OwoJLy8JfTsKCS8vfTsKCgoJLy9wY2kyOiBw
Y2llQGZmZTBiMDAwIHsKCS8vCWNlbGwtaW5kZXggPSA8Mz47CgkvLwljb21wYXRpYmxlID0gImZz
bCxwMTAyMi1wY2llIjsKCS8vCWRldmljZV90eXBlID0gInBjaSI7CgkvLwkjaW50ZXJydXB0LWNl
bGxzID0gPDE+OwoJLy8JI3NpemUtY2VsbHMgPSA8Mj47CgkvLwkjYWRkcmVzcy1jZWxscyA9IDwz
PjsKCS8vCXJlZyA9IDwwIDB4ZmZlMGIwMDAgMCAweDEwMDA+OwoJLy8JYnVzLXJhbmdlID0gPDAg
MjU1PjsKCS8vCXJhbmdlcyA9IDwweDIwMDAwMDAgMHgwIDB4ODAwMDAwMDAgMCAweDgwMDAwMDAw
IDB4MCAweDIwMDAwMDAwCgkvLwkJICAweDEwMDAwMDAgMHgwIDB4MDAwMDAwMDAgMCAweGZmYzAw
MDAwIDB4MCAweDEwMDAwPjsKCS8vCWNsb2NrLWZyZXF1ZW5jeSA9IDwzMzMzMzMzMz47CgkvLwlp
bnRlcnJ1cHQtcGFyZW50ID0gPCZtcGljPjsKCS8vCWludGVycnVwdHMgPSA8MTYgMj47CgkvLwlp
bnRlcnJ1cHQtbWFwLW1hc2sgPSA8MHhmODAwIDAgMCA3PjsKCS8vCWludGVycnVwdC1tYXAgPSA8
CgkvLwkJLyogSURTRUwgMHgwICovCgkvLwkJMDAwMCAwIDAgMSAmbXBpYyA4IDEKCS8vCQkwMDAw
IDAgMCAyICZtcGljIDkgMQoJLy8JCTAwMDAgMCAwIDMgJm1waWMgMTAgMQoJLy8JCTAwMDAgMCAw
IDQgJm1waWMgMTEgMQoJLy8JCT47CgkvLwlwY2llQDAgewoJLy8JCXJlZyA9IDwweDAgMHgwIDB4
MCAweDAgMHgwPjsKCS8vCQkjc2l6ZS1jZWxscyA9IDwyPjsKCS8vCQkjYWRkcmVzcy1jZWxscyA9
IDwzPjsKCS8vCQlkZXZpY2VfdHlwZSA9ICJwY2kiOwoJLy8JCXJhbmdlcyA9IDwweDIwMDAwMDAg
MHgwIDB4ODAwMDAwMDAKCS8vCQkJICAweDIwMDAwMDAgMHgwIDB4ODAwMDAwMDAKCS8vCQkJICAw
eDAgMHgyMDAwMDAwMAoKCS8vCQkJICAweDEwMDAwMDAgMHgwIDB4MAoJLy8JCQkgIDB4MTAwMDAw
MCAweDAgMHgwCgkvLwkJCSAgMHgwIDB4MTAwMDAwPjsKCS8vCX07CgkvL307Cn07Cg==

--_005_93CD5F41FDBC6042A6B449764F3B35CC050C38FBEUMBX03mgcmento_
Content-Type: application/octet-stream; name="p1022rdk-core1.dts"
Content-Description: p1022rdk-core1.dts
Content-Disposition: attachment; filename="p1022rdk-core1.dts"; size=15964;
	creation-date="Wed, 07 Dec 2011 01:42:25 GMT";
	modification-date="Wed, 07 Dec 2011 01:42:24 GMT"
Content-Transfer-Encoding: base64

LyoKICogUDEwMjIgUkRLIC0gQ29yZSAxIERldmljZSBUcmVlIFNvdXJjZQogKgogKi8KCi9kdHMt
djEvOwovIHsKCW1vZGVsID0gImZzbCxQMTAyMiI7Cgljb21wYXRpYmxlID0gImZzbCxQMTAyMkRT
IjsKCSNhZGRyZXNzLWNlbGxzID0gPDI+OwoJI3NpemUtY2VsbHMgPSA8Mj47CgoJYWxpYXNlcyB7
CgkJZXRoZXJuZXQxID0gJmVuZXQxOwoJCXNlcmlhbDAgPSAmc2VyaWFsMDsKCQlwY2kwID0gJnBj
aTA7CgkJcGNpMSA9ICZwY2kxOwoJCXBjaTIgPSAmcGNpMjsKCX07CgoJY3B1cyB7CgkJI2FkZHJl
c3MtY2VsbHMgPSA8MT47CgkJI3NpemUtY2VsbHMgPSA8MD47CgoJCS8vUG93ZXJQQyxQMTAyMkAw
IHsKCQkvLwlkZXZpY2VfdHlwZSA9ICJjcHUiOwoJCS8vCXJlZyA9IDwweDA+OwoJCS8vCW5leHQt
bGV2ZWwtY2FjaGUgPSA8JkwyPjsKCQkvL307CgoJCVBvd2VyUEMsUDEwMjJAMSB7CgkJCWRldmlj
ZV90eXBlID0gImNwdSI7CgkJCXJlZyA9IDwweDE+OwoJCQluZXh0LWxldmVsLWNhY2hlID0gPCZM
Mj47CgkJfTsKCX07CgoJbWVtb3J5IHsKCQlkZXZpY2VfdHlwZSA9ICJtZW1vcnkiOwoJfTsKCgls
b2NhbGJ1c0BmZmUwNTAwMCB7CgkJI2FkZHJlc3MtY2VsbHMgPSA8Mj47CgkJI3NpemUtY2VsbHMg
PSA8MT47CgkJY29tcGF0aWJsZSA9ICJmc2wscDEwMjItZWxiYyIsICJmc2wsZWxiYyIsICJzaW1w
bGUtYnVzIjsKCQlyZWcgPSA8MCAweGZmZTA1MDAwIDAgMHgxMDAwPjsKCQlpbnRlcnJ1cHRzID0g
PDE5IDI+OwoJCWludGVycnVwdC1wYXJlbnQgPSA8Jm1waWM+OwoKCQlyYW5nZXMgPSA8MHgwIDB4
MCAweDAgMHhlODAwMDAwMCAweDA4MDAwMDAwCgkJCSAgMHgxIDB4MCAweDAgMHhlMDAwMDAwMCAw
eDA4MDAwMDAwCgkJCSAgMHgyIDB4MCAweDAgMHhmZmEwMDAwMCAweDAwMDQwMDAwCgkJCSAgMHgz
IDB4MCAweDAgMHhmZmRmMDAwMCAweDAwMDA4MDAwPjsKCgkJbm9yQDAsMCB7CgkJCSNhZGRyZXNz
LWNlbGxzID0gPDE+OwoJCQkjc2l6ZS1jZWxscyA9IDwxPjsKCQkJY29tcGF0aWJsZSA9ICJjZmkt
Zmxhc2giOwoJCQlyZWcgPSA8MHgwIDB4MCAweDgwMDAwMDA+OwoJCQliYW5rLXdpZHRoID0gPDI+
OwoJCQlkZXZpY2Utd2lkdGggPSA8MT47CgoJCQlwYXJ0aXRpb25AMCB7CgkJCQlyZWcgPSA8MHgw
IDB4MDMwMDAwMDA+OwoJCQkJbGFiZWwgPSAicmFtZGlzay1ub3IiOwoJCQkJcmVhZC1vbmx5OwoJ
CQl9OwoKCQkJcGFydGl0aW9uQDMwMDAwMDAgewoJCQkJcmVnID0gPDB4MDMwMDAwMDAgMHgwMGUw
MDAwMD47CgkJCQlsYWJlbCA9ICJkaWFnbm9zdGljLW5vciI7CgkJCQlyZWFkLW9ubHk7CgkJCX07
CgoJCQlwYXJ0aXRpb25AM2UwMDAwMCB7CgkJCQlyZWcgPSA8MHgwM2UwMDAwMCAweDAwMjAwMDAw
PjsKCQkJCWxhYmVsID0gImRpbmstbm9yIjsKCQkJCXJlYWQtb25seTsKCQkJfTsKCgkJCXBhcnRp
dGlvbkA0MDAwMDAwIHsKCQkJCXJlZyA9IDwweDA0MDAwMDAwIDB4MDA0MDAwMDA+OwoJCQkJbGFi
ZWwgPSAia2VybmVsLW5vciI7CgkJCQlyZWFkLW9ubHk7CgkJCX07CgoJCQlwYXJ0aXRpb25ANDQw
MDAwMCB7CgkJCQlyZWcgPSA8MHgwNDQwMDAwMCAweDAzYjAwMDAwPjsKCQkJCWxhYmVsID0gImpm
ZnMyLW5vciI7CgkJCX07CgoJCQlwYXJ0aXRpb25AN2YwMDAwMCB7CgkJCQlyZWcgPSA8MHgwN2Yw
MDAwMCAweDAwMDgwMDAwPjsKCQkJCWxhYmVsID0gImR0Yi1ub3IiOwoJCQkJcmVhZC1vbmx5OwoJ
CQl9OwoKCQkJcGFydGl0aW9uQDdmODAwMDAgewoJCQkJcmVnID0gPDB4MDdmODAwMDAgMHgwMDA4
MDAwMD47CgkJCQlsYWJlbCA9ICJ1LWJvb3Qtbm9yIjsKCQkJCXJlYWQtb25seTsKCQkJfTsKCQl9
OwoKCQluYW5kQDIsMCB7CgkJCSNhZGRyZXNzLWNlbGxzID0gPDE+OwoJCQkjc2l6ZS1jZWxscyA9
IDwxPjsKCQkJY29tcGF0aWJsZSA9ICJmc2wsZWxiYy1mY20tbmFuZCI7CgkJCXJlZyA9IDwweDIg
MHgwIDB4NDAwMDA+OwoKCQkJcGFydGl0aW9uQDAgewoJCQkJcmVnID0gPDB4MCAweDAyMDAwMDAw
PjsKCQkJCWxhYmVsID0gInUtYm9vdC1uYW5kIjsKCQkJCXJlYWQtb25seTsKCQkJfTsKCgkJCXBh
cnRpdGlvbkAyMDAwMDAwIHsKCQkJCXJlZyA9IDwweDAyMDAwMDAwIDB4MTAwMDAwMDA+OwoJCQkJ
bGFiZWwgPSAiamZmczItbmFuZCI7CgkJCX07CgoJCQlwYXJ0aXRpb25AMTIwMDAwMDAgewoJCQkJ
cmVnID0gPDB4MTIwMDAwMDAgMHgxMDAwMDAwMD47CgkJCQlsYWJlbCA9ICJyYW1kaXNrLW5hbmQi
OwoJCQkJcmVhZC1vbmx5OwoJCQl9OwoKCQkJcGFydGl0aW9uQDIyMDAwMDAwIHsKCQkJCXJlZyA9
IDwweDIyMDAwMDAwIDB4MDQwMDAwMDA+OwoJCQkJbGFiZWwgPSAia2VybmVsLW5hbmQiOwoJCQl9
OwoKCQkJcGFydGl0aW9uQDI2MDAwMDAwIHsKCQkJCXJlZyA9IDwweDI2MDAwMDAwIDB4MDEwMDAw
MDA+OwoJCQkJbGFiZWwgPSAiZHRiLW5hbmQiOwoJCQkJcmVhZC1vbmx5OwoJCQl9OwoKCQkJcGFy
dGl0aW9uQDI3MDAwMDAwIHsKCQkJCXJlZyA9IDwweDI3MDAwMDAwIDB4MTkwMDAwMDA+OwoJCQkJ
bGFiZWwgPSAicmVzZXJ2ZWQtbmFuZCI7CgkJCX07CgkJfTsKCX07CgoJc29jQGZmZTAwMDAwIHsK
CQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKCQkjc2l6ZS1jZWxscyA9IDwxPjsKCQlkZXZpY2VfdHlw
ZSA9ICJzb2MiOwoJCWNvbXBhdGlibGUgPSAiZnNsLHAxMDIyLWltbXIiLCAic2ltcGxlLWJ1cyI7
CgkJcmFuZ2VzID0gPDB4MCAwIDB4ZmZlMDAwMDAgMHgxMDAwMDA+OwoJCWJ1cy1mcmVxdWVuY3kg
PSA8MD47CQkvLyBGaWxsZWQgb3V0IGJ5IHVib290LgoKCQllY20tbGF3QDAgewoJCQljb21wYXRp
YmxlID0gImZzbCxlY20tbGF3IjsKCQkJcmVnID0gPDB4MCAweDEwMDA+OwoJCQlmc2wsbnVtLWxh
d3MgPSA8MTI+OwoJCX07CgoJCWVjbUAxMDAwIHsKCQkJY29tcGF0aWJsZSA9ICJmc2wscDEwMjIt
ZWNtIiwgImZzbCxlY20iOwoJCQlyZWcgPSA8MHgxMDAwIDB4MTAwMD47CgkJCWludGVycnVwdHMg
PSA8MTYgMj47CgkJCWludGVycnVwdC1wYXJlbnQgPSA8Jm1waWM+OwoJCX07CgoJCW1lbW9yeS1j
b250cm9sbGVyQDIwMDAgewoJCQljb21wYXRpYmxlID0gImZzbCxwMTAyMi1tZW1vcnktY29udHJv
bGxlciI7CgkJCXJlZyA9IDwweDIwMDAgMHgxMDAwPjsKCQkJaW50ZXJydXB0LXBhcmVudCA9IDwm
bXBpYz47CgkJCWludGVycnVwdHMgPSA8MTYgMj47CgkJfTsKCgkJaTJjQDMwMDAgewoJCQkjYWRk
cmVzcy1jZWxscyA9IDwxPjsKCQkJI3NpemUtY2VsbHMgPSA8MD47CgkJCWNlbGwtaW5kZXggPSA8
MD47CgkJCWNvbXBhdGlibGUgPSAiZnNsLWkyYyI7CgkJCXJlZyA9IDwweDMwMDAgMHgxMDA+OwoJ
CQlpbnRlcnJ1cHRzID0gPDQzIDI+OwoJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZtcGljPjsKCQkJ
ZGZzcnI7CgkJfTsKCgkJc3NpQDE1MDAwIHsKCQkJY29tcGF0aWJsZSA9ICJmc2wscDEwMjItc3Np
IjsKCQkJY2VsbC1pbmRleCA9IDwwPjsKCQkJcmVnID0gPDB4MTUwMDAgMHgxMDA+OwoJCQlpbnRl
cnJ1cHQtcGFyZW50ID0gPCZtcGljPjsKCQkJaW50ZXJydXB0cyA9IDw3NSAyPjsKCQkJZnNsLG1v
ZGUgPSAiaTJzLXNsYXZlIjsKCQkJY29kZWMtaGFuZGxlID0gPCZ3bTg5NjA+OwoJCQlmc2wscGxh
eWJhY2stZG1hID0gPCZkbWEwMD47CgkJCWZzbCxjYXB0dXJlLWRtYSA9IDwmZG1hMDE+OwoJCQlm
c2wsZmlmby1kZXB0aCA9IDwxNT47CgkJCWZzbCxzc2ktYXN5bmNocm9ub3VzID0gPDE+OwoJCX07
CgoJCWkyY0AzMTAwIHsKCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47CgkJCSNzaXplLWNlbGxzID0g
PDA+OwoJCQljZWxsLWluZGV4ID0gPDE+OwoJCQljb21wYXRpYmxlID0gImZzbC1pMmMiOwoJCQly
ZWcgPSA8MHgzMTAwIDB4MTAwPjsKCQkJaW50ZXJydXB0cyA9IDw0MyAyPjsKCQkJaW50ZXJydXB0
LXBhcmVudCA9IDwmbXBpYz47CgkJCWRmc3JyOwoJCQlydGNANjh7CgkJCQljb21wYXRpYmxlID0g
ImRhbGxhcyxkczMyMzIiOwoJCQkJcmVnID0gPDB4Njg+OwoJCQkJaW50ZXJydXB0cyA9IDwxNiAw
eDI+OwoJCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmbXBpYz47CgkJCX07CgkJCWFkdDc0NjFANGN7
CgkJCQljb21wYXRpYmxlID0gImFkaSxhZHQ3NDYxIjsKCQkJCXJlZyA9IDwweDRjPjsKCQkJfTsK
CQkJemw2MTAwQDIxewoJCQkJY29tcGF0aWJsZSA9ICJpbnRlcnNpbCx6bDYxMDAiOwoJCQkJcmVn
ID0gPDB4MjE+OwoJCQl9OwoJCQl6bDYxMDBAMjR7CgkJCQljb21wYXRpYmxlID0gImludGVyc2ls
LHpsNjEwMCI7CgkJCQlyZWcgPSA8MHgyND47CgkJCX07CgkJCXpsNjEwMEAyNnsKCQkJCWNvbXBh
dGlibGUgPSAiaW50ZXJzaWwsemw2MTAwIjsKCQkJCXJlZyA9IDwweDI2PjsKCQkJfTsKCQkJemw2
MTAwQDI5ewoJCQkJY29tcGF0aWJsZSA9ICJpbnRlcnNpbCx6bDYxMDAiOwoJCQkJcmVnID0gPDB4
Mjk+OwoJCQl9OwoJCQl3bTg5NjA6Y29kZWNAMWEgewoJCQkJY29tcGF0aWJsZSA9ICJ3b2xmc29u
LHdtODk2MCI7CgkJCQlyZWcgPSA8MHgxYT47CgkJCQljbG9jay1mcmVxdWVuY3kgPSA8MHhiYjgw
MDA+OwoJCQl9OwoJCX07CgoJCXNlcmlhbDA6IHNlcmlhbEA0NTAwIHsKCQkJY2VsbC1pbmRleCA9
IDwwPjsKCQkJZGV2aWNlX3R5cGUgPSAic2VyaWFsIjsKCQkJY29tcGF0aWJsZSA9ICJuczE2NTUw
IjsKCQkJcmVnID0gPDB4NDUwMCAweDEwMD47CgkJCWNsb2NrLWZyZXF1ZW5jeSA9IDwwPjsKCQkJ
aW50ZXJydXB0cyA9IDw0MiAyPjsKCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmbXBpYz47CgkJfTsK
CgkJLy9zZXJpYWwxOiBzZXJpYWxANDYwMCB7CgkJLy8JY2VsbC1pbmRleCA9IDwxPjsKCQkvLwlk
ZXZpY2VfdHlwZSA9ICJzZXJpYWwiOwoJCS8vCWNvbXBhdGlibGUgPSAibnMxNjU1MCI7CgkJLy8J
cmVnID0gPDB4NDYwMCAweDEwMD47CgkJLy8JY2xvY2stZnJlcXVlbmN5ID0gPDA+OwoJCS8vCWlu
dGVycnVwdHMgPSA8NDIgMj47CgkJLy8JaW50ZXJydXB0LXBhcmVudCA9IDwmbXBpYz47CgkJLy99
OwoKCQlzcGlANzAwMCB7CgkJCWNlbGwtaW5kZXggPSA8MD47CgkJCSNhZGRyZXNzLWNlbGxzID0g
PDE+OwoJCQkjc2l6ZS1jZWxscyA9IDwwPjsKCQkJY29tcGF0aWJsZSA9ICJmc2wsZXNwaSI7CgkJ
CXJlZyA9IDwweDcwMDAgMHgxMDAwPjsKCQkJaW50ZXJydXB0cyA9IDw1OSAweDI+OwoJCQlpbnRl
cnJ1cHQtcGFyZW50ID0gPCZtcGljPjsKCQkJZXNwaSxudW0tc3MtYml0cyA9IDw0PjsKCQkJbW9k
ZSA9ICJjcHUiOwoKCQkJZnNsX20yNXA4MEAwIHsKCQkJCSNhZGRyZXNzLWNlbGxzID0gPDE+OwoJ
CQkJI3NpemUtY2VsbHMgPSA8MT47CgkJCQljb21wYXRpYmxlID0gImZzbCxlc3BpLWZsYXNoIjsK
CQkJCXJlZyA9IDwwPjsKCQkJCWxpbnV4LG1vZGFsaWFzID0gImZzbF9tMjVwODAiOwoJCQkJc3Bp
LW1heC1mcmVxdWVuY3kgPSA8NDAwMDAwMDA+OyAvKiBpbnB1dCBjbG9jayAqLwoJCQkJcGFydGl0
aW9uQDAgewoJCQkJCWxhYmVsID0gInUtYm9vdC1zcGkiOwoJCQkJCXJlZyA9IDwweDAwMDAwMDAw
IDB4MDAxMDAwMDA+OwoJCQkJCXJlYWQtb25seTsKCQkJCX07CgkJCQlwYXJ0aXRpb25AMTAwMDAw
IHsKCQkJCQlsYWJlbCA9ICJrZXJuZWwtc3BpIjsKCQkJCQlyZWcgPSA8MHgwMDEwMDAwMCAweDAw
NTAwMDAwPjsKCQkJCQlyZWFkLW9ubHk7CgkJCQl9OwoJCQkJcGFydGl0aW9uQDYwMDAwMCB7CgkJ
CQkJbGFiZWwgPSAiZHRiLXNwaSI7CgkJCQkJcmVnID0gPDB4MDA2MDAwMDAgMHgwMDEwMDAwMD47
CgkJCQkJcmVhZC1vbmx5OwoJCQkJfTsKCQkJCXBhcnRpdGlvbkA3MDAwMDAgewoJCQkJCWxhYmVs
ID0gImZpbGUgc3lzdGVtLXNwaSI7CgkJCQkJcmVnID0gPDB4MDA3MDAwMDAgMHgwMDkwMDAwMD47
CgkJCQl9OwoJCQl9OwoJCX07CgoJCWRtYUBjMzAwIHsKCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47
CgkJCSNzaXplLWNlbGxzID0gPDE+OwoJCQljb21wYXRpYmxlID0gImZzbCxlbG9wbHVzLWRtYSI7
CgkJCXJlZyA9IDwweGMzMDAgMHg0PjsKCQkJcmFuZ2VzID0gPDB4MCAweGMxMDAgMHgyMDA+OwoJ
CQljZWxsLWluZGV4ID0gPDE+OwoJCQlkbWEtY2hhbm5lbEAwIHsKCQkJCWNvbXBhdGlibGUgPSAi
ZnNsLGVsb3BsdXMtZG1hLWNoYW5uZWwiOwoJCQkJcmVnID0gPDB4MCAweDgwPjsKCQkJCWNlbGwt
aW5kZXggPSA8MD47CgkJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZtcGljPjsKCQkJCWludGVycnVw
dHMgPSA8NzYgMj47CgkJCX07CgkJCWRtYS1jaGFubmVsQDgwIHsKCQkJCWNvbXBhdGlibGUgPSAi
ZnNsLGVsb3BsdXMtZG1hLWNoYW5uZWwiOwoJCQkJcmVnID0gPDB4ODAgMHg4MD47CgkJCQljZWxs
LWluZGV4ID0gPDE+OwoJCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmbXBpYz47CgkJCQlpbnRlcnJ1
cHRzID0gPDc3IDI+OwoJCQl9OwoJCQlkbWEtY2hhbm5lbEAxMDAgewoJCQkJY29tcGF0aWJsZSA9
ICJmc2wsZWxvcGx1cy1kbWEtY2hhbm5lbCI7CgkJCQlyZWcgPSA8MHgxMDAgMHg4MD47CgkJCQlj
ZWxsLWluZGV4ID0gPDI+OwoJCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmbXBpYz47CgkJCQlpbnRl
cnJ1cHRzID0gPDc4IDI+OwoJCQl9OwoJCQlkbWEtY2hhbm5lbEAxODAgewoJCQkJY29tcGF0aWJs
ZSA9ICJmc2wsZWxvcGx1cy1kbWEtY2hhbm5lbCI7CgkJCQlyZWcgPSA8MHgxODAgMHg4MD47CgkJ
CQljZWxsLWluZGV4ID0gPDM+OwoJCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmbXBpYz47CgkJCQlp
bnRlcnJ1cHRzID0gPDc5IDI+OwoJCQl9OwoJCX07CgoJCWdwaW86IGdwaW8tY29udHJvbGxlckBm
MDAwIHsKCQkJI2dwaW8tY2VsbHMgPSA8Mj47CgkJCWNvbXBhdGlibGUgPSAiZnNsLG1wYzg1NzIt
Z3BpbyI7CgkJCXJlZyA9IDwweGYwMDAgMHgxMDA+OwoJCQlpbnRlcnJ1cHRzID0gPDQ3IDB4Mj47
CgkJCWludGVycnVwdC1wYXJlbnQgPSA8Jm1waWM+OwoJCQlncGlvLWNvbnRyb2xsZXI7CgkJfTsK
CgkJTDI6IGwyLWNhY2hlLWNvbnRyb2xsZXJAMjAwMDAgewoJCQljb21wYXRpYmxlID0gImZzbCxw
MTAyMi1sMi1jYWNoZS1jb250cm9sbGVyIjsKCQkJcmVnID0gPDB4MjAwMDAgMHgxMDAwPjsKCQkJ
Y2FjaGUtbGluZS1zaXplID0gPDMyPjsJLy8gMzIgYnl0ZXMKCQkJY2FjaGUtc2l6ZSA9IDwweDQw
MDAwPjsgLy8gTDIsIDI1NksKCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmbXBpYz47CgkJCS8vaW50
ZXJydXB0cyA9IDwxNiAyPjsKCQl9OwoKCQlkbWFAMjEzMDAgewoJCQkjYWRkcmVzcy1jZWxscyA9
IDwxPjsKCQkJI3NpemUtY2VsbHMgPSA8MT47CgkJCWNvbXBhdGlibGUgPSAiZnNsLGVsb3BsdXMt
ZG1hIjsKCQkJcmVnID0gPDB4MjEzMDAgMHg0PjsKCQkJcmFuZ2VzID0gPDB4MCAweDIxMTAwIDB4
MjAwPjsKCQkJY2VsbC1pbmRleCA9IDwwPjsKCQkJZG1hMDA6IGRtYS1jaGFubmVsQDAgewoJCQkJ
Y29tcGF0aWJsZSA9ICJmc2wsc3NpLWRtYS1jaGFubmVsIjsKCQkJCXJlZyA9IDwweDAgMHg4MD47
CgkJCQljZWxsLWluZGV4ID0gPDA+OwoJCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmbXBpYz47CgkJ
CQlpbnRlcnJ1cHRzID0gPDIwIDI+OwoJCQl9OwoJCQlkbWEwMTogZG1hLWNoYW5uZWxAODAgewoJ
CQkJY29tcGF0aWJsZSA9ICJmc2wsc3NpLWRtYS1jaGFubmVsIjsKCQkJCXJlZyA9IDwweDgwIDB4
ODA+OwoJCQkJY2VsbC1pbmRleCA9IDwxPjsKCQkJCWludGVycnVwdC1wYXJlbnQgPSA8Jm1waWM+
OwoJCQkJaW50ZXJydXB0cyA9IDwyMSAyPjsKCQkJfTsKCQkJZG1hLWNoYW5uZWxAMTAwIHsKCQkJ
CWNvbXBhdGlibGUgPSAiZnNsLGVsb3BsdXMtZG1hLWNoYW5uZWwiOwoJCQkJcmVnID0gPDB4MTAw
IDB4ODA+OwoJCQkJY2VsbC1pbmRleCA9IDwyPjsKCQkJCWludGVycnVwdC1wYXJlbnQgPSA8Jm1w
aWM+OwoJCQkJaW50ZXJydXB0cyA9IDwyMiAyPjsKCQkJfTsKCQkJZG1hLWNoYW5uZWxAMTgwIHsK
CQkJCWNvbXBhdGlibGUgPSAiZnNsLGVsb3BsdXMtZG1hLWNoYW5uZWwiOwoJCQkJcmVnID0gPDB4
MTgwIDB4ODA+OwoJCQkJY2VsbC1pbmRleCA9IDwzPjsKCQkJCWludGVycnVwdC1wYXJlbnQgPSA8
Jm1waWM+OwoJCQkJaW50ZXJydXB0cyA9IDwyMyAyPjsKCQkJfTsKCQl9OwoKCQl1c2JAMjIwMDAg
ewoJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKCQkJI3NpemUtY2VsbHMgPSA8MD47CgkJCWNvbXBh
dGlibGUgPSAiZnNsLXVzYjItZHIiOwoJCQlyZWcgPSA8MHgyMjAwMCAweDEwMDA+OwoJCQlpbnRl
cnJ1cHQtcGFyZW50ID0gPCZtcGljPjsKCQkJaW50ZXJydXB0cyA9IDwyOCAweDI+OwoJCQlwaHlf
dHlwZSA9ICJ1bHBpIjsKCQl9OwoKCQl1c2JAMjMwMDAgewoJCQkjYWRkcmVzcy1jZWxscyA9IDwx
PjsKCQkJI3NpemUtY2VsbHMgPSA8MD47CgkJCWNvbXBhdGlibGUgPSAiZnNsLXVzYjItZHIiOwoJ
CQlyZWcgPSA8MHgyMzAwMCAweDEwMDA+OwoJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZtcGljPjsK
CQkJaW50ZXJydXB0cyA9IDw0NiAweDI+OwoJCQlwaHlfdHlwZSA9ICJ1bHBpIjsKCQl9OwoKCSAg
bWRpb0AyNDAwMCB7CgkJCSNhZGRyZXNzLWNlbGxzID0gPDE+OwoJCQkjc2l6ZS1jZWxscyA9IDww
PjsKCQkJY29tcGF0aWJsZSA9ICJmc2wsZXRzZWMyLW1kaW8iOwoJCQlyZWcgPSA8MHgyNDAwMCAw
eDEwMDAgMHhiMDAzMCAweDQ+OwoKCQkJLy9waHkwOiBldGhlcm5ldC1waHlAMCB7CgkJCS8vCWlu
dGVycnVwdC1wYXJlbnQgPSA8Jm1waWM+OwoJCQkvLwlpbnRlcnJ1cHRzID0gPDMgMT47CgkJCS8v
CXJlZyA9IDwweDE+OwoJCQkvL307CgkJCXBoeTE6IGV0aGVybmV0LXBoeUAxIHsKCQkJCWludGVy
cnVwdC1wYXJlbnQgPSA8Jm1waWM+OwoJCQkJaW50ZXJydXB0cyA9IDw5IDE+OwoJCQkJcmVnID0g
PDB4Mj47CgkJCX07CgkJfTsKCgkJbWRpb0AyNTAwMCB7CgkJCSNhZGRyZXNzLWNlbGxzID0gPDE+
OwoJCQkjc2l6ZS1jZWxscyA9IDwwPjsKCQkJY29tcGF0aWJsZSA9ICJmc2wsZXRzZWMyLW1kaW8i
OwoJCQlyZWcgPSA8MHgyNTAwMCAweDEwMDAgMHhiMTAzMCAweDQ+OwoJCX07CgoJCS8vZW5ldDA6
IGV0aGVybmV0QEIwMDAwIHsKCQkvLwkjYWRkcmVzcy1jZWxscyA9IDwxPjsKCQkvLwkjc2l6ZS1j
ZWxscyA9IDwxPjsKCQkvLwljZWxsLWluZGV4ID0gPDA+OwoJCS8vCWRldmljZV90eXBlID0gIm5l
dHdvcmsiOwoJCS8vCW1vZGVsID0gImVUU0VDIjsKCQkvLwljb21wYXRpYmxlID0gImZzbCxldHNl
YzIiOwoJCS8vCWZzbCxudW1fcnhfcXVldWVzID0gPDB4OD47CgkJLy8JZnNsLG51bV90eF9xdWV1
ZXMgPSA8MHg4PjsKCQkvLwlmc2wsbWFnaWMtcGFja2V0OwoJCS8vCWZzbCx3YWtlLW9uLWZpbGVy
OwoJCS8vCWNsay1oYW5kbGUgPSA8JmV0c2VjMV9jbGs+OwoJCS8vCWxvY2FsLW1hYy1hZGRyZXNz
ID0gWyAwMCAwMCAwMCAwMCAwMCAwMCBdOwoJCS8vCWludGVycnVwdC1wYXJlbnQgPSA8Jm1waWM+
OwoJCS8vCWZpeGVkLWxpbmsgPSA8MSAxIDEwMDAgMCAwPjsKCQkvLwlwaHktaGFuZGxlID0gPCZw
aHkwPjsKCQkvLwlwaHktY29ubmVjdGlvbi10eXBlID0gInJnbWlpLWlkIjsKCQkvLwlxdWV1ZS1n
cm91cEAwewoJCS8vCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKCQkvLwkJI3NpemUtY2VsbHMgPSA8
MT47CgkJLy8JCXJlZyA9IDwweEIwMDAwIDB4MTAwMD47CgkJLy8JCWludGVycnVwdHMgPSA8Mjkg
MiAzMCAyIDM0IDI+OwoJCS8vCX07CgkJLy8JcXVldWUtZ3JvdXBAMXsKCQkvLwkJI2FkZHJlc3Mt
Y2VsbHMgPSA8MT47CgkJLy8JCSNzaXplLWNlbGxzID0gPDE+OwoJCS8vCQlyZWcgPSA8MHhCNDAw
MCAweDEwMDA+OwoJCS8vCQlpbnRlcnJ1cHRzID0gPDE3IDIgMTggMiAyNCAyPjsKCQkvLwl9OwoJ
CS8vfTsKCgkJZW5ldDE6IGV0aGVybmV0QEIxMDAwIHsKCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47
CgkJCSNzaXplLWNlbGxzID0gPDE+OwoJCQljZWxsLWluZGV4ID0gPDA+OwoJCQlkZXZpY2VfdHlw
ZSA9ICJuZXR3b3JrIjsKCQkJbW9kZWwgPSAiZVRTRUMiOwoJCQljb21wYXRpYmxlID0gImZzbCxl
dHNlYzIiOwoJCQlmc2wsbnVtX3J4X3F1ZXVlcyA9IDwweDg+OwoJCQlmc2wsbnVtX3R4X3F1ZXVl
cyA9IDwweDg+OwoJCQljbGstaGFuZGxlID0gPCZldHNlYzJfY2xrPjsKCQkJbG9jYWwtbWFjLWFk
ZHJlc3MgPSBbIDAwIDAwIDAwIDAwIDAwIDAwIF07CgkJCWludGVycnVwdC1wYXJlbnQgPSA8Jm1w
aWM+OwoJCQlmaXhlZC1saW5rID0gPDEgMSAxMDAwIDAgMD47CgkJCXBoeS1oYW5kbGUgPSA8JnBo
eTE+OwoJCQlwaHktY29ubmVjdGlvbi10eXBlID0gInJnbWlpLWlkIjsKCQkJcXVldWUtZ3JvdXBA
MHsKCQkJCSNhZGRyZXNzLWNlbGxzID0gPDE+OwoJCQkJI3NpemUtY2VsbHMgPSA8MT47CgkJCQly
ZWcgPSA8MHhCMTAwMCAweDEwMDA+OwoJCQkJaW50ZXJydXB0cyA9IDwzNSAyIDM2IDIgNDAgMj47
CgkJCX07CgkJCXF1ZXVlLWdyb3VwQDF7CgkJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKCQkJCSNz
aXplLWNlbGxzID0gPDE+OwoJCQkJcmVnID0gPDB4QjUwMDAgMHgxMDAwPjsKCQkJCWludGVycnVw
dHMgPSA8NTEgMiA1MiAyIDY3IDI+OwoJCQl9OwoJCX07CgoJCXNkaGNpQDJlMDAwIHsKCQkJY29t
cGF0aWJsZSA9ICJmc2wscDEwMjItZXNkaGMiLCAiZnNsLGVzZGhjIjsKCQkJcmVnID0gPDB4MmUw
MDAgMHgxMDAwPjsKCQkJaW50ZXJydXB0cyA9IDw3MiAweDI+OwoJCQlpbnRlcnJ1cHQtcGFyZW50
ID0gPCZtcGljPjsKCQkJZnNsLHNkaGNpLWF1dG8tY21kMTI7CgkJCS8qIEZpbGxlZCBpbiBieSBV
LUJvb3QgKi8KCQkJY2xvY2stZnJlcXVlbmN5ID0gPDA+OwoJCX07CgoJCWNyeXB0b0AzMDAwMCB7
CgkJCWNvbXBhdGlibGUgPSAiZnNsLHNlYzMuMyIsICJmc2wsc2VjMy4xIiwgImZzbCxzZWMzLjAi
LAoJCQkJICAgICAiZnNsLHNlYzIuNCIsICJmc2wsc2VjMi4yIiwgImZzbCxzZWMyLjEiLAoJCQkJ
ICAgICAiZnNsLHNlYzIuMCI7CgkJCXJlZyA9IDwweDMwMDAwIDB4MTAwMDA+OwoJCQlpbnRlcnJ1
cHRzID0gPDQ1IDIgNTggMj47CgkJCWludGVycnVwdC1wYXJlbnQgPSA8Jm1waWM+OwoJCQlmc2ws
bnVtLWNoYW5uZWxzID0gPDQ+OwoJCQlmc2wsY2hhbm5lbC1maWZvLWxlbiA9IDwyND47CgkJCWZz
bCxleGVjLXVuaXRzLW1hc2sgPSA8MHg5N2M+OwoJCQlmc2wsZGVzY3JpcHRvci10eXBlcy1tYXNr
ID0gPDB4M2EzMGFiZj47CgkvLwkJZnNsLG11bHRpLWhvc3QtbW9kZSA9ICJkdWFsIjsKCQkJZnNs
LGNoYW5uZWwtcmVtYXAgPSA8MHgzPjsKCQl9OwoKCQlzYXRhQDE4MDAwIHsKCQkJY29tcGF0aWJs
ZSA9ICJmc2wsbXBjODUzNi1zYXRhIiwgImZzbCxwcS1zYXRhIjsKCQkJcmVnID0gPDB4MTgwMDAg
MHgxMDAwPjsKCQkJY2VsbC1pbmRleCA9IDwxPjsKCQkJaW50ZXJydXB0cyA9IDw3NCAweDI+OwoJ
CQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZtcGljPjsKCQl9OwoKCQlzYXRhQDE5MDAwIHsKCQkJY29t
cGF0aWJsZSA9ICJmc2wsbXBjODUzNi1zYXRhIiwgImZzbCxwcS1zYXRhIjsKCQkJcmVnID0gPDB4
MTkwMDAgMHgxMDAwPjsKCQkJY2VsbC1pbmRleCA9IDwyPjsKCQkJaW50ZXJydXB0cyA9IDw0MSAw
eDI+OwoJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZtcGljPjsKCQl9OwoKCQlkaXNwbGF5QDEwMDAw
IHsKCQkJY29tcGF0aWJsZSA9ICJmc2wsZGl1IiwgImZzbCxwMTAyMi1kaXUiOwoJCQlyZWcgPSA8
MHgxMDAwMCAxMDAwPjsKCQkJaW50ZXJydXB0cyA9IDw2NCAyPjsKCQkJaW50ZXJydXB0LXBhcmVu
dCA9IDwmbXBpYz47CgkJfTsKCgkJcG93ZXJAZTAwNzB7CgkJCWNvbXBhdGlibGUgPSAiZnNsLG1w
Yzg1MzYtcG1jIiwgImZzbCxtcGM4NTQ4LXBtYyIsCgkJCQkgICAgICJmc2wscDEwMjItcG1jIjsK
CQkJcmVnID0gPDB4ZTAwNzAgMHgyMD47CgkJCWV0c2VjMV9jbGs6IHNvYy1jbGtAQjB7CgkJCQlm
c2wscG1jZHItbWFzayA9IDwweDAwMDAwMDgwPjsKCQkJfTsKCQkJZXRzZWMyX2Nsazogc29jLWNs
a0BCMXsKCQkJCWZzbCxwbWNkci1tYXNrID0gPDB4MDAwMDAwNDA+OwoJCQl9OwoJCX07CgoJCXRp
bWVyQDQxMTAwIHsKCQkJY29tcGF0aWJsZSA9ICJmc2wsbXBpYy1nbG9iYWwtdGltZXIiOwoJCQly
ZWcgPSA8MHg0MTEwMCAweDIwND47CgkJCWludGVycnVwdHMgPSA8MHhmNyAweDI+OwoJCQlpbnRl
cnJ1cHQtcGFyZW50ID0gPCZtcGljPjsKCQl9OwoKCQltcGljOiBwaWNANDAwMDAgewoJCQlpbnRl
cnJ1cHQtY29udHJvbGxlcjsKCQkJI2FkZHJlc3MtY2VsbHMgPSA8MD47CgkJCSNpbnRlcnJ1cHQt
Y2VsbHMgPSA8Mj47CgkJCXJlZyA9IDwweDQwMDAwIDB4NDAwMDA+OwoJCQljb21wYXRpYmxlID0g
ImNocnAsb3Blbi1waWMiOwoJCQkvL2NvbXBhdGlibGUgPSAiZnNsLG1waWMiOwoJCQlkZXZpY2Vf
dHlwZSA9ICJvcGVuLXBpYyI7CgkJCXBpYy1uby1yZXNldDsKCQkJcHJvdGVjdGVkLXNvdXJjZXMg
PSA8CgkJCQkxNgkJCS8vIGwyLWNhY2hlLWNvbnRyb2xsZXJAMjAwMDAKCQkJCTMJCQkvLyBldGhl
cm5ldC1waHlAMAoJCQkJMjkgMzAgMzQJLy8gcXVldWUtZ3JvdXBAMAoJCQkJMTcgMTggMjQJLy8g
Z3VldWUtZ3JvdXBAMQoJCQkJNDIJCQkvLyBzZXJpYWxANDUwMAoJCQk+OwoJCX07CgoJCW1lc3Nh
Z2VANDE0MDAgewoJCQljb21wYXRpYmxlID0gImZzbCxwMTAyMi1tc2ciLCJmc2wsbXBpYy1tc2ci
OwoJCQlyZWcgPSA8MHg0MTQwMCAweDIwMD47CgkJCWNlbGwtaW5kZXggPSA8MT47CgkJCWludGVy
cnVwdHMgPSA8MHhiMCAyIDB4YjEgMiAweGIyIDIgMHhiMyAyPjsKCQkJaW50ZXJydXB0LXBhcmVu
dCA9IDwgJm1waWMgPjsKCQl9OwoKCQltZXNzYWdlQDQyNDAwIHsKCQkJY29tcGF0aWJsZSA9ICJm
c2wscDEwMjItbXNnIiwiZnNsLG1waWMtbXNnIjsKCQkJcmVnID0gPDB4NDI0MDAgMHgyMDA+OwoJ
CQljZWxsLWluZGV4ID0gPDI+OwoJCQlpbnRlcnJ1cHRzID0gPDB4YjQgMiAweGI1IDIgMHhiNiAy
IDB4YjcgMj47CgkJCWludGVycnVwdC1wYXJlbnQgPSA8ICZtcGljID47CgkJfTsKCgkJbXNpQDQx
NjAwIHsKCQkJY29tcGF0aWJsZSA9ICJmc2wsbXBpYy1tc2kiOwoJCQlyZWcgPSA8MHg0MTYwMCAw
eDgwPjsKCQkJbXNpLWF2YWlsYWJsZS1yYW5nZXMgPSA8MCAweDEwMD47CgkJCWludGVycnVwdHMg
PSA8CgkJCQkweGUwIDAKCQkJCTB4ZTEgMAoJCQkJMHhlMiAwCgkJCQkweGUzIDAKCQkJCTB4ZTQg
MAoJCQkJMHhlNSAwCgkJCQkweGU2IDAKCQkJCTB4ZTcgMD47CgkJCWludGVycnVwdC1wYXJlbnQg
PSA8Jm1waWM+OwoJCX07CgoJCWdsb2JhbC11dGlsaXRpZXNAZTAwMDAgewkvL2dsb2JhbCB1dGls
aXRpZXMgYmxvY2sKCQkJY29tcGF0aWJsZSA9ICJmc2wscDEwMjItZ3V0cyI7CgkJCXJlZyA9IDww
eGUwMDAwIDB4MTAwMD47CgkJCWZzbCxoYXMtcnN0Y3I7CgkJfTsKCX07CgoJcGNpMDogcGNpZUBm
ZmUwOTAwMCB7CgkJY2VsbC1pbmRleCA9IDwyPjsKCQljb21wYXRpYmxlID0gImZzbCxwMTAyMi1w
Y2llIjsKCQlkZXZpY2VfdHlwZSA9ICJwY2kiOwoJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47CgkJ
I3NpemUtY2VsbHMgPSA8Mj47CgkJI2FkZHJlc3MtY2VsbHMgPSA8Mz47CgkJcmVnID0gPDAgMHhm
ZmUwOTAwMCAwIDB4MTAwMD47CgkJYnVzLXJhbmdlID0gPDAgMjU1PjsKCQlyYW5nZXMgPSA8MHgy
MDAwMDAwIDB4MCAweGEwMDAwMDAwIDAgMHhhMDAwMDAwMCAweDAgMHgyMDAwMDAwMAoJCQkgIDB4
MTAwMDAwMCAweDAgMHgwMDAwMDAwMCAwIDB4ZmZjMTAwMDAgMHgwIDB4MTAwMDA+OwoJCWNsb2Nr
LWZyZXF1ZW5jeSA9IDwzMzMzMzMzMz47CgkJaW50ZXJydXB0LXBhcmVudCA9IDwmbXBpYz47CgkJ
aW50ZXJydXB0cyA9IDwxNiAyPjsKCQlpbnRlcnJ1cHQtbWFwLW1hc2sgPSA8MHhmODAwIDAgMCA3
PjsKCQlpbnRlcnJ1cHQtbWFwID0gPAoJCQkvKiBJRFNFTCAweDAgKi8KCQkJMDAwMCAwIDAgMSAm
bXBpYyA0IDEKCQkJMDAwMCAwIDAgMiAmbXBpYyA1IDEKCQkJMDAwMCAwIDAgMyAmbXBpYyA2IDEK
CQkJMDAwMCAwIDAgNCAmbXBpYyA3IDEKCQkJPjsKCQlwY2llQDAgewoJCQlyZWcgPSA8MHgwIDB4
MCAweDAgMHgwIDB4MD47CgkJCSNzaXplLWNlbGxzID0gPDI+OwoJCQkjYWRkcmVzcy1jZWxscyA9
IDwzPjsKCQkJZGV2aWNlX3R5cGUgPSAicGNpIjsKCQkJcmFuZ2VzID0gPDB4MjAwMDAwMCAweDAg
MHhhMDAwMDAwMAoJCQkJICAweDIwMDAwMDAgMHgwIDB4YTAwMDAwMDAKCQkJCSAgMHgwIDB4MjAw
MDAwMDAKCgkJCQkgIDB4MTAwMDAwMCAweDAgMHgwCgkJCQkgIDB4MTAwMDAwMCAweDAgMHgwCgkJ
CQkgIDB4MCAweDEwMDAwMD47CgkJfTsKCX07CgoJcGNpMTogcGNpZUBmZmUwYTAwMCB7CgkJY2Vs
bC1pbmRleCA9IDwxPjsKCQljb21wYXRpYmxlID0gImZzbCxwMTAyMi1wY2llIjsKCQlkZXZpY2Vf
dHlwZSA9ICJwY2kiOwoJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47CgkJI3NpemUtY2VsbHMgPSA8
Mj47CgkJI2FkZHJlc3MtY2VsbHMgPSA8Mz47CgkJcmVnID0gPDAgMHhmZmUwYTAwMCAwIDB4MTAw
MD47CgkJYnVzLXJhbmdlID0gPDAgMjU1PjsKCQlyYW5nZXMgPSA8MHgyMDAwMDAwIDB4MCAweGMw
MDAwMDAwIDAgMHhjMDAwMDAwMCAweDAgMHgyMDAwMDAwMAoJCQkgIDB4MTAwMDAwMCAweDAgMHgw
MDAwMDAwMCAwIDB4ZmZjMjAwMDAgMHgwIDB4MTAwMDA+OwoJCWNsb2NrLWZyZXF1ZW5jeSA9IDwz
MzMzMzMzMz47CgkJaW50ZXJydXB0LXBhcmVudCA9IDwmbXBpYz47CgkJaW50ZXJydXB0cyA9IDwx
NiAyPjsKCQlpbnRlcnJ1cHQtbWFwLW1hc2sgPSA8MHhmODAwIDAgMCA3PjsKCQlpbnRlcnJ1cHQt
bWFwID0gPAoJCQkvKiBJRFNFTCAweDAgKi8KCQkJMDAwMCAwIDAgMSAmbXBpYyAwIDEKCQkJMDAw
MCAwIDAgMiAmbXBpYyAxIDEKCQkJMDAwMCAwIDAgMyAmbXBpYyAyIDEKCQkJMDAwMCAwIDAgNCAm
bXBpYyAzIDEKCQkJPjsKCQlwY2llQDAgewoJCQlyZWcgPSA8MHgwIDB4MCAweDAgMHgwIDB4MD47
CgkJCSNzaXplLWNlbGxzID0gPDI+OwoJCQkjYWRkcmVzcy1jZWxscyA9IDwzPjsKCQkJZGV2aWNl
X3R5cGUgPSAicGNpIjsKCQkJcmFuZ2VzID0gPDB4MjAwMDAwMCAweDAgMHhjMDAwMDAwMAoJCQkJ
ICAweDIwMDAwMDAgMHgwIDB4YzAwMDAwMDAKCQkJCSAgMHgwIDB4MjAwMDAwMDAKCgkJCQkgIDB4
MTAwMDAwMCAweDAgMHgwCgkJCQkgIDB4MTAwMDAwMCAweDAgMHgwCgkJCQkgIDB4MCAweDEwMDAw
MD47CgkJfTsKCX07CgoKCXBjaTI6IHBjaWVAZmZlMGIwMDAgewoJCWNlbGwtaW5kZXggPSA8Mz47
CgkJY29tcGF0aWJsZSA9ICJmc2wscDEwMjItcGNpZSI7CgkJZGV2aWNlX3R5cGUgPSAicGNpIjsK
CQkjaW50ZXJydXB0LWNlbGxzID0gPDE+OwoJCSNzaXplLWNlbGxzID0gPDI+OwoJCSNhZGRyZXNz
LWNlbGxzID0gPDM+OwoJCXJlZyA9IDwwIDB4ZmZlMGIwMDAgMCAweDEwMDA+OwoJCWJ1cy1yYW5n
ZSA9IDwwIDI1NT47CgkJcmFuZ2VzID0gPDB4MjAwMDAwMCAweDAgMHg4MDAwMDAwMCAwIDB4ODAw
MDAwMDAgMHgwIDB4MjAwMDAwMDAKCQkJICAweDEwMDAwMDAgMHgwIDB4MDAwMDAwMDAgMCAweGZm
YzAwMDAwIDB4MCAweDEwMDAwPjsKCQljbG9jay1mcmVxdWVuY3kgPSA8MzMzMzMzMzM+OwoJCWlu
dGVycnVwdC1wYXJlbnQgPSA8Jm1waWM+OwoJCWludGVycnVwdHMgPSA8MTYgMj47CgkJaW50ZXJy
dXB0LW1hcC1tYXNrID0gPDB4ZjgwMCAwIDAgNz47CgkJaW50ZXJydXB0LW1hcCA9IDwKCQkJLyog
SURTRUwgMHgwICovCgkJCTAwMDAgMCAwIDEgJm1waWMgOCAxCgkJCTAwMDAgMCAwIDIgJm1waWMg
OSAxCgkJCTAwMDAgMCAwIDMgJm1waWMgMTAgMQoJCQkwMDAwIDAgMCA0ICZtcGljIDExIDEKCQkJ
PjsKCQlwY2llQDAgewoJCQlyZWcgPSA8MHgwIDB4MCAweDAgMHgwIDB4MD47CgkJCSNzaXplLWNl
bGxzID0gPDI+OwoJCQkjYWRkcmVzcy1jZWxscyA9IDwzPjsKCQkJZGV2aWNlX3R5cGUgPSAicGNp
IjsKCQkJcmFuZ2VzID0gPDB4MjAwMDAwMCAweDAgMHg4MDAwMDAwMAoJCQkJICAweDIwMDAwMDAg
MHgwIDB4ODAwMDAwMDAKCQkJCSAgMHgwIDB4MjAwMDAwMDAKCgkJCQkgIDB4MTAwMDAwMCAweDAg
MHgwCgkJCQkgIDB4MTAwMDAwMCAweDAgMHgwCgkJCQkgIDB4MCAweDEwMDAwMD47CgkJfTsKCX07
Cn07Cg==

--_005_93CD5F41FDBC6042A6B449764F3B35CC050C38FBEUMBX03mgcmento_--
