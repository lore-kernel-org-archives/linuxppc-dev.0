Return-Path: <randy.dunlap@oracle.com>
Received: from rgminet01.oracle.com (rgminet01.oracle.com [148.87.113.118])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 99F0ADDED4
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 03:30:25 +1000 (EST)
Date: Wed, 5 Sep 2007 10:28:24 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Sleep problems with kernels >= 2.6.21 on powerpc
Message-Id: <20070905102824.a481060c.randy.dunlap@oracle.com>
In-Reply-To: <20070905100754.57ab4e3e.akpm@linux-foundation.org>
References: <6540c930708251937o2a9a23efv72a0f2b8947067bd@mail.gmail.com>
	<6bffcb0e0708261621q25316becqce7b3ae2176f45a8@mail.gmail.com>
	<20070827065246.GA21220@ime.usp.br> <46D279E8.10001@edge.ping.de>
	<46D72BC6.3020809@edge.ping.de>
	<20070905100754.57ab4e3e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: debian-powerpc@lists.debian.org, michal.k.k.piotrowski@gmail.com,
	rbrito@gmail.com, linux-kernel@vger.kernel.org, rjw@sisk.pl,
	linuxppc-dev@ozlabs.org, Stefan Richter <stefanr@s5r6.in-berlin.de>,
	linux-pm@lists.linux-foundation.org, Tim Teulings <rael@edge.ping.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 5 Sep 2007 10:07:54 -0700 Andrew Morton wrote:

> > On 30 Aug 2007 22:42:46 +0200 "Tim Teulings" <rael@edge.ping.de> wrote:
> > Hello!
> > 
> > > I don't have traces at hand and due to lack of time cannot reproduce it 
> > > up to tomorrow. However this hint may speed up your analysis!
> > 
> > Sorry for the delay, but my desktop PC had an urgent hard disk problem I 
> > had to fix ASASP.
> > 
> > So here is the output from dmesg that suggested to me that firewire 
> > might be a problem:
> 
> Straightforward regression, two reporters, nothing happening.

(material for ksummit discussion, e.g.)

> > > usb_endpoint usbdev2.2_ep81: PM: suspend 0->2, parent 2-1:1.0 already 2
> > > usb_device usbdev1.1: PM: suspend 0->2, parent usb1 already 2
> > > usb_endpoint usbdev1.1_ep81: PM: suspend 0->2, parent 1-0:1.0 already 2
> > > hub 1-0:1.0: PM: suspend 2->2, parent usb1 already 2
> > > usb_endpoint usbdev1.1_ep00: PM: suspend 0->2, parent usb1 already 2
> > > eth2: Airport entering sleep mode
> > > eth0: suspending, WakeOnLan disabled
> > > pci_set_power_state(): 0002:20:0e.0: state=3, current state=5
> > > firewire_ohci: pci_set_power_state failed with -22<3>pci_device_suspend(): pci_suspend+0x0/0x9c [firewire_ohci]() returns -22
> > > suspend_device(): pci_device_suspend+0x0/0x98() returns -22
> > > Could not suspend device 0002:20:0e.0: error -22
> > > eth0: resuming
> > > PHY ID: 4061e4, addr: 0
> > > eth2: Airport waking up
> > > eth2: New link status: Connected (0001)
> > > hda: Enabling Ultra DMA 2
> > > eth0: Link is up at 100 Mbps, full-duplex.
> > > eth0: Pause is disabled
> > > ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> > > hdb: Enabling Ultra DMA 2
> > > usb_endpoint usbdev1.1_ep00: PM: resume from 0, parent usb1 still 2
> > > usb_endpoint usbdev1.1_ep81: PM: resume from 0, parent 1-0:1.0 still 2
> > > usb_device usbdev1.1: PM: resume from 0, parent usb1 still 2
> > > Driver sleep failed
> > > Sleep rejected by devices
> > > adb: starting probe task...
> > > adb devices: [2]: 2 c4 [3]: 3 1 [7]: 7 1f
> > > ADB keyboard at 2, handler 1
> > > ADB mouse at 3, handler set to 4 (trackpad)
> > > adb: finished probe task...
> > > usb_device usbdev1.1: PM: suspend 0->2, parent usb1 already 2
> > > usb_endpoint usbdev1.1_ep81: PM: suspend 0->2, parent 1-0:1.0 already 2
> > > hub 1-0:1.0: PM: suspend 2->2, parent usb1 already 2
> > > usb_endpoint usbdev1.1_ep00: PM: suspend 0->2, parent usb1 already 2
> > > eth2: Airport entering sleep mode
> > > eth0: suspending, WakeOnLan disabled
> > > Trying to free already-free IRQ 40
> > > pci_set_power_state(): 0002:20:0e.0: state=3, current state=5
> > > firewire_ohci: pci_set_power_state failed with -22<3>pci_device_suspend(): pci_suspend+0x0/0x9c [firewire_ohci]() returns -22
> 
> I grepped the whole tree for firewire_ohci and came up blank.  What is it?

See drivers/firewire/Makefile

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
