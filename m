Return-Path: <madskateman@gmail.com>
Received: from mail-qt0-x22e.google.com (mail-qt0-x22e.google.com
 [IPv6:2607:f8b0:400d:c0d::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM5RT5WV6zF0Vw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 23:06:45 +1100 (AEDT)
Received: by mail-qt0-x22e.google.com with SMTP id o35so12061829qtj.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 04:06:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1516189651.18795.99.camel@infinera.com>
References: <CAHkrCmFCzPd_a1UmyfuZHKM4hXvou0uO0FYoG5bd_fxE8QMueg@mail.gmail.com>
 <DB3PR0402MB3849EEF00D71FF7A230B70C3ECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516035556.18795.71.camel@infinera.com> <20180116143836.GC22903@lunn.ch>
 <1516125454.18795.87.camel@infinera.com> <20180116205342.GA29888@lunn.ch>
 <1516189651.18795.99.camel@infinera.com>
From: mad skateman <madskateman@gmail.com>
Date: Wed, 17 Jan 2018 13:06:41 +0100
Message-ID: <CAHkrCmFow3kixcqdJOT=G2ExswpKDj880RxCYvqQMdC2xgngHw@mail.gmail.com>
Subject: Re: DPAA Ethernet traffice troubles with Linux kernel
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "madalin.bucur@nxp.com" <madalin.bucur@nxp.com>,
 Christian Zigotzky <chzigotzky@xenosoft.de>
Content-Type: multipart/alternative; boundary="001a1142c20c3086c50562f7ae08"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a1142c20c3086c50562f7ae08
Content-Type: text/plain; charset="UTF-8"

After using the new compiled 4.14 rc8 kernel without PAMU support posted by
Christian Zigotzky the X5000 can use the Network interface with some minor
issues.

I had to give the Eth0 a manual IP due to not responding on DHCP requests.

I can ping my Gateway, and even DNS queries work..

But when i start Netsurf (or generate to much packets)... all traffic
dies.... due to No buffer space available..

64 bytes from 192.168.22.66: icmp_seq=81 ttl=255 time=0.317 ms
64 bytes from 192.168.22.66: icmp_seq=82 ttl=255 time=0.317 ms
64 bytes from 192.168.22.66: icmp_seq=83 ttl=255 time=0.314 ms
64 bytes from 192.168.22.66: icmp_seq=84 ttl=255 time=0.321 ms
64 bytes from 192.168.22.66: icmp_seq=85 ttl=255 time=0.323 ms
64 bytes from 192.168.22.66: icmp_seq=86 ttl=255 time=0.312 ms
64 bytes from 192.168.22.66: icmp_seq=87 ttl=255 time=0.331 ms
64 bytes from 192.168.22.66: icmp_seq=88 ttl=255 time=0.338 ms
64 bytes from 192.168.22.66: icmp_seq=89 ttl=255 time=0.334 ms
64 bytes from 192.168.22.66: icmp_seq=90 ttl=255 time=0.349 ms
64 bytes from 192.168.22.66: icmp_seq=91 ttl=255 time=0.324 ms
64 bytes from 192.168.22.66: icmp_seq=92 ttl=255 time=0.320 ms
64 bytes from 192.168.22.66: icmp_seq=93 ttl=255 time=0.320 ms
64 bytes from 192.168.22.66: icmp_seq=94 ttl=255 time=0.338 ms
ping: sendmsg: No buffer space available
ping: sendmsg: No buffer space available
ping: sendmsg: No buffer space available
ping: sendmsg: No buffer space available
ping: sendmsg: No buffer space available
ping: sendmsg: No buffer space available
ping: sendmsg: No buffer space available
ping: sendmsg: No buffer space available

A workaround to keep Eth0 alive a bit longer.... is the following command

ip link set eth0 qlen 10000

We are making progress!!


On Wed, Jan 17, 2018 at 12:47 PM, Joakim Tjernlund <
Joakim.Tjernlund@infinera.com> wrote:

> On Thu, 1970-01-01 at 00:00 +0000, Andrew Lunn wrote:
> > CAUTION: This email originated from outside of the organization. Do not
> click links or open attachments unless you recognize the sender and know
> the content is safe.
> >
> >
> > > > You appear to be using an old kernel. Take a look at:
> > >
> > > Not really, I am using 4.14.x and I don't think that is old.
> >
> > Development for 4.14 stopped somewhere around the beginning of
> > September. So there has been over 4 months of work since then.  We are
> > clearly interested in fixing bugs in that kernel, since it is the
> > current stable version. But when reporting bugs, please let is know if
> > the latest version of the network kernel,
> > it://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git has
> > the issue.
> >
> > > Seems like this patch hasn't been sent to 4.14.x.
> >
> > If it fixes a bug for you, please request the fix is added to stable.
>
> That doesn't work really, having users to hit the bug, debug it, fix it
> and then
> find it fixed already in upstream, then specifically request it to be
> backported to stable.
> I don't need this fix to be backported, already got it. Someone else might
> though.
>
> I would be interested in bug fixes upstream which fixes:
>
> libphy: Freescale XGMAC MDIO Bus: probed
> iommu: Adding device ffe488000.port to group 10
> libphy: Freescale XGMAC MDIO Bus: probed
> mdio_bus ffe4e1000: Error while reading PHY0 reg at 3.3
> iommu: Adding device ffe489000.port to group 22
> libphy: Freescale XGMAC MDIO Bus: probed
> mdio_bus ffe4e3000: Error while reading PHY0 reg at 3.3
> iommu: Adding device ffe48a000.port to group 23
> libphy: Freescale XGMAC MDIO Bus: probed
> mdio_bus ffe4e5000: Error while reading PHY0 reg at 3.3
> iommu: Adding device ffe48b000.port to group 24
> libphy: Freescale XGMAC MDIO Bus: probed
> mdio_bus ffe4e7000: Error while reading PHY0 reg at 3.3
> iommu: Adding device ffe48c000.port to group 25
> libphy: Freescale XGMAC MDIO Bus: probed
> mdio_bus ffe4e9000: Error while reading PHY0 reg at 3.3
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
>
> Every FMAN eth I/F with a fixed link fails mysteriously.
> Custom board based on t1040rdb, been over the device tree and I cannot
> find any significant
> changes.
>
>  Jocke

--001a1142c20c3086c50562f7ae08
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">After using the new compiled 4.14 rc8 kernel without PAMU =
support posted by Christian Zigotzky the X5000 can use the Network interfac=
e with some minor issues.<div><br></div><div><div>I had to give the Eth0 a =
manual IP due to not responding on DHCP requests.</div><div><br></div><div>=
I can ping my Gateway, and even DNS queries work..</div><div><br></div><div=
>But when i start Netsurf (or generate to much packets)... all traffic dies=
.... due to No buffer space available..</div><div><br></div><div>64 bytes f=
rom <a href=3D"http://192.168.22.66">192.168.22.66</a>: icmp_seq=3D81 ttl=
=3D255 time=3D0.317 ms</div><div>64 bytes from <a href=3D"http://192.168.22=
.66">192.168.22.66</a>: icmp_seq=3D82 ttl=3D255 time=3D0.317 ms</div><div>6=
4 bytes from <a href=3D"http://192.168.22.66">192.168.22.66</a>: icmp_seq=
=3D83 ttl=3D255 time=3D0.314 ms</div><div>64 bytes from <a href=3D"http://1=
92.168.22.66">192.168.22.66</a>: icmp_seq=3D84 ttl=3D255 time=3D0.321 ms</d=
iv><div>64 bytes from <a href=3D"http://192.168.22.66">192.168.22.66</a>: i=
cmp_seq=3D85 ttl=3D255 time=3D0.323 ms</div><div>64 bytes from <a href=3D"h=
ttp://192.168.22.66">192.168.22.66</a>: icmp_seq=3D86 ttl=3D255 time=3D0.31=
2 ms</div><div>64 bytes from <a href=3D"http://192.168.22.66">192.168.22.66=
</a>: icmp_seq=3D87 ttl=3D255 time=3D0.331 ms</div><div>64 bytes from <a hr=
ef=3D"http://192.168.22.66">192.168.22.66</a>: icmp_seq=3D88 ttl=3D255 time=
=3D0.338 ms</div><div>64 bytes from <a href=3D"http://192.168.22.66">192.16=
8.22.66</a>: icmp_seq=3D89 ttl=3D255 time=3D0.334 ms</div><div>64 bytes fro=
m <a href=3D"http://192.168.22.66">192.168.22.66</a>: icmp_seq=3D90 ttl=3D2=
55 time=3D0.349 ms</div><div>64 bytes from <a href=3D"http://192.168.22.66"=
>192.168.22.66</a>: icmp_seq=3D91 ttl=3D255 time=3D0.324 ms</div><div>64 by=
tes from <a href=3D"http://192.168.22.66">192.168.22.66</a>: icmp_seq=3D92 =
ttl=3D255 time=3D0.320 ms</div><div>64 bytes from <a href=3D"http://192.168=
.22.66">192.168.22.66</a>: icmp_seq=3D93 ttl=3D255 time=3D0.320 ms</div><di=
v>64 bytes from <a href=3D"http://192.168.22.66">192.168.22.66</a>: icmp_se=
q=3D94 ttl=3D255 time=3D0.338 ms</div><div>ping: sendmsg: No buffer space a=
vailable</div><div>ping: sendmsg: No buffer space available</div><div>ping:=
 sendmsg: No buffer space available</div><div>ping: sendmsg: No buffer spac=
e available</div><div>ping: sendmsg: No buffer space available</div><div>pi=
ng: sendmsg: No buffer space available</div><div>ping: sendmsg: No buffer s=
pace available</div><div>ping: sendmsg: No buffer space available</div></di=
v><div><br></div><div><div>A workaround to keep Eth0 alive a bit longer....=
 is the following command=C2=A0</div><div><br></div><div>ip link set eth0 q=
len 10000</div></div><div><br></div><div>We are making progress!!</div><div=
><br></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Jan 17, 2018 at 12:47 PM, Joakim Tjernlund <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:Joakim.Tjernlund@infinera.com" target=3D"_blank">Joakim.Tje=
rnlund@infinera.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>On Thu, 1970-01-01 at 00:00 +0000, Andrew Lunn wrote:<br>
&gt; CAUTION: This email originated from outside of the organization. Do no=
t click links or open attachments unless you recognize the sender and know =
the content is safe.<br>
&gt;<br>
&gt;<br>
&gt; &gt; &gt; You appear to be using an old kernel. Take a look at:<br>
&gt; &gt;<br>
&gt; &gt; Not really, I am using 4.14.x and I don&#39;t think that is old.<=
br>
&gt;<br>
&gt; Development for 4.14 stopped somewhere around the beginning of<br>
&gt; September. So there has been over 4 months of work since then.=C2=A0 W=
e are<br>
&gt; clearly interested in fixing bugs in that kernel, since it is the<br>
&gt; current stable version. But when reporting bugs, please let is know if=
<br>
&gt; the latest version of the network kernel,<br>
&gt; it://<a href=3D"http://git.kernel.org/pub/scm/linux/kernel/git/davem/n=
et-next.git" rel=3D"noreferrer" target=3D"_blank">git.kernel.org/pub/scm/<w=
br>linux/kernel/git/davem/net-<wbr>next.git</a> has<br>
&gt; the issue.<br>
&gt;<br>
&gt; &gt; Seems like this patch hasn&#39;t been sent to 4.14.x.<br>
&gt;<br>
&gt; If it fixes a bug for you, please request the fix is added to stable.<=
br>
<br>
That doesn&#39;t work really, having users to hit the bug, debug it, fix it=
 and then<br>
find it fixed already in upstream, then specifically request it to be backp=
orted to stable.<br>
I don&#39;t need this fix to be backported, already got it. Someone else mi=
ght though.<br>
<br>
I would be interested in bug fixes upstream which fixes:<br>
<br>
libphy: Freescale XGMAC MDIO Bus: probed<br>
iommu: Adding device ffe488000.port to group 10<br>
libphy: Freescale XGMAC MDIO Bus: probed<br>
mdio_bus ffe4e1000: Error while reading PHY0 reg at 3.3<br>
iommu: Adding device ffe489000.port to group 22<br>
libphy: Freescale XGMAC MDIO Bus: probed<br>
mdio_bus ffe4e3000: Error while reading PHY0 reg at 3.3<br>
iommu: Adding device ffe48a000.port to group 23<br>
libphy: Freescale XGMAC MDIO Bus: probed<br>
mdio_bus ffe4e5000: Error while reading PHY0 reg at 3.3<br>
iommu: Adding device ffe48b000.port to group 24<br>
libphy: Freescale XGMAC MDIO Bus: probed<br>
mdio_bus ffe4e7000: Error while reading PHY0 reg at 3.3<br>
iommu: Adding device ffe48c000.port to group 25<br>
libphy: Freescale XGMAC MDIO Bus: probed<br>
mdio_bus ffe4e9000: Error while reading PHY0 reg at 3.3<br>
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
<br>
Every FMAN eth I/F with a fixed link fails mysteriously.<br>
Custom board based on t1040rdb, been over the device tree and I cannot find=
 any significant<br>
changes.<br>
<br>
=C2=A0Jocke</blockquote></div><br></div>

--001a1142c20c3086c50562f7ae08--
