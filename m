Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 860712C02CB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 11:47:38 +1000 (EST)
Date: Thu, 27 Jun 2013 20:47:27 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: enable the relocatable support for the fsl
 booke 32bit kernel
To: Kevin Hao <haokexin@gmail.com>
In-Reply-To: <20130628013637.GA3173@pek-khao-d1.corp.ad.wrs.com> (from
 haokexin@gmail.com on Thu Jun 27 20:36:37 2013)
Message-ID: <1372384047.8183.61@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/27/2013 08:36:37 PM, Kevin Hao wrote:
> On Thu, Jun 27, 2013 at 02:58:34PM -0500, Scott Wood wrote:
> > On 06/26/2013 09:00:33 PM, Kevin Hao wrote:
> > >This is based on the codes in the head_44x.S. Since we always =20
> align to
> > >256M before mapping the PAGE_OFFSET for a relocatable kernel, we =20
> also
> > >change the init tlb map to 256M size.
> >
> > Why 256M?
>=20
> For two reasons:
>   1. This is the size which both e500v1 and e500v2 support.
>   2. Since we always use the PAGE_OFFSET as 0xc0000000, the 256M is
>      max alignment value we can use for this virtual address.

Is there any reason why 64M won't continue to work here?

> > This tightens the alignment requirement for dynamic memstart.
>=20
> Yes. But since RELOCATABLE is a superset of DYNAMIC_MEMSTART, we can =20
> always
> use RELOCATABLE instead of DYNAMIC_MEMSTART for fsl booke board in =20
> any cases.

The extra flexibility of RELOCATABLE may help some use cases, but you'd =20
still require the entire 256M naturally aligned region containing the =20
kernel to be present and owned by this instance of Linux.

> So DYNAMIC_MEMSTART will seem not so useful after we enable this =20
> feature.

Then why doesn't this patch remove it?

> >  And
> > what about boards with less than 256 MiB of RAM?
>=20
> It should be fine. We just create the map in the tlb. The MM still use
> the real size of memory.

No, you must not map anything that is not present with a mapping that =20
is executable and/or not guarded, or you could get speculative accesses =20
to who-knows-what.  Even if RAM is present there but owned by some =20
other entity, you could be creating illegal aliases if that other =20
entity mapped it cache-inhibited or similar.

-Scott=
