Return-Path: <michael.heltne@gmail.com>
Received: from mail-yk0-x230.google.com (mail-yk0-x230.google.com
 [IPv6:2607:f8b0:4002:c07::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3FEB41A0026
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2016 06:44:28 +1100 (AEDT)
Received: by mail-yk0-x230.google.com with SMTP id r207so64877947ykd.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Feb 2016 11:44:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJRA9dyT6ccPtX7A30ULYMfNXBgD2kUjYAKfB7e-tX+_U4HcmA@mail.gmail.com>
References: <CANtoAtPSgkxEvAdOs-gZGOECYN8OFTvwRrsg+US41ji1fGEDLA@mail.gmail.com>
 <969BB53B-CB30-49DC-B6C5-4D2381ECE6EE@gmail.com>
 <CANtoAtMtx-iqs+DMipG0ySiL0nn+uyTqL-Dg8ye60fjpC4_HVg@mail.gmail.com>
 <CAJRA9dzDbnuKhPnrQ7gN4pSHVTcJA=gjac=fnWm6pkd62AwW_A@mail.gmail.com>
 <CANtoAtM4SidDfb-pMJAB7qw-zTOSLxNjivS7gDGqj2b3-rUuPQ@mail.gmail.com>
 <CAJRA9dyT6ccPtX7A30ULYMfNXBgD2kUjYAKfB7e-tX+_U4HcmA@mail.gmail.com>
Date: Fri, 5 Feb 2016 19:44:25 +0000
Message-ID: <CANtoAtNuJq34CkNDSewAB2avtmNyppq4WJf65zzceGAN+Cy27w@mail.gmail.com>
Subject: Re: PowerPC agpmode issues
From: Mike <michael.heltne@gmail.com>
To: "Herminio Hernandez, Jr." <herminio.hernandezjr@gmail.com>
Cc: Pranith Kumar <bobby.prani@gmail.com>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary=94eb2c0b163020393b052b0b14cd
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--94eb2c0b163020393b052b0b14cd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thanks, found this now -
https://www.mail-archive.com/search?l=3Dmesa-dev@lists.freedesktop.org&q=3D=
subject:%22%5C%5BMesa%5C-dev%5C%5D+gallium+r300+driver+for+PowerPC%22&o=3Dn=
ewest&f=3D1


On 5 February 2016 at 18:08, Herminio Hernandez, Jr. <
herminio.hernandezjr@gmail.com> wrote:

> Yeah the issue is with the driOpenDriver function at least that what I
> think from what I saw in gdb.
>
> On Fri, Feb 5, 2016 at 12:06 PM, Mike <michael.heltne@gmail.com> wrote:
>
>> True, a permanent patch was needed, but at least we are up and running
>> and can identify other issues.. In the thread with the patches it is
>> highlighted that the drivers are broken in the first place
>>
>> On 5 February 2016 at 17:51, Herminio Hernandez, Jr. <
>> herminio.hernandezjr@gmail.com> wrote:
>>
>>> I have already applied his patches on my PowerBook running Jessie to ge=
t
>>> accelerated graphics. However they are only a work around and not a rea=
l
>>> fix so they will be committed to mesa.
>>>
>>> On Fri, Feb 5, 2016 at 8:44 AM, Mike <michael.heltne@gmail.com> wrote:
>>>
>>>> Herminio,
>>>>
>>>> Ok, take a look at this.
>>>> https://github.com/threader/mesa-11.1.1-ppc-r300-debian or if on
>>>> stable maybe this is more fitting
>>>> https://github.com/threader/mesa-10.6.3-ppc-r300-debian - this only
>>>> fixes the issue for r300 on powerpc though.
>>>>
>>>> On 5 February 2016 at 14:32, Herminio Hernandez Jr. <
>>>> herminio.hernandezjr@gmail.com> wrote:
>>>>
>>>>> I have been experiencing the same thing with my iBook and PowerBook.
>>>>>
>>>>> Sent from my iPhone
>>>>>
>>>>> On Feb 4, 2016, at 8:47 PM, Mike <michael.heltne@gmail.com> wrote:
>>>>>
>>>>> Hi.
>>>>> Managed to get the Radeon R300 running on mesa 11.1.1 with an old 201=
3
>>>>> patch from Michel D=C3=A0nzer, next problem is of course enabling agp=
mode,
>>>>> running with pci-mode with radeon.agpmode=3D-1 works, but is of cours=
e slow,
>>>>> and seems to load the cpu a lot.
>>>>>
>>>>> Upon initial investigation i could not initially believe agp could be
>>>>> this this broken for this long, until i found this.
>>>>>  "committed with Ben Skeggs on Feb 26, 2013"
>>>>>
>>>>> https://github.com/DespairFactor/bullhead/commit/650e1203c11354ba84d6=
9ba445abc0efcfe3890a
>>>>>
>>>>> http://lxr.free-electrons.com/source/drivers/gpu/drm/nouveau/nouveau_=
agp.c?v=3D4.2
>>>>> #ifdef __powerpc__
>>>>> /* Disable AGP by default on all PowerPC machines for
>>>>> * now -- At least some UniNorth-2 AGP bridges are
>>>>> * known to be broken: DMA from the host to the card
>>>>> * works just fine, but writeback from the card to the
>>>>> * host goes straight to memory untranslated bypassing
>>>>> * the GATT somehow, making them quite painful to deal
>>>>> * with...
>>>>> */
>>>>> if (nouveau_agpmode =3D=3D -1)
>>>>> return false;
>>>>> #endif
>>>>>
>>>>>  and now later this:
>>>>>
>>>>> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/nouveau=
/nvkm/subdev/pci/agp.c
>>>>> #ifdef __powerpc__
>>>>> /* Disable AGP by default on all PowerPC machines for now -- At
>>>>> * least some UniNorth-2 AGP bridges are known to be broken:
>>>>> * DMA from the host to the card works just fine, but writeback
>>>>> * from the card to the host goes straight to memory
>>>>> * untranslated bypassing that GATT somehow, making them quite
>>>>> * painful to deal with...
>>>>> */
>>>>> mode =3D 0;
>>>>> #endif
>>>>>
>>>>> All seems to point to serious issues had around the time of change to
>>>>> ums to kms and a serious regression hitting the linux kernel? No?
>>>>>
>>>>> Cheers
>>>>> -Mike
>>>>>
>>>>> _______________________________________________
>>>>> Linuxppc-dev mailing list
>>>>> Linuxppc-dev@lists.ozlabs.org
>>>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>>>>
>>>>>
>>>>
>>>
>>
>

--94eb2c0b163020393b052b0b14cd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks, found this now - <a href=3D"https://www.mail-archi=
ve.com/search?l=3Dmesa-dev@lists.freedesktop.org&amp;q=3Dsubject:%22%5C%5BM=
esa%5C-dev%5C%5D+gallium+r300+driver+for+PowerPC%22&amp;o=3Dnewest&amp;f=3D=
1">https://www.mail-archive.com/search?l=3Dmesa-dev@lists.freedesktop.org&a=
mp;q=3Dsubject:%22%5C%5BMesa%5C-dev%5C%5D+gallium+r300+driver+for+PowerPC%2=
2&amp;o=3Dnewest&amp;f=3D1</a>=C2=A0<br></div><div class=3D"gmail_extra"><b=
r><div class=3D"gmail_quote">On 5 February 2016 at 18:08, Herminio Hernande=
z, Jr. <span dir=3D"ltr">&lt;<a href=3D"mailto:herminio.hernandezjr@gmail.c=
om" target=3D"_blank">herminio.hernandezjr@gmail.com</a>&gt;</span> wrote:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">Yeah the issue is with t=
he driOpenDriver function at least that what I think from what I saw in gdb=
.</div><div class=3D"HOEnZb"><div class=3D"h5"><div class=3D"gmail_extra"><=
br><div class=3D"gmail_quote">On Fri, Feb 5, 2016 at 12:06 PM, Mike <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:michael.heltne@gmail.com" target=3D"_blank=
">michael.heltne@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><div dir=3D"ltr">True, a permanent patch was needed, but at least w=
e are up and running and can identify other issues.. In the thread with the=
 patches it is highlighted that the drivers are broken in the first place</=
div><div><div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On =
5 February 2016 at 17:51, Herminio Hernandez, Jr. <span dir=3D"ltr">&lt;<a =
href=3D"mailto:herminio.hernandezjr@gmail.com" target=3D"_blank">herminio.h=
ernandezjr@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><div dir=3D"ltr">I have already applied his patches on my PowerBook runni=
ng Jessie to get accelerated graphics. However they are only a work around =
and not a real fix so they will be committed to mesa.</div><div><div><div c=
lass=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Feb 5, 2016 at =
8:44 AM, Mike <span dir=3D"ltr">&lt;<a href=3D"mailto:michael.heltne@gmail.=
com" target=3D"_blank">michael.heltne@gmail.com</a>&gt;</span> wrote:<br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex"><div dir=3D"ltr">Herminio,=C2=A0<div><br></div=
><div>Ok, take a look at this.=C2=A0<a href=3D"https://github.com/threader/=
mesa-11.1.1-ppc-r300-debian" target=3D"_blank">https://github.com/threader/=
mesa-11.1.1-ppc-r300-debian</a> or if on stable maybe this is more fitting=
=C2=A0<a href=3D"https://github.com/threader/mesa-10.6.3-ppc-r300-debian" t=
arget=3D"_blank">https://github.com/threader/mesa-10.6.3-ppc-r300-debian</a=
> - this only fixes the issue for r300 on powerpc though.=C2=A0</div></div>=
<div><div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 5 Fe=
bruary 2016 at 14:32, Herminio Hernandez Jr. <span dir=3D"ltr">&lt;<a href=
=3D"mailto:herminio.hernandezjr@gmail.com" target=3D"_blank">herminio.herna=
ndezjr@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><d=
iv dir=3D"auto"><div>I have been experiencing the same thing with my iBook =
and PowerBook.=C2=A0<br><br>Sent from my iPhone</div><div><div><div><br>On =
Feb 4, 2016, at 8:47 PM, Mike &lt;<a href=3D"mailto:michael.heltne@gmail.co=
m" target=3D"_blank">michael.heltne@gmail.com</a>&gt; wrote:<br><br></div><=
blockquote type=3D"cite"><div><div dir=3D"ltr"><div class=3D"gmail_extra"><=
div class=3D"gmail_extra">Hi.=C2=A0</div><div class=3D"gmail_extra">Managed=
 to get the Radeon R300 running on mesa 11.1.1 with an old 2013 patch from =
Michel D=C3=A0nzer, next problem is of course enabling agpmode, running wit=
h pci-mode with radeon.agpmode=3D-1 works, but is of course slow, and seems=
 to load the cpu a lot.</div><div class=3D"gmail_extra"><br></div><div clas=
s=3D"gmail_extra">Upon initial investigation i could not initially believe =
agp could be this this broken for this long, until i found this.</div><div =
class=3D"gmail_extra"><div class=3D"gmail_extra">=C2=A0&quot;committed with=
 Ben Skeggs on Feb 26, 2013&quot;</div><div class=3D"gmail_extra"><a href=
=3D"https://github.com/DespairFactor/bullhead/commit/650e1203c11354ba84d69b=
a445abc0efcfe3890a" target=3D"_blank">https://github.com/DespairFactor/bull=
head/commit/650e1203c11354ba84d69ba445abc0efcfe3890a</a></div></div><div cl=
ass=3D"gmail_extra"><a href=3D"http://lxr.free-electrons.com/source/drivers=
/gpu/drm/nouveau/nouveau_agp.c?v=3D4.2" target=3D"_blank">http://lxr.free-e=
lectrons.com/source/drivers/gpu/drm/nouveau/nouveau_agp.c?v=3D4.2</a></div>=
<div class=3D"gmail_extra">#ifdef __powerpc__</div><div class=3D"gmail_extr=
a"><span style=3D"white-space:pre-wrap">		</span>/* Disable AGP by default =
on all PowerPC machines for</div><div class=3D"gmail_extra"><span style=3D"=
white-space:pre-wrap">		</span> * now -- At least some UniNorth-2 AGP bridg=
es are</div><div class=3D"gmail_extra"><span style=3D"white-space:pre-wrap"=
>		</span> * known to be broken: DMA from the host to the card</div><div cl=
ass=3D"gmail_extra"><span style=3D"white-space:pre-wrap">		</span> * works =
just fine, but writeback from the card to the</div><div class=3D"gmail_extr=
a"><span style=3D"white-space:pre-wrap">		</span> * host goes straight to m=
emory untranslated bypassing</div><div class=3D"gmail_extra"><span style=3D=
"white-space:pre-wrap">		</span> * the GATT somehow, making them quite pain=
ful to deal</div><div class=3D"gmail_extra"><span style=3D"white-space:pre-=
wrap">		</span> * with...</div><div class=3D"gmail_extra"><span style=3D"wh=
ite-space:pre-wrap">		</span> */</div><div class=3D"gmail_extra"><span styl=
e=3D"white-space:pre-wrap">		</span>if (nouveau_agpmode =3D=3D -1)</div><di=
v class=3D"gmail_extra"><span style=3D"white-space:pre-wrap">			</span>retu=
rn false;</div><div class=3D"gmail_extra">#endif</div><div class=3D"gmail_e=
xtra">=C2=A0</div><div class=3D"gmail_extra">=C2=A0and now later this:=C2=
=A0</div><div class=3D"gmail_extra"><a href=3D"https://github.com/torvalds/=
linux/blob/master/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.c" target=3D"=
_blank">https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/nouve=
au/nvkm/subdev/pci/agp.c</a></div><div class=3D"gmail_extra">#ifdef __power=
pc__</div><div class=3D"gmail_extra"><span style=3D"white-space:pre-wrap">	=
</span>/* Disable AGP by default on all PowerPC machines for now -- At</div=
><div class=3D"gmail_extra"><span style=3D"white-space:pre-wrap">	</span> *=
 least some UniNorth-2 AGP bridges are known to be broken:</div><div class=
=3D"gmail_extra"><span style=3D"white-space:pre-wrap">	</span> * DMA from t=
he host to the card works just fine, but writeback</div><div class=3D"gmail=
_extra"><span style=3D"white-space:pre-wrap">	</span> * from the card to th=
e host goes straight to memory</div><div class=3D"gmail_extra"><span style=
=3D"white-space:pre-wrap">	</span> * untranslated bypassing that GATT someh=
ow, making them quite</div><div class=3D"gmail_extra"><span style=3D"white-=
space:pre-wrap">	</span> * painful to deal with...</div><div class=3D"gmail=
_extra"><span style=3D"white-space:pre-wrap">	</span> */</div><div class=3D=
"gmail_extra"><span style=3D"white-space:pre-wrap">	</span>mode =3D 0;</div=
><div class=3D"gmail_extra">#endif</div><div class=3D"gmail_extra"><br></di=
v><div class=3D"gmail_extra">All seems to point to serious issues had aroun=
d the time of change to ums to kms and a serious regression hitting the lin=
ux kernel? No?</div><div class=3D"gmail_extra"><br></div><div class=3D"gmai=
l_extra">Cheers</div><div class=3D"gmail_extra">-Mike</div></div></div>
</div></blockquote></div></div><blockquote type=3D"cite"><div><span>_______=
________________________________________</span><br><span>Linuxppc-dev maili=
ng list</span><br><span><a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org" ta=
rget=3D"_blank">Linuxppc-dev@lists.ozlabs.org</a></span><br><span><a href=
=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank">https=
://lists.ozlabs.org/listinfo/linuxppc-dev</a></span></div></blockquote></di=
v></blockquote></div><br></div>
</div></div></blockquote></div><br></div>
</div></div></blockquote></div><br></div>
</div></div></blockquote></div><br></div>
</div></div></blockquote></div><br></div>

--94eb2c0b163020393b052b0b14cd--
