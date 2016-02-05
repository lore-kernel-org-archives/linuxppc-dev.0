Return-Path: <michael.heltne@gmail.com>
Received: from mail-yw0-x22f.google.com (mail-yw0-x22f.google.com
 [IPv6:2607:f8b0:4002:c05::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F18C31A0221
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Feb 2016 13:47:27 +1100 (AEDT)
Received: by mail-yw0-x22f.google.com with SMTP id g127so40751086ywf.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Feb 2016 18:47:27 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 5 Feb 2016 02:47:24 +0000
Message-ID: <CANtoAtPSgkxEvAdOs-gZGOECYN8OFTvwRrsg+US41ji1fGEDLA@mail.gmail.com>
Subject: PowerPC agpmode issues
From: Mike <michael.heltne@gmail.com>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
Content-Type: multipart/alternative; boundary=94eb2c081bb6ffb839052afcde8a
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--94eb2c081bb6ffb839052afcde8a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi.
Managed to get the Radeon R300 running on mesa 11.1.1 with an old 2013
patch from Michel D=C3=A0nzer, next problem is of course enabling agpmode,
running with pci-mode with radeon.agpmode=3D-1 works, but is of course slow=
,
and seems to load the cpu a lot.

Upon initial investigation i could not initially believe agp could be this
this broken for this long, until i found this.
 "committed with Ben Skeggs on Feb 26, 2013"
https://github.com/DespairFactor/bullhead/commit/650e1203c11354ba84d69ba445=
abc0efcfe3890a
http://lxr.free-electrons.com/source/drivers/gpu/drm/nouveau/nouveau_agp.c?=
v=3D4.2
#ifdef __powerpc__
/* Disable AGP by default on all PowerPC machines for
* now -- At least some UniNorth-2 AGP bridges are
* known to be broken: DMA from the host to the card
* works just fine, but writeback from the card to the
* host goes straight to memory untranslated bypassing
* the GATT somehow, making them quite painful to deal
* with...
*/
if (nouveau_agpmode =3D=3D -1)
return false;
#endif

 and now later this:
https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/nouveau/nvkm/=
subdev/pci/agp.c
#ifdef __powerpc__
/* Disable AGP by default on all PowerPC machines for now -- At
* least some UniNorth-2 AGP bridges are known to be broken:
* DMA from the host to the card works just fine, but writeback
* from the card to the host goes straight to memory
* untranslated bypassing that GATT somehow, making them quite
* painful to deal with...
*/
mode =3D 0;
#endif

All seems to point to serious issues had around the time of change to ums
to kms and a serious regression hitting the linux kernel? No?

Cheers
-Mike

--94eb2c081bb6ffb839052afcde8a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_extra">Hi.=
=C2=A0</div><div class=3D"gmail_extra">Managed to get the Radeon R300 runni=
ng on mesa 11.1.1 with an old 2013 patch from Michel D=C3=A0nzer, next prob=
lem is of course enabling agpmode, running with pci-mode with radeon.agpmod=
e=3D-1 works, but is of course slow, and seems to load the cpu a lot.</div>=
<div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Upon initia=
l investigation i could not initially believe agp could be this this broken=
 for this long, until i found this.</div><div class=3D"gmail_extra"><div cl=
ass=3D"gmail_extra">=C2=A0&quot;committed with Ben Skeggs on Feb 26, 2013&q=
uot;</div><div class=3D"gmail_extra"><a href=3D"https://github.com/DespairF=
actor/bullhead/commit/650e1203c11354ba84d69ba445abc0efcfe3890a">https://git=
hub.com/DespairFactor/bullhead/commit/650e1203c11354ba84d69ba445abc0efcfe38=
90a</a></div></div><div class=3D"gmail_extra"><a href=3D"http://lxr.free-el=
ectrons.com/source/drivers/gpu/drm/nouveau/nouveau_agp.c?v=3D4.2">http://lx=
r.free-electrons.com/source/drivers/gpu/drm/nouveau/nouveau_agp.c?v=3D4.2</=
a></div><div class=3D"gmail_extra">#ifdef __powerpc__</div><div class=3D"gm=
ail_extra"><span class=3D"" style=3D"white-space:pre">		</span>/* Disable A=
GP by default on all PowerPC machines for</div><div class=3D"gmail_extra"><=
span class=3D"" style=3D"white-space:pre">		</span> * now -- At least some =
UniNorth-2 AGP bridges are</div><div class=3D"gmail_extra"><span class=3D""=
 style=3D"white-space:pre">		</span> * known to be broken: DMA from the hos=
t to the card</div><div class=3D"gmail_extra"><span class=3D"" style=3D"whi=
te-space:pre">		</span> * works just fine, but writeback from the card to t=
he</div><div class=3D"gmail_extra"><span class=3D"" style=3D"white-space:pr=
e">		</span> * host goes straight to memory untranslated bypassing</div><di=
v class=3D"gmail_extra"><span class=3D"" style=3D"white-space:pre">		</span=
> * the GATT somehow, making them quite painful to deal</div><div class=3D"=
gmail_extra"><span class=3D"" style=3D"white-space:pre">		</span> * with...=
</div><div class=3D"gmail_extra"><span class=3D"" style=3D"white-space:pre"=
>		</span> */</div><div class=3D"gmail_extra"><span class=3D"" style=3D"whi=
te-space:pre">		</span>if (nouveau_agpmode =3D=3D -1)</div><div class=3D"gm=
ail_extra"><span class=3D"" style=3D"white-space:pre">			</span>return fals=
e;</div><div class=3D"gmail_extra">#endif</div><div class=3D"gmail_extra">=
=C2=A0</div><div class=3D"gmail_extra">=C2=A0and now later this:=C2=A0</div=
><div class=3D"gmail_extra"><a href=3D"https://github.com/torvalds/linux/bl=
ob/master/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.c">https://github.com=
/torvalds/linux/blob/master/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.c</=
a></div><div class=3D"gmail_extra">#ifdef __powerpc__</div><div class=3D"gm=
ail_extra"><span class=3D"" style=3D"white-space:pre">	</span>/* Disable AG=
P by default on all PowerPC machines for now -- At</div><div class=3D"gmail=
_extra"><span class=3D"" style=3D"white-space:pre">	</span> * least some Un=
iNorth-2 AGP bridges are known to be broken:</div><div class=3D"gmail_extra=
"><span class=3D"" style=3D"white-space:pre">	</span> * DMA from the host t=
o the card works just fine, but writeback</div><div class=3D"gmail_extra"><=
span class=3D"" style=3D"white-space:pre">	</span> * from the card to the h=
ost goes straight to memory</div><div class=3D"gmail_extra"><span class=3D"=
" style=3D"white-space:pre">	</span> * untranslated bypassing that GATT som=
ehow, making them quite</div><div class=3D"gmail_extra"><span class=3D"" st=
yle=3D"white-space:pre">	</span> * painful to deal with...</div><div class=
=3D"gmail_extra"><span class=3D"" style=3D"white-space:pre">	</span> */</di=
v><div class=3D"gmail_extra"><span class=3D"" style=3D"white-space:pre">	</=
span>mode =3D 0;</div><div class=3D"gmail_extra">#endif</div><div class=3D"=
gmail_extra"><br></div><div class=3D"gmail_extra">All seems to point to ser=
ious issues had around the time of change to ums to kms and a serious regre=
ssion hitting the linux kernel? No?</div><div class=3D"gmail_extra"><br></d=
iv><div class=3D"gmail_extra">Cheers</div><div class=3D"gmail_extra">-Mike<=
/div></div></div>

--94eb2c081bb6ffb839052afcde8a--
