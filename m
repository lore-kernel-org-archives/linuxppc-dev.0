Return-Path: <SRS0=to3W=WL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A05EC3A589
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Aug 2019 14:11:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37188206C2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Aug 2019 14:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtMKB3MH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37188206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 468T0L5fc9zDr2J
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Aug 2019 00:11:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="PtMKB3MH"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 468Srx2l5YzDqJ2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2019 00:05:21 +1000 (AEST)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 171BD20644;
 Thu, 15 Aug 2019 14:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1565877918;
 bh=lOyzTACCHACUENr3Alx4Ml7IiaPxhwyXrxfcBKWNBJc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PtMKB3MHNCBeXVQklF3aBuT4nPDLyDVWODXEgp48SJZXXqW5ovAbc9FVn+3tX8FKE
 pR1oRIblVReZKrtntkhiaZUu9/e7AjwFuaI4yblInt8eTNK1NW/ZB7XjP4YTtW5VlW
 eNlY1nowm+mCe1y3E25iAZAab2798Rbm62UuKYmw=
Date: Thu, 15 Aug 2019 16:05:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6/6] driver core: initialize a default DMA mask for
 platform device
Message-ID: <20190815140516.GB7174@kroah.com>
References: <20190811080520.21712-1-hch@lst.de>
 <20190811080520.21712-7-hch@lst.de>
 <20190815130325.GB17065@kroah.com> <20190815133812.GF12036@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815133812.GF12036@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Gavin Li <git@thegavinli.com>, Fabio Estevam <festevam@gmail.com>,
 linux-arch@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Alan Stern <stern@rowland.harvard.edu>, NXP Linux Team <linux-imx@nxp.com>,
 Mathias Nyman <mathias.nyman@intel.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Minas Harutyunyan <hminas@synopsys.com>, Olav Kongas <ok@artecdesign.ee>,
 Bin Liu <b-liu@ti.com>, linux-arm-kernel@lists.infradead.org,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, Geoff Levand <geoff@infradead.org>,
 Shawn Guo <shawnguo@kernel.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tony Prisk <linux@prisktech.co.nz>,
 iommu@lists.linux-foundation.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Aug 15, 2019 at 03:38:12PM +0200, Christoph Hellwig wrote:
> On Thu, Aug 15, 2019 at 03:03:25PM +0200, Greg Kroah-Hartman wrote:
> > > --- a/include/linux/platform_device.h
> > > +++ b/include/linux/platform_device.h
> > > @@ -24,6 +24,7 @@ struct platform_device {
> > >  	int		id;
> > >  	bool		id_auto;
> > >  	struct device	dev;
> > > +	u64		dma_mask;
> > 
> > Why is the dma_mask in 'struct device' which is part of this structure,
> > not sufficient here?  Shouldn't the "platform" be setting that up
> > correctly already in the "archdata" type callback?
> 
> Becaus the dma_mask in struct device is a pointer that needs to point
> to something, and this is the best space we can allocate for 'something'.
> m68k and powerpc currently do something roughly equivalent at the moment,
> while everyone else just has horrible, horrible hacks.  As mentioned in
> the changelog the intent of this patch is that we treat platform devices
> like any other bus, where the bus allocates the space for the dma_mask.
> The long term plan is to eventually kill that weird pointer indirection
> that doesn't help anyone, but for that we need to sort out the basics
> first.

Ah, missed that, sorry.  Ok, no objection from me.  Might as well respin
this series and I can queue it up after 5.3-rc5 is out (which will have
your first 2 patches in it.)

thanks,

greg k-h
