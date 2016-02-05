Return-Path: <herminio.hernandezjr@gmail.com>
Received: from mail-oi0-x233.google.com (mail-oi0-x233.google.com
 [IPv6:2607:f8b0:4003:c06::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D6BC1A001D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2016 01:32:28 +1100 (AEDT)
Received: by mail-oi0-x233.google.com with SMTP id s2so42242977oie.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Feb 2016 06:32:28 -0800 (PST)
Content-Type: multipart/alternative;
 boundary=Apple-Mail-C302E032-0C75-4219-9451-513B877B6840
Mime-Version: 1.0 (1.0)
Subject: Re: PowerPC agpmode issues
From: "Herminio Hernandez Jr. " <herminio.hernandezjr@gmail.com>
In-Reply-To: <CANtoAtPSgkxEvAdOs-gZGOECYN8OFTvwRrsg+US41ji1fGEDLA@mail.gmail.com>
Date: Fri, 5 Feb 2016 08:32:22 -0600
Cc: Pranith Kumar <bobby.prani@gmail.com>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <969BB53B-CB30-49DC-B6C5-4D2381ECE6EE@gmail.com>
References: <CANtoAtPSgkxEvAdOs-gZGOECYN8OFTvwRrsg+US41ji1fGEDLA@mail.gmail.com>
To: Mike <michael.heltne@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail-C302E032-0C75-4219-9451-513B877B6840
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

I have been experiencing the same thing with my iBook and PowerBook.=20

Sent from my iPhone

> On Feb 4, 2016, at 8:47 PM, Mike <michael.heltne@gmail.com> wrote:
>=20
> Hi.=20
> Managed to get the Radeon R300 running on mesa 11.1.1 with an old 2013 pat=
ch from Michel D=C3=A0nzer, next problem is of course enabling agpmode, runn=
ing with pci-mode with radeon.agpmode=3D-1 works, but is of course slow, and=
 seems to load the cpu a lot.
>=20
> Upon initial investigation i could not initially believe agp could be this=
 this broken for this long, until i found this.
>  "committed with Ben Skeggs on Feb 26, 2013"
> https://github.com/DespairFactor/bullhead/commit/650e1203c11354ba84d69ba44=
5abc0efcfe3890a
> http://lxr.free-electrons.com/source/drivers/gpu/drm/nouveau/nouveau_agp.c=
?v=3D4.2
> #ifdef __powerpc__
> 		/* Disable AGP by default on all PowerPC machines for
> 		 * now -- At least some UniNorth-2 AGP bridges are
> 		 * known to be broken: DMA from the host to the card
> 		 * works just fine, but writeback from the card to the
> 		 * host goes straight to memory untranslated bypassing
> 		 * the GATT somehow, making them quite painful to deal
> 		 * with...
> 		 */
> 		if (nouveau_agpmode =3D=3D -1)
> 			return false;
> #endif
> =20
>  and now later this:=20
> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/nouveau/nvkm=
/subdev/pci/agp.c
> #ifdef __powerpc__
> 	/* Disable AGP by default on all PowerPC machines for now -- At
> 	 * least some UniNorth-2 AGP bridges are known to be broken:
> 	 * DMA from the host to the card works just fine, but writeback
> 	 * from the card to the host goes straight to memory
> 	 * untranslated bypassing that GATT somehow, making them quite
> 	 * painful to deal with...
> 	 */
> 	mode =3D 0;
> #endif
>=20
> All seems to point to serious issues had around the time of change to ums t=
o kms and a serious regression hitting the linux kernel? No?
>=20
> Cheers
> -Mike
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--Apple-Mail-C302E032-0C75-4219-9451-513B877B6840
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto"><div>I have been experiencing the same thin=
g with my iBook and PowerBook.&nbsp;<br><br>Sent from my iPhone</div><div><b=
r>On Feb 4, 2016, at 8:47 PM, Mike &lt;<a href=3D"mailto:michael.heltne@gmai=
l.com">michael.heltne@gmail.com</a>&gt; wrote:<br><br></div><blockquote type=
=3D"cite"><div><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gma=
il_extra">Hi.&nbsp;</div><div class=3D"gmail_extra">Managed to get the Radeo=
n R300 running on mesa 11.1.1 with an old 2013 patch from Michel D=C3=A0nzer=
, next problem is of course enabling agpmode, running with pci-mode with rad=
eon.agpmode=3D-1 works, but is of course slow, and seems to load the cpu a l=
ot.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Upo=
n initial investigation i could not initially believe agp could be this this=
 broken for this long, until i found this.</div><div class=3D"gmail_extra"><=
div class=3D"gmail_extra">&nbsp;"committed with Ben Skeggs on Feb 26, 2013"<=
/div><div class=3D"gmail_extra"><a href=3D"https://github.com/DespairFactor/=
bullhead/commit/650e1203c11354ba84d69ba445abc0efcfe3890a">https://github.com=
/DespairFactor/bullhead/commit/650e1203c11354ba84d69ba445abc0efcfe3890a</a><=
/div></div><div class=3D"gmail_extra"><a href=3D"http://lxr.free-electrons.c=
om/source/drivers/gpu/drm/nouveau/nouveau_agp.c?v=3D4.2">http://lxr.free-ele=
ctrons.com/source/drivers/gpu/drm/nouveau/nouveau_agp.c?v=3D4.2</a></div><di=
v class=3D"gmail_extra">#ifdef __powerpc__</div><div class=3D"gmail_extra"><=
span class=3D"" style=3D"white-space:pre">		</span>/* Disable A=
GP by default on all PowerPC machines for</div><div class=3D"gmail_extra"><s=
pan class=3D"" style=3D"white-space:pre">		</span> * now -- At=
 least some UniNorth-2 AGP bridges are</div><div class=3D"gmail_extra"><span=
 class=3D"" style=3D"white-space:pre">		</span> * known to be broke=
n: DMA from the host to the card</div><div class=3D"gmail_extra"><span class=
=3D"" style=3D"white-space:pre">		</span> * works just fine, b=
ut writeback from the card to the</div><div class=3D"gmail_extra"><span clas=
s=3D"" style=3D"white-space:pre">		</span> * host goes straigh=
t to memory untranslated bypassing</div><div class=3D"gmail_extra"><span cla=
ss=3D"" style=3D"white-space:pre">		</span> * the GATT somehow,=
 making them quite painful to deal</div><div class=3D"gmail_extra"><span cla=
ss=3D"" style=3D"white-space:pre">		</span> * with...</div><div=
 class=3D"gmail_extra"><span class=3D"" style=3D"white-space:pre">	=
	</span> */</div><div class=3D"gmail_extra"><span class=3D"" style=3D"white-=
space:pre">		</span>if (nouveau_agpmode =3D=3D -1)</div><div cla=
ss=3D"gmail_extra"><span class=3D"" style=3D"white-space:pre">		=
	</span>return false;</div><div class=3D"gmail_extra">#endif</div><div class=
=3D"gmail_extra">&nbsp;</div><div class=3D"gmail_extra">&nbsp;and now later t=
his:&nbsp;</div><div class=3D"gmail_extra"><a href=3D"https://github.com/tor=
valds/linux/blob/master/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.c">https=
://github.com/torvalds/linux/blob/master/drivers/gpu/drm/nouveau/nvkm/subdev=
/pci/agp.c</a></div><div class=3D"gmail_extra">#ifdef __powerpc__</div><div c=
lass=3D"gmail_extra"><span class=3D"" style=3D"white-space:pre">	</s=
pan>/* Disable AGP by default on all PowerPC machines for now -- At</div><di=
v class=3D"gmail_extra"><span class=3D"" style=3D"white-space:pre">	</s=
pan> * least some UniNorth-2 AGP bridges are known to be broken:</div><div c=
lass=3D"gmail_extra"><span class=3D"" style=3D"white-space:pre">	</s=
pan> * DMA from the host to the card works just fine, but writeback</div><di=
v class=3D"gmail_extra"><span class=3D"" style=3D"white-space:pre">	</s=
pan> * from the card to the host goes straight to memory</div><div class=3D"=
gmail_extra"><span class=3D"" style=3D"white-space:pre">	</span> * u=
ntranslated bypassing that GATT somehow, making them quite</div><div class=3D=
"gmail_extra"><span class=3D"" style=3D"white-space:pre">	</span> * p=
ainful to deal with...</div><div class=3D"gmail_extra"><span class=3D"" styl=
e=3D"white-space:pre">	</span> */</div><div class=3D"gmail_extra"><span cl=
ass=3D"" style=3D"white-space:pre">	</span>mode =3D 0;</div><div class=3D=
"gmail_extra">#endif</div><div class=3D"gmail_extra"><br></div><div class=3D=
"gmail_extra">All seems to point to serious issues had around the time of ch=
ange to ums to kms and a serious regression hitting the linux kernel? No?</d=
iv><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Cheers</d=
iv><div class=3D"gmail_extra">-Mike</div></div></div>
</div></blockquote><blockquote type=3D"cite"><div><span>____________________=
___________________________</span><br><span>Linuxppc-dev mailing list</span>=
<br><span><a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@list=
s.ozlabs.org</a></span><br><span><a href=3D"https://lists.ozlabs.org/listinf=
o/linuxppc-dev">https://lists.ozlabs.org/listinfo/linuxppc-dev</a></span></d=
iv></blockquote></body></html>=

--Apple-Mail-C302E032-0C75-4219-9451-513B877B6840--
