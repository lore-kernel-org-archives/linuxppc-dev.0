Message-ID: <3975B49B.54B85E4@raleigh.ibm.com>
Date: Wed, 19 Jul 2000 10:00:59 -0400
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: "Nikhil G. Daddikar" <ngd@routefree.com>,
        LinuxPPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Enabling Video on the IBM PowerPC 405GP walnut system
References: <397502B7.9FE5C6C8@routefree.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Nikhil,

I have video working on the Walnut board. By default, Open Bios leave
the PMM's mapped in this
manner.

PMM0 maps all memory references from processor memory 0x80000000 to PCI
memory 0x80000000.
PMM1 maps all memory references from processor memory 0xA0000000 to PCI
memory 0xA0000000.

This dictates that the isa_io_base is  0xa0000000.
Next, in arch/ppc/treeboot/main.c, one has to initialize the S3 card to
80x25 mode.  The base code for this located in
arch/ppc/boot but it will have to be modified.  This is because it
assumes a Motorola chip set
when it scans the PCI bus for video  cards.

Next, in arch/ppc/kernel/walnut_setup.c, you will have to add the code
for the vga console.
This should go in the function walnut_setup_arch.
#ifdef CONFIG_VGA_CONSOLE

     vgacon_remap_base = ioremap_nocache(0xa0000000, 0xc0000);
     conswitchp = &vga_con;
#endif

Also, you will have to added devices to your to /dev for the tty.

The keyboard, if you want it will have its functions mapped in the
function, walnut_init.
You will also have to modify the keyboard controller code to look at the
propper address of the keyboard.  I did this and it works perfectly.
The mouse will require either a second level interrupt driver or a
rework of the Altera code
to split the keyboard and mouse interrupts to separate interrupts.

The internet address for power PC support is
ppcsupp@us.ibm.com

Overall, these changes are not to bad.

Ralph "Chip" Blach
IBM MicroElectronics
RTP, NC



"Nikhil G. Daddikar" wrote:
>
> I have successfully booted up Monta Vista 6/29 linux kernel on this
> board. I  now want to get the video card to work. Any ideas/pointers
> would be helpful. Also, I think the address space is not configured
> correctly, can somebody confirm this?
> Thanks.
>
> /proc/pci reports :
> PCI devices found:
>   Bus  0, device   0, function  0:
>     Host bridge: PCI device 1014:0156 (IBM) (rev 1).
>       Master Capable.  Latency=12.  Max Lat=60.
>       Prefetchable 32 bit memory at 0x0 [0x7fffffff].
>   Bus  0, device   4, function  0:
>     VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 1).
>       IRQ 31.
>       Master Capable.  Latency=12.  Min Gnt=31.Max Lat=60.
>       Non-prefetchable 32 bit memory at 0x0 [0x3ffffff].
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
