Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 2119DB6EF1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Sep 2010 08:19:34 +1000 (EST)
Date: Wed, 29 Sep 2010 15:19:31 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 3/4] fsldma: remove DMA_SLAVE support
Message-ID: <20100929221931.GE20748@ovro.caltech.edu>
References: <1285628277-26894-1-git-send-email-iws@ovro.caltech.edu>
	<1285628277-26894-4-git-send-email-iws@ovro.caltech.edu>
	<AANLkTik4_se70GkKb2FLwsiUtQGyaHgxsLn3MQhmv5jh@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTik4_se70GkKb2FLwsiUtQGyaHgxsLn3MQhmv5jh@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 29, 2010 at 02:52:16PM -0700, Dan Williams wrote:
> On Mon, Sep 27, 2010 at 3:57 PM, Ira W. Snyder <iws@ovro.caltech.edu> wrote:
> > Now that the generic DMAEngine API has support for scatterlist to
> > scatterlist copying, this implementation of the DMA_SLAVE API is no
> > longer necessary.
> >
> > In order to let device_control() continue to function, a stub
> > device_prep_slave_sg() function is provided. This allows custom device
> > configuration, such as enabling external control.
> >
> 
> > +       case DMA_SLAVE_CONFIG:
> > +
> > +               cfg = (struct fsldma_slave_config *)arg;
> 
> Now that I actually see someone trying to use the recommended
> extension model it comes across as unsafe, what guarantees that arg is
> pointing to a fsldma_slave_config.  At at minimum you could ensure
> that this channel has been claimed for private usage which loosely
> implies that the client knows that it is talking to an fsldma channel.
>  Even safer is to just assign you a one-off dma_ctrl_cmd
> (FSLDMA_EXTERNAL_START) for this purpose.  Otherwise this and the
> other patches look good.
> 

I agree, it is a very unsafe model.

I'll take your suggestion, and do that instead. A new patch will be
forthcoming shortly.

Thanks,
Ira
