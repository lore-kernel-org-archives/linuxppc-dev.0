Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 1723667A67
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Mar 2005 15:18:39 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 30 Mar 2005 22:18:37 -0700
To: linuxppc-embedded@ozlabs.org
Message-ID: <20050331051837.GA31822@xyzzy>
References: <20050331000521.GA22041@xyzzy>
	<20050331010747.GA18254@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050331010747.GA18254@gate.ebshome.net>
Subject: Re: [PATCH 2.6.10-rc2] ppc32: Add usb support to IBM stb04xxx
	platforms including Redwood5
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Mar 30, 2005 at 05:07:47PM -0800, Eugene Surovegin wrote:
> On Wed, Mar 30, 2005 at 05:05:21PM -0700, Dale Farnsworth wrote:
> 
> [snip]
> 
> > +/* Power up the USB subsection */
> > +static int enable_usb(struct platform_device *pdev)
> > +{
> > +	u32 mask;
> > +
> > +	mask = 1 << (31 - USB0_IRQ);
> > +	mtdcr(DCRN_UIC_PR(UIC0), mfdcr(DCRN_UIC_PR(UIC0)) | mask);
> > +	mtdcr(DCRN_UIC_TR(UIC0), mfdcr(DCRN_UIC_TR(UIC0)) & ~mask);
> > +	return 0;
> > +}
> > +
> > +/* Power down the USB subsection */
> > +static void disable_usb(struct platform_device *pdev)
> > +{
> > +	u32 mask;
> > +
> > +	mask = 1 << (31 - USB0_IRQ);
> > +	mtdcr(DCRN_UIC_PR(UIC0), mfdcr(DCRN_UIC_PR(UIC0)) & ~mask);
> > +	mtdcr(DCRN_UIC_TR(UIC0), mfdcr(DCRN_UIC_TR(UIC0)) | mask);
> > +}
> 
> Dale, I'm curious, what's going on here :) ?.
> 
> How changing polarity and triggering setting could power-down USB 
> unit? Some STB funkiness?

No.  It's brown paper bag time.  Looks bogus to me now, too.

Please ignore the patch.  I'll redo it and resubmit.

Thanks Eugene,
-Dale
