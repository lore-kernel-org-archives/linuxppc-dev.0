Message-ID: <XFMail.990429180345.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <3727E20F.BC03ADD2@bwhitehead.com>
Date: Thu, 29 Apr 1999 18:03:45 +0100 (BST)
From: Gary Thomas <gdt@linuxppc.org>
To: Bill Whitehead <parman@bwhitehead.com>
Subject: RE: help with bootup code
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 29-Apr-99 Bill Whitehead wrote:
> 
> I am just learning Linux and hope to port it to a custom platform using
> older I/O chipsets(W83c553 and 87307). Basically the system consists of
> a 603/MPC106 with 64M sdram, PCI to ISA and IDE interface(W83c553), and
> I/O controller(87307). I believe the basic system is already supportted
> by Linux but support for I/O chipsets must be added. I am using LinuxPPC
> 4.1 while waiting for release 5.
> 
> I can load the compiled kernel into high memory and jump to head.S.
> 
> I have traced the boot code(arch/ppc/boot) and think I understand the
> relocate, vga_init, and decompress code but am unable to determine where
> the input is coming from when fill_inbuf() is called. It gets input from
> an array(input_data[]?) but I can't find where the data is assigned to
> that array. I don't see an open call, a pointer assignment, or a memcpy
> to draw data from. The kernel isn't running yet so Linux device drivers
> aren't supplying the data.
> 
> The code is something like "if ( data_ptr < buffer_size) {
> data_inbuf[data_ptr] = input_data[offset]; data_ptr++;}". I am sorry but
> I don't have the code accessible at the moment. If this is too confusing
> to answer, I will re-submit it tomorrow evening when the source code
> listings will be available. I check the list in the evening and am
> trying to get feedback as soon as possible.
> 

This unpacking magic is aided by the kernel build process.  The details
differ depending on the kernel version (2.0.XX is different from 2.1.XX
and 2.2.XX).  The basic idea is that the top level makfile (in /usr/src/linux)
builds a file 'vmlinux' which gets compressed and packed into that array.
Then there is some 'make' magic that puts that together with the bootup
code.

The code you're looking at above deals with the actual unpacking/uncompressing
of the data.  The kernel is uncompressed from the relocated image into low
memory by this process.  Once it's all uncompressed, the bootstrap passes
some data to it and jumps into it to start the kernel.

Hope this helps.

------------------------------------------------------------------------
Gary Thomas                              |
email: gdt@linuxppc.org                  | "Fine wine is a necessity of
   ... opinions expressed here are mine  |        life for me"
       and no one else would claim them! |
                                         |      Thomas Jefferson
------------------------------------------------------------------------



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
