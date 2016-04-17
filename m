Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qnZF94ZwjzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Apr 2016 11:58:37 +1000 (AEST)
Message-ID: <1460858312.32510.182.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Zhiqiang Hou <zhiqiang.hou@nxp.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>, linux-mtd@lists.infradead.org
Cc: Mingkai Hu <mingkai.hu@nxp.com>
Date: Sat, 16 Apr 2016 20:58:32 -0500
In-Reply-To: <AM4PR04MB21485158542FA13151D6B23484900@AM4PR04MB2148.eurprd04.prod.outlook.com>
References: <1459937676-25668-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <1459980089.32510.78.camel@buserror.net>
 <AM4PR04MB21485158542FA13151D6B23484900@AM4PR04MB2148.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] powerpc/config: Disable the 4KiB erase granularity of
 SPI flash
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-04-07 at 03:17 +0000, Zhiqiang Hou wrote:
> Hi Scott,
> 
> Thanks for your comments.
> 
> > -----Original Message-----
> > From: Scott Wood [mailto:oss@buserror.net]
> > Sent: 2016年4月7日 6:01
> > To: Zhiqiang Hou <zhiqiang.hou@nxp.com>; linuxppc-dev@lists.ozlabs.org;
> > benh@kernel.crashing.org; paulus@samba.org; mpe@ellerman.id.au
> > Cc: Mingkai Hu <mingkai.hu@nxp.com>
> > Subject: Re: [PATCH] powerpc/config: Disable the 4KiB erase granularity of
> > SPI
> > flash
> > 
> > On Wed, 2016-04-06 at 18:14 +0800, Zhiqiang Hou wrote:
> > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > 
> > > Disable the subsector (4KiB) erase granularity to speed up the erase
> > > operation.
> > > 
> > > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > ---
> > >  arch/powerpc/configs/85xx-hw.config | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/powerpc/configs/85xx-hw.config
> > > b/arch/powerpc/configs/85xx -hw.config index 528ff0e..a0f4e70 100644
> > > --- a/arch/powerpc/configs/85xx-hw.config
> > > +++ b/arch/powerpc/configs/85xx-hw.config
> > > @@ -77,6 +77,7 @@ CONFIG_MTD_PHYSMAP_OF=y
> > CONFIG_MTD_PHYSMAP=y
> > > CONFIG_MTD_PLATRAM=y  CONFIG_MTD_SPI_NOR=y
> > > +# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
> > >  CONFIG_NETDEVICES=y
> > >  CONFIG_NVRAM=y
> > >  CONFIG_PATA_ALI=y
> > 
> > Is there a reason specific to 85xx to have a different default than every
> > other
> > platform except lpc18xx?  The description of MTD_SPI_NOR_USE_4K_SECTORS
> > acknowledges that erase speed is a tradeoff.  Why is that concern more
> > compelling on 85xx than elsewhere?
> > 
> 
> I don't want to specify 85xx, but configs of fsl.

That doesn't change my question (but it does mean you put it in the wrong
file).

> For this patch, it takes about 13 mins to erase 64MiB by subsector erase
> command
> (4KiB per time), but takes 2 mins by sector erase command(64KiB per time).
> It is
> conspicuous decrease. Why it uses the 4KiB granularity by default, what's
> the
> benefit?

Again, the help text for this item says that it slows writes down, yet it's
still on by default.  Presumably there are other benefits that are deemed to
outweigh the slower erase.

-Scott
