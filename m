In-Reply-To: <1089979617.1055.19.camel@bng-d000218>
References: <s0f7edc2.025@EMAIL> <1089977681.27006.90.camel@kubu.opensource.se> <1089979617.1055.19.camel@bng-d000218>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <891CFADE-D72C-11D8-B668-003065F9B7DC@embeddededge.com>
Cc: Magnus Damm <damm@opensource.se>,
	linuxppc-embedded@lists.linuxppc.org,
	Rupesh S <rupeshs@myw.ltindia.com>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Why not kmalloc() ??
Date: Fri, 16 Jul 2004 09:32:08 -0400
To: sanjeev ramachandran <sanjeev.ramachandran@fci.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Jul 16, 2004, at 8:06 AM, sanjeev ramachandran wrote:

> Bingo , But there is another function called dpalloc which does the
> same
> job of allocating from the dual port ram.

It is the only function that allocates from dpram.  hostalloc does not.
Use the dpram only for those functions as necessary.  Use hostalloc
only for those functions necesary (small serial fifos and such).

Use dma_alloc_consistent() for large memory buffers that you need
to attach to BDs, for example Ethernet buffers.  There is very little
memory available from either dpalloc or hostalloc, and they must
be used only when necessary.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
