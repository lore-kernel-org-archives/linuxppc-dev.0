Date: Sat, 16 Nov 2002 21:58:43 -0800
Subject: Re: csum_partial() and csum_partial_copy_generic() in badly optimized?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v548)
Cc: <linuxppc-dev@lists.linuxppc.org>
To: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
From: Tim Seufert <tas@mindspring.com>
In-Reply-To: <000f01c28d59$35cf9ec0$0200a8c0@telia.com>
Message-Id: <A09E986A-F9F1-11D6-AEE9-003065F22EAA@mindspring.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Saturday, November 16, 2002, at 02:16  AM, Joakim Tjernlund wrote:

>> The comment is probably correct.  The reason the instruction has
>> (effectively) zero overhead is that most PowerPCs have a feature which
>> "folds" predicted-taken branches out of the instruction stream before
>> they are dispatched.  This effectively makes the branch cost 0 cycles,
>> as it does not occupy integer execution resources as it would on other
>> possible microarchitectures.
>>
> hmm, I am on a mpc860 and I get big performace improvements if I apply
> unrolling. Consider the standard CRC32 funtion:
> while(len--) {
>         result = (result << 8 | *data++) ^ crctab[result >> 24];
> }
> If I apply manual unrolling or compile with -funroll-loops I get
>> 20% performance increase. Is this a special case or is
> the mpc860 doing a bad job?

Don't forget about gcc.

In the code you originally were talking about, the PPC CTR register and
bdnz instruction were used to implement the loop counter.  bdnz puts
all the loop overhead (counter decrement, test, and branch) into one
instruction.  Since that instruction is a branch, it can be folded, and
thus have 0 overhead.  CTR and the instructions which operate on it
(such as bdnz) were put into the PPC architecture mainly as an
optimization opportunity for loops where the loop variable is not used
inside the loop body.

There is no guarantee that gcc will always use CTR, even for such
obvious candidates as the crc32 loop.  gcc is simply not that great at
PPC optimization, especially at low optimization levels.  I've just
been playing with gcc 2.95.4 on YDL 2.3 and Apple's gcc 3.1 on OSX
10.2.2 (these versions are merely what I happen to have installed on
machines that are handy).  Here's a summary of when gcc will compile
that crc32 loop with use of CTR and bdnz (note that -O3 or above
automatically turn on -funroll-loops, so I saw no point in testing
those levels):

           -O1    -O2    -O1 -funroll-loops    -O2 -funroll-loops
2.95.4    no     no     no                    no
3.1       no     yes    yes                   yes

If gcc isn't generating a CTR loop to start out with, the crc32 code
will benefit more from unrolling than it should.

I did a bit of crude performance testing, and with gcc 3.1 there is no
difference in the cache-hot performance of the crc32 loop when
switching between -O2 and -O2 -funroll-loops.

Now, that _was_ on a 7455.  You would see some difference on a 860,
because gcc 3.1 did find something else to optimize.  Here's the loop
body for -O2:

L48:
         ; basic block 2
         lbz r9,0(r3)    ; * data
         rlwinm r0,r30,10,22,29  ;  result
         lwzx r11,r10,r0 ;  crctab
         addi r3,r3,1    ;  data,  data
         slwi r0,r30,8   ;  result
         or r0,r0,r9
         xor r30,r0,r11  ;  result
         bdnz L48

With -O2 -funroll-loops, gcc copies this loop body four times, and
transforms the addi (increments 'data' ptr by 1) and lbz (loads *data)
instructions.  addi is hoisted from the loop body and instead the
pointer is incremented by 4 at the end of the unrolled loop.  Each lbz
copy has the appropriate offset (0, 1, 2, 3) to simulate the original
pointer incrementing.  The net effect is that for every four iterations
of the original loop we execute three fewer addi instructions.

The 7455 has a lot of integer execution units and can probably do the
extra adds for free, but the 860 is basically a 601, and I think the
601 had just one IU, so the adds will not be free.

But if you go back to that original loop in csum_partial() etc., I
don't see any opportunity to perform similar optimizations.  So I doubt
very much that unrolling that loop would have any benefit even on the
860.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
