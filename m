Message-ID: <3C0E7378.9040706@embeddededge.com>
Date: Wed, 05 Dec 2001 14:20:24 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Ralph Blach <rcblach@us.ibm.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: IO_BASE woes.
References: <OF6A7540D3.FD212873-ON85256B19.0067E145@raleigh.ibm.com >
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ralph Blach wrote:


> Along with the PCI, this spells a lot of rewrite of code.

Well, I wouldn't say lots.

A properly written PCI driver isn't an issue, since it shouldn't
use in/out with IO_BASE any more, especially on PowerPC.  When
you stumble into drivers that don't do this, they should be modified
and changes submitted to the author.

For "ISA" chips on processor busses, you just need to get into the
habit of doing something similar as we should be doing with PCI.
Simply ioremap the address and use the I/O memory read/write operations.
I regularly do this, it only requires changes to a few lines of code,
and sometimes the authors will actually accept the changes.

> The concept of an IO_base seems a little dated.

Yep.  I don't use it any more on any PowerPC embedded systems.

Memory mapped I/O is your friend.  Use it and prosper.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
