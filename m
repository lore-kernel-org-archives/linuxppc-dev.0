Message-ID: <3CDAA320.1050707@embeddededge.com>
Date: Thu, 09 May 2002 12:26:08 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: acurtis@onz.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: 8260 and skb implementation
References: <NCBBIINEHIPFGJPLBEIFGEKKDGAA.acurtis@onz.com>	<3CD8BCF7.1090102@embeddededge.com> <15577.52276.175752.518900@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> Doing zero-copy receive requires intelligent adaptor firmware/hardware
> that can look in the headers and put the packet in different places
> depending on what it finds.

????

> ....  Very few adaptors can do this and I
> assume the CPM can't.

Piece of cake with the CPM.....I just didn't know the Linux protocol
stack wanted these separated and where to put them if it did.  I can
also assemble packets from fragments just as easily.  I can even
align the headers and data in separate cache lines if you want.

When we discuss the 'zero-copy' I assumed (I guess incorrectly) that
we DMA directly into the receive SK buffer.  In the past on 8xx, we have
allocated uncached memory for the CPM receive buffers and then copied
into the receive SK buffer.  We have to do this because of other
data shared by the cache line and the SK buffer.

> Cache coherence shouldn't be a problem on transmission ....

It never has been and we have always used the sk buffer directly for
DMA output.  It's always been the ability to properly allocate the
sk buffer for the received.

In any case, none of this is an issue for the 82xx, which originally
started this thread.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
