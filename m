Date: Tue, 22 Feb 2000 12:40:29 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: FASSINO Jean-Philippe <jeanphilippe.fassino@cnet.francetelecom.fr>
cc: Paul Mackerras <paulus@linuxcare.com>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Patch for optimize context switch
In-Reply-To: <38B25749.2C4B0E1A@cnet.francetelecom.fr>
Message-ID: <Pine.HPX.4.10.10002221056430.4957-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 22 Feb 2000, FASSINO Jean-Philippe wrote:

> There are two advantages of this patch :
>     - unrolling the loop (suppress the bdnz instructions),

Cost of bdnz is virtually zero (one slot in the cmoletion queue).

>     - statically designate segment register (suppress one add per loop).

The cost of the add is negligible.


> The main disadvantage is :
>     - possibly increase i-cache misses (depend of function alignment)

Transforming a 4 instruction loop executed 12 times into straight code
needing 24 or so instruction code, you add something like 2
cache lines to the footprint. Instruction issue in the loop is not a
problem on 603/G3/G4 (2 clocks) or 604 (1 or 2 clocks depending on
alignment).

Instruction completion is often the problem and the limiting factor
actually on all processors except the 604 (the documentation clearly
states that the second completed instruction must be an integer or load,
so that the bdnz which writes back the ctr is bad since it takes an
additional clock in the completion queue):

If I interpret correctly the G3/G4 docs
- t=0, previous instruction completed, mtsrin starts, which takes 2 clocks,
- t=1, mtsrin + add complete
- t=2, second add complete
- t=3, bdnz complete
- t=4, previous instructions completed, mtsrin starts

that's 4 clocks per iteration. Which is more than the 2 clocks we can get
by interleaving mtsr/add. Cost for 12 iterations is 24 clocks, which is
still cheaper than 2 cache line feches IMHO. However, changing the loop
to:

        rlwinm  r3,r3,4,8,27    /* VSID = context << 4 */
        addis   r3,r3,0x6000    /* Set Ks, Ku bits */
        lis     r4,0xc000
	lis	r5,0xf000
        addi    r3,r3,12        /* Last segment to write */
3:      add.    r4,r4,r5        /* address of next segment */
        addi    r3,r3,-1        /* next VSID */
	mtsrin  r3,r4
        bne     3b

transforms the branch into a folded branch which saves one clock in the
completion unit:

- t=0: previous instructions complete, mstrin starts, takes 2 clocks
- t=1: mtsrin and first add complete, branch has been folded
- t=2: addi complete, branch has been
- t=3: previous instruction completed, mtsrin starts

however this will only save 12 clocks from each context switch. I think
that there are other areas to focus on to improve performance.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
