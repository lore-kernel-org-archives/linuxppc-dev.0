Message-ID: <406C488A.2090109@embeddededge.com>
Date: Thu, 01 Apr 2004 11:51:22 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: John Whitney <jwhitney-linuxppc@sands-edge.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems with dma_alloc_coherent()
References: <9EB527A2-83F5-11D8-9FF0-000A95A07384@sands-edge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


John Whitney wrote:

> To that end, I am submitting the attached patch which modifies
> dma_alloc_coherent() and dma_free_coherent() to do just this for
> cache-coherent platforms.

I think you should change/implement consistent_alloc()/free() to do
the right thing rather that use the #ifdef here.  Also, ensure the
ancillary function (like the dma sync/sg functions) work properly as
well.  They are probably no-ops (well, not the sg functions) but
look for those anyway.

There are also reasons to allocate un-cached DMA regions on
cache coherent platforms (but I will not debate the value in doing so),
so keep that under consideration.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
