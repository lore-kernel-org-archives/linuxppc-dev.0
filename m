Date: Tue, 23 Mar 2004 12:17:36 +0100
From: Marc Leeman <marc.leeman@barco.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI Memory mapping
Message-ID: <20040323111736.GJ1446@smtp.barco.com>
Reply-To: Marc Leeman <marc.leeman@barco.com>
References: <20040316114030.GB7133@smtp.barco.com> <1079455175.4184.25.camel@localhost.localdomain> <20040322074833.GY7133@smtp.barco.com>
Mime-Version: 1.0
In-Reply-To: <20040322074833.GY7133@smtp.barco.com>
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>   +------+       +--------+     +------------+
>   | user |------>| kernel |---->| pci-mapped |
>   +------+       +--------+     +------------+

Hm, I'm not quite out of the woods yet it seems :-/

The system contains (amongst other components) a MPC8245 PPC and a
TMS320C6415 DSP. The PPC handles incoming data and passes it along to
the DSP. Partially due to a problem on the DSP, we want the DMA to be
initiated by the DSP.

As such, we prepare a kernel buffer:
if(!(driver_data.device[i]->kern_addr= \
  pci_alloc_consistent(driver_data.dev,PCI_TRANSFER_SIZE,\
  &(driver_data.device[i]->bus_addr)))){...}

that links/maps it on the PCI memory range. This dma_t (bus address) is
passed to the DSP. The DSP then reads the data over the PCI buss and
acknowledges this to the (currently polling) PPC.

The PPC prepares the data, and calls an ioctl that copies part of the
user buffer into kernel space (driver_data.device[i]->kern_addr);
following this, the DSP is warned that new data is available.

 ioctl(...,MAP_CONSISTENT,...);

 while(ptr<end){
   movebuftokernel(ptr,size); /* ioctl */
   ptr+=size;
 }

 ioctl(...,MAPOFF_CONSISTENT,...);

This process is repeated until the entire userspace buffer has been
processed.

Even though documentation indicates that consistent DMA mapping should
not have caching issues we have a problem that reflects this very much:

When data is passed to the DSP and every buffer is confirmed with an
[Enter] (i.e. __very__ slow_), data is passed correctly. When we try to
pass the same data without user intervention (comment out
waitforenter()),
parts of the transferred data are copied from other locations: most of
the time, part of the buffer (e.g. 2048 bytes) is not update yet (old
data).

e.g.

8 * 32 bit: correct
96 * 32 bit: wrong
... rest is OK.

Any ideas what might go wrong since consistent mappings 'should' not
have problems with caching...

--
  Marc Leeman                          Hardware R&D Engineer
  Barco Controlrooms Division Noordlaan 5, B-8520 Kuurne (BE)
  Tel. +32 56 368 428        http://www.barcocontrolrooms.com=20

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
