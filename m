Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id A8CCBDDDEA
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Nov 2008 09:29:30 +1100 (EST)
Date: Tue, 4 Nov 2008 14:29:27 -0800
From: Ira Snyder <iws@ovro.caltech.edu>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC v2] net: add PCINet driver
Message-ID: <20081104222927.GE4641@ovro.caltech.edu>
References: <20081029202027.GH12879@ovro.caltech.edu>
	<200811041309.25869.arnd@arndb.de>
	<20081104173414.GB4641@ovro.caltech.edu>
	<200811042123.03819.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200811042123.03819.arnd@arndb.de>
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

On Tue, Nov 04, 2008 at 09:23:03PM +0100, Arnd Bergmann wrote:

Big snip.

> > 
> > I tried to make the locking do only what was needed. I just couldn't get
> > it correct unless I used spin_lock_irqsave(). I was able to get the
> > system to deadlock otherwise. This is why I posted the driver for
> > review, I could use some help here.
> > 
> > It isn't critical anyway. You can always use spin_lock_irqsave(), it is
> > just a little slower, but it will always work :)
> 
> I like the documenting character of the spinlock functions. E.g. if you
> use spin_lock_irq() in a function, it is obvious that interrupts are enabled,
> and if you use spin_lock() on a lock that requires disabling interrupts,
> you know that interrupts are already off.
>  

Ok, I've started addressing your comments. I'm having trouble with the
locking again. Let me see if my understanding is correct:

spin_lock_irqsave() disables interrupts and saves the interrupt state
spin_unlock_irqrestore() MAY re-enable interrupts based on the saved
flags

spin_lock_irq() disables interrupts, and always turns them back on when
spin_unlock_irq() is called

spin_lock_bh() disables softirqs, spin_unlock_bh() re-enables them

spin_lock() and spin_unlock() are just regular spinlocks


So, since interrupts are disabled while my interrupt handler is running,
I think I should be able to use spin_lock() and spin_unlock(), correct?

But sparse gives me the following warning:
wqt.c:185:9: warning: context imbalance in 'wqt_interrupt': wrong count at exit
wqt.c:185:9:    context 'lock': wanted 0, got 1

If I'm using spin_lock_irqsave() and spin_lock_irqrestore() I do not get
the same warnings. Therefore I must have some misunderstanding :)

Thanks,
Ira
