Message-ID: <3AEF0F8B.836C77A7@mvista.com>
Date: Tue, 01 May 2001 15:33:31 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: ashish anand <ashisha@india.infogain.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: placing of ioremap ?
References: <12D7C6A4.AE725CC6@india.infogain.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


ashish anand wrote:
>
> I have one question regarding the placing of ioremap call
> suppose i have done ioremap call inside the mm/init.c
> for pci i/o or memory space

Well, you really shouldn't.......The PCI I/O space could be
done there so the usual inb/outb and friends work.  PCI memory
space should not be mapped there, it is done by the driver.

> in case my bios has not done the resource allocation
> i have to just write the proper values in PCI_BASE_ADDRESS
> registers of that pci card. Am I Correct?

You should include the Linux PCI auto config function.  It will
do this plus properly assign the interrupts.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
