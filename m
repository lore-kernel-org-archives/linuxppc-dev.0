Subject: Re: consistent_alloc changes for 4xx/8xx
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF15CE0A9C.B48A773C-ON85256B4B.004A34B7@raleigh.ibm.com >
From: "Ralph Blach" <rcblach@us.ibm.com>
Date: Thu, 24 Jan 2002 08:30:54 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have just looked at the code for pinning tlbs and have several
suggestions for improvement.

1)put the tlb_4xx_index   in the first 64 k of memory.
2)add a tlb_4xx_watermark  in the same cache line as the index register.

Next, change the tlb miss code for pinning to

li   r22, tlb_4xx_index@l          #Since the tlb is in the first 64k, get
its address
                         #this saves two cycles and covers the access to
the watermark into the data cache.
lwz  r23,0(r22)               #now get the tlb index
li   r22,tlb_4xx_watermark@l  #get the watermark address
lwz  r22,0(r22)               #now get the watermark
cmpw cr0,r23,r22              #compare the index to the watermark
blt  66f
li   r23,0                    #set the watermark to 0
li   r22,tlb_4xx_index        #get the address of the index
stw  r23,0(r22)               #save the new index.

This has the advantange of allowing the user to select the number of tlb's
they wish to pin, although software in the tlb pin routines should limit it
to the current 4.

It also has very good performance, being about as long as the current
replacement mechanism.
Since the TLBs water mark are paired in a cache line accessing the index
covers the access to the
watermark so that it only takes one extra cycle, even if the line is a
cache miss.

Of course the tlb_pin routine has to correctly set up the watermark
register, which is not a big deal.

Another suggestion would be to load the address of the index and  eariler
and do a dcbt and allow these be brought into the
data cache eariler and save a possible miss.

Also, I modified the Journeyman kernel to allow riscwatch to function
correctly  and I performed the following experiment.
In finnish_tlb_load, there is a tlbsx instruction and I wanted to see if
tlbsx every made a match.

To do this I split the different paths and put a breakpoint on the tlbsx
matching path.
I never saw a match.  If we are really concerned about performance and this
instructionever produces a match,
it should be eliminated from the instruction path and thus saving two
instructions.

Chip





Chip


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
