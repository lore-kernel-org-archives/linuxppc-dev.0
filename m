Date: Wed, 16 Jun 1999 17:36:28 -0700
Message-Id: <199906170036.RAA07978@pizda.davem.net>
From: "David S. Miller" <davem@redhat.com>
To: loic@myri.com
CC: ultralinux@vger.rutgers.edu, linux-alpha@vger.rutgers.edu,
        linuxppc-dev@lists.linuxppc.org, feldy@myri.com
In-reply-to: <14184.12536.601868.330309@blue1.myri.com> (loic@myri.com)
Subject: Re: ioremap, virt_to_phys and pcidev->base_address consistency issues
References: <14184.12536.601868.330309@blue1.myri.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


   Date: 	Thu, 17 Jun 1999 00:23:58 +0000 (XXX)
   From: loic@myri.com

   So what would be the right person to contact to try to make things
   more consistent? Is there currently a standard way to map PCI
   memory space both in the kernel and in user-space aside from using
   some #ifdefs?

The problem is that virt_to_phys and virt_to_bus mean two totally
different things on architectures like sparc64 where PCI memory space
is disjoint from the physical RAM space.

In some cases you want the "physical" address as seen by the CPU, in
other cases you want the "physical" address as seen by a bus mastering
PCI device.  For PCI memory space these two values are different in
both cases on some machines, and there is no public mechanism to deal
with this.

Take the ncr53c8xx.c SCSI driver for example, it must deal with all of
these issues because of how the scsi processor needs to touch it's own
registers via PCI memory space transactions addressed to itself and
the assosciated bus_dvma_to_mem() macros it defines per architecture.

I'll be frank and say there is nobody you can talk to in order to get
this cleaned up for 2.2.x Linux, that simply isn't going to happen.
Maybe for 2.3.x...

Another issue is that all of the ISA/EISA drivers want to say:
outb(0x370) or whatever and expect it to access standard ISA ports on
all architectures, yet outb(pci_dev->base_address[0]) should work
correctly too.  See where the problems are?

Just use ifdefs for now, it will get cleaned up eventually, the "inner
circle" of Linux developers know it is a problem but we're putting out
much larger fires at the moment.

Later,
David S. Miller
davem@redhat.com

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
