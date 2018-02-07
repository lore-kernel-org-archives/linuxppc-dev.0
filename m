Return-Path: <madskateman@gmail.com>
Received: from mail-qk0-x22f.google.com (mail-qk0-x22f.google.com
 [IPv6:2607:f8b0:400d:c09::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zcDJ2114VzF0Qq
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Feb 2018 08:00:49 +1100 (AEDT)
Received: by mail-qk0-x22f.google.com with SMTP id 15so2960616qkl.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Feb 2018 13:00:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1d62c827-0ff7-0372-a2f8-f1930e9f788c@xenosoft.de>
References: <CAHkrCmFCzPd_a1UmyfuZHKM4hXvou0uO0FYoG5bd_fxE8QMueg@mail.gmail.com>
 <DB3PR0402MB3849EEF00D71FF7A230B70C3ECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516035556.18795.71.camel@infinera.com> <20180116143836.GC22903@lunn.ch>
 <1516125454.18795.87.camel@infinera.com> <20180116205342.GA29888@lunn.ch>
 <1516189651.18795.99.camel@infinera.com> <20180117134339.GC32299@lunn.ch>
 <DB3PR0402MB3849850266808EC52F88A783ECE90@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <DB3PR0402MB3849865056493075A4F4317CECE90@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <DB3PR0402MB38494AC5EE923A10053745DDECE90@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <CAHkrCmGxFUbfEyufdYhFYA4jyOkh+W2z=1yZsZwv+O4t+hE_1w@mail.gmail.com>
 <1d62c827-0ff7-0372-a2f8-f1930e9f788c@xenosoft.de>
From: mad skateman <madskateman@gmail.com>
Date: Wed, 7 Feb 2018 22:00:45 +0100
Message-ID: <CAHkrCmGrp3eUKYqRpv4__qw24yvL3Fou+MNwaDCX=XGgmFqRRg@mail.gmail.com>
Subject: Re: DPAA Ethernet traffice troubles with Linux kernel
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Madalin-cristian Bucur <madalin.bucur@nxp.com>,
 Andrew Lunn <andrew@lunn.ch>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Jamie Krueger <jamie@bitbybitsoftwaregroup.com>
Content-Type: multipart/alternative; boundary="001a114c8cacd4641e0564a5962d"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a114c8cacd4641e0564a5962d
Content-Type: text/plain; charset="UTF-8"

Hi,

I just found out that something goes wrong within the ARP table (well thats
what i think). I hope someone has a clue..

When i bootup the AmigaOne X5000 with the Ethernet cable connected, it just
never senses the presence of the UTP cable.
I must run the following command as root: mii-tool -R eth0 ... it Resets
the transceiver and the ethernet connection is ready to go.
But then... it randomly dies....

After some digging i found that in a working situation the ARP table is
filled with the correct info. Router address, and corresponding MAC, C mask
and Interface.

(Working)
skateman@X5000LNX:~$ arp -n
Address                  HWtype  HWaddress           Flags Mask
Iface
192.168.22.66            ether   08:5b:0e:fd:db:6a   C
eth0

No more traffic..it just suddenly dies...
skateman@X5000LNX:~$ ping www.google.com
ping: unknown host www.google.com

Rechecked the ARP... and found out it has lost the necessary info.
skateman@X5000LNX:~$ arp -n
Address                  HWtype  HWaddress           Flags Mask
Iface
192.168.22.66                    (incomplete)
eth0

Anyone??? :-)


On Tue, Feb 6, 2018 at 12:20 PM, Christian Zigotzky <chzigotzky@xenosoft.de>
wrote:

> Hello,
>
> I have tried to figure out why there is a problem with the buffer space
> but unfortunately without any success. Any ideas? Could you please watch
> Skateman's video? [1]
>
> Thanks,
> Christian
>
> [1] https://drive.google.com/file/d/18RhksfcavRJPr86asQDTzrmsN20D0Xim/view
>
>
> On 03 February 2018 at 12:54PM, mad skateman wrote:
> >
> > For those interested... i have recorded a video of my X5000 DPAA
> Ethernet, and the weird problems..
> > In this Video i am also transfering hundereds of megabytes from my NAS
> to the X5000.
> > You will also see pings die... mostly after the 12th packet and giving
> the no buffer space error..
> > Hopefully someone might have a clue about what is happening.
> >
> > https://drive.google.com/file/d/18RhksfcavRJPr86asQDTzrmsN20D0Xim/view
> >
> > On Wed, Jan 17, 2018 at 3:43 PM, Madalin-cristian Bucur <
> madalin.bucur@nxp.com> wrote:
> >
> >     > -----Original Message-----
> >     > From: Madalin-cristian Bucur
> >     > Sent: Wednesday, January 17, 2018 4:25 PM
> >     > To: David S . Miller <davem@davemloft.net>
> >     > Cc: linuxppc-dev@lists.ozlabs.org; netdev@vger.kernel.org;
> >     > madskateman@gmail.com; 'Madalin-cristian Bucur' <
> madalin.bucur@nxp.com>;
> >     > Andrew Lunn <andrew@lunn.ch>; Joakim Tjernlund
> >     > <Joakim.Tjernlund@infinera.com>
> >     > Subject: RE: DPAA Ethernet traffice troubles with Linux kernel
> >     >
> >     > > -----Original Message-----
> >     > > From: netdev-owner@vger.kernel.org [mailto:
> netdev-owner@vger.kernel.org]
> >     > > On Behalf Of Madalin-cristian Bucur
> >     > > Sent: Wednesday, January 17, 2018 4:16 PM
> >     > > To: Andrew Lunn <andrew@lunn.ch>; Joakim Tjernlund
> >     > > <Joakim.Tjernlund@infinera.com>
> >     > > Cc: linuxppc-dev@lists.ozlabs.org; netdev@vger.kernel.org;
> >     > > madskateman@gmail.com; David S . Miller <davem@davemloft.net>
> >     > > Subject: RE: DPAA Ethernet traffice troubles with Linux kernel
> >     > >
> >     > > > -----Original Message-----
> >     > > > From: Andrew Lunn [mailto:andrew@lunn.ch]
> >     > > > Sent: Wednesday, January 17, 2018 3:44 PM
> >     > > > To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
> >     > > > Subject: Re: DPAA Ethernet traffice troubles with Linux kernel
> >     > > >
> >     > > > > That doesn't work really, having users to hit the bug, debug
> it, fix
> >     > > it
> >     > > > and then
> >     > > > > find it fixed already in upstream, then specifically request
> it to
> >     > be
> >     > > > backported to stable.
> >     > > > > I don't need this fix to be backported, already got it.
> Someone else
> >     > > > might though.
> >     > > >
> >     > > > The "someone else might though" is a big point of asking for
> it to
> >     > > > added to stable. The other reason is it means one less patch
> you need
> >     > > > to maintain in your build.
> >     > >
> >     > > I've sent that patch [1] for net but I guess the timing was
> wrong and
> >     > > it was merged to net-next.
> >     > >
> >     > > > > I would be interested in bug fixes upstream which fixes:
> >     > > >
> >     > > > Did you try upstream? Does it give the same errors?
> >     > > >
> >     > > >     Andrew
> >     > >
> >     > > [1] https://patchwork.kernel.org/patch/10146119/
> >     > >
> >     > > Madalin
> >     >
> >     > Hi Dave,
> >     >
> >     > Can you please add the fix [1] to stable?
> >     >
> >     > Thank you,
> >     > Madalin
> >
> >     Sorry,
> >
> >     I've provided the wrong link towards the patch (v1 instead of v3),
> >     here's the correct one:
> >
> >     https://patchwork.kernel.org/patch/10151969/
> >
> >     Madalin
> >
> >
>
>
>

--001a114c8cacd4641e0564a5962d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi,<br><br></div>I just found out that something=
 goes wrong within the ARP table (well thats what i think). I hope someone =
has a clue..<br><br><div>When i bootup the AmigaOne X5000 with the Ethernet=
 cable connected, it just never senses the presence of the UTP cable. <br><=
/div><div>I must run the following command as root: mii-tool -R eth0 ... it=
 Resets the transceiver and the ethernet connection is ready to go.<br></di=
v><div>But then... it randomly dies....=C2=A0 <br><br></div><div>After some=
 digging i found that in a working situation the ARP table is filled with t=
he correct info. Router address, and corresponding MAC, C mask and Interfac=
e.<br><br></div>(Working)<br>skateman@X5000LNX:~$ arp -n<br>Address=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 HWtype=C2=A0 HWaddress=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags Mask=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Iface<br>192.168.22.66=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ether=C2=A0=C2=A0 08:5b:0e=
:fd:db:6a=C2=A0=C2=A0 C=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eth0<=
br><br>No more traffic..it just suddenly dies... <br>skateman@X5000LNX:~$ p=
ing <a target=3D"_blank" href=3D"http://www.google.com">www.google.com</a><=
br>ping: unknown host <a target=3D"_blank" href=3D"http://www.google.com">w=
ww.google.com</a><br><br>Rechecked the ARP... and found out it has lost the=
 necessary info. <br>skateman@X5000LNX:~$ arp -n<br>Address=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 HWtype=C2=A0 HWaddress=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Flags Mask=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Iface<br>192.168.22.66=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
<wbr>=C2=A0=C2=A0 (incomplete)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eth0<br><br></=
div><div>Anyone??? :-)<br><br></div></div><div class=3D"gmail_extra"><br><d=
iv class=3D"gmail_quote">On Tue, Feb 6, 2018 at 12:20 PM, Christian Zigotzk=
y <span dir=3D"ltr">&lt;<a href=3D"mailto:chzigotzky@xenosoft.de" target=3D=
"_blank">chzigotzky@xenosoft.de</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Hello,<br>
<br>
I have tried to figure out why there is a problem with the buffer space but=
 unfortunately without any success. Any ideas? Could you please watch Skate=
man&#39;s video? [1]<br>
<br>
Thanks,<br>
Christian<br>
<br>
[1] <a href=3D"https://drive.google.com/file/d/18RhksfcavRJPr86asQDTzrmsN20=
D0Xim/view" rel=3D"noreferrer" target=3D"_blank">https://drive.google.com/f=
ile/<wbr>d/18RhksfcavRJPr86asQDTzrmsN20<wbr>D0Xim/view</a><br>
<br>
<br>
On 03 February 2018 at 12:54PM, mad skateman wrote:<br>
&gt;<br>
&gt; For those interested... i have recorded a video of my X5000 DPAA Ether=
net, and the weird problems..<br>
&gt; In this Video i am also transfering hundereds of megabytes from my NAS=
 to the X5000.<br>
&gt; You will also see pings die... mostly after the 12th packet and giving=
 the no buffer space error..<br>
&gt; Hopefully someone might have a clue about what is happening.<br>
&gt;<br>
&gt; <a href=3D"https://drive.google.com/file/d/18RhksfcavRJPr86asQDTzrmsN2=
0D0Xim/view" rel=3D"noreferrer" target=3D"_blank">https://drive.google.com/=
file/<wbr>d/18RhksfcavRJPr86asQDTzrmsN20<wbr>D0Xim/view</a><br>
&gt;<br>
&gt; On Wed, Jan 17, 2018 at 3:43 PM, Madalin-cristian Bucur &lt;<a href=3D=
"mailto:madalin.bucur@nxp.com" target=3D"_blank">madalin.bucur@nxp.com</a>&=
gt; wrote:<br>
&gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; -----Original Message-----<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; From: Madalin-cristian Bucur<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; Sent: Wednesday, January 17, 2018 4:25 PM=
<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; To: David S . Miller &lt;<a href=3D"mailt=
o:davem@davemloft.net" target=3D"_blank">davem@davemloft.net</a>&gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; Cc: <a href=3D"mailto:linuxppc-dev@lists.=
ozlabs.org" target=3D"_blank">linuxppc-dev@lists.ozlabs.org</a>; <a href=3D=
"mailto:netdev@vger.kernel.org" target=3D"_blank">netdev@vger.kernel.org</a=
>;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; <a href=3D"mailto:madskateman@gmail.com" =
target=3D"_blank">madskateman@gmail.com</a>; &#39;Madalin-cristian Bucur&#3=
9; &lt;<a href=3D"mailto:madalin.bucur@nxp.com" target=3D"_blank">madalin.b=
ucur@nxp.com</a>&gt;;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; Andrew Lunn &lt;<a href=3D"mailto:andrew@=
lunn.ch" target=3D"_blank">andrew@lunn.ch</a>&gt;; Joakim Tjernlund<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &lt;<a href=3D"mailto:Joakim.Tjernlund@in=
finera.com" target=3D"_blank">Joakim.Tjernlund@infinera.com</a><wbr>&gt;<br=
>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; Subject: RE: DPAA Ethernet traffice troub=
les with Linux kernel<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; -----Original Message-----<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; From: <a href=3D"mailto:netdev-owner=
@vger.kernel.org" target=3D"_blank">netdev-owner@vger.kernel.org</a> [mailt=
o:<a href=3D"mailto:netdev-owner@vger.kernel.org" target=3D"_blank">netdev-=
owner@vger.kern<wbr>el.org</a>]<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; On Behalf Of Madalin-cristian Bucur<=
br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; Sent: Wednesday, January 17, 2018 4:=
16 PM<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; To: Andrew Lunn &lt;<a href=3D"mailt=
o:andrew@lunn.ch" target=3D"_blank">andrew@lunn.ch</a>&gt;; Joakim Tjernlun=
d<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; &lt;<a href=3D"mailto:Joakim.Tjernlu=
nd@infinera.com" target=3D"_blank">Joakim.Tjernlund@infinera.com</a><wbr>&g=
t;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; Cc: <a href=3D"mailto:linuxppc-dev@l=
ists.ozlabs.org" target=3D"_blank">linuxppc-dev@lists.ozlabs.org</a>; <a hr=
ef=3D"mailto:netdev@vger.kernel.org" target=3D"_blank">netdev@vger.kernel.o=
rg</a>;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; <a href=3D"mailto:madskateman@gmail.=
com" target=3D"_blank">madskateman@gmail.com</a>; David S . Miller &lt;<a h=
ref=3D"mailto:davem@davemloft.net" target=3D"_blank">davem@davemloft.net</a=
>&gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; Subject: RE: DPAA Ethernet traffice =
troubles with Linux kernel<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; &gt; -----Original Message-----<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; &gt; From: Andrew Lunn [mailto:<a hr=
ef=3D"mailto:andrew@lunn.ch" target=3D"_blank">andrew@lunn.ch</a>]<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; &gt; Sent: Wednesday, January 17, 20=
18 3:44 PM<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; &gt; To: Joakim Tjernlund &lt;<a hre=
f=3D"mailto:Joakim.Tjernlund@infinera.com" target=3D"_blank">Joakim.Tjernlu=
nd@infinera.com</a><wbr>&gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; &gt; Subject: Re: DPAA Ethernet traf=
fice troubles with Linux kernel<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; &gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; &gt; &gt; That doesn&#39;t work real=
ly, having users to hit the bug, debug it, fix<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; it<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; &gt; and then<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; &gt; &gt; find it fixed already in u=
pstream, then specifically request it to<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; be<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; &gt; backported to stable.<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; &gt; &gt; I don&#39;t need this fix =
to be backported, already got it. Someone else<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; &gt; might though.<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; &gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; &gt; The &quot;someone else might th=
ough&quot; is a big point of asking for it to<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; &gt; added to stable. The other reas=
on is it means one less patch you need<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; &gt; to maintain in your build.<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; I&#39;ve sent that patch [1] for net=
 but I guess the timing was wrong and<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; it was merged to net-next.<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; &gt; &gt; I would be interested in b=
ug fixes upstream which fixes:<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; &gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; &gt; Did you try upstream? Does it g=
ive the same errors?<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; &gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; &gt;=C2=A0=C2=A0=C2=A0=C2=A0 Andrew<=
br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; [1] <a href=3D"https://patchwork.ker=
nel.org/patch/10146119/" rel=3D"noreferrer" target=3D"_blank">https://patch=
work.kernel.org/p<wbr>atch/10146119/</a><br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; &gt; Madalin<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; Hi Dave,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; Can you please add the fix [1] to stable?=
<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; Thank you,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 &gt; Madalin<br>
&gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 Sorry,<br>
&gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 I&#39;ve provided the wrong link towards the p=
atch (v1 instead of v3),<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 here&#39;s the correct one:<br>
&gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 <a href=3D"https://patchwork.kernel.org/patch/=
10151969/" rel=3D"noreferrer" target=3D"_blank">https://patchwork.kernel.or=
g/p<wbr>atch/10151969/</a><br>
&gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 Madalin<br>
&gt;<br>
&gt;<br>
<br>
<br>
</blockquote></div><br></div>

--001a114c8cacd4641e0564a5962d--
