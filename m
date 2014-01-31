Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id 411312C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Feb 2014 10:25:03 +1100 (EST)
Message-ID: <52EC2F46.7000609@ovro.caltech.edu>
Date: Fri, 31 Jan 2014 15:18:30 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: "Moese, Michael" <michael.moese@men.de>
Subject: Re: PCIe Access - achieve bursts without DMA
References: <2DF74D4E746FF14C8697D5041AAE72D56A2B1420@MEN-EX2.intra.men.de>
 <1391208815.27142.38.camel@pasglop>
In-Reply-To: <1391208815.27142.38.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

>> I'm currently trying to benchmark access speeds to our PCIe-connected IP-cores
>> located inside our FPGA. On x86-based systems I was able to achieve bursts for
>> both read and write access. On PPC32, using an e500v2, I had no success at all
>> so far.

Whenever I want to benchmark PCI/PCIe performance I do the
following tests;

1. Peripheral board DMA (board-to-board)

    Use two of your FPGA boards in a chassis and DMA between them.

    In a PCI system, you can put the cards on the same bus segment and
    then between a bridge and see how that affects things. In your case,
    the PCIe traffic will all be via the root-complex/switch, so
    you should get the same performance regardless of which PCIe slot
    you use.

    This is likely the "best you can do" as far as bursts go.

2. Peripheral board DMA to host memory.

    In this case I typically insmod a simple driver on the host that
    gives me a page of memory, and then DMA into and out of that
    memory, using the DMA controller on the peripheral.

3. Host (root complex) DMA.

    If your host has a DMA controller, then program it per (2).

As far as "verification" of your custom peripheral board FPGA IP is
concerned, if I was a customer, and you had data for (1) and (2),
I'd be pretty happy (and could care less about (2), since its so
system dependent).

Since its an FPGA-based IP. I'd also expect to see a PCIe simulation
with Bus Functional Models showing what the optimal performance of
your IP was, and then how it nicely matches with the measurements
in (1). If you do not have a PCIe logic analyzer, both Xilinx and
Altera have Chipscope/SignalTap logic analyzers that can be used
for tracing traffic at the TLP layer inside the FPGA.

Just some thoughts ...

Cheers,
Dave
