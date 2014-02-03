Return-Path: <michael.moese@men.de>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9E6C42C0086
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Feb 2014 21:47:19 +1100 (EST)
Date: Mon, 3 Feb 2014 11:39:44 +0100
From: Michael Moese <michael.moese@men.de>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: PCIe Access - achieve bursts without DMA
Message-ID: <20140203103943.GC1970@localhost.intra.men.de>
References: <2DF74D4E746FF14C8697D5041AAE72D56A2B1420@MEN-EX2.intra.men.de>
 <1391208815.27142.38.camel@pasglop>
 <52EC2F46.7000609@ovro.caltech.edu>
 <20140203082050.GB1970@localhost.intra.men.de>
 <063D6719AE5E284EB5DD2968C1650D6D0F6B774B@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D0F6B774B@AcuExch.aculab.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 David Hawkins <dwh@ovro.caltech.edu>, 'Michael Moese' <michael.moese@men.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 03, 2014 at 10:17:43AM +0000, David Laight wrote:

> We achieved about twice that using the PEX dma controller.

> Your 3MB/s for single word transfers is similar to what we saw.
> Cycle times that make an ISA bus look fast.

Indeed, this is a really poor performance. I know we could achieve much
more performance using DMA, we have several products where we simply 
don't have DMA available - this requires searching for other paths.

My ioremap_wt() could help in these situations, at least increasing
performance for non-DMA operation to a not-that-bad level.

I don't know if other devices could benefit from this, but surely we
got several IPs that would, but those were not yet upstreamed, we're
still working on this.

Michael
