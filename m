Message-ID: <3E6A42A1.9080503@tataelxsi.co.in>
Date: Sun, 09 Mar 2003 00:51:05 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org,
	linux-india-programmers@lists.sourceforge.net
Subject: how to allocate physically contiguous memory in kernel.
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
We are using mpc8260 for our communication application.
In our application, we have to allocate contiguous memory of size 1536
bytes. These memory will be used in the buffer descriptors for DMA.
These will be later freed from another driver in the kernel. For DMA we
require physically contiguous addresses.

We are currently allocating 1536 bytes using dev_alloc_skb non interrupt
context and skb_alloc(x, GFP_ATOMIC) in terrupt context. The doubt is
that will a dev_alloc_skb()/skb_alloc call allocate 1536 bytes within
page boundary? My understanding of kmem allocation is that kernel keeps
free buffers of size 512k, 256k ... (buddy system) upto 1 page, and
whenver a request arises, contiguous memory is allocated from the
nearest large page frame block. If there is no page frame block to
satisfy this request, it will fail.
In this context can I safely asssume that a dev_alloc_skb() request will
return memory which is contiguous physical memory within a page ?

if not what should be the approach I should take? I cannot allocate 1
page for 1536 bytes, which will cause huge over heads. shall I redefine
PAGE_SIZE to 2048 and allocate one page for 1536 bytes and do a skb_put
on the data?

Any help is appreciated.
Om.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
