Date: Mon, 3 Mar 2003 17:34:30 +0100
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: PrPMC800 NON-MONARCH Patch 
From: Anders Blomdell <anders.blomdell@control.lth.se>
To: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Message-Id: <01BBDD6E-4D96-11D7-BD61-0003931C2BFA@control.lth.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Finally I have a working PrPMC800 Linux for NON-MONARCH operations. The
attached patch is what is needed.

The content of the patch falls in three categories:

   1. PrPMC800 specific stuff (in files prpmc*, harrier*)
   2. Discontigous memory support (various files) and a gross hack in
      numa.c
   3. Making all network and PCI memory DMA-able, I did the changes at
      this low level since I found numerous places where GFP_DMA should
      be added to get things working, and on most systems all (or much)
      of the memory is DMA-able, thus nobody has experienced any problems
      before (arch/ppc/kernel/pci-dma.c, net/core/skbuff.c)


IMHO, supporting systems where DMA-able memory is small and not starting in
low memory is harder than it needs to be (and wastes memory, since memory
zones needs to be 2MB aligned). I think it would be easier to describe
memory layout with something like:

   typedef struct {
     void *start;
     unsigned long size;
     gfp_type kind;
   } memory_layout_t;

   memory_layout_t the_memory_layout = {
     { 0,         0x4000000, GFP_NORMAL },
     { 0x4000000, 0x100000,  GFP_DMA },
     ...

than it is to describe it as a number of memory nodes, each consisting of
GFP_NORMAL, GFP_DMA and GFP_HIGHMEM memory, and their associated holes to
make everything align to 2 MB (1 << PAGE_SHIFT << (MAX_ORDER -1))

Patch is available as:
   http://www.control.lth.se/~andersb/prpmc800/2003-03-03.patch

and something somewhat like ChangeLog entries is available as:
   http://www.control.lth.se/~andersb/prpmc800/patch_2003-03-03_description.
txt

Regards

Anders Blomdell

------------------------------------------------------------------------------
  Anders Blomdell
  Department of Automatic Control        Email: anders.blomdell@control.lth.
se
  Lund Institute of Technology           Phone: +46 46 222 4625
  Box 118, S-221 00 Lund, Sweden         Fax:   +46 46 138118


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
