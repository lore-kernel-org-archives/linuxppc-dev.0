Return-Path: <maximlevitsky@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id F12B1DDE9C
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 15:37:06 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so806460uge
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 22:37:05 -0700 (PDT)
From: Maxim Levitsky <maximlevitsky@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] synchronize_irq needs a barrier
Date: Sat, 20 Oct 2007 07:36:21 +0200
References: <1192670742.12879.5.camel@pasglop>
	<200710200624.58261.maximlevitsky@gmail.com>
	<1192856675.6745.5.camel@pasglop>
In-Reply-To: <1192856675.6745.5.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200710200736.22129.maximlevitsky@gmail.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	akpm <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 20 October 2007 07:04:35 Benjamin Herrenschmidt wrote:
> 
> > 1) some drivers use pci_disable_device(), and pci_enable_device().
> > should I use it too?
> 
> I generally don't do the former, and I would expect the late to be done
> by pci_restore_state() for you. pci_disable_device(), last I looked,
> only cleared the bus master bit though, which might be a good idea to
> do.
> 
> People in ACPI/x86 land, are there more good reasons to do one or the
> other ?
> 
> That reminds me that I volunteered to write a documentation on how
> drivers should do all that stuff at KS and didn't get to actually doing
> it yet. shame ... I'll try to start something asap.
> 
> > 2) I accidentally did this:
> > 	pci_set_power_state(pci_dev, pci_choose_state(pci_dev, state));
> > 	pci_save_state(pci_dev);
> > 
> > I somehow thought that this is correct, that I should save the pci config state
> > after the power-down, but now I know that it isn't correct.
> 
> Right, you need to do the save_state before the power down. You need to
> avoid pretty much any access to the device after the save state other
> than the pending set_power_state on resume.
> 
> > I now need to send a patch for dmfe.c network driver that has the same commands written by me.
> > (but it works perfectly anyway)
> 
> On x86 desktop... might have surprises on others.
> 
> > Is it possible to access pci configuration space in D3?
> 
> It's only really safe to access the PM register itself, though I suppose
> you should be able to walk the capability chain to do that. But I
> wouldnt recommend doing anything else.
> 
> > And lastly speaking of network drivers, one issue came to my mind:
> > most network drivars has a packet queue and in case of dmfe it is located in main memory,
> > and card does dma from it.
> 
> Note that the network stack nowadays does a fair bit of cleaning up for
> you before your suspend routine is called....
> > 
> > in .suspend I ignore that some packets may be in that queue, and I want
> > to ask, whenever there are better ways to do that.
> > 
> > 
> > this is my dmfe .suspend routine.
> > 
> > 	/* Disable upper layer interface */
> > 	netif_device_detach(dev);
> 

> 
> Looks allright on a quick glance appart from the bits we already
> discussed.


> 
> > I guess, everybody makes mistakes... :-)
> > 
> > Other network drivers has a bit more complicated .suspend/.resume routines, 
> > but I didn't see a driver waiting for output queue to finish
> 
> I think the network stack does that nowadays but we'll have to double
> check, that's based on what DaveM told me at KS.
> 
> Ben. 
> 
> 

Hi,

Thanks a lot.
I fix the order of calls in dmfe.c
and in saa7134-core.c.

I probably need to add this synchronize_irq() logic in dmfe.c too, but I probably do it later,
I think I am overestimating this race, since most drivers don't do dev->insuspend checks in IRQ handler.
Maybe even just use free_irq() after all....


Best regards,
	Maxim Levitsky
