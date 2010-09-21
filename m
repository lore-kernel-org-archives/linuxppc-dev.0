Return-Path: <timur.tabi@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) by ozlabs.org (Postfix) with ESMTP id 8BF36B70E2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Sep 2010 08:05:10 +1000 (EST)
Received: by iwn4 with SMTP id 4so2316914iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Sep 2010 15:05:09 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <20100921164944.164ed0af@udp111988uds.am.freescale.net>
References: <1285066638-7473-1-git-send-email-leoli@freescale.com>
	<877FD0B5-19A7-4A16-831E-369B80B104EA@kernel.crashing.org>
	<AANLkTimiwtoa6i10OTcgFnvbvcO9N4KWHyt4Poj-yj=T@mail.gmail.com>
	<20100921163456.7e2c9b32@udp111988uds.am.freescale.net>
	<AANLkTine--kry0c0n87WOqYyi3AQOb2KnmNRs-MeXcQt@mail.gmail.com>
	<20100921164944.164ed0af@udp111988uds.am.freescale.net>
From: Timur Tabi <timur@freescale.com>
Date: Tue, 21 Sep 2010 17:04:39 -0500
Message-ID: <AANLkTik3dNU1FdUG6sWnQ3P0eXQu62PrckQ9_-Dk7GEJ@mail.gmail.com>
Subject: Re: [PATCH] fsldma: add support to 36-bit physical address
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 21, 2010 at 4:49 PM, Scott Wood <scottwood@freescale.com> wrote:

> Look in dmaengine.c, there are calls to dma_map_single() and
> dma_map_page(), using what I assume is that same device pointer --
> unless there's confusion between the channel and the controller.

You're right.  I missed this line in the driver:

	fdev->common.dev = &op->dev;

Also, the driver does something stupid.  Sometimes "chan->dev" refers
to dma_chan.chan, and sometimes it refers to fsldma_chan.chan.  I
could have sworn I saw a patch that fixes that, though.

-- 
Timur Tabi
Linux kernel developer at Freescale
