Date: Mon, 7 Jun 1999 14:18:48 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Matt Porter <mporter@phx.mcd.mot.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.9 patch for Motorola support.
In-Reply-To: <Pine.LNX.3.96.990526163555.23472S-100000@fwrsl-11.phx.mcd.mot.com>
Message-ID: <Pine.HPP.3.96.990607140855.27048C-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 26 May 1999, Matt Porter wrote:

> 
> Below is a cumulative patch versus official 2.2.9 to support Motorola
> boards.  Fixes OpenPIC irq handling, kbd controllerless board support, and
> initrd relocation.

Fine, butif you set CONFIG_VT to off the kernel won't link.  
BTW why don't you set CONFIG_VT to off for machines without KB
controller ?

I have put some new patches which work at least on my mvme2600 at: 

	ftp://vlab1.iram.es/pub/linux-2.2/mvme2600.*patch-2.2.9

note that prepboot now reconfigures Raven/Falcon (Hawk ?) boards to use
a CHRP mapping, this allows me to use only 2 BATS to access all PCI I/O,
VGA memory, chipset registers (and Flash if it were necessary) and 
still have about 450 Mb for VME windows through the Universe. 

The only drawback is that DMA to 1st megabyte of memory does not work,
this is not a problem as long as kernels are big enough to never put any 
DMA buffer in this area.

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
