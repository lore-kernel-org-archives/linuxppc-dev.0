Return-Path: <madskateman@gmail.com>
Received: from mail-qt0-x22d.google.com (mail-qt0-x22d.google.com
 [IPv6:2607:f8b0:400d:c0d::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLfK86y94zF0Yv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 05:44:44 +1100 (AEDT)
Received: by mail-qt0-x22d.google.com with SMTP id m59so19487893qte.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 10:44:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1516125454.18795.87.camel@infinera.com>
References: <CAHkrCmFCzPd_a1UmyfuZHKM4hXvou0uO0FYoG5bd_fxE8QMueg@mail.gmail.com>
 <DB3PR0402MB3849EEF00D71FF7A230B70C3ECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516035556.18795.71.camel@infinera.com> <20180116143836.GC22903@lunn.ch>
 <1516125454.18795.87.camel@infinera.com>
From: mad skateman <madskateman@gmail.com>
Date: Tue, 16 Jan 2018 19:44:41 +0100
Message-ID: <CAHkrCmE5GzvkKTm5=Yy5QxKOL_OJn+9xrWLjhH=Zayg_nsQt7A@mail.gmail.com>
Subject: Re: DPAA Ethernet traffice troubles with Linux kernel
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "madalin.bucur@nxp.com" <madalin.bucur@nxp.com>
Content-Type: multipart/alternative; boundary="94eb2c124be8b3b22e0562e91f17"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--94eb2c124be8b3b22e0562e91f17
Content-Type: text/plain; charset="UTF-8"

Hi,

I have been looking deeper into my wireshark packet captures and found
something that could be helpfull.

I can see that the Ethernet NIC at least does something. ARP BROADCAST
traffic is seen.
But i also found some packets...which have LG BITs set to 1 .. when i think
0 should be the correct value..something with Octets.

*"the first 3 octets/first-half of a MAC-48/EUI-48 Address, correspond to
the OUI (e.g.: MAC = 06:00:00:xx:xx:xx, OUI = 06:00:00), and the 2nd least
significant bit of its first octet is used to differentiate "Universally"
and "Locally" administered addresses). In other words, if we convert 06
(Hex) to 00000110 (Binary), we can see that the U/L bit is set to one,
which means that it a locally administered address.*

*Given this if we disable that bit, we get the matching "Universally
Administered Address" 00000100 (Binary), 04 (Hex) -> "04:00:00", hence my
question:"*

This has something to do with the MAC adresses being locally administered
.. and since whe can use Uboot and choose any Mac addr we want, this could
make sense..

These types of Logs also apear in my Wireshark Capture files... ( these are
not my org. logs)

Ethernet II, Src: Microchi_8f:c6:a8 (d8:80:39:8f:c6:a8), Dst: Broadcast
(ff:ff:ff:ff:ff:ff)
Destination: Broadcast (ff:ff:ff:ff:ff:ff)
Address: Broadcast (ff:ff:ff:ff:ff:ff)
.... ..1. .... .... .... .... = LG bit: Locally administered address (this
is NOT the factory default)
.... ...1 .... .... .... .... = IG bit: Group address (multicast/broadcast)
Source: Microchi_8f:c6:a8 (d8:80:39:8f:c6:a8)
Address: Microchi_8f:c6:a8 (d8:80:39:8f:c6:a8)
.... ..0. .... .... .... .... = LG bit: Globally unique address (factory
default)
.... ...0 .... .... .... .... = IG bit: Individual address (unicast)
Type: IP (0x0800)
Internet Protocol Version 4, Src: 0.0.0.0 (0.0.0.0), Dst: 255.255.255.255
(255.255.255.255)

In the link below some similair Logs and problems regarding DHCP for
example.

Dave

--94eb2c124be8b3b22e0562e91f17
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_extra"><spa=
n style=3D"font-size:12.8px">Hi,</span></div><div class=3D"gmail_extra"><sp=
an style=3D"font-size:12.8px"><br></span></div><div class=3D"gmail_extra"><=
span style=3D"font-size:12.8px">I have been looking deeper into my wireshar=
k packet captures and found something that could be helpfull.</span></div><=
div class=3D"gmail_extra"><span style=3D"font-size:12.8px"><br></span></div=
><div class=3D"gmail_extra"><span style=3D"font-size:12.8px">I can see that=
 the Ethernet NIC at least does something. ARP BROADCAST traffic is seen.</=
span></div><div class=3D"gmail_extra"><span style=3D"font-size:12.8px">But =
i also found some packets...which have LG BITs set to 1 .. when i think 0 s=
hould be the correct value..something with Octets.</span></div><div class=
=3D"gmail_extra"><span style=3D"font-size:12.8px"><br></span></div><div cla=
ss=3D"gmail_extra"><p style=3D"border:medium none;margin:0px 0px 13px;paddi=
ng:0px;font-size:13px;line-height:18.2px;max-width:700px;color:rgb(0,0,0);f=
ont-family:sans-serif"><i>&quot;the first 3 octets/first-half of a MAC-48/E=
UI-48 Address, correspond to the OUI (e.g.: MAC =3D 06:00:00:xx:xx:xx, OUI =
=3D 06:00:00), and the 2nd least significant bit of its first octet is used=
 to differentiate &quot;Universally&quot; and &quot;Locally&quot; administe=
red addresses). In other words, if we convert 06 (Hex) to 00000110 (Binary)=
, we can see that the U/L bit is set to one, which means that it a locally =
administered address.</i></p><p style=3D"border:medium none;margin:0px 0px =
13px;padding:0px;font-size:13px;line-height:18.2px;max-width:700px;color:rg=
b(0,0,0);font-family:sans-serif"><i>Given this if we disable that bit, we g=
et the matching &quot;Universally Administered Address&quot; 00000100 (Bina=
ry), 04 (Hex) -&gt; &quot;04:00:00&quot;, hence my question:&quot;</i></p><=
/div><div class=3D"gmail_extra"><span style=3D"font-size:12.8px"><br></span=
></div><div class=3D"gmail_extra"><span style=3D"font-size:12.8px">This has=
 something to do with the MAC adresses being locally administered .. and si=
nce whe can use Uboot and choose any Mac addr we want, this could make sens=
e..</span></div><div class=3D"gmail_extra"><span style=3D"font-size:12.8px"=
><br></span></div><div class=3D"gmail_extra"><span style=3D"font-size:12.8p=
x">These types of Logs also apear in my Wireshark Capture files... ( these =
are not my org. logs)=C2=A0</span></div><div class=3D"gmail_extra"><span st=
yle=3D"font-size:12.8px"><br></span></div><div class=3D"gmail_extra"><span =
style=3D"font-size:12.8px">Ethernet II, Src: Microchi_8f:c6:a8 (d8:80:39:8f=
:c6:a8), Dst: Broadcast (ff:ff:ff:ff:ff:ff)</span></div><div class=3D"gmail=
_extra"><span style=3D"font-size:12.8px">Destination: Broadcast (ff:ff:ff:f=
f:ff:ff)</span></div><div class=3D"gmail_extra"><span style=3D"font-size:12=
.8px">Address: Broadcast (ff:ff:ff:ff:ff:ff)</span></div><div class=3D"gmai=
l_extra"><span style=3D"font-size:12.8px">.... ..1. .... .... .... .... =3D=
 LG bit: Locally administered address (this is NOT the factory default)</sp=
an></div><div class=3D"gmail_extra"><span style=3D"font-size:12.8px">.... .=
..1 .... .... .... .... =3D IG bit: Group address (multicast/broadcast)</sp=
an></div><div class=3D"gmail_extra"><span style=3D"font-size:12.8px">Source=
: Microchi_8f:c6:a8 (d8:80:39:8f:c6:a8)</span></div><div class=3D"gmail_ext=
ra"><span style=3D"font-size:12.8px">Address: Microchi_8f:c6:a8 (d8:80:39:8=
f:c6:a8)</span></div><div class=3D"gmail_extra"><span style=3D"font-size:12=
.8px">.... ..0. .... .... .... .... =3D LG bit: Globally unique address (fa=
ctory default)</span></div><div class=3D"gmail_extra"><span style=3D"font-s=
ize:12.8px">.... ...0 .... .... .... .... =3D IG bit: Individual address (u=
nicast)</span></div><div class=3D"gmail_extra"><span style=3D"font-size:12.=
8px">Type: IP (0x0800)</span></div><div class=3D"gmail_extra"><span style=
=3D"font-size:12.8px">Internet Protocol Version 4, Src: 0.0.0.0 (0.0.0.0), =
Dst: 255.255.255.255 (255.255.255.255)</span></div><div class=3D"gmail_extr=
a"><span style=3D"font-size:12.8px"><br></span></div><div class=3D"gmail_ex=
tra"><span style=3D"font-size:12.8px">In the link below some similair Logs =
and problems regarding DHCP for example.</span></div><div class=3D"gmail_ex=
tra"><span style=3D"font-size:12.8px"><br></span></div><div class=3D"gmail_=
extra"><span style=3D"font-size:12.8px">Dave</span></div><div class=3D"gmai=
l_extra"><span style=3D"font-size:12.8px"><br></span></div></div></div>

--94eb2c124be8b3b22e0562e91f17--
