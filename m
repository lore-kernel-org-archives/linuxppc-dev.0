Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by lists.ozlabs.org (Postfix) with ESMTP id F18CD1A1A9A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 20:58:49 +1100 (AEDT)
Subject: Re: PowerPC agpmode issues
To: Mike <michael.heltne@gmail.com>, Pranith Kumar <bobby.prani@gmail.com>
References: <CANtoAtPSgkxEvAdOs-gZGOECYN8OFTvwRrsg+US41ji1fGEDLA@mail.gmail.com>
Cc: "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <56B865A0.4060707@daenzer.net>
Date: Mon, 8 Feb 2016 18:53:36 +0900
MIME-Version: 1.0
In-Reply-To: <CANtoAtPSgkxEvAdOs-gZGOECYN8OFTvwRrsg+US41ji1fGEDLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05.02.2016 11:47, Mike wrote:
> Hi. 
> Managed to get the Radeon R300 running on mesa 11.1.1 with an old 2013
> patch from Michel Dànzer, next problem is of course enabling agpmode,
> running with pci-mode with radeon.agpmode=-1 works, but is of course
> slow, and seems to load the cpu a lot.
> 
> Upon initial investigation i could not initially believe agp could be
> this this broken for this long, until i found this.
>  "committed with Ben Skeggs on Feb 26, 2013"
> https://github.com/DespairFactor/bullhead/commit/650e1203c11354ba84d69ba445abc0efcfe3890a
> http://lxr.free-electrons.com/source/drivers/gpu/drm/nouveau/nouveau_agp.c?v=4.2
> #ifdef __powerpc__
> /* Disable AGP by default on all PowerPC machines for
> * now -- At least some UniNorth-2 AGP bridges are
> * known to be broken: DMA from the host to the card
> * works just fine, but writeback from the card to the
> * host goes straight to memory untranslated bypassing
> * the GATT somehow, making them quite painful to deal
> * with...
> */
> if (nouveau_agpmode == -1)
> return false;
> #endif
>  
>  and now later this: 
> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/nouveau/nvkm/subdev/pci/agp.c
> #ifdef __powerpc__
> /* Disable AGP by default on all PowerPC machines for now -- At
> * least some UniNorth-2 AGP bridges are known to be broken:
> * DMA from the host to the card works just fine, but writeback
> * from the card to the host goes straight to memory
> * untranslated bypassing that GATT somehow, making them quite
> * painful to deal with...
> */
> mode = 0;
> #endif
> 
> All seems to point to serious issues had around the time of change to
> ums to kms and a serious regression hitting the linux kernel? No?

Not really. UMS was just using a static GART mapping, whereas KMS is
dynamically binding pages into the GART as needed. Apparently, older
revisions of UniNorth have trouble with the latter. I think it would
make sense to change radeon.agpmode to default to -1 on powerpc as well.
Any takers?


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
