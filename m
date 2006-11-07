Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[217.147.92.249])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3713667D30
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 07:49:10 +1100 (EST)
Date: Tue, 7 Nov 2006 20:48:53 +0000
From: Russell King <rmk-pci@arm.linux.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [RFC/PATCH 4/7] Powerpc MSI implementation
Message-ID: <20061107204853.GF9533@flint.arm.linux.org.uk>
References: <1162884080.585336.70559261997.qpush@cradle>
	<20061107072125.68E9F67CA7@ozlabs.org>
	<20061107200730.GY27140@parisc-linux.org>
	<20061107201436.GE9533@flint.arm.linux.org.uk>
	<20061107204432.GZ27140@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061107204432.GZ27140@parisc-linux.org>
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	"Eric W.Biederman" <ebiederm@xmission.com>,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S.Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 07, 2006 at 01:44:32PM -0700, Matthew Wilcox wrote:
> On Tue, Nov 07, 2006 at 08:14:36PM +0000, Russell King wrote:
> > On Tue, Nov 07, 2006 at 01:07:30PM -0700, Matthew Wilcox wrote:
> > > We have the per-irq void *chip_data; could this be the right place to
> > > keep it instead?  That way, it won't take up space in the pci_dev for
> > > devices which don't use MSI.
> > 
> > Bah.  chip_data is supposed to be __iomem.  I bet if you build ARM
> > with sparse it'll kick out lots of warnings as a result of that loss.
> 
> Erm, since when?  When I introduced it (back in January 2005 [1]), it
> was called handler_data and pointed to a struct which is chip-type
> dependent.

Since before the generic irq merge.  If I was more expert with git
I'd post a URL, but I'm not so I won't.  But I'm sure you can find
it - look at the history of include/asm-arm/mach/irq.h.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
