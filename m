Message-ID: <3CD9425D.2020206@embeddededge.com>
Date: Wed, 08 May 2002 11:21:01 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: acurtis@onz.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 8260 and skb implementation
References: <NCBBIINEHIPFGJPLBEIFCEKODGAA.acurtis@onz.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Allen Curtis wrote:


>>...I don't think SK bufs will because of the high processor core access.
>
>
> I am not sure what you are saying here?

The advantage of the local RAM is for the CPM to better satisfy its
memory resource requirements by not having to compete with the PowerPC
core (or other bus masters) for 60x bus access.  Since the SK buffers are
predominantly used by the PowerPC core during its IP stack and application
processing, I doubt there is any performance benefit.  However, it isn't
hard to cause SK buffers to be allocated from this memory for testing
purposes, and I would run some benchmarks that represent your application
rather than design by speculation :-)


> You would think that alignment was a common implementation concern.

It's a concern, but we are lucky they are aligned properly.  The transmit
buffers are 16-bit aligned due to the way the headers are built, which
causes trouble for some controllers.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
