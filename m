Message-ID: <3BF54569.3060000@embeddededge.com>
Date: Fri, 16 Nov 2001 11:57:13 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] Allow small areas in io_block_mapping
References: <3BF52F0C.7020608@humboldt.co.uk> <3BF53B55.90900@embeddededge.com> <3BF54157.6070605@humboldt.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Adrian Cox wrote:


> I hadn't realised that ioremap could be used before vmalloc was working,
> but on examining the code, it looks like it can. So I may just change my
> code to use ioremap.

Yeah, but just remember it does 1:1 virt->phys mapping.  I have a couple
of 4xx processors with hard-wired low physical addresses, and I have to
force them to map to a "friendly" virtual address :-).  That's the
only reason I like io_block_mapping(), but I don't have BATs to deal with.

> In defense of the patch....

You are correct.  The comments in the code are kind of funny.....ensure
you call it with the right parameters, but then it checks some anyway.


> That's pretty well what I need here.

Let's do it.  I think io_block_mapping() was conceptually copied from
other architectures for consistency, but I don't think it's doing the
right thing for us in all cases.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
