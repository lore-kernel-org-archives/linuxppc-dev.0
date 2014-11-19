Return-Path: <benh@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F46E1A012A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 07:51:52 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Thu, 20 Nov 2014 06:51:50 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 715C83578054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 07:51:47 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAJKpNcQ32112738
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 07:51:23 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAJKpkLn032369
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 07:51:46 +1100
Message-ID: <1416430300.5704.35.camel@au1.ibm.com>
Subject: Re: [PATCH V9 03/18] PCI: Add weak pcibios_iov_resource_size()
 interface
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 20 Nov 2014 07:51:40 +1100
In-Reply-To: <20141119172350.GC23467@google.com>
References: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1414942894-17034-4-git-send-email-weiyang@linux.vnet.ibm.com>
 <20141119011243.GA23467@google.com> <1416363332.5704.18.camel@au1.ibm.com>
 <20141119032100.GA7105@richard> <20141119042601.GB23467@google.com>
 <20141119092740.GA12872@richard> <20141119172350.GC23467@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com,
 Donald Dutile <ddutile@redhat.com>, Myron Stowe <myron.stowe@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-11-19 at 10:23 -0700, Bjorn Helgaas wrote:
> 
> Yes, I've read that many times.  What's missing is the connection between a
> PE and the things in the PCI specs (buses, devices, functions, MMIO address
> space, DMA, MSI, etc.)  Presumably the PE structure imposes constraints on
> how the core uses the standard PCI elements, but we don't really have a
> clear description of those constraints yet.

Right, a "PE" is a HW concept in fact in our bridges, that essentially is
a shared isolation state between DMA, MMIO, MSIs, PCIe error messages,...
for a given "domain" or set of PCI functions.

The techniques of how the HW resources are mapped to PE and associated
constraints are slightly different from one generation of our chips to
the next. In general, P7 follows an architecture known as "IODA" and P8
"IODA2". I'm trying to get that spec made available via OpenPower but
that hasn't happened yet.

In this case we mostly care about IODA2 (P8), so I'll give a quick
description here. Wei, feel free to copy/paste that into a bit of doco
to throw into Documentation/powerpc/ along with your next spin of the patch.

The concept of "PE" is a way to group the various resources associated
with a device or a set of device to provide isolation between partitions
(ie. filtering of DMA, MSIs etc...) and to provide a mechanism to freeze
a device that is causing errors in order to limit the possibility of
propagation of bad data.

There is thus, in HW, a table of "PE" states that contains a pair of
"frozen" state bits (one for MMIO and one for DMA, they get set together
but can be cleared independently) for each PE.

When a PE is frozen, all stores in any direction are dropped and all loads
return all 1's value. MSIs are also blocked. There's a bit more state that
captures things like the details of the error that caused the freeze etc...
but that's not critical.

The interesting part is how the various type of PCIe transactions (MMIO,
DMA,...) are matched to their corresponding PEs.

I will provide a rought description of what we have on P8 (IODA2). Keep
in mind that this is all per PHB (host bridge). Each PHB is a completely
separate HW entity which replicates the entire logic, so has its own set
of PEs etc...

First, P8 has 256 PEs per PHB.

 * Inbound

For DMA, MSIs and inbound PCIe error messages, we have a table (in memory but
accessed in HW by the chip) that provides a direct correspondence between
a PCIe RID (bus/dev/fn) with a PE number. We call this the RTT.

 - For DMA we then provide an entire address space for each PE that can contains
two "windows", depending on the value of PCI bit 59. Each window can then be
configured to be remapped via a "TCE table" (iommu translation table), which has
various configurable characteristics which we can describe another day.

 - For MSIs, we have two windows in the address space (one at the top of the 32-bit
space and one much higher) which, via a combination of the address and MSI value,
will result in one of the 2048 interrupts per bridge being triggered. There's
a PE value in the interrupt controller descriptor table as well which is compared
with the PE obtained from the RTT to "authorize" the device to emit that specific
interrupt.

 - Error messages just use the RTT.

 * Outbound. That's where the tricky part is.

The PHB basically has a concept of "windows" from the CPU address space to the
PCI address space. There is one M32 window and 16 M64 windows. They have different
characteristics. First what they have in common: they are configured to forward a
configurable portion of the CPU address space to the PCIe bus and must be naturally
aligned power of two in size. The rest is different:

  - The M32 window:

    * It is limited to 4G in size

    * It drops the top bits of the address (above the size) and replaces them with
a configurable value. This is typically used to generate 32-bit PCIe accesses. We
configure that window at boot from FW and don't touch it from Linux, it's usually
set to forward a 2G portion of address space from the CPU to PCIe
0x8000_0000..0xffff_ffff. (Note: The top 64K are actually reserved for MSIs but
this is not a problem at this point, we just need to ensure Linux doesn't assign
anything there, the M32 logic ignores that however and will forward in that space
if we try).

    * It is divided into 256 segments of equal size. A table in the chip provides
for each of these 256 segments a PE#. That allows to essentially assign portions
of the MMIO space to PEs on a segment granularity. For a 2G window, this is 8M.

Now, this is the "main" window we use in Linux today (excluding SR-IOV). We
basically use the trick of forcing the bridge MMIO windows onto a segment
alignment/granularity so that the space behind a bridge can be assigned to a PE.

Ideally we would like to be able to have individual functions in PE's but that
would mean using a completely different address allocation scheme where individual
function BARs can be "grouped" to fit in one or more segments....

 - The M64 windows.

   * Their smallest size is 1M

   * They do not translate addresses (the address on PCIe is the same as the
address on the PowerBus. There is a way to also set the top 14 bits which are
not conveyed by PowerBus but we don't use this).

   * They can be configured to be segmented or not. When segmented, they have
256 segments, however they are not remapped. The segment number *is* the PE
number. When no segmented, the PE number can be specified for the entire
window.

   * They support overlaps in which case there is a well defined ordering of
matching (I don't remember off hand which of the lower or higher numbered
window takes priority but basically it's well defined).

We have code (fairly new compared to the M32 stuff) that exploits that for
large BARs in 64-bit space:

We create a single big M64 that covers the entire region of address space that
has been assigned by FW for the PHB (about 64G, ignore the space for the M32,
it comes out of a different "reserve"). We configure that window as segmented.

Then we do the same thing as with M32, using the bridge aligment trick, to
match to those giant segments.

Since we cannot remap, we have two additional constraints:

  - We do the PE# allocation *after* the 64-bit space has been assigned since
the segments used will derive directly the PE#, we then "update" the M32 PE#
for the devices that use both 32-bit and 64-bit spaces or assign the remaining
PE# to 32-bit only devices.

  - We cannot "group" segments in HW so if a device ends up using more than
one segment, we end up with more than one PE#. There is a HW mechanism to
make the freeze state cascade to "companion" PEs but that only work for PCIe
error messages (typically used so that if you freeze a switch, it freezes all
its children). So we do it in SW. We lose a bit of effectiveness of EEH in that
case, but that's the best we found. So when any of the PEs freezes, we freeze
the other ones for that "domain". We thus introduce the concept of "master PE"
which is the one used for DMA, MSIs etc... and "secondary PEs" that are used
for the remaining M64 segments.

We would like to investigate using additional M64's in "single PE" mode to
overlay over specific BARs to work around some of that, for example for devices
with very large BARs (some GPUs), it would make sense, but we haven't done it
yet.

Finally, the plan to use M64 for SR-IOV, which we describe a bit already, consists
of using those M64's. So for a given IOV BAR, we need to effectively reserve the
entire 256 segments (256 * IOV BAR size) and then "position" the BAR to start at
the beginning of a free range of segments/PEs inside that M64.

The goal is of course to be able to give a separate PE for each VF...

I hope that helps clarifying things a bit ...

Cheers,
Ben.
