Message-ID: <393D5996.4004845C@embeddededge.com>
Date: Tue, 06 Jun 2000 16:05:42 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Murray Jensen <Murray.Jensen@cmst.csiro.au>
CC: Dan Malek <dan@netx4.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8xx MMU Table Walk Base (was Re: kernel crashes at
 InstructionTLBMiss )
References: <23333.960273068@msa.cmst.csiro.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Murray Jensen wrote:

> I use the linuxppc_2_3 bitkeeper repository at hq.fsmlabs.com as the
> base for my local changes.

This has not run correctly on the 8xx for quite some time.  It won't
boot since the addition of the IBM403 changes.

> .... (including the I/O mappings, which are different
> to the MBX in that they reside in the lower half of the address space which
> required me to use ioremap() correctly by setting ioremap_base and saving
> its return value and using this to access my devices) and some other minor
> changes, which I believe are not relevant.

Not again......Did you read any of my past postings about memory
mapping on the 8xx?  You can't change ioremap_base, and any memory
mapping change is highly relevant.

> I checked this out again, and one other change was moving most of the code
> at _start in head_8xx.S


Oh geeze.....Let me quickly paraphrase what I have written in the past.
You should not be changing _any_ code in head_8xx.S.  This code will
minimally map some memory and the IMMR.  This is all that is required
to boot the kernel into further initialization functions.  If there
are some devices that you must use early (such as board control/status
registers), you ioremap() these in arch/ppc/mm/init.c.  These physical
hardware addresses must reside outside of the user and kernel text/data
virtual addresses.


> ..... to after the exception handlers because the extra
> mappings required for the Cogent devices caused this code to exceed 0x100
> bytes.

All of this mapping should be done inside of the device drivers, not
part of the early kernel initialization.

> These are all 2.2.x, no? I believe I need 2.[34].x because I want to use
> the latest RT-Linux stuff eventually, which only works with the 2.3.x, or
> later, kernels.

Yes, but 2.4.xx doesn't work right now.  I am trying to get that
working among other things.  You have to back up to a much older
version of 2.3.xx if you want to use this baseline right now.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
