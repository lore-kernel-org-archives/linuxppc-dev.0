Message-ID: <3BF4A68B.5080803@embeddededge.com>
Date: Fri, 16 Nov 2001 00:39:23 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Steve Rossi <srossi@labs.mot.com>
Cc: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mmap & no cache regions
References: <3BF1939A.B96072AC@labs.mot.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve Rossi wrote:

> .....I learned that consistent_alloc is not sufficent to
> guarantee cache coherency on the mmaped region

Well, it has no clue about what you are doing.  It's purpose is to
ensure the kernel's mapping of that page is set properly.

> .... - in fact I had to mark
> these pages PAGE_NO_CACHE in the user space application's memory map as
> well.

Yep, that's because the kernel and applications have their own page
tables and page attributes.

> .....- but is it safe
> to assume that the application's memory map will be destroyed so I don't
> have to worry about marking the pages in that map as cacheable again?

I was about to write a couple of pages when it is best to answer this
with a simple "yes."  When the application releases this space, the page
tables are simply destroyed.  The kernel does it's weird attribute change
because it doesn't really "release" the page as an application does.  That's
all I'll say for now :-).

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
