Return-Path: <SRS0=h5jx=SC=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 5209CDDDEE
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 18:26:58 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] ibm_newemac: Increase number of default rx-/tx-buffers
Date: Sat, 12 Jan 2008 08:26:52 +0100
References: <1199526609-12290-1-git-send-email-sr@denx.de>
	<20080111174822.GB17240@gate.ebshome.net>
	<1200089457.6896.65.camel@pasglop>
In-Reply-To: <1200089457.6896.65.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200801120826.53091.sr@denx.de>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 11 January 2008, Benjamin Herrenschmidt wrote:
> On Fri, 2008-01-11 at 09:48 -0800, Eugene Surovegin wrote:
> > On Sat, Jan 05, 2008 at 01:38:17PM +0100, Stefan Roese wrote:
> > > On Saturday 05 January 2008, Benjamin Herrenschmidt wrote:
> > > > On Sat, 2008-01-05 at 10:50 +0100, Stefan Roese wrote:
> > > > > Performance tests done by AMCC have shown that 256 buffer increase
> > > > > the performance of the Linux EMAC driver. So let's update the
> > > > > default values to match this setup.
> > > > >
> > > > > Signed-off-by: Stefan Roese <sr@denx.de>
> > > > > ---
> > > >
> > > > Do we have the numbers ? Did they also measure latency ?
> > >
> > > I hoped this question would not come. ;) No, unfortunately I don't have
> > > any numbers. Just the recommendation from AMCC to always use 256
> > > buffers.
> >
> > This cannot be true for all chips. Default numbers I selected weren't
> > random. In particular, 256 for Tx doesn't make a lot of sense for 405.
> > You just gonna waste memory.

This may be the case with the "old" 405 PPC's. But with the new ones coming 
out right now, like the up to 666MHz 405EX with GBit support, 256 could be an 
improvement. I still owe you figures though. Will try to do some testing in a 
short while.

> > I'd be quite reluctant to follow such advices from AMCC without actual
> > details.
>
> I think we can make defaults based on other config options nowadays. Not
> very nice but we could do things like
>
> 	default 128 if PPC_40x
> 	default 256
>
> Or even more detailed.

We shouldn't make it too complicated. We can always select different settings 
in the defconfig file. My thinking here is to better wast a little memory 
with a potential performance improvement. Just me 0.02$

Best regards,
Stefan
