From: loic@myri.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 17 Jun 1999 00:23:58 +0000 (XXX)
To: ultralinux@vger.rutgers.edu, linux-alpha@vger.rutgers.edu,
        linuxppc-dev@lists.linuxppc.org
Cc: feldy@myri.com
Subject: ioremap, virt_to_phys and pcidev->base_address consistency issues
Message-Id: <14184.12536.601868.330309@blue1.myri.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



[ I am not currently subscribed to all the mailing-lists, sorry
if this issue has been brought recently]

Hello,

I am looking for a simple way to map PCI memory space to both kernel
and user-space, and to map kernel memory to user-space.

ioremap, virt_to_phys and the base_address field of the pci_dev
structure have different meaning across architectures which makes it
more difficult that needed, to support all the linux archs.

Here is the status of things as I understand it:

ioremap function:
  x86: 
    take a physical==bus address (note there is both ioremap and
    ioremap_nocache. On >= P6 processors, if the  kernel is not compiled
    with mtrr support, the "cacheability" behaviour of plain ioremap may
    depend on the BIOS, so you may want to use ioremap_nocache instead)
  Alpha: 
    take a virtual kernel address
  sparc64:
  powerpc:
    take a physical address
  

pcidev->base_address:
  x86:
    base_adress register === bus address + type bits
  alpha:
    gives a "special address" that code the bus number + bus base
      address" meant to be used with the alpha specific dense_mem function.
  sparc64:
     gives the kernel virtual address to access the device from kernel
  powerpc:
     has some hacks so that it gives the physical address for some devices,
     gives the bus address the rest of the time

virt_to_phys:
  x86, Alpha, powerpc:
     same than __pa() => give physical address
  sparc64:
     same than virt_to_bus => gives DMAable PCI bus address
(so I just use __pa now instead of virt_to_phys).

So what would be the right person to contact to try to make things
more consistent? Is there currently a standard way to map PCI memory
space both in the kernel and in user-space aside from using some
#ifdefs? 

Loic PRYLLI



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
