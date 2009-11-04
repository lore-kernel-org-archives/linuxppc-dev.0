Return-Path: <john.p.price@l-3com.com>
Received: from smtp2out.l-3com.com (smtp2out.l-3com.com [166.20.51.112])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ironport2.l-3com.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0940AB7BA2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 Nov 2009 06:02:42 +1100 (EST)
From: john.p.price@l-3com.com
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: DMA to User-Space
Date: Wed, 4 Nov 2009 14:02:26 -0500
Message-ID: <B9639434CFA424438117913649CDB78710AF5CBA@MA_EXCHANGE.corp.sds.l-3com.com>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F03310302E2@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330F9DC29@midas.usurf.usu.edu><4AF0E4A0.30802@windriver.com>
	<BB99A6BA28709744BF22A68E6D7EB51F03310302E2@midas.usurf.usu.edu>
To: "Jonathan Haws" <Jonathan.Haws@sdl.usu.edu>,
	<Bo.Liu@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jonathan,  what kind of memory is fpga_drv.strmdata? memory from the
kernel stack, something you allocated?  You'll notice you were trying to
access location 0.

To use dma streaming memory you must call dma_map_single() to get the
physical address of fpga_drv.strmdata.  That memory must be contiguous.
Then you may call remap_pfn_range with the page offset of the physical
address returned from the dma_map_single() call.  Then when the cpu
accesses that region you must sync the region for with dma direction for
cpu or when the device needs to access it, for the device.

LDD3 seems a bit dated on this topic it says to use nopage instead of
remap_pfn_range(), in my experiments remap_pfn_range seemed ok.  I would
ask others on the list for their experience on the topic.

Ultimately I went with mapping user space provided address and
implementing dma with scatter-gather.


-----Original Message-----
From: linuxppc-dev-bounces+john.p.price=3Dl-3com.com@lists.ozlabs.org
[mailto:linuxppc-dev-bounces+john.p.price=3Dl-3com.com@lists.ozlabs.org]
On Behalf Of Jonathan Haws
Sent: Wednesday, November 04, 2009 12:40 PM
To: Bo.Liu@windriver.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: RE: DMA to User-Space

> Jonathan Haws wrote:
> > All,
> >
> > I have what may be an unconventional question:
> >
> > Our application consists of data being captured by an FPGA,
> processed, and transferred to SDRAM.  I simply give the FPGA an
> address of where I want it stored in SDRAM and it simply DMAs the
> data over and interrupts me when finished.  I then take that data
> and store it to disk.
> >
> > I have code in user space that handles all of the writing to disk
> nicely and fast enough for my application (I am capturing data at
> about 35-40 Mbytes/sec).
> >
> > My question is this:  is it possible to give a user-space pointer
> to the FPGA to DMA to?  It seems like I would have problems with
> alignment, address manipulation, and a whole slew of other issues.
> >
> > What would be the best way to accomplish something like that?  I
> want to handle all the disk access in user-space, but I do not want
> to have to copy 40 MB/s from kernel space to user-space either.
> >
> You can maintain a DMA buffer in kernel, then mmap to user space.
> And
> maybe you need some handshake between FPGA and the apps to balance
> input
> datas  with datas to disk.
> > I can maintain an allocated, DMA-safe buffer in kernel space if
> needed.  Can I simply get a user-space pointer to that buffer?  What
> calls are needed to translate addresses?
> >
> Use remap_pfn_range()  in your kernel DMA buffer manipulation driver
> .mmap() handler to export DMA  buffer address to user space.
>=20

Can you provide an example for how to do that?  I have an mmap routine
to map BARs that the FPGA maintains and I can access those, however when
I try to map the DMA buffer and access what is in it, the system
crashes.  Here is the mmap function I have right now:

/* fpga_mmap()
 *
 *  Description:
 *       The purpose of this function is to serve as a 'file_operation'
 *       which maps different PCI resources into the calling processes
 *       memory space.
 *
 *       NOTE:  The file offset are in page size; i.e.:
 *       offset 0 in process's mmap syscall -> BAR0
 *       offset 4096 in process's mmap syscall -> BAR1
 *       offset 8192 in process's mmap syscall -> BAR2
 *	   offset 12288 -> Streaming DMA buffer
 *
 *  Arguments:
 *       struct file             *filp -- struct representing an open
file
 *       struct vm_area_struct   *vma  -- struct representing memory
'segment'
 *
 *  Returns:
 *       int -- indication of success or failure
 *
 */
int fpga_mmap(struct file *filp, struct vm_area_struct *vma)
{
	struct pci_dev *dev;
	unsigned long addressToMap;
	uint8_t mapType =3D 0; /* 0 =3D IO, 1 =3D memory */

	/* Get the PCI device */
	dev =3D (struct pci_dev*)(filp->private_data);

	/* Map in the appropriate BAR based on page offset */
	if (vma->vm_pgoff =3D=3D FPGA_CONFIG_SPACE)
	{
		/* Map BAR1 (the CONFIG area) */
		printk(KERN_ALERT "FPGA: Mapping BAR1 (CONFIG BAR).\n");
		addressToMap =3D pci_resource_start(dev,
FPGA_CONFIG_SPACE);
		printk(KERN_ALERT "FPGA: PCI BAR1 (CONFIG BAR) Size ->
%#08x.\n",
			pci_resource_len(dev, FPGA_CONFIG_SPACE));
		mapType =3D 0;
	}
	else if(vma->vm_pgoff =3D=3D FPGA_TEST_SPACE)
	{
		/* Map BAR2 (the TEST area) */
		printk(KERN_ALERT "FPGA: Mapping BAR2 (TEST BAR).\n");
		addressToMap =3D (pci_resource_start(dev, FPGA_TEST_SPACE)
+
			pci_resource_len(dev, FPGA_TEST_SPACE)) -
FPGA_TEST_LENGTH;
		printk(KERN_ALERT "FPGA: PCI BAR2 (TEST BAR) Size ->
%#08x.\n",
			pci_resource_len(dev, FPGA_TEST_SPACE));
		mapType =3D 0;
	}
	else if(vma->vm_pgoff =3D=3D 3)
	{

		addressToMap =3D (unsigned long)&fpga_drv.strmData[0];
		mapType =3D 1;
	}
	else
	{
		printk(KERN_ALERT " FPGA: Invalid BAR mapping
specified.\n");
		return ERROR;
	}

	/* Execute the mapping */
	vma->vm_flags |=3D VM_IO;
	vma->vm_flags |=3D VM_RESERVED;
	vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
	printk(KERN_ALERT "FPGA: vmSize -> 0x%x.\n",
			(unsigned int)(vma->vm_end - vma->vm_start));

	if( mapType =3D=3D 0 )
	{
		if(io_remap_pfn_range(vma, vma->vm_start, addressToMap
>> PAGE_SHIFT,
				vma->vm_end - vma->vm_start,
vma->vm_page_prot) !=3D 0)
		{
			printk(KERN_ALERT "FPGA: Failed to map BAR PCI
space to user space.\n");
			return ERROR;
		}
	}
	else
	{
		printk(KERN_NOTICE "FPGA: Mapping stream ptr (%#08x) to
user space\n",(uint32_t)&fpga_drv.strmData[0]);
		printk(KERN_NOTICE "FPGA: Setting strmData[0][0] to
0x37\n");
		fpga_drv.strmData[0][0] =3D 0x37;
		if(remap_pfn_range(vma, vma->vm_start, addressToMap >>
PAGE_SHIFT,
				vma->vm_end - vma->vm_start,
vma->vm_page_prot) !=3D 0)
		{
			printk(KERN_ALERT "FPGA: Failed to map BAR PCI
space to user space.\n");
			return ERROR;
		}
	}

	return OK;
}


And here is the failure:

~ # ./main
FPGA: vmSize -> 0x4000.
FPGA: Mapping stream ptr (0xd10613bc) to user space
FPGA: Setting strmData[0][0] to 0x37
Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xd105f5e0
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT Kilauea
Modules linked in: fpgaDriver
NIP: d105f5e0 LR: d105f5d8 CTR: c003fff4
REGS: cf86dde0 TRAP: 0300   Not tainted  (2.6.30.3-wolverine-dirty)
MSR: 00029030 <EE,ME,CE,IR,DR>  CR: 24008022  XER: 0000005f
DEAR: 00000000, ESR: 00800000
TASK =3D cf873950[281] 'main' THREAD: cf86c000
GPR00: 00000037 cf86de90 cf873950 00000028 17d78400 c0302028 c0302068
00000000
GPR08: 00000000 00000000 00000003 c0300000 24008024 100e89c8 100d6590
100917d8
GPR16: 100d0000 100d0000 c0320000 cfaca07c 00000001 cf8c0230 00000003
000000fb
GPR24: 00000000 cf8a6840 cfaca07c 00000000 d10613bc d106128c 00000004
cfaca07c
NIP [d105f5e0] fpga_mmap+0x9c/0x214 [fpgaDriver]
LR [d105f5d8] fpga_mmap+0x94/0x214 [fpgaDriver]
Call Trace:
[cf86de90] [d105f5d8] fpga_mmap+0x94/0x214 [fpgaDriver] (unreliable)
[cf86deb0] [c00c1a4c] mmap_region+0x29c/0x408
[cf86df10] [c000377c] sys_mmap+0x78/0x100
[cf86df40] [c00103fc] ret_from_syscall+0x0/0x3c
Instruction dump:
386302a8 48000735 3b9d0130 3c60d106 7f84e378 386302c4 48000721 3c60d106
386302f8 48000715 813d0130 38000037 <98090000> 7fe3fb78 809f0004
80df0008
---[ end trace 4393e8cf23caef19 ]---


Where am I going wrong?

Using mmap() would work well for me.

Also, what about this:

1. I open /dev/mem and get a file descriptor
2. I use mmap to reserve some physical addresses for my buffers in user
space.
3. I give that address to the FPGA for DMA use.
4. When I get the FPGA interrupt, I invalidate the data cache and write
the data to disk

Does that sound like it would work?  Would the address I receive from
mmap() and pass to the FPGA be the actual physical address, or would I
need to send the physical address to the FPGA and use the mmap() address
to access and write to disk?

Thanks for the help!

Jonathan


_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev
