Message-ID: <3C4CECAF.6050309@embeddededge.com>
Date: Mon, 21 Jan 2002 23:38:07 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Ralph Blach <rcblach@us.ibm.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Mark Wisner <markwiz@us.ibm.com>, Alan Booker <alanbee@us.ibm.com>
Subject: Re: consistent_alloc changes for 4xx/8xx
References: <OFE9B9ADDA.B1DDEE86-ON85256B48.006CEF8B@raleigh.ibm.com >
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralph Blach wrote:


> On the IBM book E part, __va()/__pa() will have to be obsoleted.  The
> address space is
> 36 bits.  Better now than later.

These macros are not used on I/O space addresses, and would continue
to work properly on the Book E parts when used as intended.  In fact they
are still used in all kernel ports, people just had the tendency to
take shortcuts and abuse them.  I was just pointing out one case of
abuse that will now break.


> Dan, you saw netperf which  demonstrated the benefit.

Netperf is not an application that does any real work, it is simply
an IP stack performance tool.  In the real world in real products, you
have to be concerned with resources consumed by applications.  When you
pin TLB entries, you steal resources from applications and could cause
a decline in the overall system performance.

> ....  These were the very
> test you
> suggested we run and they showed a >10% performance increase on a 405.

I suggested netperf in response to your question about which network
performance test to use, not as a tool to measure system performance.
When you look at applications like MP3 players that are nearly 100%
in user space, they are very sensitive to instruction and data cache
footprint.  Increasing the complexity of TLB miss handlers by adding more
code or requiring the fetching of additional data, causes these applications
to actually require more processing time.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
