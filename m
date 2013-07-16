Return-Path: <anton@scarybugs.org>
Received: from mail-pb0-f47.google.com (mail-pb0-f47.google.com
 [209.85.160.47])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 68C712C010D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2013 15:04:58 +1000 (EST)
Received: by mail-pb0-f47.google.com with SMTP id rr13so270662pbb.20
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2013 22:04:56 -0700 (PDT)
Sender: Anton Vorontsov <anton@scarybugs.org>
Date: Mon, 15 Jul 2013 22:04:52 -0700
From: Anton Vorontsov <anton@enomsg.org>
To: Zhang Haijun-B42677 <B42677@freescale.com>
Subject: Re: [PATCH 3/4 V2] mmc: esdhc: Add quirks to support T4240QDS board
Message-ID: <20130716050452.GA10380@teo>
References: <1373267764-6364-1-git-send-email-Haijun.Zhang@freescale.com>
 <1373267764-6364-2-git-send-email-Haijun.Zhang@freescale.com>
 <1373303919.8183.164@snotra> <20130712183503.GA24689@teo>
 <99E897753B6F7048BD8CCDB4661D02E13A7CC3@039-SN2MPN1-021.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <99E897753B6F7048BD8CCDB4661D02E13A7CC3@039-SN2MPN1-021.039d.mgd.msft.net>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Wrobel Heinz-R39252 <r39252@freescale.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 "cjb@laptop.org" <cjb@laptop.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 16, 2013 at 03:11:47AM +0000, Zhang Haijun-B42677 wrote:
> Hi, Anton
> 
> You mean get voltage support from DTS?
> Or get voltage both from DTS and host capacity register?

The logic might be that you first check device-tree, if it specifies
voltage ranges, assume that DTS knows better, otherwise read capabilities
from the register.

Anton

> Thanks.
> 
> Regards
> Haijun.
> 
> 
> > -----Original Message-----
> > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > owner@vger.kernel.org] On Behalf Of Anton Vorontsov
> > Sent: Saturday, July 13, 2013 2:35 AM
> > To: Wood Scott-B07421
> > Cc: Zhang Haijun-B42677; linux-mmc@vger.kernel.org; linuxppc-
> > dev@lists.ozlabs.org; cjb@laptop.org; Fleming Andy-AFLEMING; Wrobel
> > Heinz-R39252
> > Subject: Re: [PATCH 3/4 V2] mmc: esdhc: Add quirks to support T4240QDS
> > board
> > 
> > On Mon, Jul 08, 2013 at 12:18:39PM -0500, Scott Wood wrote:
> > > On 07/08/2013 02:16:04 AM, Haijun Zhang wrote:
> > > >On T4240QDS board controllers has an unusable ADMA engine, so use
> > > >SDMA instead.
> > > >Also 3.0v is support on T4240QDS board even if the capacity detailed
> > > >only 1.8v support. Without this quirk SD card will declare voltage
> > > >not support and
> > > >
> > > >Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> > >
> > > ...and what?
> > >
> > > Why is this board-specific?  Isn't the controller part of the SoC, not
> > > part of the board?  If it really is board-specific, could you be more
> > > detailed about why (ideally with an erratum number), and check the
> > > toplevel board compatible (or get the information from platform
> > > code) rather than modify the device tree?
> > 
> > Yup, and if anything, I would recommend to reuse voltage-ranges property,
> > it is already implemented for mmc spi driver,
> > 
> > drivers/mmc/host/of_mmc_spi.c
> > Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt
> > 
> > Thanks,
> > 
> > Anton
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
> 
