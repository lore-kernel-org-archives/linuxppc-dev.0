Date: Tue, 2 Feb 1999 09:41:19 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Bryan Christianson <bryanc@ihug.co.nz>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: I/O Port Conflicts with PCI devices?
In-Reply-To: <l03130300b2dbb10d21bc@[172.16.10.14]>
Message-ID: <Pine.HPP.3.96.990202093717.16636I-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 2 Feb 1999, Bryan Christianson wrote:

> The following listing of /proc/pci shows that I have 2 devices reporting an
> I/O port of 0x400. Is this possible or am I not seeing the whole truth
> here? When I try to access the port (with inl() or outl()), the machine
> panics. I published this panic on the list last week and had no response.
> 
> I notice that GPR00 contains the address of the port plus my offset
> (0x043c), offset by 0xFE000000, which from my reading of the kernel source
> is the remapping done for PCI devices during initialisation.
> 
> I have tried kernels 2.1.130, 2.2.0 and 2.2.1, all with the same result. If
> there are any PCI gurus out there who can help, I would dearly love to get
> this to work.
> 
> PCI devices found:
>   Bus  0, device   0, function  0:
>     Host bridge: Motorola MPC106 Grackle (rev 64).
>       Fast devsel.  Fast back-to-back capable.  Master Capable.  No bursts.

I'd rather have the output of lspci -vx, this allows to check more details
like enabled or disabled I/O and memory space response. If you don't have
lspci, the following should be sufficient: 

	od -tx1 -Ax /proc/bus/pci/00/0e.0
	od -tx1 -Ax /proc/bus/pci/00/12.0
	

	Gabriel


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
