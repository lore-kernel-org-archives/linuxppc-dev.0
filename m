Message-ID: <3A806D89.16B31EA0@mvista.com>
Date: Tue, 06 Feb 2001 16:32:57 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: Gabriel Paubert <paubert@iram.es>, tom_gall@vnet.ibm.com,
        linuxppc-commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
References: <3A6CCBDC.3D7B722A@mvista.com>
		<Pine.HPX.4.10.10101231050450.3872-100000@gra-ux1.iram.es> <14975.55035.835724.234984@tango.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> What's incorrect about it?

The PowerPC gives us the ability to utilize a huge virtual address
space, and with newer processors a larger physical address space.
Although on 32-bit processors we can't see all of this at once, it
is there for us to use.  The only difference between a 32- and 64-bit
PowerPC kernel implementation is that on the 64-bit you get to see
all of the VM space all of the time, while the 32-bit system is
scurrying around behind the scenes ensuring what you need to see
is currently mapped.

We are currently using VSIDs as a lazy TLB reloader, not for
a large VM space context manager.  There shouldn't be any need
for CONFIG_HIGHMEM on PowerPC, and we should be able to map huge
PCI spaces we see on the multiple bridge CPCI systems without
any worry of running out of VM space.

The reason this is hard to realize today is we have built up a
system with the assumption there is only a 32-bit virtual space,
half of it consumed by a user task.  When I saw the VM changes
happening during 2.3, I saw hoping we could take the opportunity
to improve PowerPC performance with better MMU management.  Maybe
someday I can work on it.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
