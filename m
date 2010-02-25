Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 99C25B7CE6
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2010 06:25:41 +1100 (EST)
Date: Thu, 25 Feb 2010 11:25:39 -0800
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [async_tx-next PATCH 2/2] fsldma: Fix cookie issues
Message-ID: <20100225192539.GB32092@ovro.caltech.edu>
References: <1266860439-17352-1-git-send-email-steve@digidescorp.com>
	<Pine.LNX.4.64.1002222123350.4120@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.1002222123350.4120@axis700.grange>
Cc: Zhang Wei <zw@zh-kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org, "Steven J. Magnani" <steve@digidescorp.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 22, 2010 at 09:26:13PM +0100, Guennadi Liakhovetski wrote:
> On Mon, 22 Feb 2010, Steven J. Magnani wrote:
> 
> > diff -uprN a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > --- a/include/linux/dmaengine.h	2010-02-22 11:18:11.000000000 -0600
> > +++ b/include/linux/dmaengine.h	2010-02-22 11:18:30.000000000 -0600
> > @@ -31,6 +31,8 @@
> >   * if dma_cookie_t is >0 it's a DMA request cookie, <0 it's an error code
> >   */
> >  typedef s32 dma_cookie_t;
> > +#define DMA_MIN_COOKIE	1
> > +#define DMA_MAX_COOKIE	2147483647
> 
> Taking into account, that dma_cookie_t is 32 bits:
> 
> +#define DMA_MAX_COOKIE		((1 << 31) - 1)
> 

Steven,

After you take Guennadi's comment into acount, the rest of the patch
looks good. I'm sure I've never rolled the cookie around during testing.

Ira
