Return-Path: <Farrukh_Arshad@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "relay1.mentorg.com",
 Issuer "Entrust Certification Authority - L1B" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CF6A41007D4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 20:14:49 +1100 (EST)
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
 by relay1.mentorg.com with esmtp
 id 1RVJAq-0003aD-Mp from Farrukh_Arshad@mentor.com
 for linuxppc-dev@lists.ozlabs.org; Tue, 29 Nov 2011 00:36:20 -0800
From: "Arshad, Farrukh" <Farrukh_Arshad@mentor.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Booting Linux on one core of P1022
Date: Tue, 29 Nov 2011 08:36:18 +0000
Message-ID: <93CD5F41FDBC6042A6B449764F3B35CC050B8ADA@EU-MBX-01.mgc.mentorg.com>
Content-Type: multipart/alternative;
 boundary="_000_93CD5F41FDBC6042A6B449764F3B35CC050B8ADAEUMBX01mgcmento_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_93CD5F41FDBC6042A6B449764F3B35CC050B8ADAEUMBX01mgcmento_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Greetings All,

I am working on P1022RDK (P1022 Processor). I am trying to bring up LTIB Li=
nux only on Core1 of the processor. I have configured the "cpus" node in th=
e device tree file as following way

Cpus {
     #address-cells =3D <1>;
     #size-cells =3D <0>;
     PowerPC,P1022@1 {
           Device_type =3D "cpu";
          Ret =3D <0x1>;
           Next-level-cache =3D <&L2>;
     };
};

Mpic: pic@40000 {
     Interrupt-controller;
     #address-cells =3D <0>;
     #interrupt-cells =3D <2>;
     Reg =3D <0x40000 0x40000>;
     Compatible =3D "chrp,open-pic";
     Device_type =3D "open-pic";
     Pic-no-reset;
     Protected-sources =3D <
           16         // l2-cache-controller@20000
     >;
};

I am loading the kernel from Uboot as following way

Setenv bootm_low 0x10000000
Setenv bootm_size 0x10000000
Setenv bootm boot=3D/dev/mmcblk0p3 ro debug rootdelay=3D5
Interrupts off
Bootm start $load1addr - $fdt1addr
Bootm loados
Bootm fdt
Fdt boardsetup
Fdt chosen
Bootm prep
Bootm go

Using above configuration when the kernel boots it fails giving following m=
essage

[    2.057448] WM8960 I2C Codec 1-001a: No platform data supplied
[    3.062314] WM8960 I2C Codec 1-001a: Failed to issue reset
[    3.067816] WM8960 I2C Codec: probe of 1-001a failed with error -110
[    3.074528] No device for DAI WM8990 ADC/DAC Primary
[    3.079834] ALSA device list:
[    3.082821]   No soundcards found.
[    3.087561] IPv4 over IPv4 tunneling driver
[    3.092757] GRE over IPv4 tunneling driver
[    3.097871] TCP cubic registered
[    3.101124] Initializing XFRM netlink socket
[    3.105405] NET: Registered protocol family 17
[    3.109869] NET: Registered protocol family 15
[    3.114734] SCTP: Hash tables configured (established 8192 bind 8192)
[    3.122984] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    3.129329] Waiting 5sec before mounting root device...
[    8.138471] Root-NFS: No NFS server available, giving up.
[    8.143896] VFS: Unable to mount root fs via NFS, trying floppy.
[    8.150150] VFS: Cannot open root device "mmcblk0p3" or unknown-block(2,=
0)
[    8.157038] Please append a correct "root=3D" boot option; here are the =
available partitions:
[    8.165410] Kernel panic - not syncing: VFS: Unable to mount root fs on =
unknown-block(2,0)
[    8.173681] Rebooting in 180 seconds..
[   11.994301] mmc0: Timeout waiting for hardware interrupt.
[   11.999870] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REGISTER D=
UMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   12.005697] sdhci: Sys addr: 0x00000000 | Version:  0x00001201
[   12.011523] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000001
[   12.017349] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
[   12.023175] sdhci: Present:  0xff8d0008 | Host ctl: 0x00000020
[   12.029001] sdhci: Power:    0x00000003 | Blk gap:  0x00000000
[   12.034828] sdhci: Wake-up:  0x00000000 | Clock:    0x000010ff
[   12.040654] sdhci: Timeout:  0x00000000 | Int stat: 0x00000001
[   12.046479] sdhci: Int enab: 0x007f0003 | Sig enab: 0x007f0003
[   12.052305] sdhci: AC12 err: 0x00000000 | Slot int: 0x00001201
[   12.058130] sdhci: Caps:     0x05f30000 | Max curr: 0x00000000
[   12.063955] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

When I boot the same kernel using 2 CPUs in the device tree file, it boots =
successfully. Any thoughts on what I am missing.


Best Regards

Farrukh Arshad
Sr. Software Development Engineer
Mentor Graphics Pakistan
Ph:   +92 - 423 - 609 - 92 - 09
Cell: +92 - 303 - 444 - 77 - 05


--_000_93CD5F41FDBC6042A6B449764F3B35CC050B8ADAEUMBX01mgcmento_
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
<p class=3D"MsoNormal">I am working on P1022RDK (P1022 Processor). I am try=
ing to bring up LTIB Linux only on Core1 of the processor. I have configure=
d the &#8220;cpus&#8221; node in the device tree file as following way<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Cpus {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =3D &lt;1&gt;;<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; #size-cells =3D &lt;0&gt;;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; PowerPC,P1022@1 {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device_type =
=3D &#8220;cpu&#8221;;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Ret =3D &lt;0x1&gt;;<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Next-level-cac=
he =3D &lt;&amp;L2&gt;;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; };<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
};<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
<o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Mpic: pic@40000 {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; Interrupt-controller;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =3D &lt;0&gt;;<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; #interrupt-cells =3D &lt;2&gt;;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; Reg =3D &lt;0x40000 0x40000&gt;;<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; Compatible =3D &#8220;chrp,open-pic&#8221;;<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; Device_type =3D &#8220;open-pic&#8221;;<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; Pic-no-reset;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; Protected-sources =3D &lt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // l2-cache-controller@20000<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
&nbsp;&nbsp;&nbsp;&nbsp; &gt;;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
};<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am loading the kernel from Uboot as following way<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Setenv bootm_low 0x10000000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Setenv bootm_size 0x10000000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Setenv bootm boot=3D/dev/mmcblk0p3 ro debug rootdelay=3D5<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Interrupts off<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Bootm start $load1addr - $fdt1addr<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Bootm loados<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Bootm fdt<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Fdt boardsetup<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Fdt chosen<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Bootm prep<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
Bootm go</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Using above configuration when the kernel boots it f=
ails giving following message<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 2.057448] WM8960 I2C Codec 1-001a: No platform data sup=
plied<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 3.062314] WM8960 I2C Codec 1-001a: Failed to issue rese=
t<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 3.067816] WM8960 I2C Codec: probe of 1-001a failed with=
 error -110<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 3.074528] No device for DAI WM8990 ADC/DAC Primary<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 3.079834] ALSA device list:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 3.082821]&nbsp;&nbsp; No soundcards found.<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 3.087561] IPv4 over IPv4 tunneling driver<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 3.092757] GRE over IPv4 tunneling driver<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 3.097871] TCP cubic registered<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 3.101124] Initializing XFRM netlink socket<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 3.105405] NET: Registered protocol family 17<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 3.109869] NET: Registered protocol family 15<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 3.114734] SCTP: Hash tables configured (established 819=
2 bind 8192)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 3.122984] drivers/rtc/hctosys.c: unable to open rtc dev=
ice (rtc0)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 3.129329] Waiting 5sec before mounting root device...<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 8.138471] Root-NFS: No NFS server available, giving up.=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 8.143896] VFS: Unable to mount root fs via NFS, trying =
floppy.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 8.150150] VFS: Cannot open root device &quot;mmcblk0p3&=
quot; or unknown-block(2,0)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 8.157038] Please append a correct &quot;root=3D&quot; b=
oot option; here are the available partitions:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 8.165410] Kernel panic - not syncing: VFS: Unable to mo=
unt root fs on unknown-block(2,0)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp;&nbsp; 8.173681] Rebooting in 180 seconds..<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp; 11.994301] mmc0: Timeout waiting for hardware interrupt.<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp; 11.999870] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
REGISTER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp; 12.005697] sdhci: Sys addr: 0x00000000 | Version:&nbsp; 0x000=
01201<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp; 12.011523] sdhci: Blk size: 0x00000000 | Blk cnt:&nbsp; 0x000=
00001<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp; 12.017349] sdhci: Argument: 0x00000000 | Trn mode: 0x00000000=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp; 12.023175] sdhci: Present:&nbsp; 0xff8d0008 | Host ctl: 0x000=
00020<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp; 12.029001] sdhci: Power:&nbsp;&nbsp;&nbsp; 0x00000003 | Blk g=
ap:&nbsp; 0x00000000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp; 12.034828] sdhci: Wake-up:&nbsp; 0x00000000 | Clock:&nbsp;&nb=
sp;&nbsp; 0x000010ff<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp; 12.040654] sdhci: Timeout:&nbsp; 0x00000000 | Int stat: 0x000=
00001<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp; 12.046479] sdhci: Int enab: 0x007f0003 | Sig enab: 0x007f0003=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp; 12.052305] sdhci: AC12 err: 0x00000000 | Slot int: 0x00001201=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp; 12.058130] sdhci: Caps:&nbsp;&nbsp;&nbsp;&nbsp; 0x05f30000 | =
Max curr: 0x00000000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;">=
[&nbsp;&nbsp; 12.063955] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">When I boot the same kernel using 2 CPUs in the devi=
ce tree file, it boots successfully. Any thoughts on what I am missing.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
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

--_000_93CD5F41FDBC6042A6B449764F3B35CC050B8ADAEUMBX01mgcmento_--
