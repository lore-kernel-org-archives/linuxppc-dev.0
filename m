MIME-Version: 1.0
Subject: Re: consistent_alloc changes for 4xx/8xx
Cc: "Mark Wisner" <markwiz@us.ibm.com>,
	"Alan Booker" <alanbee@us.ibm.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <OFE9B9ADDA.B1DDEE86-ON85256B48.006CEF8B@raleigh.ibm.com >
From: "Ralph Blach" <rcblach@us.ibm.com>
Date: Mon, 21 Jan 2002 15:45:02 -0500
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan, here are my responces.



>>Another, more challenging, situation also exists because you can't use
>>the __va()/__pa() macros on the addresses returned from consistent_alloc
().
>>On the 4xx/8xx, the virt_to_* macros will call iopa() which will track
down
>>the real physical address in the page table, which continues to work.

On the IBM book E part, __va()/__pa() will have to be obsoleted.  The
address space is
36 bits.  Better now than later.



>>For testing, I added the ability on the MPC860 to pin the first 8M of
kernel
>>text (of which there is probably on 512K used), up to 24 Mbytes of kernel
>>data, and the 8M IMMR space.  Note that this will only work on the 860
>>processors with a 32 entry TLB.  I added, but couldn't test for lack of
>>hardware, a similar feature to the 4xx.  I wanted to check this in before
the
>>kernel changed too much, and I have volunteers testing it, so any
problems
>>should be corrected shortly.  Note that this TLB pinning comes at a cost
of
>>taking TLB entries out of use for applications, so IMHO it isn't
something
>>that should be done without verification of total system performance
improvement.
>>I hope someone can find some benchmarks where this feature actually
provides
>>benefit

Dan, you saw netperf which  demonstrated the benefit.  These were the very
test you
suggested we run and they showed a >10% performance increase on a 405.


Chip


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
