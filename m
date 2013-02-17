Return-Path: <shawn.guo@linaro.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D4B922C0085
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Feb 2013 18:43:31 +1100 (EST)
Date: Sun, 17 Feb 2013 15:43:20 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] of: use platform_device_add
Message-ID: <20130217074317.GB16632@S2101-09.ap.freescale.net>
References: <1358473200-17886-1-git-send-email-grant.likely@secretlab.ca>
 <1358473200-17886-2-git-send-email-grant.likely@secretlab.ca>
 <20130217030331.GA15048@S2101-09.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20130217030331.GA15048@S2101-09.ap.freescale.net>
Cc: linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 17, 2013 at 11:03:35AM +0800, Shawn Guo wrote:
> On Fri, Jan 18, 2013 at 01:40:00AM +0000, Grant Likely wrote:
> > This allows platform_device_add a chance to call insert_resource on all
> > of the resources from OF. At a minimum this fills in proc/iomem and
> > presumably makes resource tracking and conflict detection work better.
> > However, it has the side effect of moving all OF generated platform
> > devices from /sys/devices to /sys/devices/platform/. It /shouldn't/
> > break userspace because userspace is not supposed to depend on the full
> > path (because userspace always does what it is supposed to, right?).
> > 
> > This may cause breakage if either:
> > 1) any two nodes in a given device tree have overlapping & staggered
> >    regions (ie. 0x80..0xbf and 0xa0..0xdf; where one is not contained
> >    within the other). In this case one of the devices will fail to
> >    register and an exception will be needed in platform_device_add() to
> >    complain but not fail.
> 
> Grant,
> 
> The patch introduce a regression on imx6q boot.

It also breaks all of_amba_device users.

of_amba_device_create() --> amba_device_add() --> request_resource()
and fails.

Shawn
