Message-ID: <410FC9F4.8020301@mvista.com>
Date: Tue, 03 Aug 2004 10:23:00 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 750 and Discovery II coherency with PCI....
References: <410F05EC.1040405@realitydiluted.com>
In-Reply-To: <410F05EC.1040405@realitydiluted.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Steve,

You leave out a lot of pertinent information that would help us help
you.  For example, what board are you using?  Is it a board with a known
good Linux board port?  What kernel base are you using (the *exact* tree
and version of that tree; there are several 2.4 trees)?  Are you sure
that the PCI I/O & MEM space allocations are correct (e.g., did you run
pci_auto)?

Somc comments follow...

Steven J. Hill wrote:

>
> Greetings.
>
> I am writing a device driver for a PMC card that is nothing
> fancy. It is not a PCI-X card though. My Linux driver properly
> detects the device, 'ioremaps' the PCI IO


PCI I/O space is already "ioremap'd" for you, don't do it again.
Assuming your board code in arch/ppc/platforms is correct and you are
using the correct PCI I/O space access routines (e.g., inb/outb and
friends), it will just work.  Make sure those assumptions are valid.

There are many, many linux drivers available for you to look at, please
use them for examples on how to access PCI I/O and MEM space.  Also,
there is lots of good info in .../Documentation/*.  It will be well
worth your time to read through it.

> and MEM regions then
> attempts to start writing the devices registers for setup
> and configuration. I am not getting valid reads and there
> appears to be some coherency issues.


What makes you think there are coherency issues?

> I have verified that no
> other drivers or resources in the system are utilizing the
> addresses that are returned to me from 'ioremap'.


Of course not, ioremap returns the virtual address from the virt->CPU
phys mapping it just made.  That's always going to look fine.  Its the
CPU physical, PCI I/O, and PCI MEM addresses that you need to make sure
don't overlap.

> I have the
> following code snippet:
>
> #define shunt_read_8(offset)        \
>     *((volatile u8 *) (shunt_dev->ctrl_base + offset))


Don't do that.  Use the proper access routines that are already
available to you.

Also, I see nothing remotely related to cache coherency here.  You only
talk about accessing registers in ioremap'd areas.  Caches are not
involved nor are you looking at areas in memory where your device DMA'd
data into or out of.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
