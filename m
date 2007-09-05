Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BF234DDF8E
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 06:13:49 +1000 (EST)
Date: Wed, 5 Sep 2007 22:12:17 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: Sleep problems with kernels >= 2.6.21 on powerpc
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20070905124411.bc15f48c.akpm@linux-foundation.org>
Message-ID: <tkrat.29a16d2ec8698ff2@s5r6.in-berlin.de>
References: <6540c930708251937o2a9a23efv72a0f2b8947067bd@mail.gmail.com>
	<6bffcb0e0708261621q25316becqce7b3ae2176f45a8@mail.gmail.com>
	<20070827065246.GA21220@ime.usp.br> <46D279E8.10001@edge.ping.de>
	<46D72BC6.3020809@edge.ping.de>
	<20070905100754.57ab4e3e.akpm@linux-foundation.org>
	<46DEEBBE.4070201@s5r6.in-berlin.de>
	<20070905124411.bc15f48c.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Cc: michal.k.k.piotrowski@gmail.com, rbrito@gmail.com, krh@redhat.com,
	linux-kernel@vger.kernel.org, rjw@sisk.pl,
	linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org,
	linux-pm@lists.linux-foundation.org, rael@edge.ping.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On  5 Sep, Andrew Morton wrote:
>> On Wed, 05 Sep 2007 19:47:42 +0200 Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
>> >>> Trying to free already-free IRQ 40
>> >>> pci_set_power_state(): 0002:20:0e.0: state=3, current state=5
>> >>> firewire_ohci: pci_set_power_state failed with -22<3>pci_device_suspend(): pci_suspend+0x0/0x9c [firewire_ohci]() returns -22
...
>> The old ohci1394.c used to ignore pci_set_power_state's return value.
>> In the pre 2.6.19-rc1 commit ea6104c22468239083857fa07425c312b1ecb424, I
>> added a fail-on-error.  This was toned down to a printk-on-err by pre
>> 2.6.19-rc4 commit 346f5c7ee7fa4ebee0e4c96415a7e59716bfa1d0.
> 
> OK.
> 
>> This was because of Benjamin Herrenschmidt's regression report:
>> http://lkml.org/lkml/2006/10/24/13
> 
> It's not clear _why_ pci_set_power_state() is failing.

The only -22 error path in pci_set_power_state is this:

	/* Validate current state:
	 * Can enter D0 from any state, but if we can only go deeper 
	 * to sleep if we're already in a low power state
	 */
	if (state != PCI_D0 && dev->current_state > state) {
		printk(KERN_ERR "%s(): %s: state=%d, current state=%d\n",
			__FUNCTION__, pci_name(dev), state, dev->current_state);
		return -EINVAL;
	} [...else...]

(There seems to be one "if" too many in the comment.)


dev->current_state was PCI_UNKNOWN, and this is not properly handled by
pci_set_power_state.  Some checks later, there is

	switch (dev->current_state) {
	case PCI_D0:
	case PCI_D1:
	case PCI_D2:
		pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
		pmcsr |= state;
		break;
	case PCI_UNKNOWN: /* Boot-up */
		if ((pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D3hot
		 && !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
			need_restore = 1;
		/* Fall-through: force to D0 */
	default:
		pmcsr = 0;
		break;
	}

But the PCI_UNKNOWN branch will never be reached because of the if ()
clause quoted above.

Also, this FireWire controller here surely had left the boot-up phase
already long ago when the reporter tried to suspend the machine.
-- 
Stefan Richter
-=====-=-=== =--= --=-=
http://arcgraph.de/sr/
