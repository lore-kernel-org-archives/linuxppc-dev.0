Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5D8752C0343
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 11:52:33 +1000 (EST)
Date: Thu, 27 Jun 2013 20:52:20 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: enable the relocatable support for the fsl
 booke 32bit kernel
To: Kevin Hao <haokexin@gmail.com>
References: <1372298434-20220-2-git-send-email-haokexin@gmail.com>
 <1372363114.8183.54@snotra>
 <20130628013637.GA3173@pek-khao-d1.corp.ad.wrs.com>
In-Reply-To: <20130628013637.GA3173@pek-khao-d1.corp.ad.wrs.com> (from
 haokexin@gmail.com on Thu Jun 27 20:36:37 2013)
Message-ID: <1372384340.8183.62@snotra>
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

0xc0000000 is 1G-aligned, so I don't see why 256M is the maximum (after =20
verifying that enough memory is present with the right alignment, of =20
course).  The TLB1 savings would probably not be enough to justify =20
figuring that out, though.

-Scott=
