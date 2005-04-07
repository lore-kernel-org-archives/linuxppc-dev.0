Return-Path: <wfarnsworth@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 596B367A2E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Apr 2005 02:05:50 +1000 (EST)
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Josh Boyer <jwboyer@jdub.homelinux.org>
In-Reply-To: <1112835532.6160.37.camel@jdub.homelinux.org>
References: <1112808085.24527.296.camel@rhino.az.mvista.com>
	<1112808669.24673.304.camel@rhino.az.mvista.com>
	<1112808814.24527.307.camel@rhino.az.mvista.com>
	<1112835532.6160.37.camel@jdub.homelinux.org>
Content-Type: text/plain
Message-Id: <1112889944.24527.325.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 07 Apr 2005 09:05:45 -0700
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 3/3] PPC440EP: MTD support for the Bamboo Board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2005-04-06 at 17:58, Josh Boyer wrote:
> On Wed, 2005-04-06 at 10:33 -0700, Wade Farnsworth wrote:
> 
> Cool beans.  Can't wait to test this out tomorrow.  Just a couple comments.
> 
> <snip>
> 
> > +struct ppc440ep_ndfc_regs {
> > +       uint cmd;
> > +       uint addr;
> > +       uint data;
> > +       uint reserved1;
> > +       uint ecc0;
> > +       uint ecc1;
> > +       uint ecc2;
> > +       uint ecc3;
> > +       uint ecc4;
> > +       uint ecc5;
> > +       uint ecc6;
> > +       uint ecc7;
> > +       uint b0cr;
> > +       uint b1cr;
> > +       uint b2cr;
> > +       uint b3cr;
> > +       uint cr;
> > +       uint sr;
> > +       uint hwctl;
> > +       uint reserved2;
> > +       uint revid;
> > +};
> 
> These ecc registers actually have a use...
> 
> <snip>
> 
> > +
> > +       /* Set address of NAND IO lines (Using Linear Data Access Region) */
> > +       this->IO_ADDR_R = (void __iomem *) ((ulong) bamboo_ndfc + 0x1000);
> > +       this->IO_ADDR_W = (void __iomem *) ((ulong) bamboo_ndfc + 0x1000);
> > +       /* Reference hardware control function */
> > +       this->hwcontrol  = bamboo_nand0_hwcontrol;
> > +       /* Set command delay time */
> > +       this->chip_delay = 12;
> > +       this->eccmode    = NAND_ECC_SOFT;
> > +       this->write_byte = bamboo_nand0_write_byte;
> > +       this->read_byte  = bamboo_nand0_read_byte;
> > +       this->write_buf  = bamboo_nand0_write_buf;
> > +       this->read_buf   = bamboo_nand0_read_buf;
> > +       this->verify_buf = bamboo_nand0_verify_buf;
> > +       this->dev_ready  = bamboo_dev_ready;
> 
> <snip>
> 
> > +       /* Link the private data with the MTD structure */
> > +       bamboo_nand1_mtd->priv = this;
> > +
> > +       /* Set address of NAND IO lines (Using Linear Data Access Region) */
> > +       this->IO_ADDR_R = (void __iomem *) ((ulong) bamboo_ndfc + 0x1000);
> > +       this->IO_ADDR_W = (void __iomem *) ((ulong) bamboo_ndfc + 0x1000);
> > +       /* Reference hardware control function */
> > +       this->hwcontrol  = bamboo_nand1_hwcontrol;
> > +       /* Set command delay time */
> > +       this->chip_delay = 25;
> > +       this->eccmode    = NAND_ECC_SOFT;
> > +       this->write_byte = bamboo_nand1_write_byte;
> > +       this->read_byte  = bamboo_nand1_read_byte;
> > +       this->write_buf  = bamboo_nand1_write_buf;
> > +       this->read_buf   = bamboo_nand1_read_buf;
> > +       this->verify_buf = bamboo_nand1_verify_buf;
> > +       this->dev_ready  = NULL;
> 
> ... so any reason why NAND_ECC_SOFT is used instead of making use of the
> ECC registers that come with the NDFC?

Mainly because I haven't looked at what it would take to get HW ECC
working yet.  I'll look at this when I have time, but until then at
least the NAND flashes are functional.

> 
> Overall, I think the patch looks good.  Care to send it to the MTD
> maintainers so it gets in their CVS tree?

Will do.

-Wade
