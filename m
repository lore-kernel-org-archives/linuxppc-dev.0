Message-ID: <3CFC0FDD.1060607@embeddededge.com>
Date: Mon, 03 Jun 2002 20:54:53 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: CONFIG_PIN_TLB and telnet problems
References: <20020531071550.GF16537@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

 > ....I was unable to reproduce the problem
> on any of the other 405GP machines I have, each of which as at least
> 64MB of RAM.

As I mentioned in the first message, I suspect the problem is with the
multiple mapping/access of data in the pinned and remapped areas.  Linux
tends to allocate memory from the high end down, so if you consistent_alloc()
some space on large memory systems, you are just remapping the attributes
of a page.  If you do this on memory that is also covered by a large page,
sometimes you will get the access through this large page, and others through
an alternate mapping, which I believe confuses the MMU/cache with different
attributes (which I was assured wouldn't cause problems on 4xx).

So, if you use large pages for the first 16 or 32M, and you have only that
much memory, you will encounter mapping aliases.  If you only use large
pages for the first 16 or 32M, but have 64M or more total, then the upper
pages usually allocated to skbufs aren't subject to the large page mapping alias.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
