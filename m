Message-ID: <3E45DB59.3563294@xilinx.com>
Date: Sat, 08 Feb 2003 20:38:49 -0800
From: "Peter Ryser" <Peter.Ryser@xilinx.com>
MIME-Version: 1.0
To: "Kerl John" <John.Kerl@avnet.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Low memory on Virtex-II Pro
References: <C08678384BE7D311B4D70004ACA37105111946A2@amer22.avnet.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John,

please correct me if I see this wrong but it looks like you are mixing up
MicroBlaze and PowerPC. The LMB is a bus that is only available on MicroBlaze.
Linux does not have support for MicroBlaze.

However, Linux works great on the PowerPC inside the Virtex-II Pro FPGA when
you map the main memory at address zero. When using EDK to build your system
just set the BASEADDR for the SDRAM to zero.

You might also want to be aware of the fact that the interrupt controller that
ships with EDK is different from the interrupt controller that ships with the
Xilinx ML300 board. If you build your system with EDK you will have to adapt
arch/ppc/kernel/xilinx_pic.c.

Regards,
- Peter


"Kerl, John" wrote:

> Hello all,
>
> There have been some recent posts about Linux & Virtex-II Pro
> (FPGA with PPC405 hard core).  & apparently people have it working.
>
> One question before I start, though:
>
> Of course the kernel starts at *virtual* address 0xc0000000, regardless
> of the processor.  But my understanding is that certain processors have
> zero-based *physical* addresses for RAM, and some don't -- x86 of course
> being an example of the former, and ARM being an example of the latter.
> I believe that PPC is an example of the former.  Certainly our MPC857T
> board, and all the other boards of which I'm aware, have RAM starting at
> physical address 0x00000000.
>
> Now, on our custom Virtex-II Pro board, with Xilinx EDK setup, there's a
> bit (the MSB) in the physical address that specifies whether a memory
> region is on the LMB bus or OPB bus.  We get to pick *which* bit, but
> there must be *a* bit set for the SDRAM.  The upshot is that our SDRAM
> starts at physical address 0xb0000000.  It can't be placed at address 0.
> And block RAM could be made low, but I can't see having megabytes of
> block RAM.
>
> So, I think I have to have the kernel at non-zero physical address
> with PPC405.
>
> Can anyone advise on success or failure of doing so?
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
