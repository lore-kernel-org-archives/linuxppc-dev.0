Subject: Re: chip select initialization - mbx860
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <AD2F581BD7340A4C908AF1AFB066EA3B0E48F5@ntah901e.savan.com>
References: <AD2F581BD7340A4C908AF1AFB066EA3B0E48F5@ntah901e.savan.com>
Content-Type: text/plain
Message-Id: <1068637576.26055.306.camel@zambia.cambridgebroadband.com>
Mime-Version: 1.0
Date: 12 Nov 2003 11:46:17 +0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2003-11-11 at 15:35, Amit.Lubovsky@infineon.com wrote:
> Hi,
> I try to set up the qspan bridge on the mbx860 board and from my
> understanding
> I have to initialize chip select 2 to an address that will be used later by
> the cpu.
> Any idea how this should be done ?
> I use kernel 2.4  from www.denx.de
> Thanks,
> Amit.
>


Amit,

Here's some example code.  At the end reg is a pointer containing a
kernel virtual address, and it points at 0x100 bytes starting at
physical address PHYSADDR.  You will need to choose a PHYSADDR, and
modify the OR2 and BR2 settings (these registers are covered in the
MPC860UM.)

Alex

    // Get a usable virtual address corresponding to PHYSADDR
    if ((result = check_mem_region(PHYSADDR,0x100))) {
        printk(KERN_ERR "Error: memory already in use\n");
        return result;
    }

    request_mem_region(PHYSADDR,0x100,__FUNCTION__);

    // These are very relaxed timings - but who cares ;-|
    immap->im_memctl.memc_or2 = 0xff000ff4; barrier();
    immap->im_memctl.memc_br2 = PHYSADDR | 0x00000401; barrier();

    if ((regs = ioremap_nocache(PHYSADDR,0x100)) == NULL) {
        printk(KERN_ERR "Error: ioremap failed\n");
        return -EFAULT;
    }


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
