Return-Path: <oss@buserror.net>
Received: from baldur.buserror.net (unknown [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425CCj3pbXzF3FY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 04:39:12 +1000 (AEST)
Message-ID: <2d922b460faae736ddacb4ff0fe7c4bb60e16e94.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>, Christian Zigotzky
 <chzigotzky@xenosoft.de>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 05 Sep 2018 13:39:04 -0500
In-Reply-To: <AM6PR0402MB38644F9691306961BBD68C0DEC020@AM6PR0402MB3864.eurprd04.prod.outlook.com>
References: <0F797F4E-755B-499C-BA74-48CC03235393@xenosoft.de>
 <76A7B415-F6D4-4BF8-B4B7-B146C5337CF8@xenosoft.de>
 <196C6151-3085-4A42-B6D6-5891F4AF9759@xenosoft.de>
 <07ad630cccbd33c81031f690fd17cdc30b662e49.camel@buserror.net>
 <AM6PR0402MB38644F9691306961BBD68C0DEC020@AM6PR0402MB3864.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: FSL/NXP P5020: USB problems with the latest Git kernels
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-09-05 at 14:08 +0000, Laurentiu Tudor wrote:
> Hi Scott,
> 
> > -----Original Message----- 
> > On Mon, 2018-08-27 at 20:15 +0200, Christian Zigotzky wrote:
> > > Hello,
> > > 
> > > Our users tested the RC1 of kernel 4.19 on their P5020 boards today.
> > > Unfortunately the USB bug still exists. With mem values bigger than
> > 
> > 4096M,
> > > the USB mouse and keyboard doesn’t work. With the bootarg mem=4096M, the
> > 
> > USB
> > > devices work without any problems. Please compile the RC1 and test it on
> > > your P5020 board. There is a problem with the memory management since
> > > 22/08/18.
> > 
> > I just tested 4.19-rc1 on a T4240 and got a similar problem with MMC.  MMC
> > and
> > USB on these chips both have a 32-bit DMA limitation.  I'll look into it.
> 
> I encountered similar issues on LS104xA chips. This is the workaround for
> MMC:
> https://patchwork.kernel.org/patch/10506627/

That's not a workaround; it's the proper way to handle DMA addressing limits.

> On the USB side I didn't find a proper place in the usb subsystem code for a
> workaround but instead
> found an undocumented kernel arg (*) that limits the dma mask to 32 bits:
> xhci-hcd.quirks=0x800000.
> 
> (*) https://patchwork.kernel.org/patch/10509159/

The mask should already be getting set to 32 bits.  The problem is a recent
patch that changed initcall order, which lead to swiotlb not being used.  We
need to rework the swiotlb notifier so it doesn't depend on initcall ordering.

-Scott
