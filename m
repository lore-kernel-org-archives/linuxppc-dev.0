Date: Fri, 25 Jun 1999 12:11:11 +1000
Message-Id: <199906250211.MAA04916@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: ad@MPIfR-Bonn.MPG.de
CC: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
In-reply-to: <3771D987.C59A9374@mpifr-bonn.mpg.de> (message from Albrecht
	=?iso-8859-1?Q?Dre=DF?= on Thu, 24 Jun 1999 09:08:55 +0200)
Subject: Re: Help: Porting PCI driver from Linux/Intel -> PPC
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <3771D987.C59A9374@mpifr-bonn.mpg.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Albrecht =?iso-8859-1?Q?Dre=DF?= <ad@MPIfR-Bonn.MPG.de> wrote:

> 	I wrote a driver for a pci dsp card, which works fine on several Intel/
> Linux boxes both with 2.0.x and 2.2.x.  This encouraged to make a test with my
> PMac 7300/166, running R5 with the stock 2.2.6 kernel.  I compiled and inserted
> the driver --- and got a kernel panic :-(

A machine check?  That will happen if you try to access an I/O port
which doesn't respond.

> Maybe I missed some setup which is needed with LinuxPPC but not with Intel?  Or

PCI cards don't automatically their memory and I/O accesses enabled on
powermacs.  Arguably the generic PCI stuff in the kernel should turn
on memory and I/O accesses, and it should probably also check that the
addresses assigned by Open Firmware are sane.

> Now I try to insmod my driver, which reads the configuration space (using calls
> to pci_read_config_dword) and dumps it, reads irq and board revision, reads the
> base adresses of the five io regions, and reads one io address via inl().  The

Ideally you should use pci_find_device and then use the base_address
and irq fields from the pci_dev structure it returns.  And for
powermacs, you will need to set the bit in the config-space control
register to enable I/O accesses.

> * lspci reports irq #25, but the value in the config space is 1

Use pci_dev->irq instead, it should be correct.

> * the regions 0 to 3 are 256 bytes each, so they would overlap if the values
>   reported would be correct.

Possibly OF's fault.  I assume that if you write 0xffffffff into those
base address registers, you get back 0xffffff01, indicating 256 bytes
of I/O space?

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
