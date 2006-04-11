Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id EB5E967A62
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Apr 2006 13:16:15 +1000 (EST)
Message-ID: <443B1EE9.5030104@ovro.caltech.edu>
Date: Mon, 10 Apr 2006 20:13:45 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: "Howard, Marc" <Marc.Howard@KLA-Tencor.com>
Subject: Re: Create permanent mapping from PCI bus to region of physical memory
References: <91B22F93A880FA48879475E134D6F0BE026CD163@CA1EXCLV02.adcorp.kla-tencor.com>
	<443B0718.3050001@ovro.caltech.edu>
	<91B22F93A880FA48879475E134D6F0BE386FBC@CA1EXCLV02.adcorp.kla-tencor.com>
In-Reply-To: <91B22F93A880FA48879475E134D6F0BE386FBC@CA1EXCLV02.adcorp.kla-tencor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Marc,

> The periperal is an FPGA.  No, there is no internal processor;
> everything is coded in Verilog.
>
> Scatter/gather isn't a viable option because of this. 

Er, why not, its an FPGA, everything is possible :)

So you have a PCI core, since you are planning to write to
the host memory space, its a Bus Master PCI core.
Who's FPGA, Altera, Xilinx, or someone else?

> Additionally non-contiguous memory would reduce bandwidth 
> and increase FPGA design complexity. 

Not necessarily. If the target is using bus master DMA to
write to the host memory, then you can hit pretty close
to the bandwidth of the PCI bus. If you are DMAing in
big blocks, the overhead of a block change isn't too much.
I did tests with the 440EP using a DMA controller on an
adapter board and found that the PCI bridge in the 440EP
was the limiting factor, i.e., for a 33MHz 32-bit bus
with a potential for 132MB/s, the *best* you can do is
about 40MB/s since the bridge only accepts data in cache
line sizes before sending a retry to the target. I can
send you those results.

> The data must be contignuous because
> of these reasons and the need for the data to be randomly
> accessible from the outside using simple address arithmetic.

Randomly accessible from where; the host or an I/O interface
at the FPGA. The pages can be made to appear contiguous to
a host processor user-space process using the nopage callback
of the VMA.

> I realize this isn't a standard linux request but having
> fixed, linear memory is quite common in embedded apps.  There
> should be a way to create this mapping in the 440GX's hardware
> and I'm just looking for a system call (if there is one) to
> implement it.

Alas, this is one of the concessions one must make if you
want to use a processor that enables the MMU. However,
I don't see any fundamental limitation in the design
that would preclude a little extra work on the FPGA.
But, it does require additional Verilog to support
the flexibility. The long-term advantage is that you
don't have to provide a hack (eg. reserve a block of
high-memory under Linux).

So how about this concession. If Linux lets you alloc_pages
in 2MB max chunks, create 8 address decode regions on your
FPGA. Provide the host access to the 8 address registers.
When the Linux driver is installed, the driver alloc_pages
8 times and loads the PCI address of those regions into
the 8 registers.

On the FPGA side of things create a flat 16MB region, as
an address passes through a 2MB block, it changes the PCI
address it decodes to. So, your FPGA believes it has
a 16MB continuous block, and Linux can supply the memory
as 8 non-contiguous chunks. Back in user-space on Linux,
the nopage VMA call is used to map a page-at-a-time
and the 2MB regions appear as a 16MB contiguous region to
user-space. (There are probably other ways to make user
space see it as one block too)

Cheers
Dave
