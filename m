Return-Path: <BATV+0c91a423bf0bc08960f9+2619+infradead.org+dwmw2@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 068ABB70D1
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Oct 2010 01:15:40 +1100 (EST)
Subject: Re: [PATCH 1/2] P4080/eLBC: Make Freescale elbc interrupt common
	to elbc	devices
From: David Woodhouse <dwmw2@infradead.org>
To: "tiejun.chen" <tiejun.chen@windriver.com>
In-Reply-To: <4CBC1775.6000706@windriver.com>
References: <1287386552-10647-1-git-send-email-tie-fei.zang@freescale.com>
	<4CBC0B95.9010300@windriver.com>
	<3850A844E6A3854C827AC5C0BEC7B60A2B0708@zch01exm23.fsl.freescale.net>
	<4CBC16FD.6030507@windriver.com>  <4CBC1775.6000706@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 25 Oct 2010 15:15:27 +0100
Message-ID: <1288016127.5674.45.camel@macbook.infradead.org>
Mime-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>, dedekind1@gmail.com,
	Zang Roy-R61911 <r61911@freescale.com>,
	Lan Chunhe-B25806 <B25806@freescale.com>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	akpm@linux-foundation.org, Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-10-18 at 17:46 +0800, tiejun.chen wrote:
> 
> >>> Looks you always iounmap(fsl_lbc_ctrl_dev->regs) on position 'err' but here
> >>> of_iomap() is already failed you should skip iounmap() fsl_lbc_ctrl_dev->regs
> >>> again. So you should improve that as the following on 'err', or layout 'err'
> >>> in
> >>> gain.
> >>> ------
> >>>     if(fsl_lbc_ctrl_dev->regs)
> >>>             iounmap(fsl_lbc_ctrl_dev->regs);
> >>>
> >>> Tiejun
> >> You are right!
> >> How about
> >>  
> >>         if (!fsl_lbc_ctrl_dev->regs) {
> >>                 dev_err(&dev->dev, "failed to get memory region\n");
> >>                 kfree(fsl_lbc_ctrl_dev);
> >>                 return -ENOMEM;
> >>         }
> > 
> > Although this is a big problem, I prefer to return 'ENXIO' :)
>                 ^
>                 Typo: is not a ...... 

My God! Why did you *both* repeat over 400 lines of patch, over and over
again, just for this?

Please, make sure you quote *only* what you actually need to quote for
context. Don't make me implement a filter for the list which rejects
messages that are more than 90% quotation.

-- 
dwmw2
