Return-Path: <madskateman@gmail.com>
Received: from mail-qt0-x231.google.com (mail-qt0-x231.google.com
 [IPv6:2607:f8b0:400d:c0d::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLfBz1y1TzF0Y6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 05:39:23 +1100 (AEDT)
Received: by mail-qt0-x231.google.com with SMTP id o35so9331832qtj.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 10:39:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1516125454.18795.87.camel@infinera.com>
References: <CAHkrCmFCzPd_a1UmyfuZHKM4hXvou0uO0FYoG5bd_fxE8QMueg@mail.gmail.com>
 <DB3PR0402MB3849EEF00D71FF7A230B70C3ECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516035556.18795.71.camel@infinera.com> <20180116143836.GC22903@lunn.ch>
 <1516125454.18795.87.camel@infinera.com>
From: mad skateman <madskateman@gmail.com>
Date: Tue, 16 Jan 2018 19:39:20 +0100
Message-ID: <CAHkrCmFd8F8Bpm8vUete_QHjGosyXH0JZVEJ6gwvBMMUtBivLQ@mail.gmail.com>
Subject: Re: DPAA Ethernet traffice troubles with Linux kernel
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "madalin.bucur@nxp.com" <madalin.bucur@nxp.com>
Content-Type: multipart/alternative; boundary="94eb2c0e610e8602e10562e90ca7"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--94eb2c0e610e8602e10562e90ca7
Content-Type: text/plain; charset="UTF-8"

Hi,

I have been looking deeper into my wireshark packet captures and found
something that could be helpfull.

I can see using wireshark that the Ethernet NIC at least does something.
ARP BROADCAST traffic is seen.
But i also found some packets...which have LG BITs set to 1 .. when i think
0 should be the correct value..

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

On Tue, Jan 16, 2018 at 6:57 PM, Joakim Tjernlund <
Joakim.Tjernlund@infinera.com> wrote:

> On Thu, 1970-01-01 at 00:00 +0000, Andrew Lunn wrote:
> > CAUTION: This email originated from outside of the organization. Do not
> click links or open attachments unless you recognize the sender and know
> the content is safe.
> >
> >
> > > Hi, just saw this and thought of a small patch I just wrote for mdio
> bus, o idea
> > > if it is relevant but here goes:
> > >
> > > From fe0b98d54a79779482700676331b4d10a0f3cada Mon Sep 17 00:00:00 2001
> > > From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
> > > Date: Sun, 14 Jan 2018 21:27:20 +0100
> > > Subject: [PATCH] of_mdiobus_register: Continue after error
> > >
> > > of_mdiobus_register unregister itself if one phy fails to register
> > > which is bad for system having all its PHYs on the same MDIO bus.
> > > Just log the error and continue with the remaining PHYs instead.
> > >
> > > Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
> >
> > Hi Joakim
> >
> > You appear to be using an old kernel. Take a look at:
>
> Not really, I am using 4.14.x and I don't think that is old. Seems like
> this
> patch hasn't been sent to 4.14.x.
>
> I wonder if I might be missing something else, we just moved to 4.14 and
> notic that all
> our fixed PHYs are non functioning:
> fsl_mac ffe4e2000.ethernet: FMan MEMAC
> fsl_mac ffe4e2000.ethernet: FMan MAC address: 00:06:9c:0b:06:20
> fsl_mac dpaa-ethernet.0: __devm_request_mem_region(mac) failed
> fsl_mac: probe of dpaa-ethernet.0 failed with error -16
> fsl_mac ffe4e4000.ethernet: FMan MEMAC
> fsl_mac ffe4e4000.ethernet: FMan MAC address: 00:06:9c:0b:06:21
> fsl_mac dpaa-ethernet.1: __devm_request_mem_region(mac) failed
> fsl_mac: probe of dpaa-ethernet.1 failed with error -16
> fsl_mac ffe4e6000.ethernet: FMan MEMAC
> fsl_mac ffe4e6000.ethernet: FMan MAC address: 00:06:9c:0b:06:22
> fsl_mac dpaa-ethernet.2: __devm_request_mem_region(mac) failed
> fsl_mac: probe of dpaa-ethernet.2 failed with error -16
> fsl_mac ffe4e8000.ethernet: FMan MEMAC
> fsl_mac ffe4e8000.ethernet: FMan MAC address: 00:06:9c:0b:06:23
> fsl_mac dpaa-ethernet.3: __devm_request_mem_region(mac) failed
> fsl_mac: probe of dpaa-ethernet.3 failed with error -16
>
> Feels like FMAN still think there are real PHYs there ?
> >
> > commit 95f566de0269a0c59fd6a737a147731302136429
> > Author: Madalin Bucur <madalin.bucur@nxp.com>
> > Date:   Tue Jan 9 14:43:34 2018 +0200
> >
> >     of_mdio: avoid MDIO bus removal when a PHY is missing
> >
> >     If one of the child devices is missing the of_mdiobus_register_phy()
> >     call will return -ENODEV. When a missing device is encountered the
> >     registration of the remaining PHYs is stopped and the MDIO bus will
> >     fail to register. Propagate all errors except ENODEV to avoid it.
> >
> >     Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
> >     Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> >     Signed-off-by: David S. Miller <davem@davemloft.net>
> >
> >
> >     Andrew
>

--94eb2c0e610e8602e10562e90ca7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-size:12.8px">Hi,</span><div style=3D"f=
ont-size:12.8px"><br></div><div style=3D"font-size:12.8px">I have been look=
ing deeper into my wireshark packet captures and found something that could=
 be helpfull.</div><div style=3D"font-size:12.8px"><br></div><div style=3D"=
font-size:12.8px">I can see using wireshark that the Ethernet NIC at least =
does something. ARP BROADCAST traffic is seen.</div><div style=3D"font-size=
:12.8px">But i also found some packets...which have LG BITs set to 1 .. whe=
n i think 0 should be the correct value..</div><div style=3D"font-size:12.8=
px"><br></div><div style=3D"font-size:12.8px">This has something to do with=
 the MAC adresses being locally administered .. and since whe can use Uboot=
 and choose any Mac addr we want, this could make sense..</div><div style=
=3D"font-size:12.8px"><br></div><div style=3D"font-size:12.8px">These types=
 of Logs also apear in my Wireshark Capture files... ( these are not my org=
. logs)=C2=A0</div><div style=3D"font-size:12.8px"><br></div><div style=3D"=
font-size:12.8px"><div style=3D"font-size:12.8px">Ethernet II, Src: Microch=
i_8f:c6:a8 (d8:80:39:8f:c6:a8), Dst: Broadcast (ff:ff:ff:ff:ff:ff)</div><di=
v style=3D"font-size:12.8px">Destination: Broadcast (ff:ff:ff:ff:ff:ff)</di=
v><div style=3D"font-size:12.8px">Address: Broadcast (ff:ff:ff:ff:ff:ff)</d=
iv><div style=3D"font-size:12.8px">.... ..1. .... .... .... .... =3D LG bit=
: Locally administered address (this is NOT the factory default)</div><div =
style=3D"font-size:12.8px">.... ...1 .... .... .... .... =3D IG bit: Group =
address (multicast/broadcast)</div><div style=3D"font-size:12.8px">Source: =
Microchi_8f:c6:a8 (d8:80:39:8f:c6:a8)</div><div style=3D"font-size:12.8px">=
Address: Microchi_8f:c6:a8 (d8:80:39:8f:c6:a8)</div><div style=3D"font-size=
:12.8px">.... ..0. .... .... .... .... =3D LG bit: Globally unique address =
(factory default)</div><div style=3D"font-size:12.8px">.... ...0 .... .... =
.... .... =3D IG bit: Individual address (unicast)</div><div style=3D"font-=
size:12.8px">Type: IP (0x0800)</div><div style=3D"font-size:12.8px">Interne=
t Protocol Version 4, Src: 0.0.0.0 (0.0.0.0), Dst: 255.255.255.255 (255.255=
.255.255)</div></div><div style=3D"font-size:12.8px"><br></div><div style=
=3D"font-size:12.8px">In the link below some similair Logs and problems reg=
arding DHCP for example.</div><div style=3D"font-size:12.8px"><br></div><di=
v style=3D"font-size:12.8px">Dave</div></div><div class=3D"gmail_extra"><br=
><div class=3D"gmail_quote">On Tue, Jan 16, 2018 at 6:57 PM, Joakim Tjernlu=
nd <span dir=3D"ltr">&lt;<a href=3D"mailto:Joakim.Tjernlund@infinera.com" t=
arget=3D"_blank">Joakim.Tjernlund@infinera.com</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">On Thu, 1970-01-01 at 00:00 +0000, Andrew Lunn =
wrote:<br>
&gt; CAUTION: This email originated from outside of the organization. Do no=
t click links or open attachments unless you recognize the sender and know =
the content is safe.<br>
&gt;<br>
&gt;<br>
&gt; &gt; Hi, just saw this and thought of a small patch I just wrote for m=
dio bus, o idea<br>
&gt; &gt; if it is relevant but here goes:<br>
&gt; &gt;<br>
&gt; &gt; From fe0b98d54a79779482700676331b4d<wbr>10a0f3cada Mon Sep 17 00:=
00:00 2001<br>
&gt; &gt; From: Joakim Tjernlund &lt;<a href=3D"mailto:joakim.tjernlund@inf=
inera.com">joakim.tjernlund@infinera.com</a><wbr>&gt;<br>
&gt; &gt; Date: Sun, 14 Jan 2018 21:27:20 +0100<br>
&gt; &gt; Subject: [PATCH] of_mdiobus_register: Continue after error<br>
&gt; &gt;<br>
&gt; &gt; of_mdiobus_register unregister itself if one phy fails to registe=
r<br>
&gt; &gt; which is bad for system having all its PHYs on the same MDIO bus.=
<br>
&gt; &gt; Just log the error and continue with the remaining PHYs instead.<=
br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Joakim Tjernlund &lt;<a href=3D"mailto:joakim.tjer=
nlund@infinera.com">joakim.tjernlund@infinera.com</a><wbr>&gt;<br>
&gt;<br>
&gt; Hi Joakim<br>
&gt;<br>
&gt; You appear to be using an old kernel. Take a look at:<br>
<br>
Not really, I am using 4.14.x and I don&#39;t think that is old. Seems like=
 this<br>
patch hasn&#39;t been sent to 4.14.x.<br>
<br>
I wonder if I might be missing something else, we just moved to 4.14 and no=
tic that all<br>
our fixed PHYs are non functioning:<br>
fsl_mac ffe4e2000.ethernet: FMan MEMAC<br>
fsl_mac ffe4e2000.ethernet: FMan MAC address: 00:06:9c:0b:06:20<br>
fsl_mac dpaa-ethernet.0: __devm_request_mem_region(mac) failed<br>
fsl_mac: probe of dpaa-ethernet.0 failed with error -16<br>
fsl_mac ffe4e4000.ethernet: FMan MEMAC<br>
fsl_mac ffe4e4000.ethernet: FMan MAC address: 00:06:9c:0b:06:21<br>
fsl_mac dpaa-ethernet.1: __devm_request_mem_region(mac) failed<br>
fsl_mac: probe of dpaa-ethernet.1 failed with error -16<br>
fsl_mac ffe4e6000.ethernet: FMan MEMAC<br>
fsl_mac ffe4e6000.ethernet: FMan MAC address: 00:06:9c:0b:06:22<br>
fsl_mac dpaa-ethernet.2: __devm_request_mem_region(mac) failed<br>
fsl_mac: probe of dpaa-ethernet.2 failed with error -16<br>
fsl_mac ffe4e8000.ethernet: FMan MEMAC<br>
fsl_mac ffe4e8000.ethernet: FMan MAC address: 00:06:9c:0b:06:23<br>
fsl_mac dpaa-ethernet.3: __devm_request_mem_region(mac) failed<br>
fsl_mac: probe of dpaa-ethernet.3 failed with error -16<br>
<br>
Feels like FMAN still think there are real PHYs there ?<br>
&gt;<br>
&gt; commit 95f566de0269a0c59fd6a737a14773<wbr>1302136429<br>
&gt; Author: Madalin Bucur &lt;<a href=3D"mailto:madalin.bucur@nxp.com">mad=
alin.bucur@nxp.com</a>&gt;<br>
&gt; Date:=C2=A0 =C2=A0Tue Jan 9 14:43:34 2018 +0200<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0of_mdio: avoid MDIO bus removal when a PHY is missi=
ng<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0If one of the child devices is missing the of_mdiob=
us_register_phy()<br>
&gt;=C2=A0 =C2=A0 =C2=A0call will return -ENODEV. When a missing device is =
encountered the<br>
&gt;=C2=A0 =C2=A0 =C2=A0registration of the remaining PHYs is stopped and t=
he MDIO bus will<br>
&gt;=C2=A0 =C2=A0 =C2=A0fail to register. Propagate all errors except ENODE=
V to avoid it.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Madalin Bucur &lt;<a href=3D"mailto:=
madalin.bucur@nxp.com">madalin.bucur@nxp.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Reviewed-by: Andrew Lunn &lt;<a href=3D"mailto:andr=
ew@lunn.ch">andrew@lunn.ch</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: David S. Miller &lt;<a href=3D"mailt=
o:davem@davemloft.net">davem@davemloft.net</a>&gt;<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Andrew<br>
</blockquote></div><br></div>

--94eb2c0e610e8602e10562e90ca7--
