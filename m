Message-ID: <3D1A0BBE.20004@embeddededge.com>
Date: Wed, 26 Jun 2002 14:45:18 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Dave Wilhardt <wilhardt@synergymicro.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: contiguous kernel pages
References: <3D19DD30.87A5DB6D@synergymicro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dave Wilhardt wrote:

> As you can see, some operations are less than 1/2 speed. We suspected
> that
> this was due to page fragmentation.

What do you mean by "page fragmentation" and how to see this causing
the performance difference you see?  I suspect I know the answer, I
just want to know what you are thinking :-)


> We suspect that the kernel has been optimized for a much smaller cache.
> Where
> should we be looking to make the kernel allocate larger contiguous
> chunks of
> memory?

The kernel doesn't know anything about processor caches and simply
allocates a 4K page at a time when they are faulted for the first time.
Your "malloc()" doesn't allocate any real memory when it is called,
just the virtual space to map it.  When you touch the pages for the
first time, they are zeroed and mapped.

What did your "special" driver do to allocate pages and map them
into an application?

> ..... Because the PowerPc L2 is 2 way and 2MB in size, we suspect that
> we
> need to tell the kernel to attempt to allocate 1MB chunks of memory
> whenever
> possible. Any thoughts?

Yes, but allocating 1M chunks of memory isn't the answer.  We need to
implement a cache coloring algorithm, but I'm surprised you can so
easily cause your performance problem, as I would think we would have
to write a specific allocation algorithm for force the behavior you see :-)

It would be interesting to see your test as well, since that is quite
a variation in performance within a single test session.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
