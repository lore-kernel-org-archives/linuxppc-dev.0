Message-ID: <20011114041633.4910.qmail@kunk.jriver.com>
Subject: Re: E15 Carolina Frame Buffer Driver for 2.4
To: linuxppc-dev@lists.linuxppc.org
Date: Tue, 13 Nov 2001 22:16:33 -0600 (CST)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


One caution:

When I was doing some testing of the driver this afternoon in X 3.3.6
repeatedly hitting the forced reload button on netscape while on the
netscape site killed my machine (hard freeze, no keyboard activity).

I'm not sure it's related to the driver because I'm running the
bleeding edge kernel as well but beware... I should be able to do
more testing on it on Thursday. As a precaution, I converted the
43p filesystem to EXT3, nice that EXT3 is in the 2.4 kernel.

A big difference between the ibm_e15 fb driver running on 2.4 as opposed
to 2.2 is that this code that tries to get the frame buffer base address
succeeds in 2.4 but failed (and was hacked to a "default address") in
2.2.

Could anyone more familiar with this machine take a look at the
frame buffer memory initialization below and see if anything looks
funny??


    retval = pci_read_config_dword(pcidev, PCI_BASE_ADDRESS_0, &fb_info.fb_phys_
membase);
.
.
.
/* THE FOLLOWING CODE GETS USED IN 2.2.X ONLY*/

   if (fb_info.fb_phys_membase == 0) {
        printk(KERN_WARNING "%s: No PCI linear framebuffer base address "
            " assigned to 864.\n", ibm_e15_name);
        printk(KERN_WARNING "%s: This is normal. Using default of 0x%08x.\n",
            ibm_e15_name, DEFAULT_VIDBASE);
        fb_info.fb_phys_membase = DEFAULT_VIDBASE;
        retval = pci_write_config_dword(pcidev, PCI_BASE_ADDRESS_0,
                fb_info.fb_phys_membase);
/* END OF 2.2.X ONLY CODE */
.
.
.
    }
    printk(KERN_INFO "%s: detected S3 864, linear frame buffer at 0x%08x\n",
        ibm_e15_name, fb_info.fb_phys_membase);

    fb_info.fb_phys_membase += isa_mem_base;

    device_present = 1;
    request_region(0x3c0, 32, "ibm_e15");
    fb_info.fb_virt_membase = (u32)ioremap(fb_info.fb_phys_membase, VIDSIZE);
    printk(KERN_INFO "Video ram virt base = %p\n", (char*)fb_info.fb_virt_membas
e);
    return;


Here are the values I get when the system comes up...

PCI: Probing PCI hardware
Fixup res 0 (200) of dev 00:0e.0: 2800000 -> c2800000
Fixup res 6 (7200) of dev 00:0e.0: c0000 -> c00c0000
IBM ID: 000000f7
Setting PCI interrupts for a "IBM PS830/PS850/7248 (Carolina)"
Relocating PCI address 20000000 -> 1000000
PCI:00:0b.0: Resource 0: 00001000-00001007 (f=101)
PCI:00:0e.0: Resource 0: c2800000-c2ffffff (f=200)
PCI:00:0c.0: Resource 0: 01000200-0100021f (f=101)
PCI:00:10.0: Resource 0: 01000000-010000ff (f=101)
.
.
.
IBM_E15: initializing
IBM_E15: detected S3 864, linear frame buffer at 0x02800000
Video ram virt base = f2800000
IBM_E15: Text console mode: 8 bit color depth
Console: switching to colour frame buffer device 80x30
fb0: IBM_E15 frame buffer device

Regards,
Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
