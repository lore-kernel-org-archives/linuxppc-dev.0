Return-Path: <herminio.hernandezjr@gmail.com>
Received: from mail-vk0-x22b.google.com (mail-vk0-x22b.google.com
 [IPv6:2607:f8b0:400c:c05::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D70E1A006D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2016 04:51:35 +1100 (AEDT)
Received: by mail-vk0-x22b.google.com with SMTP id c3so14734843vkb.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Feb 2016 09:51:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CANtoAtMtx-iqs+DMipG0ySiL0nn+uyTqL-Dg8ye60fjpC4_HVg@mail.gmail.com>
References: <CANtoAtPSgkxEvAdOs-gZGOECYN8OFTvwRrsg+US41ji1fGEDLA@mail.gmail.com>
 <969BB53B-CB30-49DC-B6C5-4D2381ECE6EE@gmail.com>
 <CANtoAtMtx-iqs+DMipG0ySiL0nn+uyTqL-Dg8ye60fjpC4_HVg@mail.gmail.com>
Date: Fri, 5 Feb 2016 11:51:32 -0600
Message-ID: <CAJRA9dzDbnuKhPnrQ7gN4pSHVTcJA=gjac=fnWm6pkd62AwW_A@mail.gmail.com>
Subject: Re: PowerPC agpmode issues
From: "Herminio Hernandez, Jr." <herminio.hernandezjr@gmail.com>
To: Mike <michael.heltne@gmail.com>
Cc: Pranith Kumar <bobby.prani@gmail.com>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary=001a1145504c608297052b09804b
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a1145504c608297052b09804b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I have already applied his patches on my PowerBook running Jessie to get
accelerated graphics. However they are only a work around and not a real
fix so they will be committed to mesa.

On Fri, Feb 5, 2016 at 8:44 AM, Mike <michael.heltne@gmail.com> wrote:

> Herminio,
>
> Ok, take a look at this.
> https://github.com/threader/mesa-11.1.1-ppc-r300-debian or if on stable
> maybe this is more fitting
> https://github.com/threader/mesa-10.6.3-ppc-r300-debian - this only fixes
> the issue for r300 on powerpc though.
>
> On 5 February 2016 at 14:32, Herminio Hernandez Jr. <
> herminio.hernandezjr@gmail.com> wrote:
>
>> I have been experiencing the same thing with my iBook and PowerBook.
>>
>> Sent from my iPhone
>>
>> On Feb 4, 2016, at 8:47 PM, Mike <michael.heltne@gmail.com> wrote:
>>
>> Hi.
>> Managed to get the Radeon R300 running on mesa 11.1.1 with an old 2013
>> patch from Michel D=C3=A0nzer, next problem is of course enabling agpmod=
e,
>> running with pci-mode with radeon.agpmode=3D-1 works, but is of course s=
low,
>> and seems to load the cpu a lot.
>>
>> Upon initial investigation i could not initially believe agp could be
>> this this broken for this long, until i found this.
>>  "committed with Ben Skeggs on Feb 26, 2013"
>>
>> https://github.com/DespairFactor/bullhead/commit/650e1203c11354ba84d69ba=
445abc0efcfe3890a
>>
>> http://lxr.free-electrons.com/source/drivers/gpu/drm/nouveau/nouveau_agp=
.c?v=3D4.2
>> #ifdef __powerpc__
>> /* Disable AGP by default on all PowerPC machines for
>> * now -- At least some UniNorth-2 AGP bridges are
>> * known to be broken: DMA from the host to the card
>> * works just fine, but writeback from the card to the
>> * host goes straight to memory untranslated bypassing
>> * the GATT somehow, making them quite painful to deal
>> * with...
>> */
>> if (nouveau_agpmode =3D=3D -1)
>> return false;
>> #endif
>>
>>  and now later this:
>>
>> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/nouveau/nv=
km/subdev/pci/agp.c
>> #ifdef __powerpc__
>> /* Disable AGP by default on all PowerPC machines for now -- At
>> * least some UniNorth-2 AGP bridges are known to be broken:
>> * DMA from the host to the card works just fine, but writeback
>> * from the card to the host goes straight to memory
>> * untranslated bypassing that GATT somehow, making them quite
>> * painful to deal with...
>> */
>> mode =3D 0;
>> #endif
>>
>> All seems to point to serious issues had around the time of change to um=
s
>> to kms and a serious regression hitting the linux kernel? No?
>>
>> Cheers
>> -Mike
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
>>
>

--001a1145504c608297052b09804b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I have already applied his patches on my PowerBook running=
 Jessie to get accelerated graphics. However they are only a work around an=
d not a real fix so they will be committed to mesa.</div><div class=3D"gmai=
l_extra"><br><div class=3D"gmail_quote">On Fri, Feb 5, 2016 at 8:44 AM, Mik=
e <span dir=3D"ltr">&lt;<a href=3D"mailto:michael.heltne@gmail.com" target=
=3D"_blank">michael.heltne@gmail.com</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex"><div dir=3D"ltr">Herminio,=C2=A0<div><br></div><div>Ok, t=
ake a look at this.=C2=A0<a href=3D"https://github.com/threader/mesa-11.1.1=
-ppc-r300-debian" target=3D"_blank">https://github.com/threader/mesa-11.1.1=
-ppc-r300-debian</a> or if on stable maybe this is more fitting=C2=A0<a hre=
f=3D"https://github.com/threader/mesa-10.6.3-ppc-r300-debian" target=3D"_bl=
ank">https://github.com/threader/mesa-10.6.3-ppc-r300-debian</a> - this onl=
y fixes the issue for r300 on powerpc though.=C2=A0</div></div><div class=
=3D"HOEnZb"><div class=3D"h5"><div class=3D"gmail_extra"><br><div class=3D"=
gmail_quote">On 5 February 2016 at 14:32, Herminio Hernandez Jr. <span dir=
=3D"ltr">&lt;<a href=3D"mailto:herminio.hernandezjr@gmail.com" target=3D"_b=
lank">herminio.hernandezjr@gmail.com</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex"><div dir=3D"auto"><div>I have been experiencing the same =
thing with my iBook and PowerBook.=C2=A0<br><br>Sent from my iPhone</div><d=
iv><div><div><br>On Feb 4, 2016, at 8:47 PM, Mike &lt;<a href=3D"mailto:mic=
hael.heltne@gmail.com" target=3D"_blank">michael.heltne@gmail.com</a>&gt; w=
rote:<br><br></div><blockquote type=3D"cite"><div><div dir=3D"ltr"><div cla=
ss=3D"gmail_extra"><div class=3D"gmail_extra">Hi.=C2=A0</div><div class=3D"=
gmail_extra">Managed to get the Radeon R300 running on mesa 11.1.1 with an =
old 2013 patch from Michel D=C3=A0nzer, next problem is of course enabling =
agpmode, running with pci-mode with radeon.agpmode=3D-1 works, but is of co=
urse slow, and seems to load the cpu a lot.</div><div class=3D"gmail_extra"=
><br></div><div class=3D"gmail_extra">Upon initial investigation i could no=
t initially believe agp could be this this broken for this long, until i fo=
und this.</div><div class=3D"gmail_extra"><div class=3D"gmail_extra">=C2=A0=
&quot;committed with Ben Skeggs on Feb 26, 2013&quot;</div><div class=3D"gm=
ail_extra"><a href=3D"https://github.com/DespairFactor/bullhead/commit/650e=
1203c11354ba84d69ba445abc0efcfe3890a" target=3D"_blank">https://github.com/=
DespairFactor/bullhead/commit/650e1203c11354ba84d69ba445abc0efcfe3890a</a><=
/div></div><div class=3D"gmail_extra"><a href=3D"http://lxr.free-electrons.=
com/source/drivers/gpu/drm/nouveau/nouveau_agp.c?v=3D4.2" target=3D"_blank"=
>http://lxr.free-electrons.com/source/drivers/gpu/drm/nouveau/nouveau_agp.c=
?v=3D4.2</a></div><div class=3D"gmail_extra">#ifdef __powerpc__</div><div c=
lass=3D"gmail_extra"><span style=3D"white-space:pre-wrap">		</span>/* Disab=
le AGP by default on all PowerPC machines for</div><div class=3D"gmail_extr=
a"><span style=3D"white-space:pre-wrap">		</span> * now -- At least some Un=
iNorth-2 AGP bridges are</div><div class=3D"gmail_extra"><span style=3D"whi=
te-space:pre-wrap">		</span> * known to be broken: DMA from the host to the=
 card</div><div class=3D"gmail_extra"><span style=3D"white-space:pre-wrap">=
		</span> * works just fine, but writeback from the card to the</div><div c=
lass=3D"gmail_extra"><span style=3D"white-space:pre-wrap">		</span> * host =
goes straight to memory untranslated bypassing</div><div class=3D"gmail_ext=
ra"><span style=3D"white-space:pre-wrap">		</span> * the GATT somehow, maki=
ng them quite painful to deal</div><div class=3D"gmail_extra"><span style=
=3D"white-space:pre-wrap">		</span> * with...</div><div class=3D"gmail_extr=
a"><span style=3D"white-space:pre-wrap">		</span> */</div><div class=3D"gma=
il_extra"><span style=3D"white-space:pre-wrap">		</span>if (nouveau_agpmode=
 =3D=3D -1)</div><div class=3D"gmail_extra"><span style=3D"white-space:pre-=
wrap">			</span>return false;</div><div class=3D"gmail_extra">#endif</div><=
div class=3D"gmail_extra">=C2=A0</div><div class=3D"gmail_extra">=C2=A0and =
now later this:=C2=A0</div><div class=3D"gmail_extra"><a href=3D"https://gi=
thub.com/torvalds/linux/blob/master/drivers/gpu/drm/nouveau/nvkm/subdev/pci=
/agp.c" target=3D"_blank">https://github.com/torvalds/linux/blob/master/dri=
vers/gpu/drm/nouveau/nvkm/subdev/pci/agp.c</a></div><div class=3D"gmail_ext=
ra">#ifdef __powerpc__</div><div class=3D"gmail_extra"><span style=3D"white=
-space:pre-wrap">	</span>/* Disable AGP by default on all PowerPC machines =
for now -- At</div><div class=3D"gmail_extra"><span style=3D"white-space:pr=
e-wrap">	</span> * least some UniNorth-2 AGP bridges are known to be broken=
:</div><div class=3D"gmail_extra"><span style=3D"white-space:pre-wrap">	</s=
pan> * DMA from the host to the card works just fine, but writeback</div><d=
iv class=3D"gmail_extra"><span style=3D"white-space:pre-wrap">	</span> * fr=
om the card to the host goes straight to memory</div><div class=3D"gmail_ex=
tra"><span style=3D"white-space:pre-wrap">	</span> * untranslated bypassing=
 that GATT somehow, making them quite</div><div class=3D"gmail_extra"><span=
 style=3D"white-space:pre-wrap">	</span> * painful to deal with...</div><di=
v class=3D"gmail_extra"><span style=3D"white-space:pre-wrap">	</span> */</d=
iv><div class=3D"gmail_extra"><span style=3D"white-space:pre-wrap">	</span>=
mode =3D 0;</div><div class=3D"gmail_extra">#endif</div><div class=3D"gmail=
_extra"><br></div><div class=3D"gmail_extra">All seems to point to serious =
issues had around the time of change to ums to kms and a serious regression=
 hitting the linux kernel? No?</div><div class=3D"gmail_extra"><br></div><d=
iv class=3D"gmail_extra">Cheers</div><div class=3D"gmail_extra">-Mike</div>=
</div></div>
</div></blockquote></div></div><blockquote type=3D"cite"><div><span>_______=
________________________________________</span><br><span>Linuxppc-dev maili=
ng list</span><br><span><a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org" ta=
rget=3D"_blank">Linuxppc-dev@lists.ozlabs.org</a></span><br><span><a href=
=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank">https=
://lists.ozlabs.org/listinfo/linuxppc-dev</a></span></div></blockquote></di=
v></blockquote></div><br></div>
</div></div></blockquote></div><br></div>

--001a1145504c608297052b09804b--
