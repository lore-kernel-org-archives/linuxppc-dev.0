Return-Path: <B32579@freescale.com>
Received: from VA3EHSOBE007.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 39967B6FE0
	for <linuxppc-dev@ozlabs.org>; Fri,  6 May 2011 22:00:40 +1000 (EST)
From: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
To: "iws@ovro.caltech.edu" <iws@ovro.caltech.edu>
Subject: [RFC v2] virtio: add virtio-over-PCI driver
Date: Fri, 6 May 2011 12:00:34 +0000
Message-ID: <071A08F2C6A57E4E94D980ECA553F8741A54D4@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Aggrwal Poonam-B10812 <B10812@freescale.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Zang Roy-R61911 <R61911@freescale.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Kalra Ashish-B00888 <B00888@freescale.com>,
	Gala Kumar-B11780 <B11780@freescale.com>,
	Gupta Maneesh-B18878 <B18878@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I want to use this patch as base patch for "FSL 85xx platform" to support P=
CIe Agent.
The work looks to be little old now. So wanted to understand if any develop=
ment has happened further on it.

In case no, I would take this work forward for PCIe Agent.=20

Any help/suggestions are most appreciated in this regard.

Thanks,
Prabhakar

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.ke=
rnel.org] On Behalf Of Ira Snyder
Sent: Friday, 27 February, 2009 3:19 AM
To: Arnd Bergmann
Cc: linux-kernel@vger.kernel.org; Rusty Russell; Jan-Bernd Themann; linuxpp=
c-dev@ozlabs.org; netdev@vger.kernel.org
Subject: Re: [RFC v2] virtio: add virtio-over-PCI driver

On Thu, Feb 26, 2009 at 09:37:14PM +0100, Arnd Bergmann wrote:
> On Thursday 26 February 2009, Ira Snyder wrote:
> > On Thu, Feb 26, 2009 at 05:15:27PM +0100, Arnd Bergmann wrote:
> >
> > I think so too. I was just getting something working, and thought it=20
> > would be better to have it "out there" rather than be working on it=20
> > forever. I'll try to break things up as I have time.
>=20
> Ok, perfect!
> =20
> > For the "libraries", would you suggest breaking things into seperate=20
> > code files, and using EXPORT_SYMBOL_GPL()? I'm not very familiar=20
> > with doing that, I've mostly been writing code within the existing=20
> > device driver frameworks. Or do I need export symbol at all? I'm not su=
re...
>=20
> You have both options. When you list each file as a separate module in=20
> the Makefile, you use EXPORT_SYMBOL_GPL to mark functions that get=20
> called by dependent modules, but this will work only in one way.
>=20
> You can also link multiple files together into one module, although it=20
> is less common to link a single source file into multiple modules.
>=20

Ok. I'm more familiar with the EXPORT_SYMBOL_GPL interface, so I'll do that=
. If we decide it sucks later, we'll change it.

> > I always thought you were supposed to use packed for data structures=20
> > that are external to the system. I purposely designed the structures=20
> > so they wouldn't need padding.
>=20
> That would only make sense for structures that are explicitly=20
> unaligned, like a register layout using
>=20
> struct my_registers {
> 	__le16 first;
> 	__le32 second __attribute__((packed));
> 	__le16 third;
> };
>=20
> Even here, I'd recommend listing the individual members as packed=20
> rather than the entire struct. Obviously if you layout the members in=20
> a sane way, you don't need either.
>=20

Ok. I'll drop the __attribute__((packed)) and make sure there aren't proble=
ms. I don't suspect any, though.

> > I mostly don't need it. In fact, the only place I'm using registers=20
> > not specific to the messaging unit is in the probe routine, where I=20
> > setup the 1GB window into host memory and setting up access to the=20
> > guest memory on the PCI bus.
>=20
> You could add the registers you need for this to the "reg" property of=20
> your device, to be mapped with of_iomap.
>=20
> If the registers for setting up this window don't logically fit into=20
> the same device as the one you already use, the cleanest solution=20
> would be to have another device just for this and then make a function=20
> call into that driver to set up the window.
>=20

The registers are part of the board control registers. They don't fit at al=
l in the message unit. Doing this in the bootloader seems like a logical pl=
ace, but that would require any testers to flash a new U-Boot image into th=
eir mpc8349emds boards.

The first set of access is used to set up a 1GB region in the memory map th=
at accesses the host's memory. Any reads/writes to addresses 0x80000000-0xc=
0000000 actually hit the host's memory.

The last access sets up PCI BAR1 to hit the memory from dma_alloc_coherent(=
). The bootloader already sets up the window as 16K, it just doesn't point =
it anywhere. Maybe this /should/ go into the bootloader. Like above, it wou=
ld require testers to flash a new U-Boot image into their mpc8349emds board=
s.

> > Now, I wouldn't need to access these registers at all if the=20
> > bootloader could handle it. I just don't know if it is possible to=20
> > have Linux not use some memory that the bootloader allocated, other=20
> > than with the mem=3DXXX trick, which I'm sure wouldn't be acceptable.
> > I've just used regular RAM so this is portable to my custom board=20
> > (mpc8349emds based) and a regular mpc8349emds. I didn't want to=20
> > change anything board specific.
> >=20
> > I would love to have the bootloader allocate (or reserve somewhere=20
> > in the memory map) 16K of RAM, and not be required to allocate it=20
> > with dma_alloc_coherent(). It would save me plenty of headaches.
>=20
> I believe you can do that through the "memory" devices in the device=20
> tree, by leaving out a small part of the description of main memory,=20
> at putting it into the "reg" property of your own device.
>=20

I'll explore this option. I didn't even know you could do this.  Is a drive=
r that requires the trick acceptable for mainline inclusion? Just like sett=
ing up the 16K PCI window, this is very platform specific.

This limits the guest driver to systems which are able to change Linux's vi=
ew of their memory somehow. Maybe this isn't a problem.

> > Code complexity only. Also, it was easier to write 80-char lines=20
> > with something like:
> >=20
> > vop_get_desc(vq, idx, &desc);
> > if (desc.flags & VOP_DESC_F_NEXT) {
> > 	/* do something */
> > }
> >=20
> > Instead of:
> > if (le16_to_cpu(vq->desc[idx].flags) & VOP_DESC_F_NEXT) {
> > 	/* do something */
> > }
> >=20
> > Plus, I didn't have to remember how many bits were in each field. I=20
> > just thought it made everything simpler to understand. Suggestions?
>=20
> hmm, in this particular case, you could change the definition of=20
> VOP_DESC_F_NEXT to
>=20
> #define VOP_DESC_F_NEXT cpu_to_le16(1)
>=20
> and then do the code as the even simpler (source and object code wise)
>=20
> if (vq->desc[idx].flags) & VOP_DESC_F_NEXT)
>=20
> I'm not sure if you can do something along these lines for the other=20
> cases as well though.
>=20

That's a good idea. It wouldn't fix the addresses, lengths, and next fields=
, though. I'll make the change and see how bad it is, then report back. It =
may not be so bad after all.

> > I used 3 so they would would align to 1024 byte boundaries within a=20
> > 4K page. Then the layout was 16K on the bus, each 4K page is a=20
> > single virtio-device, and each 1K block is a single virtqueue. The=20
> > first 1K is for virtio-device status and feature bits, etc.
> >=20
> > Packing them differently isn't a problem. It was just easier to code=20
> > because setting up a window with the correct size is so platform=20
> > specific.
>=20
> Ok. I guess the important question is what part of the code makes this=20
> decision. Ideally, the virtio-net glue would instantiate the device=20
> with the right number of queues.
>=20

Yeah, virtio doesn't work that way.

The virtio drivers just call find_vq() with a different index for each queu=
e they want to use. You have no way of knowing how many queues each virtio =
driver will want, unless you go read their source code.

virtio-net currently uses 3 queues, but we only support the first two.
The third is optional (for now...), and non-symmetric.

Thanks again,
Ira
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in =
the body of a message to majordomo@vger.kernel.org More majordomo info at  =
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
