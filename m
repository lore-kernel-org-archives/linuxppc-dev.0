Return-Path: <kda@linux-powerpc.org>
Received: from mail-yw0-x22c.google.com (mail-yw0-x22c.google.com
 [IPv6:2607:f8b0:4002:c05::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0B6FD1A0243
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Feb 2016 18:50:00 +1100 (AEDT)
Received: by mail-yw0-x22c.google.com with SMTP id q190so45002051ywd.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Feb 2016 23:50:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CANtoAtPSgkxEvAdOs-gZGOECYN8OFTvwRrsg+US41ji1fGEDLA@mail.gmail.com>
References: <CANtoAtPSgkxEvAdOs-gZGOECYN8OFTvwRrsg+US41ji1fGEDLA@mail.gmail.com>
Date: Fri, 5 Feb 2016 10:49:58 +0300
Message-ID: <CAOJe8K3wL-ctaWU+Fb+hz3JaTAVLgvMia0-cM2ziW+jM1jpUcA@mail.gmail.com>
Subject: Re: PowerPC agpmode issues
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Mike <michael.heltne@gmail.com>
Cc: Pranith Kumar <bobby.prani@gmail.com>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/5/16, Mike <michael.heltne@gmail.com> wrote:
> Hi.
> Managed to get the Radeon R300 running on mesa 11.1.1 with an old 2013
> patch from Michel D=C3=A0nzer, next problem is of course enabling agpmode=
,
> running with pci-mode with radeon.agpmode=3D-1 works, but is of course sl=
ow,
> and seems to load the cpu a lot.

For me nouveau on quad pmac is also broken for years(?) :/

>
> Upon initial investigation i could not initially believe agp could be thi=
s
> this broken for this long, until i found this.
>  "committed with Ben Skeggs on Feb 26, 2013"
> https://github.com/DespairFactor/bullhead/commit/650e1203c11354ba84d69ba4=
45abc0efcfe3890a
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
