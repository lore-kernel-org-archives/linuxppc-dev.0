Message-Id: <4.2.2.20000308153704.00a601f0@mail.kerbango.com>
Date: Wed, 08 Mar 2000 15:53:16 -0800
To: Björn Lundberg <bjorn.lundberg@inu.se>,
        "linuxppc-embedded@lists.linuxppc.org"
  <linuxppc-embedded@lists.linuxppc.org>
From: Steve Calfee <calfee@kerbango.com>
Subject: Re: USB driver for MPC850/823
In-Reply-To: <38C61ED8.E77126FB@inu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 10:35 AM 3/8/00 +0100, Björn Lundberg wrote:

>The driver is developed under Malek's 2.2.5 for embedded PPC.
>Since the documentation has been a bit poor for the USB host mode, much
>had to be done with trial and error. Some of which is left in the
>source.
>Most changes are in new source files but some changes has been done in
>commproc.c and .h to support RISC timers and more DPRAM (microcode
>alert).
>For some reason I couldn't use USB buffers in SDRAM, only DPRAM!?
>As stated earlier on the list it's developed on an 850, but I haven't
>found anything that says it won't work on an 823.

I have started looking at your code to try understand some of the
roadblocks that I have hit. I have ISOC in/out working on the 823 USB. My
IN and OUT packets are from main system Dram. You dont say what the problem
was, but if the problem is; the data sent was garbage, not what you
prepared, the problem may be memory mapping. The CPM wants to access
physical memory addresses. You use a macro __pa for this, but I dont think
that works for all cases of user and kernel memory. I grepped and found:

#define PAGE_OFFSET     0xc0000000
#define __pa(x)                 ((unsigned long)(x)-PAGE_OFFSET)

Look at virt_to_phys(x); but that only does kmalloc'ed memory. There seems
to be many mapping macros/routines but I don't know if one works for ANY
virtual address to its physical address.

Does anyone have a pointer to a document that thoroughly describes memory
mapping, both for the x86 and the ppc?



Steve Calfee	--	embedded systems consultant
calfee@home.com
cell phone: (510) 468-5837
Kerbango phone: (408) 517-3355
home office ph: (510) 657-6039


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
