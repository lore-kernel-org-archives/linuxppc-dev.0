Return-Path: <thunderbird2k@gmail.com>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.147])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 09846B7171
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 01:48:13 +1000 (EST)
Received: by ey-out-1920.google.com with SMTP id 5so157562eyb.50
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 08:48:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A37A740.1090501@oxtel.com>
References: <4A37A740.1090501@oxtel.com>
Date: Tue, 16 Jun 2009 17:48:10 +0200
Message-ID: <c8485d470906160848j6f6dab58yfe3343ee69288387@mail.gmail.com>
Subject: Re: PowerPC PCI DMA issues (prefetch/coherency?)
From: Roderick Colenbrander <thunderbird2k@gmail.com>
To: Chris Pringle <chris.pringle@oxtel.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Chris,

The last couple of months I had the 'pleasure' to work with a Xilinx
ML510 ATX board which contains a Virtex-5 FXT. In my case I had to set
up the plbv46 pci soft-core to function properly with PCI add-on
boards and onboard pci devices. I have had a lot of issues including
ones with DMA but in the end it worked properly. I'm not sure how in
your case the Virtex-5 is wired to the PCI bus but in my case it was
connected to the crossbar switch of the PowerPC 440 which is inside
the Virtex-5 FXT. Not all Xilinx reference designs were interfaced
properly to this (sometimes the MPLB->SPLB connection from the
soft-core to the crossbar wasn't connected) and even then the PCI
soft-core wasn't configured properly by Xilinx and this MIGHT be
similar to your issue.

In the explanation of the issue I will use the terminology used by
Xilinx. The CPU side is the 'IPIF' side and the and the PCI side is
the 'PCI' side. Both domains have their own address domains and hence
translation from IPIFtoPCI and PCItoIPIF is needed. From what I
understood is that the 'incoming window' (ipif->pci) and outgoing
window (pci>ipif) should use different address ranges else the bridge
gets confused. I don't have access to my design right now but by head
Xilinx doesn't set C_IPIFBAR2PCIBAR_0 properly in a lot of cases and
just sets it to 0. Which means that cpu -> ipif (lets say the soft
core is accessible from 0xa0000000 from the cpu) 0xa0001234 translates
to 0x00001234 on the PCI side but PCI cards expect that when they
write low memory addresses that they write to system memory. What
should be done is to set C_IPIFBAR2PCIBAR_0 to 0xa0000000 in this
case, so that the incoming window is 0xa0000000-0xffffffff
and the outgoing window 0x00000000-0x9fffffff or just set it half way
at 0x80000000.

I'm not saying this is your issue but it could be it.

Regards,
Roderick Colenbrander


On Tue, Jun 16, 2009 at 4:08 PM, Chris Pringle<chris.pringle@oxtel.com> wrote:
> Hello All
>
> We're developing on a Freescale MPC8272 and are having some nasty problems
> with PCI bus mastering and data corruption.
>
> We have some custom hardware that is bus mastering, reading data from the
> CPUs memory for it's own use. Most of the time, the data is correct, however
> occasionally we are seeing data that appears to be from somewhere else in
> memory (usually memory that has already been read by the PCI device). The
> problem looks like stale data on the PCI bridge prefetch buffers or a cache
> coherency problem, but we've been unable to come up with a solution to our
> problem. It is my understanding that it shouldn't be a cache coherency
> problem as the CPU cache should be snooped as the data is read from memory.
> Even if it were an issue, the pci_map_sg* functions should have sorted out
> any cache coherency issues before the DMA operation started.
>
> I've not been able to find anything on the Freescale data sheet that
> provides any way of flushing the prefetch cache on the PCI bridge. We've
> done a bit of experimenting, and found that turning off prefetch appears to
> solve (or possibly mask?) the problem (at the expensive of massive
> performance problems). I've also tried DMA'ing two adjacent userspace
> buffers in memory (from the same page), and see corruption on the second
> buffer. If I populate both buffers, then DMA them both, the data is fine. If
> I populate the first, DMA the first, then populate the second and DMA the
> second, corruption occurs at the start of the second buffer. If I add 8-32
> bytes of padding between the buffers, the problem goes away.
>
> The PCI spec says that the PCI bridge is supposed to flush any data from
> it's prefetch buffers that are not read by the bus master, so technically,
> this isn't supposed to happen.
>
> I've tried making sure that buffers are cache line (and page) aligned, and
> are multiples of cache lines, but it's made no difference. PIO mode works
> fine, and I've checked the data with the CPU just before, and immediately
> after the DMA and the driver sees no data integrity issues. There are memory
> write barriers just before the DMA start, so all the registers should be
> correct before the DMA starts.
>
> For background info, the device doing the bus mastering is a Xilinx Virtex 5
> FPGA. We've monitored the data as it comes off the PCI bus using ChipScope -
> so the firmware should not be manipulating the data in any way.
>
> We have some hardware/firmware/drivers that has a lot of common code that
> runs on an x86 platform (as opposed to powerpc), and that works without any
> issues whatsoever.
>
> Has anyone got any ideas what this might be? Does anyone of know issues with
> PCI bridges on the PowerPC platform? Is there extra things that need to be
> done from the driver when DMAing on PowerPC (I've looked at other drivers
> and there's nothing obvious). The chip errata doesn't have anything on it
> that looks like it could cause this.
>
> I'm really hoping this is something that we're doing wrong in the driver or
> the firmware, but we've been through both the firmware and drivers countless
> times and are unable to see anything wrong.
>
> Any thoughts/ideas would be much appreciated!
>
> Regards,
> Chris
>
> --
>
> ______________________________
> Chris Pringle
> Software Engineer
>
> Miranda Technologies Ltd.
> Hithercroft Road
> Wallingford
> Oxfordshire OX10 9DG
> UK
>
> Tel. +44 1491 820206
> Fax. +44 1491 820001
> www.miranda.com
>
> ____________________________
>
> Miranda Technologies Limited
> Registered in England and Wales CN 02017053
> Registered Office: James House, Mere Park, Dedmere Road, Marlow, Bucks, SL7
> 1FJ
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
