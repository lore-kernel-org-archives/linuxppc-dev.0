Message-ID: <39BFACA1.1C6F7CAF@mvista.com>
Date: Wed, 13 Sep 2000 12:34:41 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Gong Zhuo <gongzhuo@163.net>
CC: Linux PPC Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Any docments analyzing linuxppc kernel and it's policy?
References: <014301c01d7f$a1592540$4607a8c0@LocalHost>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Gong Zhuo wrote:

>   I am reading the source code of linuxppc mm.

Okay.......

> ....  It seems that the process
> uses the logical address 0 - 0x7fffffff, and the kernel uses the logical
> address 0xc0000000 -- (0xc0000000 + maxium memory). The rest logical address
> will not be used by anyone. Am I right?

You got the user process part right.....The kernel will map anything
over 0x80000000 in a variety of useful and interesting ways.  The system
memory is usually mapped to 0xc0000000, the remainder of the space is
used for mapping I/O devices, other pages of memory with different
attributes (uncached for example).  This is processor/board dependent,
so there are many different mappings for this space, although we do
try to keep them somewhat consistent.

>   Is there any document analyzing the linuxppc kernel and how does the
> kernel arrange all the logical space ?

I don't know.  I do know this could change daily.....


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
