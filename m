Return-Path: <gramaalexandruionut@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by ozlabs.org (Postfix) with ESMTP id 0B2571007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Dec 2010 12:11:18 +1100 (EST)
Received: by wyi11 with SMTP id 11so9505870wyi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Dec 2010 17:11:15 -0800 (PST)
MIME-Version: 1.0
From: Alexandru Ionut Grama <gramaalexandruionut@gmail.com>
Date: Wed, 29 Dec 2010 02:10:55 +0100
Message-ID: <AANLkTikjjGGd5h7TsQtEuSjX3qhJv3wC28UtWHtJ19jo@mail.gmail.com>
Subject: problem backporting talitos for MPC8272
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: multipart/alternative; boundary=0016e6de17bae960960498823ed3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e6de17bae960960498823ed3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

I'm trying to backporting cryptoApi from 2.6.35.7 to 2.6.21 for making
backward compatibility with the crypto-processor of powerpc MPC8272. This
uses the SEC1.0 from Freescale for crypto. This processor it's mounted on a
custom board with a non-standard closed bootloader, but it can pass
parameters to the kernel.

I've made already the backport for the cryptoApi and talitos and the
compiles and runs. Consulting /proc/crypto I can see normal results, but no
drivers involving talitos. This it's normal because talitos_init() runs, bu=
t
not talitos_probe(). =BFWhy? =BFHow can I force a driver to be probed? I ca=
n see
that talitos it's registered on "of drivers tree", but nobody calls the
function talitos_probe(). I've making print this activating the print of
changing kobject on Kernel Hacking.

My final question it's about of-tree. I have the mpc8272ads.dts file with a
tree that involves talitos, but I've changed the properties acording the ne=
w
version of it on 2.6.35. =BFThis file (mpc8272ads.dts) when it's used?I thi=
nk
I don't use this file for nothing (it doesn't appears on make V=3D1) becaus=
e I
don't have a normal bootloader and I have to load the kernel like a
flat-binary gz, so there's no more step after building System.map.

In the ocf-linux talitos driver specifications says that the only differenc=
e
between SEC1.0 and SEC2.0 it's the clock velocity. It has the same number o=
f
channels and so on... =BFso talitos can be compatible with SEC1.0?

Also, =BFwhere I can submit the work already done (backporting of cryptoApi=
) ?
Maybe it's useful for someone.

I appreciate your help because this work it's a part for my finial bachelor
work.Thank you.

King regads,
Alexandru.

--=20
*---------------------------------------------------------------
Alexandru Ionut Grama
**email: gramaalexandruionut@gmail.com**
*

--0016e6de17bae960960498823ed3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>I&#39;m trying to backporting cryptoApi from 2.6.35.7 to 2.6.=
21 for making backward compatibility with the crypto-processor of powerpc M=
PC8272. This uses the SEC1.0 from Freescale for crypto. This processor it&#=
39;s mounted on a custom board with a non-standard closed bootloader, but i=
t can pass parameters to the kernel.<br>

<br>I&#39;ve made already the backport for the cryptoApi and talitos and th=
e compiles and runs. Consulting /proc/crypto I can see normal results, but =
no drivers involving talitos. This it&#39;s normal because talitos_init() r=
uns, but not talitos_probe(). =BFWhy? =BFHow can I force a driver to be pro=
bed? I can see that talitos it&#39;s registered on &quot;of drivers tree&qu=
ot;, but nobody calls the function talitos_probe(). I&#39;ve making print t=
his activating the print of changing kobject on Kernel Hacking.<br>

<br>My final question it&#39;s about of-tree. I have the mpc8272ads.dts fil=
e with a tree that involves talitos, but I&#39;ve changed the properties ac=
ording the new version of it on 2.6.35. =BFThis file (mpc8272ads.dts) when =
it&#39;s used?I think I don&#39;t use this file for nothing (it doesn&#39;t=
 appears on make V=3D1) because I don&#39;t have a normal bootloader and I =
have to load the kernel like a flat-binary gz, so there&#39;s no more step =
after building System.map.<br>

<br>In the ocf-linux talitos driver specifications says that the only diffe=
rence between SEC1.0 and SEC2.0 it&#39;s the clock velocity. It has the sam=
e number of channels and so on... =BFso talitos can be compatible with SEC1=
.0?<br>

<br>Also, =BFwhere I can submit the work already done (backporting of crypt=
oApi) ? Maybe it&#39;s useful for someone.<br><br>I appreciate your help be=
cause this work it&#39;s a part for my finial bachelor work.Thank you.<br>

<br>King regads,<br>Alexandru.=A0 <br clear=3D"all"><br>-- <br><b>---------=
------------------------------------------------------<br>Alexandru Ionut G=
rama<br></b><i style=3D"color: rgb(102, 102, 102);">email: <a href=3D"mailt=
o:gramaalexandruionut@gmail.com" target=3D"_blank">gramaalexandruionut@gmai=
l.com</a></i><b><br>

</b><br>

--0016e6de17bae960960498823ed3--
