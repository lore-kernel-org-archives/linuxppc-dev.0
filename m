Return-Path: <michael.heltne@gmail.com>
Received: from mail-yk0-x229.google.com (mail-yk0-x229.google.com
 [IPv6:2607:f8b0:4002:c07::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C21991A002B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2016 01:42:39 +1100 (AEDT)
Received: by mail-yk0-x229.google.com with SMTP id z7so59967739yka.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Feb 2016 06:42:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOJe8K3wL-ctaWU+Fb+hz3JaTAVLgvMia0-cM2ziW+jM1jpUcA@mail.gmail.com>
References: <CANtoAtPSgkxEvAdOs-gZGOECYN8OFTvwRrsg+US41ji1fGEDLA@mail.gmail.com>
 <CAOJe8K3wL-ctaWU+Fb+hz3JaTAVLgvMia0-cM2ziW+jM1jpUcA@mail.gmail.com>
Date: Fri, 5 Feb 2016 14:42:37 +0000
Message-ID: <CANtoAtNf0Z8M8utDn1VQGnT5OBiMs+ECvM054r-HFVpGAW2fbg@mail.gmail.com>
Subject: Re: PowerPC agpmode issues
From: Mike <michael.heltne@gmail.com>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: Pranith Kumar <bobby.prani@gmail.com>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary=001a113d07ccc4d2c9052b06dc9f
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a113d07ccc4d2c9052b06dc9f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Put the info forth in an Amiga ppc related thread, agpmode=3D-1 is also
needed on the Pegasos 2, need do some research/googling but is it safe to
say its broken for all non x86 platforms?

Including those replies here:
----
Hi Christian and Mike,
for my personal experiences on Pegasos2 and MacMini G4 the performance was
 good on 3D and 2D but need the agpmode=3D-1 or the system freeze
adding the agpmode=3D-1 make loose performances but make the system working
this because the gpu without that append was over working it was look like
software overclocked.
 About agp macs a guy on ubuntuforums boost his performance adding this to
the kernel append  "quiet splash radeon.modeset=3D0
video=3Dradeonfb:1280x960-32@60 "

About Pegasos2 i had it with 9800pro and the machine was running great.
Alex i know is a geek with this machine that i dont have any moore or
better i have another one died :-
---

Hi Luigi.

Thanks. Remember the modeset=3D0 flag my self from a while back, had to be
appended to either the kernel or as an option the the module. What a sorry
state.. I think agpmode=3D-1 masks a bunch of issues, degrading performance
due to some hittage of the cpu unnecessary, thats my suspicion anyway.
likely if ever a fix is found it will reveal a bunch of other issues is my
fear.
----



On 5 February 2016 at 07:49, Denis Kirjanov <kda@linux-powerpc.org> wrote:

> On 2/5/16, Mike <michael.heltne@gmail.com> wrote:
> > Hi.
> > Managed to get the Radeon R300 running on mesa 11.1.1 with an old 2013
> > patch from Michel D=C3=A0nzer, next problem is of course enabling agpmo=
de,
> > running with pci-mode with radeon.agpmode=3D-1 works, but is of course
> slow,
> > and seems to load the cpu a lot.
>
> For me nouveau on quad pmac is also broken for years(?) :/
>
> >
> > Upon initial investigation i could not initially believe agp could be
> this
> > this broken for this long, until i found this.
> >  "committed with Ben Skeggs on Feb 26, 2013"
> >
> https://github.com/DespairFactor/bullhead/commit/650e1203c11354ba84d69ba4=
45abc0efcfe3890a
> >
> http://lxr.free-electrons.com/source/drivers/gpu/drm/nouveau/nouveau_agp.=
c?v=3D4.2
> > #ifdef __powerpc__
> > /* Disable AGP by default on all PowerPC machines for
> > * now -- At least some UniNorth-2 AGP bridges are
> > * known to be broken: DMA from the host to the card
> > * works just fine, but writeback from the card to the
> > * host goes straight to memory untranslated bypassing
> > * the GATT somehow, making them quite painful to deal
> > * with...
> > */
> > if (nouveau_agpmode =3D=3D -1)
> > return false;
> > #endif
> >
> >  and now later this:
> >
> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/nouveau/nvk=
m/subdev/pci/agp.c
> > #ifdef __powerpc__
> > /* Disable AGP by default on all PowerPC machines for now -- At
> > * least some UniNorth-2 AGP bridges are known to be broken:
> > * DMA from the host to the card works just fine, but writeback
> > * from the card to the host goes straight to memory
> > * untranslated bypassing that GATT somehow, making them quite
> > * painful to deal with...
> > */
> > mode =3D 0;
> > #endif
> >
> > All seems to point to serious issues had around the time of change to u=
ms
> > to kms and a serious regression hitting the linux kernel? No?
> >
> > Cheers
> > -Mike
> >
>

--001a113d07ccc4d2c9052b06dc9f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Put the info forth in an Amiga ppc related thread, agpmode=
=3D-1 is also needed on the Pegasos 2, need do some research/googling but i=
s it safe to say its broken for all non x86 platforms?=C2=A0<div><br></div>=
<div>Including those replies here:</div><div>----</div><div><span style=3D"=
font-size:12.8px">Hi Christian and Mike,</span><div style=3D"font-size:12.8=
px">for my personal experiences on Pegasos2 and MacMini G4 the performance =
was =C2=A0good on 3D and 2D but need the agpmode=3D-1 or the system freeze=
=C2=A0</div><div style=3D"font-size:12.8px">adding the agpmode=3D-1 make lo=
ose performances but make the system working this because the gpu without t=
hat append was over working it was look like software overclocked.</div><di=
v style=3D"font-size:12.8px">=C2=A0<span style=3D"font-size:12pt">About agp=
 macs a guy on ubuntuforums boost his performance adding this to the kernel=
 append =C2=A0</span><span style=3D"font-family:Ubuntubeta,Ubuntu,&#39;Bits=
tream Vera Sans&#39;,&#39;DejaVu Sans&#39;,Tahoma,sans-serif;font-size:13px=
;line-height:15.99px;background-color:rgb(235,236,228)">&quot;quiet splash =
radeon.modeset=3D0 video=3Dradeonfb:1280x960-32@60 &quot;</span></div><div =
style=3D"font-size:12.8px"><font face=3D"Ubuntubeta, Ubuntu, Bitstream Vera=
 Sans, DejaVu Sans, Tahoma, sans-serif"><span style=3D"font-size:13px;line-=
height:15.99px"><br></span></font></div><div style=3D"font-size:12.8px"><fo=
nt face=3D"Ubuntubeta, Ubuntu, Bitstream Vera Sans, DejaVu Sans, Tahoma, sa=
ns-serif"><span style=3D"font-size:13px;line-height:15.99px">About Pegasos2=
 i had it with 9800pro and the machine was running great.</span></font></di=
v><div style=3D"font-size:12.8px"><font face=3D"Ubuntubeta, Ubuntu, Bitstre=
am Vera Sans, DejaVu Sans, Tahoma, sans-serif"><span style=3D"font-size:13p=
x;line-height:15.99px">Alex i know is a geek with this machine that i dont =
have any moore or better i have another one died :-</span></font></div></di=
v><div style=3D"font-size:12.8px"><font face=3D"Ubuntubeta, Ubuntu, Bitstre=
am Vera Sans, DejaVu Sans, Tahoma, sans-serif"><span style=3D"font-size:13p=
x;line-height:15.99px">---</span></font></div><div style=3D"font-size:12.8p=
x"><font face=3D"Ubuntubeta, Ubuntu, Bitstream Vera Sans, DejaVu Sans, Taho=
ma, sans-serif"><span style=3D"font-size:13px;line-height:15.99px"><br></sp=
an></font></div><div style=3D"font-size:12.8px"><span style=3D"font-size:12=
.8px">Hi Luigi.=C2=A0</span><div style=3D"font-size:12.8px"><br></div><div =
style=3D"font-size:12.8px">Thanks. Remember the modeset=3D0 flag my self fr=
om a while back, had to be appended to either the kernel or as an option th=
e the module. What a sorry state.. I think agpmode=3D-1 masks a bunch of is=
sues, degrading performance due to some hittage of the cpu unnecessary, tha=
ts my suspicion anyway. likely if ever a fix is found it will reveal a bunc=
h of other issues is my fear. =C2=A0=C2=A0</div><div style=3D"font-size:12.=
8px">----</div><div style=3D"font-size:12.8px"><br></div><div style=3D"font=
-size:12.8px"><br></div></div></div><div class=3D"gmail_extra"><br><div cla=
ss=3D"gmail_quote">On 5 February 2016 at 07:49, Denis Kirjanov <span dir=3D=
"ltr">&lt;<a href=3D"mailto:kda@linux-powerpc.org" target=3D"_blank">kda@li=
nux-powerpc.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><sp=
an class=3D"">On 2/5/16, Mike &lt;<a href=3D"mailto:michael.heltne@gmail.co=
m">michael.heltne@gmail.com</a>&gt; wrote:<br>
&gt; Hi.<br>
&gt; Managed to get the Radeon R300 running on mesa 11.1.1 with an old 2013=
<br>
&gt; patch from Michel D=C3=A0nzer, next problem is of course enabling agpm=
ode,<br>
&gt; running with pci-mode with radeon.agpmode=3D-1 works, but is of course=
 slow,<br>
&gt; and seems to load the cpu a lot.<br>
<br>
</span>For me nouveau on quad pmac is also broken for years(?) :/<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt; Upon initial investigation i could not initially believe agp could be =
this<br>
&gt; this broken for this long, until i found this.<br>
&gt;=C2=A0 &quot;committed with Ben Skeggs on Feb 26, 2013&quot;<br>
&gt; <a href=3D"https://github.com/DespairFactor/bullhead/commit/650e1203c1=
1354ba84d69ba445abc0efcfe3890a" rel=3D"noreferrer" target=3D"_blank">https:=
//github.com/DespairFactor/bullhead/commit/650e1203c11354ba84d69ba445abc0ef=
cfe3890a</a><br>
&gt; <a href=3D"http://lxr.free-electrons.com/source/drivers/gpu/drm/nouvea=
u/nouveau_agp.c?v=3D4.2" rel=3D"noreferrer" target=3D"_blank">http://lxr.fr=
ee-electrons.com/source/drivers/gpu/drm/nouveau/nouveau_agp.c?v=3D4.2</a><b=
r>
&gt; #ifdef __powerpc__<br>
&gt; /* Disable AGP by default on all PowerPC machines for<br>
&gt; * now -- At least some UniNorth-2 AGP bridges are<br>
&gt; * known to be broken: DMA from the host to the card<br>
&gt; * works just fine, but writeback from the card to the<br>
&gt; * host goes straight to memory untranslated bypassing<br>
&gt; * the GATT somehow, making them quite painful to deal<br>
&gt; * with...<br>
&gt; */<br>
&gt; if (nouveau_agpmode =3D=3D -1)<br>
&gt; return false;<br>
&gt; #endif<br>
&gt;<br>
&gt;=C2=A0 and now later this:<br>
&gt; <a href=3D"https://github.com/torvalds/linux/blob/master/drivers/gpu/d=
rm/nouveau/nvkm/subdev/pci/agp.c" rel=3D"noreferrer" target=3D"_blank">http=
s://github.com/torvalds/linux/blob/master/drivers/gpu/drm/nouveau/nvkm/subd=
ev/pci/agp.c</a><br>
&gt; #ifdef __powerpc__<br>
&gt; /* Disable AGP by default on all PowerPC machines for now -- At<br>
&gt; * least some UniNorth-2 AGP bridges are known to be broken:<br>
&gt; * DMA from the host to the card works just fine, but writeback<br>
&gt; * from the card to the host goes straight to memory<br>
&gt; * untranslated bypassing that GATT somehow, making them quite<br>
&gt; * painful to deal with...<br>
&gt; */<br>
&gt; mode =3D 0;<br>
&gt; #endif<br>
&gt;<br>
&gt; All seems to point to serious issues had around the time of change to =
ums<br>
&gt; to kms and a serious regression hitting the linux kernel? No?<br>
&gt;<br>
&gt; Cheers<br>
&gt; -Mike<br>
&gt;<br>
</div></div></blockquote></div><br></div>

--001a113d07ccc4d2c9052b06dc9f--
