Return-Path: <michael.heltne@gmail.com>
Received: from mail-yk0-x236.google.com (mail-yk0-x236.google.com
 [IPv6:2607:f8b0:4002:c07::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6DA001A0190
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 23:09:51 +1100 (AEDT)
Received: by mail-yk0-x236.google.com with SMTP id z7so85750879yka.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Feb 2016 04:09:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56B865A0.4060707@daenzer.net>
References: <CANtoAtPSgkxEvAdOs-gZGOECYN8OFTvwRrsg+US41ji1fGEDLA@mail.gmail.com>
 <56B865A0.4060707@daenzer.net>
Date: Mon, 8 Feb 2016 12:09:48 +0000
Message-ID: <CANtoAtMBuvObPZPYuUiFJF39qRgay7jLKH_Ch3DzdhdG-cFbbA@mail.gmail.com>
Subject: Re: PowerPC agpmode issues
From: Mike <michael.heltne@gmail.com>
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: Pranith Kumar <bobby.prani@gmail.com>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary=001a113dd0d0cc8978052b411376
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a113dd0d0cc8978052b411376
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I feel that would alleviate the symptoms and still leave a sick puppy. If
one could work around some of the issues i'd like that solution, it would
certainly make it easier for newcomers. It's a lucky enough situation that
default shipping mesa is broken enough to default to swrast, hardware
acceleration brings on a crash so hard a 5 sec power off is required if
agpmode is active...

On 8 February 2016 at 09:53, Michel D=C3=A4nzer <michel@daenzer.net> wrote:

> On 05.02.2016 11:47, Mike wrote:
> > Hi.
> > Managed to get the Radeon R300 running on mesa 11.1.1 with an old 2013
> > patch from Michel D=C3=A0nzer, next problem is of course enabling agpmo=
de,
> > running with pci-mode with radeon.agpmode=3D-1 works, but is of course
> > slow, and seems to load the cpu a lot.
> >
> > Upon initial investigation i could not initially believe agp could be
> > this this broken for this long, until i found this.
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
> > All seems to point to serious issues had around the time of change to
> > ums to kms and a serious regression hitting the linux kernel? No?
>
> Not really. UMS was just using a static GART mapping, whereas KMS is
> dynamically binding pages into the GART as needed. Apparently, older
> revisions of UniNorth have trouble with the latter. I think it would
> make sense to change radeon.agpmode to default to -1 on powerpc as well.
> Any takers?
>
>
> --
> Earthling Michel D=C3=A4nzer               |               http://www.amd=
.com
> Libre software enthusiast             |             Mesa and X developer
>

--001a113dd0d0cc8978052b411376
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I feel that would alleviate the symptoms and still leave a=
 sick puppy. If one could work around some of the issues i&#39;d like that =
solution, it would certainly make it easier for newcomers. It&#39;s a lucky=
 enough situation that default shipping mesa is broken enough to default to=
 swrast, hardware acceleration brings on a crash so hard a 5 sec power off =
is required if agpmode is active...=C2=A0</div><div class=3D"gmail_extra"><=
br><div class=3D"gmail_quote">On 8 February 2016 at 09:53, Michel D=C3=A4nz=
er <span dir=3D"ltr">&lt;<a href=3D"mailto:michel@daenzer.net" target=3D"_b=
lank">michel@daenzer.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On 05.02.2016 11:47, Mike wro=
te:<br>
&gt; Hi.<br>
&gt; Managed to get the Radeon R300 running on mesa 11.1.1 with an old 2013=
<br>
&gt; patch from Michel D=C3=A0nzer, next problem is of course enabling agpm=
ode,<br>
&gt; running with pci-mode with radeon.agpmode=3D-1 works, but is of course=
<br>
&gt; slow, and seems to load the cpu a lot.<br>
&gt;<br>
&gt; Upon initial investigation i could not initially believe agp could be<=
br>
&gt; this this broken for this long, until i found this.<br>
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
&gt; All seems to point to serious issues had around the time of change to<=
br>
&gt; ums to kms and a serious regression hitting the linux kernel? No?<br>
<br>
</div></div>Not really. UMS was just using a static GART mapping, whereas K=
MS is<br>
dynamically binding pages into the GART as needed. Apparently, older<br>
revisions of UniNorth have trouble with the latter. I think it would<br>
make sense to change radeon.agpmode to default to -1 on powerpc as well.<br=
>
Any takers?<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"http://www.amd.com" rel=3D"noreferrer" target=3D"_blank">http://www.amd=
.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
</font></span></blockquote></div><br></div>

--001a113dd0d0cc8978052b411376--
