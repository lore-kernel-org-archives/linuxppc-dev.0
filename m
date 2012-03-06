Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 61453B6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 20:00:20 +1100 (EST)
Date: Tue, 6 Mar 2012 08:59:39 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: Re: [PATCH 6/9] dmaengine: consolidate tx_status functions
Message-ID: <20120306085939.GC17370@n2100.arm.linux.org.uk>
References: <20120305201411.GA17791@n2100.arm.linux.org.uk>
 <E1S4eKz-0000tE-FB@rmk-PC.arm.linux.org.uk>
 <ADE657CA350FB648AAC2C43247A983F001F41FF555BD@AUSP01VMBX24.collaborationhost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F001F41FF555BD@AUSP01VMBX24.collaborationhost.net>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Viresh Kumar <viresh.kumar@st.com>, Stephen Warren <swarren@nvidia.com>,
 Linus Walleij <linus.walleij@stericsson.com>,
 Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
 Vinod Koul <vinod.koul@intel.com>, Zhang Wei <zw@zh-kernel.org>,
 Barry Song <baohua.song@csr.com>, Dan Williams <dan.j.williams@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 05, 2012 at 06:12:50PM -0600, H Hartley Sweeten wrote:
> On Monday, March 05, 2012 1:17 PM, Russell King wrote:
> > diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
> > index 47e0997..244a2c5 100644
> > --- a/drivers/dma/dmaengine.h
> > +++ b/drivers/dma/dmaengine.h
> > @@ -45,4 +45,35 @@ static inline void dma_cookie_complete(struct dma_async_tx_descriptor *tx)
> >  	tx->cookie = 0;
> >  }
> >  
> > +/**
> > + * dma_cookie_status - report cookie status
> > + * @chan: dma channel
> > + * @cookie: cookie we are interested in
> > + * @state: dma_tx_state structure to return last/used cookies
> > + *
> > + * Report the status of the cookie, filling in the state structure if
> > + * non-NULL.  No locking is required.
> > + */
> > +static inline enum dma_status dma_cookie_status(struct dma_chan *chan,
> > +	dma_cookie_t cookie, struct dma_tx_state *state)
> > +{
> > +	dma_cookie_t used, complete;
> > +
> > +	used = chan->cookie;
> > +	complete = chan->complete;
> > +	barrier();
> > +	if (state) {
> > +		state->last = complete;
> > +		state->used = used;
> > +		state->residue = 0;
> > +	}
> 
> Isn't this dma_set_tx_state()?

It's more than dma_set_tx_state().  It is my intention to get rid of
dma_set_tx_state() in favour of these implementations.

> > +	return dma_async_is_complete(cookie, complete, used);
> > +}
> 
> Regards,
> Hartley
> 
