Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3F6E667A60
	for <linuxppc-dev@ozlabs.org>; Sat, 20 May 2006 09:00:52 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k4JN0mOr019633
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 19:00:48 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k4JN0mOK209260
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 19:00:48 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k4JN0mMM004404
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 19:00:48 -0400
Date: Fri, 19 May 2006 18:00:47 -0500
To: Srinivas Murthy <codevana@gmail.com>
Subject: Re: PPC host with a PCI root-complex
Message-ID: <20060519230047.GM12135@austin.ibm.com>
References: <7cb1293c0605181456p3c1726e2n56942dfbd4217f70@mail.gmail.com>
	<20060519162310.GI12135@austin.ibm.com>
	<7cb1293c0605191428n57c18a60h5b86863d729cd9b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7cb1293c0605191428n57c18a60h5b86863d729cd9b9@mail.gmail.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 19, 2006 at 02:28:29PM -0700, Srinivas Murthy wrote:
> 
> On a PPC (44x) platform, following an error such as parity error detected by
> the PCI root complex, should we cause a bus error (causing a machine-check
> exception) or complete the bus transaction normally but trigger a critical
> interrupt? Note that these are two diff types of interrupts as seen by the
> CPU with the machine check having the highest NMI priority.

I can't answer that question; I'd say that's a platform implementation
question that each platform has to decide on thier own.  If you have a 
recoverable machine check, and can take it and recover from it, then
I suppose that's a reasonable choice. But I've never dealt with that.

> If the parity error detection was a result of say a memory read operation by
> the core to a PCI device, there might be a several cycle diff between the
> read and the cpu being interrupted (with the critical interrupt handler).
> This may result in data corruption, etc. Is this a valid concern to have?

Yes. Sort of. Maybe. In the early days of getting pci error handling 
to work, it became clear that there were lots of pci devices with weak 
firmware or buggy hardware that were dma'ing to all sorts of wild adresses, 
and/or doing other bad things (mangled PCI split transactions, etc). 
We became painfully aware of this, because our pci bridges flagged any DMA 
to any page that hadn't been expressly mapped (as well as a bunch of
other PCI errors).  Seems that these devices had been busy corrupting
memory and whatever else for years, and no one noticed before, because 
no one had a stringent, error checking PCI bridge.  Is data corruption
important? Yes. Have you been living with it for years, and not noticing
it? Yes.

(Most of those I dealt with have been fixed, either in the Linux device
driver, the device firmware, or in one case, a hardware change, (I assume
some gate array fixup)).

> What is the normal approach to deal with this issue in an "enterprise" or
> high-end environment?

On IBM pSeries, the PCI-Host bridge stops the transaction; I don't know 
the details at the hardware level; I presume its some abort or termination.
In principle, the corrupted data never makes it to system memory or CPU.
If the CPU is reading, 0xffffffff is returned, as are all future reads. 
All writes are dropped on the floor.  DMA's are also cut off.  

On pSeries, there's no interrupt generated on error. Rather, if the 
device gets an unexpected 0xffffff on read, it can query the firmware 
for the PCI bridge state, and proceed from there.  Typical scenario 
is that an error occurred during DMA, long ago; the device driver gets 
a dma-complete interrupt from pci device, and discovers upon reading
that the device interrupt status register is all 0xffff... During 
recovery, that hunk of incomplete dma data is discarded. 

The point here is that its potentially OK to allow corrupted data into
systm memory, as long as its at the right address, and as long as the 
device driver can nuke it before it has gotten to other consumers. 
If you ar getting parity erorrs on DMA addresses, then ... :-) 

PCI Express does something else, and I don't quite understand what.
Part of thier mechanism involves an interrupt, although its somehow 
wired that on MMIO read, the interrupt gets to the CPU before the
MMIO read completes. Some chunk of it seems x86/itanium-centric.
The Intel guys have been trying to figure out how to implement this, 
but haven't done so yet.

--linas
