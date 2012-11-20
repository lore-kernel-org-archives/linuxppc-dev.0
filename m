Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zoneX.GCU-Squad.org [194.213.125.0])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AB22D2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2012 00:38:40 +1100 (EST)
Date: Tue, 20 Nov 2012 14:37:43 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 207/493] i2c: remove use of __devinit
Message-ID: <20121120143743.3f54a3cb@endymion.delvare>
In-Reply-To: <20121120132342.GP3332@n2100.arm.linux.org.uk>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-207-git-send-email-wfp5p@virginia.edu>
 <20121120092046.24496415@endymion.delvare>
 <20121120132342.GP3332@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Rudolf Marek <r.marek@assembler.cz>, Tony Lindgren <tony@atomide.com>,
 gregkh@linuxfoundation.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Wolfram Sang <w.sang@pengutronix.de>, "Mark M.
 Hoffman" <mhoffman@lightlink.com>, Bill Pemberton <wfp5p@virginia.edu>,
 linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
 Barry Song <baohua.song@csr.com>, Olof Johansson <olof@lixom.net>,
 linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 20 Nov 2012 13:23:42 +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 20, 2012 at 09:20:46AM +0100, Jean Delvare wrote:
> > Hi Bill,
> > 
> > On Mon, 19 Nov 2012 13:22:36 -0500, Bill Pemberton wrote:
> > > CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> > > needed.
> > 
> > Can you please point me/us to the discussion explaining the rationale
> > behind this move, and the explanation of what will be done exactly?
> > While I can easily understand that we want to drop CONFIG_HOTPLUG and
> > always enable hot-plug support, I don't see where we are going with
> > removing __devinit annotations and the like.
> 
> It's actually very simple to understand.
> 
> 1. CONFIG_HOTPLUG is going away; it's already defined to always be 'Y'.
> 2. This means that the the devinit sections will not be discarded anymore.
> 3. As a result, there's no point the devinit sections existing anymore.
> 4. As there's no devinit sections, the __devinit marker is entirely
>    redundant and useless.

Ah, yes, very simple indeed. Not sure how I managed to not understand
it earlier today. Thanks for explaining.

> The reason this is being done is because the benefit to cost ratio of this
> is far too high; it's well proven that people constantly get these markings
> wrong, and with most kernels having had hotplug enabled anyway, it's not
> providing much in the way of space saving benefit over the number of section
> conflicts it causes.  So, it's been decided a few years ago that this is

Yes, I completely agree.

> going to happen, with that justification, and it's been accepted by 300
> odd kernel developers in at least one kernel summit when it was talked

Probably that was one I didn't attend to, as I can't remember this
discussion.

> about... and it's been mentioned on mailing lists several times.

Maybe LKML, which I don't read. So I wasn't aware of the plan before
seeing Bill's patches.

-- 
Jean Delvare
