Message-ID: <367833C4.60C22371@jlc.net>
Date: Wed, 16 Dec 1998 17:27:16 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Helmut Buchsbaum <helmut.buchsbaum@siemens.at>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Problems starting up system on a MPC823FADS
References: <36750901.A3E0E6D1@siemens.at>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Helmut Buchsbaum wrote:

> I try to get a linux system up and running on a Motorola MPC823FADS

Cool!


> ...... I only adopted the boot code slightly to feed the
> correct board info data, set up the correct clocks, etc., since my board
> has no boot prom.

Points again!


> 3) Setting up MMU works fine, the kernel initializes SMC1 (my console)
> and SMC2 for UART and SCC2 for ethernet (I adopted Dan's drivers for the
> MPC823, wasn't a big deal ;-)

Sorry about that.  I have recently finished an 821, 823, and 850
port to several boards.  I am sitting on lots of configuration changes
like this.  It was easy to just hack the files, but now I have to
make the config process work.  That is going to take longer
than the other changes :-(.  I hope to have it done as a new year
treat for everyone!


> Now the kernel tries to load & exec /sbin/init and /lib/ld.so.1. Loading
> via nfs seems to work fine (haven't had any trouble with this part) but
> when the kernel sets up the memory for this process I realized a strange

Yes.  I and others have seen this on the FADS boards.  I don't
yet understand it since the same software will run on other boards.


> BTW, why must the M_TWB be set in SET_PAGE_DIR ?

The M_TWB points to the first level page table (Linux pgd_t)
and is used in the mpc8xx page fault handler.  When Linux
deletes or otherwise modifies the memory map object such that
the first level page table is modified (as during exec), it
uses SET_PAGE_DIR.  Since the first level table has potentially
moved to a new memory location, we have to set M_TWB at
this time.  If we don't, a process exec without an intervening
context switch will cause us to use a bogus M_TWB when
trying to find page tables.


    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
