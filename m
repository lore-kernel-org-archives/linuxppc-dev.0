Return-Path: <vjai22@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4AE10B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 20 Jul 2009 04:44:35 +1000 (EST)
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.173])
	by ozlabs.org (Postfix) with ESMTP id 89CC5DDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Jul 2009 04:44:33 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so577780wfg.15
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Jul 2009 11:44:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e571380d0907191132u3985423aiacc7ec8c75c0534b@mail.gmail.com>
References: <e571380d0907191132u3985423aiacc7ec8c75c0534b@mail.gmail.com>
Date: Mon, 20 Jul 2009 00:06:42 +0530
Message-ID: <e571380d0907191136j37d341d7k514f46396a38abc3@mail.gmail.com>
Subject: PPCboot and latest kernel
From: vijay sharma <vjai22@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=000e0cd3116a85061f046f134daa
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd3116a85061f046f134daa
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi ALL,
I have been woking on upgrading an embedded system based on MPC8241 from
2.4.17 linux to 2.6.30 kernel.
I am currently struck one point.

Here is the console output where I am struck:
=================================
cpboot> bootm
## Booting image at 08000000 ...
   Image Name:   Linux-2.6.30
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    21729342 Bytes = 21220 kB = 20 MB
   Load Address: 01900000
   Entry Point:  01900570
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory <- <0x0 0x10000000> (256MB)
CPU clock-frequency <- 0xbebc1fe (200MHz)
CPU timebase-frequency <- 0x17d783f (25MHz)
CPU bus-frequency <- 0x5f5e0ff (100MHz)

zImage starting: loaded at 0x01900000 (sp: 0x0fdc3a08)
Allocating 0x165ca04 bytes for kernel ...
gunzipping (0x00000000 <- 0x0190c000:0x02f58efc)...done 0x1637b54 bytes

Linux/PowerPC load:
Finalizing device tree... flat tree at 0x2f65300 <== Beyond this point no
output is available.
(The size of image is 20MB because ramfs embedded inside the image)

==================================

Here are the steps I have taken till now.
1) Defined platform.dts file for my platform. Since I am using MPC8241, I
have taken cuboot-824x.c. Is this file correct.
Do I need to define my own cuboot-*.c file ?

2)Built cuImage and loaded it into memory. I am not seeing any output once
control passes from wrapper to kernel. As you can see from logs mentioned
above.

While going through mail achieves I found two possible reasons for this
1) Wrong entries inside dts file
I am sure serial attributes are correctly defined inside the file. Also it
works for wrapper. It should work for linux also.

2) PPCboot not providing information.
I have built cuImage . Shouldn't kernel be getting its attributes from dtb
file rather then depending on bd_info structure.
I cannot upgrade to uboot. Is there some way I can make my board come up?

Thanks in advance,
Vijay

--000e0cd3116a85061f046f134daa
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">Hi ALL,<div><br></div><div>I have been woking on=
 upgrading an embedded system based on MPC8241 from 2.4.17 linux to 2.6.30 =
kernel.</div><div>I am currently struck one point.</div><div><br></div><div=
>
Here is the console output where I am struck:=A0</div>
<div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>cpboot&gt; bootm</div><div>## Boot=
ing image at 08000000 ...</div><div>=A0=A0 Image Name: =A0 Linux-2.6.30</di=
v><div>=A0=A0 Image Type: =A0 PowerPC Linux Kernel Image (gzip compressed)<=
/div>

<div>=A0=A0 Data Size: =A0 =A021729342 Bytes =3D 21220 kB =3D 20 MB</div><d=
iv>=A0=A0 Load Address: 01900000</div><div>=A0=A0 Entry Point: =A001900570<=
/div><div>=A0=A0 Verifying Checksum ... OK</div><div>=A0=A0 Uncompressing K=
ernel Image ... OK</div><div>

Memory &lt;- &lt;0x0 0x10000000&gt; (256MB)</div><div>CPU clock-frequency &=
lt;- 0xbebc1fe (200MHz)</div><div>CPU timebase-frequency &lt;- 0x17d783f (2=
5MHz)</div><div>CPU bus-frequency &lt;- 0x5f5e0ff (100MHz)</div><div><br>

</div><div>zImage starting: loaded at 0x01900000 (sp: 0x0fdc3a08)</div><div=
>Allocating 0x165ca04 bytes for kernel ...</div><div>gunzipping (0x00000000=
 &lt;- 0x0190c000:0x02f58efc)...done 0x1637b54 bytes</div><div><br></div>

<div>Linux/PowerPC load:</div><div>Finalizing device tree... flat tree at 0=
x2f65300=A0&lt;=3D=3D Beyond this point no output is available.</div><div>(=
The size of image is 20MB because ramfs embedded inside the image)</div><di=
v>

<br></div><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div><br></div><div>Here ar=
e the steps I have taken till now.</div><div>1) Defined platform.dts file f=
or my platform. Since I am using MPC8241, I have taken cuboot-824x.c. Is th=
is file correct.=A0</div>

<div>Do I need to define my own cuboot-*.c file ?</div><div><br></div><div>=
2)Built cuImage and loaded it into memory. I am not seeing any output once =
control passes from wrapper to kernel. As you can see from logs mentioned a=
bove.</div>

<div><br></div><div>While going through mail=A0achieves=A0I found two possi=
ble reasons for this=A0</div><div>1) Wrong entries inside dts file</div><di=
v>I am sure serial attributes are=A0correctly=A0defined inside the file. Al=
so it works for wrapper. It should work for linux also.</div>

<div><br></div><div>2) PPCboot not providing information.</div><div>I have =
built cuImage .=A0Shouldn&#39;t=A0kernel be getting its attributes from dtb=
 file rather then depending on bd_info structure.</div><div>I cannot upgrad=
e to uboot. Is there some way I can make my board come up?</div>

<div><br></div><div>Thanks in advance,</div><div>Vijay</div><font color=3D"=
#888888"><div><br></div>
</font></div><br>

--000e0cd3116a85061f046f134daa--
