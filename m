Date: Tue, 22 Dec 1998 11:13:27 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
Reply-To: Gabriel Paubert <paubert@iram.es>
To: Corey Minyard <minyard@acm.org>
cc: Martin Mares <mj@ucw.cz>, Gerard Roudier <groudier@club-internet.fr>,
        linuxppc-dev@lists.linuxppc.org
Subject: SCSI NCR driver and PCI mappings on PPC (was restructure of arch/ppc/kernel...)
In-Reply-To: <m2ogp1tvh6.fsf@wf-rch.cirr.com>
Message-ID: <Pine.HPP.3.96.981221150948.18639G-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 

On 18 Dec 1998, Corey Minyard wrote:

> I do plan on trying your preploader, but I don't expect a problem with
> it since I have a 2700.  I have been quite busy recently trying to
> clean things up in the kernel and with the rest of my job.  I'm hoping
> with your stuff we can get rid of the "Wacky IBM" relocation done in
> the NCR SCSI driver.

Indeed, on my machine the SCSI interface now appears at sane addresses. 
Here is what I get after changing slightly the offending code from
ncr53c8xx.c (don't worry about I/O ports above the 16 biit boundary, they 
are placed there to make sure no ISA conflicts can happen): 

[root@vcorr1 /root]# lspci -v -s 0c
00:0c.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c825 (rev 13)
        Flags: bus master, medium devsel, latency 128, IRQ 19
        I/O ports at 10000
        Memory at c3f51000 (32-bit, non-prefetchable)
        Memory at c3f50000 (32-bit, non-prefetchable)

[root@vcorr1 /root]# lspci -vb -s 0c
00:0c.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c825 (rev 13)
        Flags: bus master, medium devsel, latency 128, IRQ 14
        I/O ports at 10000
        Memory at 03f51000 (32-bit, non-prefetchable)
        Memory at 03f50000 (32-bit, non-prefetchable)

  Note that the address are different if seen from the kernel and from
the bus since the bridge offsets MMIO addresses by 0xc0000000. I think 
it is the right way to do it since it should not change the interface 
to ioremap(). However I had to add the following hack to ncr53c8xx.c:

	if ( is_prep ) {
#if 0	
[previous Wacky IBM hack]
#else
		base -= 0xc0000000;
		base_2 -= 0xc0000000;
#endif


Which I think is equivalent to the base{,_2}=__pa(base{,_2) used on
SPARC, although it should be implemented more elegantly.

I don't have any SPARC around and much less running Linux to see if what
I've done is coherent however. Any comments to confirm that I'm not
grossly mistaken (Gerard/Martin) ?

Oh, and I don't know the effect of the following in struct Symbios_host: 
        struct Symbios_host{
[snipped]
                u_short io_port;        /* PCI io_port address */
        } host[4];

on architectures where PCI I/O space is > 64k. I have only one host, so
probably I can't be affected. 


> I haven't changed the function of anything in the kernel, just the
> structure, so I don't expect a problem in that respect with your
> changes.  I'll probably try it out early next year sometime.

I've for now tried to keep the things religiously so that the same exact
vmlinux boots with my bootloader and with the old one. However, this might
change in the future since for example my bootloader also clears the bss
(there is ugly code to clear the bss only when booting the first processor
on SMP, all of this could be removed. The bootloader runs UP by definition
and can set a few things up to remove some of the assembly mess in 
early PPC init code). 

	Regards,
	Gabriel






[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
