Date: Sun, 9 Feb 2003 21:13:39 +0100
From: Peter Vandenabeele <peter.vandenabeele@mind.be>
To: "Kerl, John" <John.Kerl@Avnet.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Low memory on Virtex-II Pro
Message-ID: <20030209211339.F25620@mind.be>
Reply-To: Peter Vandenabeele <peter.vandenabeele@mind.be>
References: <C08678384BE7D311B4D70004ACA37105111946A2@amer22.avnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C08678384BE7D311B4D70004ACA37105111946A2@amer22.avnet.com>; from John.Kerl@Avnet.com on Fri, Feb 07, 2003 at 02:56:30PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Feb 07, 2003 at 02:56:30PM -0700, Kerl, John wrote:
>
> Hello all,
>
> There have been some recent posts about Linux & Virtex-II Pro
> (FPGA with PPC405 hard core). & apparently people have it working

Yes.

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

What is your SDRAM controller ?

When we used the Xilinx SDRAM controller IP (softcore), it was easy
to remap the SDRAM physical base address to 0x00000000 in the .mhs
file (in the Xilinx EDK). We found this to be much less work than trying
to force the Linux kernel to boot from another address than 0x00000000.

Coreconnect PLB bus is what you want to use for off-chip memory
(OPB is low-speed peripherals).

Peter

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
