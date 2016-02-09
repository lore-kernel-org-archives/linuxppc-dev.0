Return-Path: <intermediadc@hotmail.com>
Received: from DUB004-OMC2S16.hotmail.com (dub004-omc2s16.hotmail.com
 [157.55.1.155])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8E8EF1A0331
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 23:20:44 +1100 (AEDT)
Message-ID: <DUB117-W780D7ADCEFBEC8C1401988C8D60@phx.gbl>
Content-Type: multipart/alternative;
 boundary="_445da21b-51dc-41f5-a459-f7753749b247_"
From: luigi burdo <intermediadc@hotmail.com>
To: Gerhard Pircher <gerhard_pircher@gmx.net>, Mike <michael.heltne@gmail.com>
CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>, "\"Michel D?nzer\"
 <michel@daenzer.net>;  open list": "LINUX FOR POWERPC...
 <linuxppc-dev@lists.ozlabs.org>;  Boris Reinhard
 <reinhard.boris@googlemail.com>;  Pranith Kumar  <bobby.prani@gmail.com>";
Subject: RE: PowerPC agpmode issues
Date: Tue, 9 Feb 2016 13:15:16 +0100
In-Reply-To: <trinity-ec0d2d46-6887-49a0-aa66-47aad4c93969-1455018735101@3capp-gmx-bs34>
References: <CANtoAtPSgkxEvAdOs-gZGOECYN8OFTvwRrsg+US41ji1fGEDLA@mail.gmail.com>,
 <56B865A0.4060707@daenzer.net>,
 <CAK90Sjk-AXekt_WKSk53GUeUZk-T4WhrwoNuwPA5N4pX2OPceA@mail.gmail.com>,
 <CANtoAtPoYodsC3u-BOi8HM=ew03CX32BBKvFXwZJ4wbSkMWRZQ@mail.gmail.com>,
 <56B943E3.1010407@daenzer.net>, ,
 <CANtoAtNUbSdS0GgoSGUPK4sRsXOhLtNmPqbFFaQ0xW0gGecCRA@mail.gmail.com>,
 <trinity-ec0d2d46-6887-49a0-aa66-47aad4c93969-1455018735101@3capp-gmx-bs34>
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_445da21b-51dc-41f5-a459-f7753749b247_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Mike and Gerhard=2C dont think the situation of the pcie powerpc is bettrer=
.but compared with last years with the new kernels and last xorg on a radeo=
nhd 4650 i have an increase of performance about 250x ... example QuakeSpas=
m was gaving 640x480157fps on Radeon 4650... Now is 380 fps yes compared th=
e old nvida 7800gtx on Osx  450 fps this results are less but for sure bett=
er than before.
The worst of last period im facing r600 radeon ring test errors and  i cant=
 usewith gpu accel now only in fbdev the 5450 and 6570 that it was perfect =
working before.
Luigi

> From: gerhard_pircher@gmx.net
> To: michael.heltne@gmail.com
> Subject: Re: PowerPC agpmode issues
> Date: Tue=2C 9 Feb 2016 12:52:15 +0100
> CC: aneesh.kumar@linux.vnet.ibm.com=3B michel@daenzer.net=3B linuxppc-dev=
@lists.ozlabs.org=3B reinhard.boris@googlemail.com=3B bobby.prani@gmail.com
>=20
> > On 9 Feb 2016 03:27=2C "Mike" <michael.heltne@gmail.com> wrote:
> > Ok=2C so its quirks to be added then? Something not implemented in KMS
> > that was in UMS?
> > Reports are that the same issue exsist on PPC Amiga Ones with a VIA
> > chipset=2C and the Pegasos 2 with the Artica s chipset=2C i posted a
> > mail from detailiing that.
> Just to avoid some confusion:
> Old long story short: the issues for AmigaOnes and the Pegasos _1_ with
> ArticiaS northbridge and VIA southbridge are that:
> 1. the AGP controller corrupts data transfers in AGP mode (also depending
> on the AGP HW request queue size). So there is no official AGP driver tha=
t
> would require radeon.agpmode=3D-1. The microA1 is supposed to have a fix
> for this HW data corruption=2C but I yet have to dig out my ArticiaS AGP
> driver code for some test runs...
> 2. At least the AmigaOne with ArticiaS chip need non-coherent DMA
> allocations and/or proper cache flushes to avoid corrupted DMA transfers.
>=20
> Nonetheless I had DRI1 working _only_ on my A1SE under Debian Squeeze (i.=
e.
> glxgears could run on the desktop with hardware acceleration)=2C but DRI2
> with its very dynamic GART mapping is a no-go on every first-gen AmigaOne
> machine=2C even if the GART driver test (radeon.test=3D1) runs through in
> PCIGART mode (could it be that it uses a more or less static GART mapping
> for the test?).
>=20
> > Sure that might be it=2C but i get different results trying agpmode=3D1=
-2-4=2C
> > 2 gave a noisy screen before the hard crash. i find it rather impossibl=
e
> > to debug at all as the crash happens so fast no logs seem to be written=
..
> > I think i would need serial...
> > I'd personally love nothing more then to see support restored and a
> > default as expected working condition ought be the minimum requirement.
> > I use a powerbook a1106=2C 5=2C6. With a 5=2C8 on the way. Those are th=
e last
> > two revision powerbooks in the 15" series. In swrast they become useles=
s=2C
> > impossible to use for any productivity. Most people trying to use linux
> > on ppc for personal use come in macs=2C with the exception of the Amiga=
 PPC
> > crowd now running their amcc 440/460ex or e600 based x500/5000=2C all o=
f
> > which have of course pci-e more cores and more threads. Yet struggle ev=
en
> > with regressions left and right to keep up with the single core perform=
ance
> > of the G4's. Sure it's pushing 10 years =2C but it's the only alternati=
ve
> > if one wishes to remain mobile.
> swrast definitely isn't fun on 10 years old PPC machines. Current Firefox
> is already slow enough on these machines... :-)
>=20
> > On 9 Feb 2016 02:41=2C "Michel D=E4nzer" <michel@daenzer.net> wrote:
> > > On 08.02.2016 22:28=2C Mike wrote:
> > > Certainly 750~800 fps in glxgears vs 3000+ in debian squeeze=2C i can=
t
> > > bring myself to say that it's an acceptable situation no matter how
> > > tired i am of the problem knowing how well the setup could do. It's
> > > clear that the implementation is broken for everything but x86=2C [..=
.]
> >=20
> > Why is that? It was working fine on my last-gen PowerBook. AFAIK Darwin
> > / OS X never used anything but a static AGP GART mapping though=2C so i=
t
> > seems very likely that the issues with older UniNorth revisions are
> > simply due to the hardware being unable to support the usage patterns o=
f
> > modern GPU drivers.
> >=20
> > That said=2C if you guys have specific suggestions for a "proper"
> > solution=2C nobody's standing in your way.
> I have to admit that I lack the knowledge of the inner workings of the
> TTM/radeon code (and its TTM AGP backend) to do any useful work here.
> I was hoping that the TMA DMA allocator could be of any help at least for
> non-cache coherent machines given that (IIRC) ARM is using it together
> with the nuoveau driver on the TEGRA platform=2C but I guess that would n=
eed
> some modifications also on the powerpc architecture side (maybe a new
> non-coherent DMA allocator that is not limited to 2M virtual address spac=
e
> for mappings). Thus I guess a lot of things could be improved/fixed=2C bu=
t
> nowadays Linux code doesn't seem to be something for the "occasional hobb=
y
> hacker". :-)
>=20
> regards=2C
> Gerhard
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
 		 	   		  =

--_445da21b-51dc-41f5-a459-f7753749b247_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 12pt=3B
font-family:Calibri
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>Mike and Gerhard=2C&nbsp=3B<div>=
dont think the situation of the pcie powerpc is bettrer.</div><div>but comp=
ared with last years with the new kernels and last xorg on a radeonhd 4650&=
nbsp=3B</div><div>i have an increase of performance about 250x ...&nbsp=3B<=
/div><div>example QuakeSpasm was gaving 640x480157fps on Radeon 4650... Now=
 is 380 fps&nbsp=3B</div><div>yes compared the old nvida 7800gtx on Osx &nb=
sp=3B450 fps this results are less but for sure better than before.</div><d=
iv><br></div><div>The worst of last period im facing r600 radeon ring test =
errors and &nbsp=3Bi cant use</div><div>with gpu accel now only in fbdev th=
e 5450 and 6570 that it was perfect working before.</div><div><br></div><di=
v>Luigi<br><br><div>&gt=3B From: gerhard_pircher@gmx.net<br>&gt=3B To: mich=
ael.heltne@gmail.com<br>&gt=3B Subject: Re: PowerPC agpmode issues<br>&gt=
=3B Date: Tue=2C 9 Feb 2016 12:52:15 +0100<br>&gt=3B CC: aneesh.kumar@linux=
.vnet.ibm.com=3B michel@daenzer.net=3B linuxppc-dev@lists.ozlabs.org=3B rei=
nhard.boris@googlemail.com=3B bobby.prani@gmail.com<br>&gt=3B <br>&gt=3B &g=
t=3B On 9 Feb 2016 03:27=2C "Mike" &lt=3Bmichael.heltne@gmail.com&gt=3B wro=
te:<br>&gt=3B &gt=3B Ok=2C so its quirks to be added then? Something not im=
plemented in KMS<br>&gt=3B &gt=3B that was in UMS?<br>&gt=3B &gt=3B Reports=
 are that the same issue exsist on PPC Amiga Ones with a VIA<br>&gt=3B &gt=
=3B chipset=2C and the Pegasos 2 with the Artica s chipset=2C i posted a<br=
>&gt=3B &gt=3B mail from detailiing that.<br>&gt=3B Just to avoid some conf=
usion:<br>&gt=3B Old long story short: the issues for AmigaOnes and the Peg=
asos _1_ with<br>&gt=3B ArticiaS northbridge and VIA southbridge are that:<=
br>&gt=3B 1. the AGP controller corrupts data transfers in AGP mode (also d=
epending<br>&gt=3B on the AGP HW request queue size). So there is no offici=
al AGP driver that<br>&gt=3B would require radeon.agpmode=3D-1. The microA1=
 is supposed to have a fix<br>&gt=3B for this HW data corruption=2C but I y=
et have to dig out my ArticiaS AGP<br>&gt=3B driver code for some test runs=
...<br>&gt=3B 2. At least the AmigaOne with ArticiaS chip need non-coherent=
 DMA<br>&gt=3B allocations and/or proper cache flushes to avoid corrupted D=
MA transfers.<br>&gt=3B <br>&gt=3B Nonetheless I had DRI1 working _only_ on=
 my A1SE under Debian Squeeze (i.e.<br>&gt=3B glxgears could run on the des=
ktop with hardware acceleration)=2C but DRI2<br>&gt=3B with its very dynami=
c GART mapping is a no-go on every first-gen AmigaOne<br>&gt=3B machine=2C =
even if the GART driver test (radeon.test=3D1) runs through in<br>&gt=3B PC=
IGART mode (could it be that it uses a more or less static GART mapping<br>=
&gt=3B for the test?).<br>&gt=3B <br>&gt=3B &gt=3B Sure that might be it=2C=
 but i get different results trying agpmode=3D1-2-4=2C<br>&gt=3B &gt=3B 2 g=
ave a noisy screen before the hard crash. i find it rather impossible<br>&g=
t=3B &gt=3B to debug at all as the crash happens so fast no logs seem to be=
 written..<br>&gt=3B &gt=3B I think i would need serial...<br>&gt=3B &gt=3B=
 I'd personally love nothing more then to see support restored and a<br>&gt=
=3B &gt=3B default as expected working condition ought be the minimum requi=
rement.<br>&gt=3B &gt=3B I use a powerbook a1106=2C 5=2C6. With a 5=2C8 on =
the way. Those are the last<br>&gt=3B &gt=3B two revision powerbooks in the=
 15" series. In swrast they become useless=2C<br>&gt=3B &gt=3B impossible t=
o use for any productivity. Most people trying to use linux<br>&gt=3B &gt=
=3B on ppc for personal use come in macs=2C with the exception of the Amiga=
 PPC<br>&gt=3B &gt=3B crowd now running their amcc 440/460ex or e600 based =
x500/5000=2C all of<br>&gt=3B &gt=3B which have of course pci-e more cores =
and more threads. Yet struggle even<br>&gt=3B &gt=3B with regressions left =
and right to keep up with the single core performance<br>&gt=3B &gt=3B of t=
he G4's. Sure it's pushing 10 years =2C but it's the only alternative<br>&g=
t=3B &gt=3B if one wishes to remain mobile.<br>&gt=3B swrast definitely isn=
't fun on 10 years old PPC machines. Current Firefox<br>&gt=3B is already s=
low enough on these machines... :-)<br>&gt=3B <br>&gt=3B &gt=3B On 9 Feb 20=
16 02:41=2C "Michel D=E4nzer" &lt=3Bmichel@daenzer.net&gt=3B wrote:<br>&gt=
=3B &gt=3B &gt=3B On 08.02.2016 22:28=2C Mike wrote:<br>&gt=3B &gt=3B &gt=
=3B Certainly 750~800 fps in glxgears vs 3000+ in debian squeeze=2C i cant<=
br>&gt=3B &gt=3B &gt=3B bring myself to say that it's an acceptable situati=
on no matter how<br>&gt=3B &gt=3B &gt=3B tired i am of the problem knowing =
how well the setup could do. It's<br>&gt=3B &gt=3B &gt=3B clear that the im=
plementation is broken for everything but x86=2C [...]<br>&gt=3B &gt=3B <br=
>&gt=3B &gt=3B Why is that? It was working fine on my last-gen PowerBook. A=
FAIK Darwin<br>&gt=3B &gt=3B / OS X never used anything but a static AGP GA=
RT mapping though=2C so it<br>&gt=3B &gt=3B seems very likely that the issu=
es with older UniNorth revisions are<br>&gt=3B &gt=3B simply due to the har=
dware being unable to support the usage patterns of<br>&gt=3B &gt=3B modern=
 GPU drivers.<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B That said=2C if you guys h=
ave specific suggestions for a "proper"<br>&gt=3B &gt=3B solution=2C nobody=
's standing in your way.<br>&gt=3B I have to admit that I lack the knowledg=
e of the inner workings of the<br>&gt=3B TTM/radeon code (and its TTM AGP b=
ackend) to do any useful work here.<br>&gt=3B I was hoping that the TMA DMA=
 allocator could be of any help at least for<br>&gt=3B non-cache coherent m=
achines given that (IIRC) ARM is using it together<br>&gt=3B with the nuove=
au driver on the TEGRA platform=2C but I guess that would need<br>&gt=3B so=
me modifications also on the powerpc architecture side (maybe a new<br>&gt=
=3B non-coherent DMA allocator that is not limited to 2M virtual address sp=
ace<br>&gt=3B for mappings). Thus I guess a lot of things could be improved=
/fixed=2C but<br>&gt=3B nowadays Linux code doesn't seem to be something fo=
r the "occasional hobby<br>&gt=3B hacker". :-)<br>&gt=3B <br>&gt=3B regards=
=2C<br>&gt=3B Gerhard<br>&gt=3B ___________________________________________=
____<br>&gt=3B Linuxppc-dev mailing list<br>&gt=3B Linuxppc-dev@lists.ozlab=
s.org<br>&gt=3B https://lists.ozlabs.org/listinfo/linuxppc-dev<br></div></d=
iv> 		 	   		  </div></body>
</html>=

--_445da21b-51dc-41f5-a459-f7753749b247_--
