Date: Fri, 28 Jan 2000 11:35:58 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Christophe Lizzi <lizzi@csti.fr>
cc: linuxppc-dev@lists.linuxppc.org, plaurent@csti.fr
Subject: Re: PREP memory layout and PCI transactions
In-Reply-To: <200001280947.KAA09960@devl58>
Message-ID: <Pine.HPX.4.10.10001281125040.22483-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Fri, 28 Jan 2000, Christophe Lizzi wrote:

> Hi,
>
> I'm currently porting a third-party RAID driver from ix86 to LinuxPPC.
> The target is an MTX board with 32 Mbytes of RAM, running a 2.2.10 kernel.
>
> The driver requests the device to fill some memory locations in kernel
> space via DMA. This works just fine when such memory locations come
> from pages allocated by get_free_page() or kmalloc().
>
> However, this fails when these locations come from the *static* data
> of the module, or from pages allocated by vmalloc().

This is normal, all physical memory is mapped starting from 0xc0000000
in the kernel virtual address space. [I think that copying blindly the
x86 setup is a mistake but it's not the time to discuss this ;-)]

But module code and data are allocated with vmalloc, and te fixed offset
between physical and kernel virtual addresses no more hold (obviously).
So you can only do DMA to memory acquired by kmalloc (and incidentally to
local buffers on the stack but don't forget that the size is very limited
so I recommend against unless you have a very strong argument in favor).

It is possible the the raw io patches which are in recent kernels allow
for DMA to vmalloced memory but I did not study them and I'm not sure.


> Specifically, the pages returned by get_free_page() or kmalloc() are located
> around kernel virtual addresses C1xxxxxx (bus addresses 81xxxxxx), while the
> static data in question and the pages returned by vmalloc() are located
> behind virtual addresses C4xxxxxx (bus addresses 84xxxxxx).

Bus address 84xxxxxx will not point to your physical memory and you'll end
up with some weird error on the PCI bus.

> The PCI analyser sees on the PCI bus a memory write transaction initiated
> by the device to such an 84xxxxxx address in memory. We can observe that this
> transaction is never completed because the DEVSEL signal on the bus is not
> asserted during the correct 5 clock time interval. The transaction is then
> terminated as with a master-abort termination, meaning that this address
> is not known by the memory controler as an address that can be accessed
> from the PCI bus.

Normal....

> Is this a feature, a known restriction, or a bug? Maybe a register

It is a very well known and documented restriction, which is a problem if
your device can't do scatter gather since the size of buffers you can
allocate with kmalloc is limited.

> describing the accessible address range from the bus is not correctly
> initialised into the Falcon chip?

No, oh and by the way if you want to use the Falcon/Raven/Hawk in CHRP
mode, grab my patches at:

ftp://vlab1.iram.es/linux-2.[23]

they work on my MVME26xx and 24xx, but the MTX is quite similar AFAICT.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
