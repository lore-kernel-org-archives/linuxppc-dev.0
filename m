Message-ID: <3B70D192.AAF239AB@india.infogain.com>
Date: Wed, 08 Aug 2001 11:13:46 +0530
From: ashish anand <ashisha@india.infogain.com>
MIME-Version: 1.0
To: Hollis@india.infogain.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: PReP and generic PCI resource assignment
References: <01080800112002.00491@silence.internal>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


if I remember correctly there should be some a board specific variable like pci_dram_offset
it is zero for your case.
0xc1000000 is a virtual address ..while pci bar should be programmed with bus address .
your case bios is not apropiately updating the resource assignment with 0xc0000000 , the kernel_base.

Hollis wrote:
>
> I'm trying to boot _2_4_devel on a Thinkpad 850. The only problem comes when
> the video controller's PCI resource 1 (mapped by the firmware to
> 0x0..0x00ffffff) is relocated to 0xc1000000..0xc1ffffff. [The symptom is that
> all new VGA text is drawn backwards-endian, which I would not have expected
> but is very visible.] That's way out of bounds for PReP IO memory, which in
> bus addresses can only be 0x0..0x40000000 (in CPU addresses that's
> 0xc0000000..0xfeffffff or so).
>
> How did it get moved that drastically? The problem comes from generic PCI
> code, starting with pci_assign_resource (called from
> pcibios_assign_resources). The actual bad line of code is in
> kernel/resource.c find_resource():
>         new->start = root->start;
> where it starts the new resource at the bottom of the parent resource's
> range.
>
> The problem is that root in this case is the PCI memory resource of the host
> bridge, which correctly starts at 0xc0000000... but NOT in bus terms. In bus
> terms it starts at 0x0. (CPU physical 0xc0000000 = PCI bus 0x0 [IO mem].) So
> the new resource is assigned 0xc1000000, which is written back to the BAR
> with pcibios_update_resource... which is way wrong.
>
> Now if resources could be assigned properly in the first place this code path
> wouldn't be taken, but quite a few things fail (request_resource's and
> pci_find_parent_resource's) and it's proving difficult to track down why
> (maybe I've been staring at this too long).
>
> Anyways, when I change "root->start" above to be 0, the symptom is fixed, but
> that's clearly a hack. I don't see how anything PReP (system IO nor IO
> memory) could escape generic resource assignment unscathed though.
>
> Thoughts?
>
> -Hollis
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
