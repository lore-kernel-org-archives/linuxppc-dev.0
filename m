Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 45219DE2A0
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 10:31:34 +1100 (EST)
Date: Thu, 15 Jan 2009 15:31:31 -0800
From: Ira Snyder <iws@ovro.caltech.edu>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC v5] net: add PCINet driver
Message-ID: <20090115233131.GE9091@ovro.caltech.edu>
References: <20090107195052.GA24981@ovro.caltech.edu>
	<200901152222.55006.arnd@arndb.de>
	<20090115214056.GC9091@ovro.caltech.edu>
	<200901152353.25052.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200901152353.25052.arnd@arndb.de>
Cc: Jan-Bernd Themann <themann@de.ibm.com>, netdev@vger.kernel.org,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	shemminger@vyatta.com, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 15, 2009 at 11:53:24PM +0100, Arnd Bergmann wrote:
> On Thursday 15 January 2009, Ira Snyder wrote:
> > I do have mailboxes (two inbound, two outbound) which can generate
> > interrupts, as well as doorbell registers (one inbound, one outbound).
> > The doorbell register's bits are "write 1 to clear", and can only be
> > cleared by the opposite side.
> > 
> 
> Ok, in this case, you should be able to use one of these to implement
> the DMA complete interrupt, but adding an extra DMA transfer to the
> mailbox after each transfer that you want to get notified for.

Yep. I wouldn't have come up with that idea on my own, but it seems
obvious now :)

It seems a little strange to keep the DMA descriptors host memory (the
DMA controller will need to issue a PCI read to get them) but I guess
that is how real network cards work.

Thanks,
Ira
