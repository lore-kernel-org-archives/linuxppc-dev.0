Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 4292Nd3dymzF37c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 10:15:12 +1000 (AEST)
Date: Wed, 12 Sep 2018 10:15:23 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
cc: Frank Rowand <frank.rowand@sony.com>, Stan Johnson <userm57@yahoo.com>,
 Rob Herring <robh+dt@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Chintan Pandya <cpandya@codeaurora.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: v4.17 regression: PowerMac G3 won't boot, was Re: [PATCH v5 1/3]
 of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
In-Reply-To: <abb0dec2-da3a-2c04-0e9f-28851b22cf75@yahoo.com>
Message-ID: <alpine.LNX.2.21.1809121015070.137@nippy.intranet>
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
 <1520208889-3908-2-git-send-email-frowand.list@gmail.com>
 <alpine.LNX.2.21.1808301025480.73@nippy.intranet>
 <0ad5dbfd-08f3-b97d-34b9-70fc9a729921@gmail.com>
 <d9e53e48794c2eade19309b73febd492e3c5eeeb.camel@kernel.crashing.org>
 <7427daf6570d519e6793eb96d2fbaa52714b0cd7.camel@kernel.crashing.org>
 <20180910125320.GA17028@bogus>
 <abb0dec2-da3a-2c04-0e9f-28851b22cf75@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[The Cc list got pruned so I'm forwarding Stan's reply for the benefit of 
the list archives and any other interested parties.]

On Mon, 10 Sep 2018, Stan Johnson wrote:

> On 9/10/18 6:53 AM, Rob Herring wrote:
> 
> > ...
> > Can you try this patch (w/o Ben's patch). I think the problem is if 
> > there are no phandles, then roundup_pow_of_two is passed 0 which is 
> > documented as undefined result.
> >
> > Though, if a DT has no properties with phandles, then why are we doing a 
> > lookup in the first place?
> >
> >
> > 8<----------------------------------------------------------------------
> >
> > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > index 9095b8290150..74eaedd5b860 100644
> > --- a/drivers/of/base.c
> > +++ b/drivers/of/base.c
> > @@ -140,6 +140,9 @@ void of_populate_phandle_cache(void)
> >  		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
> >  			phandles++;
> >  
> > +	if (!phandles)
> > +		goto out;
> > +
> >  	cache_entries = roundup_pow_of_two(phandles);
> >  	phandle_cache_mask = cache_entries - 1;
> >  
> 
> Using the attached .config file, I first compiled the stock 4.18
> kernel from kernel.org; it hung at the Mac OS background screen
> on my Beige G3 Desktop using the BootX extension and the BootX.app
> from within MacOS.  I then applied the above patch, and it booted
> without any problems from both the BootX extension and using the
> BootX.app from within MacOS.
> 
> -Stan
> 
> 
