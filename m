Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 47D9E67BC8
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 08:40:32 +1000 (EST)
Subject: Re: pci_set_power_state() failure and breaking suspend
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
In-Reply-To: <453DFBFF.8040001@s5r6.in-berlin.de>
References: <1161672898.10524.596.camel@localhost.localdomain>
	<1161675611.10524.598.camel@localhost.localdomain>
	<453DCB17.6050304@s5r6.in-berlin.de>
	<1161678557.10524.602.camel@localhost.localdomain>
	<453DFBFF.8040001@s5r6.in-berlin.de>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 08:40:16 +1000
Message-Id: <1161729616.10524.657.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux1394-devel@lists.sourceforge.net,
	Linux Kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-10-24 at 13:41 +0200, Stefan Richter wrote:
> Benjamin Herrenschmidt wrote:
> > Well, the question is wether we want to make the whole machine suspend
> > fail because there is a 1394 chip that doesn't do PCI PM in or not...
> > 
> > I can send patches "fixing" it both ways (just ignoring the result from
> > pci_set_power_state in general, or just ignoring that result on Apple
> > cells).
> 
> Yes, what would be the correct way to do this? And if it the latter
> option, should that be implemented in ohci1394 or in pci_set_power_state?
> 
> grep says that almost nobody checks the return code of
> pci_set_power_state. But e.g. usb/core/hcd-pci.c does...

Yes, and I think that's bogus too ...

> (Side note: The sole function that ohci1394's suspend and resume hooks
> fulfill right now in mainline is to change power consumption of the
> chip. The IEEE 1394 stack as a whole does not survive suspend + resume
> yet. A still incomplete solution is in linux1394-2.6.git.)
