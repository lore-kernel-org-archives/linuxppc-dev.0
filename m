Return-Path: <michael.heltne@gmail.com>
Received: from mail-yw0-x232.google.com (mail-yw0-x232.google.com
 [IPv6:2607:f8b0:4002:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E84461A002B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2016 01:44:16 +1100 (AEDT)
Received: by mail-yw0-x232.google.com with SMTP id q190so52527339ywd.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Feb 2016 06:44:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <969BB53B-CB30-49DC-B6C5-4D2381ECE6EE@gmail.com>
References: <CANtoAtPSgkxEvAdOs-gZGOECYN8OFTvwRrsg+US41ji1fGEDLA@mail.gmail.com>
 <969BB53B-CB30-49DC-B6C5-4D2381ECE6EE@gmail.com>
Date: Fri, 5 Feb 2016 14:44:14 +0000
Message-ID: <CANtoAtMtx-iqs+DMipG0ySiL0nn+uyTqL-Dg8ye60fjpC4_HVg@mail.gmail.com>
Subject: Re: PowerPC agpmode issues
From: Mike <michael.heltne@gmail.com>
To: "Herminio Hernandez Jr." <herminio.hernandezjr@gmail.com>
Cc: Pranith Kumar <bobby.prani@gmail.com>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary=94eb2c081bb6938d6f052b06e255
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--94eb2c081bb6938d6f052b06e255
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Herminio,

Ok, take a look at this.
https://github.com/threader/mesa-11.1.1-ppc-r300-debian or if on stable
maybe this is more fitting
https://github.com/threader/mesa-10.6.3-ppc-r300-debian - this only fixes
the issue for r300 on powerpc though.

On 5 February 2016 at 14:32, Herminio Hernandez Jr. <
herminio.hernandezjr@gmail.com> wrote:

> I have been experiencing the same thing with my iBook and PowerBook.
>
> Sent from my iPhone
>
> On Feb 4, 2016, at 8:47 PM, Mike <michael.heltne@gmail.com> wrote:
>
> Hi.
> Managed to get the Radeon R300 running on mesa 11.1.1 with an old 2013
> patch from Michel D=C3=A0nzer, next problem is of course enabling agpmode=
,
> running with pci-mode with radeon.agpmode=3D-1 works, but is of course sl=
ow,
> and seems to load the cpu a lot.
>
> Upon initial investigation i could not initially believe agp could be thi=
s
> this broken for this long, until i found this.
>  "committed with Ben Skeggs on Feb 26, 2013"
>
> https://github.com/DespairFactor/bullhead/commit/650e1203c11354ba84d69ba4=
45abc0efcfe3890a
>
> http://lxr.free-electrons.com/source/drivers/gpu/drm/nouveau/nouveau_agp.=
c?v=3D4.2
> #ifdef __powerpc__
> /* Disable AGP by default on all PowerPC machines for
> * now -- At least some UniNorth-2 AGP bridges are
> * known to be broken: DMA from the host to the card
> * works just fine, but writeback from the card to the
> * host goes straight to memory untranslated bypassing
> * the GATT somehow, making them quite painful to deal
> * with...
> */
> if (nouveau_agpmode =3D=3D -1)
> return false;
> #endif
>
>  and now later this:
>
> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/nouveau/nvk=
m/subdev/pci/agp.c
> #ifdef __powerpc__
> /* Disable AGP by default on all PowerPC machines for now -- At
> * least some UniNorth-2 AGP bridges are known to be broken:
> * DMA from the host to the card works just fine, but writeback
> * from the card to the host goes straight to memory
> * untranslated bypassing that GATT somehow, making them quite
> * painful to deal with...
> */
> mode =3D 0;
> #endif
>
> All seems to point to serious issues had around the time of change to ums
> to kms and a serious regression hitting the linux kernel? No?
>
> Cheers
> -Mike
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>

--94eb2c081bb6938d6f052b06e255
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Herminio,=C2=A0<div><br></div><div>Ok, take a look at this=
.=C2=A0<a href=3D"https://github.com/threader/mesa-11.1.1-ppc-r300-debian">=
https://github.com/threader/mesa-11.1.1-ppc-r300-debian</a> or if on stable=
 maybe this is more fitting=C2=A0<a href=3D"https://github.com/threader/mes=
a-10.6.3-ppc-r300-debian">https://github.com/threader/mesa-10.6.3-ppc-r300-=
debian</a> - this only fixes the issue for r300 on powerpc though.=C2=A0</d=
iv></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 5 Feb=
ruary 2016 at 14:32, Herminio Hernandez Jr. <span dir=3D"ltr">&lt;<a href=
=3D"mailto:herminio.hernandezjr@gmail.com" target=3D"_blank">herminio.herna=
ndezjr@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><d=
iv dir=3D"auto"><div>I have been experiencing the same thing with my iBook =
and PowerBook.=C2=A0<br><br>Sent from my iPhone</div><div><div class=3D"h5"=
><div><br>On Feb 4, 2016, at 8:47 PM, Mike &lt;<a href=3D"mailto:michael.he=
ltne@gmail.com" target=3D"_blank">michael.heltne@gmail.com</a>&gt; wrote:<b=
r><br></div><blockquote type=3D"cite"><div><div dir=3D"ltr"><div class=3D"g=
mail_extra"><div class=3D"gmail_extra">Hi.=C2=A0</div><div class=3D"gmail_e=
xtra">Managed to get the Radeon R300 running on mesa 11.1.1 with an old 201=
3 patch from Michel D=C3=A0nzer, next problem is of course enabling agpmode=
, running with pci-mode with radeon.agpmode=3D-1 works, but is of course sl=
ow, and seems to load the cpu a lot.</div><div class=3D"gmail_extra"><br></=
div><div class=3D"gmail_extra">Upon initial investigation i could not initi=
ally believe agp could be this this broken for this long, until i found thi=
s.</div><div class=3D"gmail_extra"><div class=3D"gmail_extra">=C2=A0&quot;c=
ommitted with Ben Skeggs on Feb 26, 2013&quot;</div><div class=3D"gmail_ext=
ra"><a href=3D"https://github.com/DespairFactor/bullhead/commit/650e1203c11=
354ba84d69ba445abc0efcfe3890a" target=3D"_blank">https://github.com/Despair=
Factor/bullhead/commit/650e1203c11354ba84d69ba445abc0efcfe3890a</a></div></=
div><div class=3D"gmail_extra"><a href=3D"http://lxr.free-electrons.com/sou=
rce/drivers/gpu/drm/nouveau/nouveau_agp.c?v=3D4.2" target=3D"_blank">http:/=
/lxr.free-electrons.com/source/drivers/gpu/drm/nouveau/nouveau_agp.c?v=3D4.=
2</a></div><div class=3D"gmail_extra">#ifdef __powerpc__</div><div class=3D=
"gmail_extra"><span style=3D"white-space:pre-wrap">		</span>/* Disable AGP =
by default on all PowerPC machines for</div><div class=3D"gmail_extra"><spa=
n style=3D"white-space:pre-wrap">		</span> * now -- At least some UniNorth-=
2 AGP bridges are</div><div class=3D"gmail_extra"><span style=3D"white-spac=
e:pre-wrap">		</span> * known to be broken: DMA from the host to the card</=
div><div class=3D"gmail_extra"><span style=3D"white-space:pre-wrap">		</spa=
n> * works just fine, but writeback from the card to the</div><div class=3D=
"gmail_extra"><span style=3D"white-space:pre-wrap">		</span> * host goes st=
raight to memory untranslated bypassing</div><div class=3D"gmail_extra"><sp=
an style=3D"white-space:pre-wrap">		</span> * the GATT somehow, making them=
 quite painful to deal</div><div class=3D"gmail_extra"><span style=3D"white=
-space:pre-wrap">		</span> * with...</div><div class=3D"gmail_extra"><span =
style=3D"white-space:pre-wrap">		</span> */</div><div class=3D"gmail_extra"=
><span style=3D"white-space:pre-wrap">		</span>if (nouveau_agpmode =3D=3D -=
1)</div><div class=3D"gmail_extra"><span style=3D"white-space:pre-wrap">			=
</span>return false;</div><div class=3D"gmail_extra">#endif</div><div class=
=3D"gmail_extra">=C2=A0</div><div class=3D"gmail_extra">=C2=A0and now later=
 this:=C2=A0</div><div class=3D"gmail_extra"><a href=3D"https://github.com/=
torvalds/linux/blob/master/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.c" t=
arget=3D"_blank">https://github.com/torvalds/linux/blob/master/drivers/gpu/=
drm/nouveau/nvkm/subdev/pci/agp.c</a></div><div class=3D"gmail_extra">#ifde=
f __powerpc__</div><div class=3D"gmail_extra"><span style=3D"white-space:pr=
e-wrap">	</span>/* Disable AGP by default on all PowerPC machines for now -=
- At</div><div class=3D"gmail_extra"><span style=3D"white-space:pre-wrap">	=
</span> * least some UniNorth-2 AGP bridges are known to be broken:</div><d=
iv class=3D"gmail_extra"><span style=3D"white-space:pre-wrap">	</span> * DM=
A from the host to the card works just fine, but writeback</div><div class=
=3D"gmail_extra"><span style=3D"white-space:pre-wrap">	</span> * from the c=
ard to the host goes straight to memory</div><div class=3D"gmail_extra"><sp=
an style=3D"white-space:pre-wrap">	</span> * untranslated bypassing that GA=
TT somehow, making them quite</div><div class=3D"gmail_extra"><span style=
=3D"white-space:pre-wrap">	</span> * painful to deal with...</div><div clas=
s=3D"gmail_extra"><span style=3D"white-space:pre-wrap">	</span> */</div><di=
v class=3D"gmail_extra"><span style=3D"white-space:pre-wrap">	</span>mode =
=3D 0;</div><div class=3D"gmail_extra">#endif</div><div class=3D"gmail_extr=
a"><br></div><div class=3D"gmail_extra">All seems to point to serious issue=
s had around the time of change to ums to kms and a serious regression hitt=
ing the linux kernel? No?</div><div class=3D"gmail_extra"><br></div><div cl=
ass=3D"gmail_extra">Cheers</div><div class=3D"gmail_extra">-Mike</div></div=
></div>
</div></blockquote></div></div><blockquote type=3D"cite"><div><span>_______=
________________________________________</span><br><span>Linuxppc-dev maili=
ng list</span><br><span><a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org" ta=
rget=3D"_blank">Linuxppc-dev@lists.ozlabs.org</a></span><br><span><a href=
=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank">https=
://lists.ozlabs.org/listinfo/linuxppc-dev</a></span></div></blockquote></di=
v></blockquote></div><br></div>

--94eb2c081bb6938d6f052b06e255--
