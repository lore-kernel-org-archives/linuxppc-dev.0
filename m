Message-Id: <v03010d13b43bd5fd445b@[192.168.1.16]>
In-Reply-To: <Pine.LNX.4.05.9910262020350.665-100000@callisto.of.borg>
References: <v03010d0cb43a9d52cd3e@[192.168.1.16]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 26 Oct 1999 15:13:22 -0700
To: linuxppc-dev@lists.linuxppc.org
From: Rob Barris <rbarris@quicksilver.com>
Subject: Re: question about altivec registers
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>On Mon, 25 Oct 1999, Rob Barris wrote:
>> >The flag is to actually tell the kernel that your application is using
>> >the Altivec registers, so that it can save time by not saving and
>> >restoring them when the interrupted or swapped application is not using
>> >them. It is supposed to be dynamic so only routines actually using Altivec
>> >should set (and clear) it. I am not sure of the details so look into the
>> >manual for the hardware support. I think the kernel should enforce the
>> >use of this flag since moving the full Altivec register set is time
>> >consuming (16 bytes X 32 registers = 1/2 KB).
>>
>>    I worked this out once, the extra 512 bytes of register context,
>> multiplied by (say) a thousand context switches per second only add up to
>> about a MB of memory traffic per second - a fraction of a percent of the
>> available memory bandwidth in a G4 machine.  Most of that will sit in cache
>> anyway depending on the working set size of the processes involved.
>
>Moving around blocks of 512 bytes quickly thrashes the L1 cache, unless the
>loads/stores are done using cache-bypassing instructions (cfr. MOVE16 on
>'040).
>Don't know whether PPC has these (still no PPC guru :-(


   Well, doing anything useful will cause traffic in and out of L1. That's
just a fact of life.  "Thrash" is a strong word, considering we're talking
about 512 bytes of data, that's 512/32768 == 1/64 of the typical PPC 750
data cache.

   Further, the PPC register state was already large (at least 384 bytes
for all 32 int and 32 fp regs) - no one seemed to be noticing context
switch time as a problem before, this further supports my assertion. 2.5
times "tiny" is still "tiny".

   Now, copying a 16K or 32K block from point A to point B will indeed
cause a complete cache replacement.  But that's not what's going on here.
In fact, for a few processes being switched between rapidly, it may well be
the case that those register state blocks may park in the L1 or L2 and not
go back out to main memory at all.   But my estimate was based on a worst
case again, and assuming that anything leaving L1 has to go to RAM and not
the L2.

   The point I was trying to make is that even in a hypothetical worst case
scenario, the added traffic is modest and possibly below the threshold of
noticeability.

   Moving things in and out of L1 is not bad in itself. The net impact is
what matters, that's what my calculation was trying to show.  If for
example, memory was infinitely fast, traffic to and from L1 would have no
impact.  OK so that's not true, the question then becomes "so how much time
does in fact get spent servicing that traffic, given real memory speeds".
At a hypothetical switch rate of 1KHz (extremely high) the overhead is
still quite small.

--
Rob Barris       Quicksilver Software Inc.      rbarris@quicksilver.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
