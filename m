Return-Path: <r61911@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 646632C008F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2012 13:59:48 +1000 (EST)
From: Zang Roy-R61911 <r61911@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tabi Timur-B04825
 <B04825@freescale.com>, Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH] powerpc/mm: add ZONE_NORMAL zone for 64 bit kernel
Date: Tue, 24 Jul 2012 03:59:40 +0000
Message-ID: <3E027F8168735B46AC006B1D0C7BB002079C4E2C@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1342786906-12634-1-git-send-email-Shaohui.Xie@freescale.com>
 <1343023569.2957.19.camel@pasglop>	<500D7921.6060804@freescale.com>
 <1343082030.2957.38.camel@pasglop>
 <CAOZdJXXd6GuLAed_Z4zNMjDN+DBBXHdd0yVRHof+BJ_eiUMbqQ@mail.gmail.com>
 <1343085145.2957.44.camel@pasglop> <500DDB1B.9030900@freescale.com>
 <1343086186.2957.46.camel@pasglop> <500DDFF3.3000408@freescale.com>
 <1343099318.3715.0.camel@pasglop>
In-Reply-To: <1343099318.3715.0.camel@pasglop>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Hu Mingkai-B21284 <B21284@freescale.com>,
 Chen Yuanquan-B41889 <B41889@freescale.com>,
 Xie Shaohui-B21989 <B21989@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-bounces+tie-
> fei.zang=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Benjamin
> Herrenschmidt
> Sent: Tuesday, July 24, 2012 11:09 AM
> To: Tabi Timur-B04825
> Cc: Wood Scott-B07421; Hu Mingkai-B21284; linuxppc-dev@lists.ozlabs.org;
> Xie Shaohui-B21989; Chen Yuanquan-B41889
> Subject: Re: [PATCH] powerpc/mm: add ZONE_NORMAL zone for 64 bit kernel
>=20
> On Mon, 2012-07-23 at 18:36 -0500, Timur Tabi wrote:
> > The DMA zone only kicks in if the DMA mask is set to a size smaller
> > that
> > available physical memory.  Sane HW should set the DMA mask to
> > DMA_BIT_MASK(36).  And we have plenty of sane HW on our SOCs, but not
> > every device is like that.
> >
> > The whole point behind this patch is that some drivers are setting a
> > DMA
> > mask of 32, but still getting memory above 4GB.
>=20
> Sure but I don't want to create the zones in the first place (and thus
> introduce the added pressure on the memory management) on machines that
> don't need it.
OK, then how do you think Scott's suggestion to add a configurable threshol=
d?
Roy
