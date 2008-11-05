Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 93669DDDF0
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 06:18:44 +1100 (EST)
Date: Wed, 5 Nov 2008 11:18:41 -0800
From: Ira Snyder <iws@ovro.caltech.edu>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC v2] net: add PCINet driver
Message-ID: <20081105191841.GB31188@ovro.caltech.edu>
References: <20081029202027.GH12879@ovro.caltech.edu>
	<200811042123.03819.arnd@arndb.de>
	<20081104222927.GE4641@ovro.caltech.edu>
	<200811051419.53194.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200811051419.53194.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Stephen Hemminger <shemminger@vyatta.com>,
	Jan-Bernd Themann <THEMANN@de.ibm.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 05, 2008 at 02:19:52PM +0100, Arnd Bergmann wrote:
> On Tuesday 04 November 2008, Ira Snyder wrote:
> 
> > So, since interrupts are disabled while my interrupt handler is running,
> > I think I should be able to use spin_lock() and spin_unlock(), correct?
> 
> yes.
> 
> > But sparse gives me the following warning:
> > wqt.c:185:9: warning: context imbalance in 'wqt_interrupt': wrong count at exit
> > wqt.c:185:9:    context 'lock': wanted 0, got 1
> > 
> > If I'm using spin_lock_irqsave() and spin_lock_irqrestore() I do not get
> > the same warnings. Therefore I must have some misunderstanding :)
> 
> 
> I've seen something like that before, I think it was a bug either in
> sparse or in the powerpc platform code. Try updating both the kernel
> and sparse and see if it still happens.
> 

Ok, I had the latest sparse, but I've been developing the host driver
against Ubuntu 8.04's kernel, which is based on 2.6.24. Using Linus' git
tree resolved the errors from sparse.

I ended up finding that the dma_mapping_error() API has changed, and so
I updated the driver for that. It should build against 2.6.28-rc now.
I'll post it in a little while.

Ira
