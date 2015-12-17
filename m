Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 09D711A1BA4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Dec 2015 08:06:57 +1100 (AEDT)
Message-ID: <1450386414.2674.129.camel@redhat.com>
Subject: Re: [RFC PATCH 3/3] vfio-pci: Allow to mmap MSI-X table if EEH is
 supported
From: Alex Williamson <alex.williamson@redhat.com>
To: David Laight <David.Laight@ACULAB.COM>, Yongji Xie
 <xyjxie@linux.vnet.ibm.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: "nikunj@linux.vnet.ibm.com" <nikunj@linux.vnet.ibm.com>,
 "zhong@linux.vnet.ibm.com" <zhong@linux.vnet.ibm.com>, "aik@ozlabs.ru"
 <aik@ozlabs.ru>, "paulus@samba.org" <paulus@samba.org>,
 "warrier@linux.vnet.ibm.com" <warrier@linux.vnet.ibm.com>
Date: Thu, 17 Dec 2015 14:06:54 -0700
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CBEF1BC@AcuExch.aculab.com>
References: <1449823994-3356-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1449823994-3356-4-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1450296869.2674.62.camel@redhat.com>
 <063D6719AE5E284EB5DD2968C1650D6D1CBEF1BC@AcuExch.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-12-17 at 10:08 +0000, David Laight wrote:
> > The MSI-X table is paravirtualized on vfio in general and interrupt
> > remapping theoretically protects against errant interrupts, so why
> > is
> > this PPC64 specific? We have the same safeguards on x86 if we want
> > to
> > decide they're sufficient. Offhand, the only way I can think that a
> > device can touch the MSI-X table is via backdoors or p2p DMA with
> > another device.
> 
> Is this all related to the statements in the PCI(e) spec that the
> MSI-X table and Pending bit array should in their own BARs?
> (ISTR it even suggests a BAR each.)
> 
> Since the MSI-X table exists in device memory/registers there is
> nothing to stop the device modifying the table contents (or even
> ignoring the contents and writing address+data pairs that are known
> to reference the CPUs MSI-X interrupt generation logic).
> 
> We've an fpga based PCIe slave that has some additional PCIe slaves
> (associated with the interrupt generation logic) that are currently
> next to the PBA (which is 8k from the MSI-X table).
> If we can't map the PBA we can't actually raise any interrupts.
> The same would be true if page size is 64k and mapping the MSI-X
> table banned.
> 
> Do we need to change our PCIe slave address map so we don't need
> to access anything in the same page (which might be 64k were we to
> target large ppc - which we don't at the moment) as both the
> MSI-X table and the PBA?
> 
> I'd also note that being able to read the MSI-X table is a useful
> diagnostic that the relevant interrupts are enabled properly.

Yes, the spec requirement is that MSI-X structures must reside in a 4k
aligned area that doesn't overlap with other configuration registers
for the device.  It's only an advisement to put them into their own
BAR, and 4k clearly wasn't as forward looking as we'd hope.  Vfio
doesn't particularly care about the PBA, but if it resides in the same
host PAGE_SIZE area as the MSI-X vector table, you currently won't be
able to get to it.  Most devices are not at all dependent on the PBA
for any sort of functionality.

It's really more correct to say that both the vector table and PBA are
emulated by QEMU than paravirtualized.  Only PPC64 has the guest OS
taking a paravirtual path to program the vector table, everyone else
attempts to read/write to the device MMIO space, which gets trapped and
emulated in QEMU.  This is why the QEMU side patch has further ugly
hacks to mess with the ordering of MemoryRegions since even if we can
access and mmap the MSI-X vector table, we'll still trap into QEMU for
emulation.

How exactly does the ability to map the PBA affect your ability to
raise an interrupt?  I can only think that maybe you're writing PBA
bits to clear them, but the spec indicates that software should never
write to the PBA, only read, and that writes are undefined.  So that
would be very non-standard, QEMU drops writes, they don't even make it
to the hardware.  Thanks,

Alex
