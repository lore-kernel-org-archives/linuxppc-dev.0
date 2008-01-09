Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5DA30DE031
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 03:18:55 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m09GIgHv001084
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 11:18:42 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m09GIg2d135798
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 11:18:42 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m09GIfP4021763
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 11:18:42 -0500
Date: Wed, 9 Jan 2008 10:18:26 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Subject: Re: PCI interrupt assignment on sequoia board
Message-ID: <20080109101826.51c6799c@zod.rchland.ibm.com>
In-Reply-To: <200801091653.22478.matthias.fuchs@esd-electronics.com>
References: <200801091653.22478.matthias.fuchs@esd-electronics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 9 Jan 2008 16:53:22 +0100
Matthias Fuchs <matthias.fuchs@esd-electronics.com> wrote:

> Hi,
> 
> I noticed that Josh's 'for-2.5.25' does not assign PCI interrupts correctly:
> 
> bash-3.00# lspci -v
> 00:00.0 Class 0680: 1014:027f
>         Subsystem: 10e8:cafe
>         Flags: bus master, medium devsel, latency 0, IRQ 16
>         Memory at <unassigned> (32-bit, prefetchable)
>         Capabilities: [58] Power Management version 2
> 
> 00:0a.0 Class 0b20: 1014:027f	(this is a PPC440EPx PCI target board in a sequoia PCI slot)
>         Subsystem: 12fe:0441
>         Flags: bus master, medium devsel, latency 128, IRQ 16
>         Memory at 0000000180000000 (32-bit, prefetchable) [size=64M]
>         Memory at 0000000184000000 (32-bit, prefetchable) [size=16M]
>         Capabilities: [58] Power Management version 2
> 
> 00:0c.0 Class 0200: 168c:0013 (rev 01)
>         Subsystem: 14b7:0a60
>         Flags: bus master, medium devsel, latency 128, IRQ 16
>         Memory at 0000000185000000 (32-bit, non-prefetchable) [size=64K]
>         Capabilities: [44] Power Management version 2
> 
> bash-3.00# uname -a
> Linux sequoia 2.6.24-rc6-g78994e24 #5 Wed Jan 9 16:22:31 CET 2008 ppc ppc ppc GNU/Linux
> 
> 
> All interrupts are '16'. But I expected 67 as correctly stated in the device tree.
> This test has been made with the uboot wrapper code.
> 
> Any idea?

Does lspci display the virtual IRQ number that is assigned when the
device tree is parsed and interrupts are mapped?  I think so.  If you
look at the other devices in /proc/interrupts you'll see they have the
virtual IRQ numbers as well.

josh
