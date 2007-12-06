Return-Path: <greg@kroah.com>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8714ADDDF9
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 18:34:48 +1100 (EST)
Date: Wed, 5 Dec 2007 22:39:40 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] pci: Fix bus resource assignment on 32 bits with 64b
	resources
Message-ID: <20071206063940.GA16474@kroah.com>
References: <20071205064116.D849BDE10A@ozlabs.org>
	<1196911347.7033.15.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1196911347.7033.15.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 06, 2007 at 02:22:27PM +1100, Benjamin Herrenschmidt wrote:
> 
> On Wed, 2007-12-05 at 17:40 +1100, Benjamin Herrenschmidt wrote:
> > The current pci_assign_unassigned_resources() code doesn't work properly
> > on 32 bits platforms with 64 bits resources. The main reason is the use
> > of unsigned long in various places instead of resource_size_t.
> > 
> > This fixes it, along with some tricks to avoid casting to 64 bits on
> > platforms that don't need it in every printk around.
> > 
> > This is a pre-requisite for making powerpc use the generic code instead of
> > its own half-useful implementation.
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> > 
> > This version fixes some stupid warnings when using 32 bits resources
> 
>  ... and has warnings on 64 bits platforms... GRRRR
> 
> This whole issue of printk vs. resource_size_t is a terrible mess :-(
> 
> Part of the problem is that resource_size_t can be either u32 or u64..
> 
> that is  it can be either unsigned int, unsigned long or unsigned long
> long... and we have no way to reliably printk that.

We do this already just fine.  Take a look in the kernel, I think we
just always cast it to long long to be uniform.

> Any clever idea before I start pushing filthy macros up linux/types.h ?

I don't think any macros are needed.

thanks,

greg k-h
