Message-ID: <3C1E561D.1060005@embeddededge.com>
Date: Mon, 17 Dec 2001 15:31:25 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "svacca@valcom.com" <svacca@valcom.com>
Cc: "LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Writing to PCI Bridge in User Space - Problem
References: <01C18705.8C0C5810.svacca@valcom.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Vacca wrote:

> I have a "resident" driver which reads and writes a PLX PCI Bridge
> chip, which is mapped into 0x2000.0000 in MMU_init() (for the mpc860).

Bzzzzt!!  Potentially wrong answer.  How are you "mapping" it?  If you
are using ioremap(), this isn't going to work.  You either need to map it
much later in the kernel initialization, after the kernel VM is set up,
or by carefully choosing addresses for io_block_mapping().


> So, why does it work fine just before starting the app, from the non-driver
> kernel code, but not from the driver's ioctl fops func?

Because if you just use ioremap(), it placed the virtual address into the
user space.  When you started up the user programs the mapping was used for
it's intended purpose (user space).  There are plenty of messages in the
archives and FAQs describing the memory mapping.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
