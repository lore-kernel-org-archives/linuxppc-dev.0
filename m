Date: Wed, 16 Aug 2000 10:51:31 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: David Riley <oscar@the-rileys.net>
cc: jlquinn@us.ibm.com, tom_gall@vnet.ibm.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI Buses
In-Reply-To: <39999677.4790E775@the-rileys.net>
Message-ID: <Pine.HPX.4.10.10008161029090.8448-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 15 Aug 2000, David Riley wrote:

> On a side note, does anyone know if Linux properly supports the 64-bit PCI
> slots in the Blue G3's and G4's?  The only cards I know of that use them are
> several SCSI cards and TotalImpact cards.

>From a software point of view 64 bit PCI is indistinguishable from 32 bit.
Actually MVME boards have a 64 bit PCI host bridge, although only the VME
bridge (Tundra's Universe) is a 64 bit device. The software just does not
care. PIO transfers of 32 bit or less (in practice all on a 32 bit
processor) will use standard PCI bus protocol for reads; writes may be
merged under some conditions by the processor or the host bridge as
explained for example in the PPC750 or CPC710 (IBM) doc. Still these
operations are often short (with the exception of graphics adapter memory
accesses) and the benefit of 64 bit transfers versus a short burst of 32
bit transfers is minimal.

DMA operations on the other hand benefit a lot from 64 bit transfers,
since well designed adapters will have large FIFOs and generate bursts of
several tens of transfers at which point the overhead of setting up the
operation becomes small. In practice this almost halves the bus
utilization.


	Regards,
	Gabriel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
