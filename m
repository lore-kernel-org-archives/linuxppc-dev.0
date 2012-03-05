Return-Path: <hartleys@visionengravers.com>
Received: from mail160.messagelabs.com (mail160.messagelabs.com
 [216.82.253.99])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail160.messagelabs.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 26140B6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 10:38:38 +1100 (EST)
From: H Hartley Sweeten <hartleys@visionengravers.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Dan Williams
 <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>
Date: Mon, 5 Mar 2012 17:35:53 -0600
Subject: RE: [PATCH 6/9] dmaengine: consolidate tx_status functions
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41FF555AF@AUSP01VMBX24.collaborationhost.net>
References: <20120305201411.GA17791@n2100.arm.linux.org.uk>
 <E1S4eKz-0000tE-FB@rmk-PC.arm.linux.org.uk>
In-Reply-To: <E1S4eKz-0000tE-FB@rmk-PC.arm.linux.org.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Viresh Kumar <viresh.kumar@st.com>, Stephen Warren <swarren@nvidia.com>,
 Linus Walleij <linus.walleij@stericsson.com>,
 Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
 Zhang Wei <zw@zh-kernel.org>, Barry Song <baohua.song@csr.com>,
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

On Monday, March 05, 2012 1:17 PM, Russell King wrote:
>
> Now that we have the completed cookie in the dma_chan structure, we
> can consolidate the tx_status functions by providing a function to set
> the txstate structure and returning the DMA status.  We also provide
> a separate helper to set the residue for cookies which are still in
> progress.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

<snip>

> diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
> index 47e0997..244a2c5 100644
> --- a/drivers/dma/dmaengine.h
> +++ b/drivers/dma/dmaengine.h
> @@ -45,4 +45,35 @@ static inline void dma_cookie_complete(struct dma_asyn=
c_tx_descriptor *tx)
>  	tx->cookie =3D 0;
>  }
> =20
> +/**
> + * dma_cookie_status - report cookie status
> + * @chan: dma channel
> + * @cookie: cookie we are interested in
> + * @state: dma_tx_state structure to return last/used cookies
> + *
> + * Report the status of the cookie, filling in the state structure if
> + * non-NULL.  No locking is required.
> + */
> +static inline enum dma_status dma_cookie_status(struct dma_chan *chan,
> +	dma_cookie_t cookie, struct dma_tx_state *state)
> +{
> +	dma_cookie_t used, complete;
> +
> +	used =3D chan->cookie;
> +	complete =3D chan->complete;

Is this supposed to be:

	complete =3D chan->completed_cookie;

Regards,
Hartley
