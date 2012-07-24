Return-Path: <R65777@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 105E52C007C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2012 18:01:33 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tabi Timur-B04825
 <B04825@freescale.com>
Subject: RE: [PATCH] powerpc/mm: add ZONE_NORMAL zone for 64 bit kernel
Date: Tue, 24 Jul 2012 08:01:24 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D03DD660F@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1342786906-12634-1-git-send-email-Shaohui.Xie@freescale.com>
 <1343023569.2957.19.camel@pasglop>	<500D7921.6060804@freescale.com>
 <1343082030.2957.38.camel@pasglop>
 <CAOZdJXXd6GuLAed_Z4zNMjDN+DBBXHdd0yVRHof+BJ_eiUMbqQ@mail.gmail.com>
 <1343085145.2957.44.camel@pasglop> <500DDB1B.9030900@freescale.com>
 <1343086186.2957.46.camel@pasglop> <500DDFF3.3000408@freescale.com>
 <1343099318.3715.0.camel@pasglop> <500E1EB3.6060203@freescale.com>
 <1343105157.3715.6.camel@pasglop>
In-Reply-To: <1343105157.3715.6.camel@pasglop>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Hu Mingkai-B21284 <B21284@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Xie Shaohui-B21989 <B21989@freescale.com>,
 Chen Yuanquan-B41889 <B41889@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-
> bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Ben=
jamin
> Herrenschmidt
> Sent: Tuesday, July 24, 2012 10:16 AM
> To: Tabi Timur-B04825
> Cc: Wood Scott-B07421; Hu Mingkai-B21284; linuxppc-dev@lists.ozlabs.org; =
Xie
> Shaohui-B21989; Chen Yuanquan-B41889
> Subject: Re: [PATCH] powerpc/mm: add ZONE_NORMAL zone for 64 bit kernel
>=20
> On Tue, 2012-07-24 at 04:04 +0000, Tabi Timur-B04825 wrote:
> > Benjamin Herrenschmidt wrote:
> > > Sure but I don't want to create the zones in the first place (and
> > > thus introduce the added pressure on the memory management) on
> > > machines that don't need it.
> >
> > One thing that does confuse me -- by default, we don't create a
> > ZONE_NORMAL.  We only create a ZONE_DMA.  Why is that?  Shouldn't it
> > be the other way around?
>=20
> Because ZONE_NORMAL allocations can be serviced from the ZONE_DMA while t=
he
> other way isn't possible.

Say, if we have defined only one zone (ZONE_DMA) to which we give all memor=
y ( > 4G).
Device set the DMA_MASK to 4G or less.

dma_alloc_coherent() will set GFP_DMA flag, But that is of no use, because =
the memory allocator have only one zone which have all memory (which assume=
s all dma-able). And can return memory at address at > 4G. which will crash=
 !!

I think we have to have at least one zone which gives memory to be dma-able=
 for all devices (memory limit should be set by platform, because different=
  platform have different devices with different limits.). And another ( 1 =
or more) will cover rest of memory.

Thanks
-Bharat

>=20
> Especially in the old days, there were quite a few cases of drivers and/o=
r
> subsystems who were a bit heavy handed at using ZONE_DMA, so not having o=
ne
> would essentially make them not work at all.
>=20
> Cheers,
> Ben.
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
