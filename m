Message-ID: <38F78D23.CAFA1BFC@embeddededge.com>
Date: Fri, 14 Apr 2000 17:26:59 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Dayton, Dean" <dean@aiinet.com>
CC: "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: device memory mapping
References: <7283DE19D141D111AD0E00A0C95B195502D968E1@mail2.aiinet.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Dayton, Dean" wrote:

> How do I map this address in Linux.

Very carefully....seriously.  You will need to do ioremap() of the
address, and it will return a virtual address to you.  The very
carefully part comes from you having to do this after the kernel
virtual memory allocator has been initialized.  Don't do this ioremap()
in the mm/init.c function, but rather in the device driver initialization
(or open, or whatever seems appropriate).  It should return a virtual
address something like 0xc4xxxxxx.  Then, have at it!


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
