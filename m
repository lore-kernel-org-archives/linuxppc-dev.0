Message-ID: <39203732.AD113B13@charter.net>
Date: Mon, 15 May 2000 12:43:14 -0500
From: "Dan A. Dickey" <ddickey@charter.net>
MIME-Version: 1.0
To: Richard Hendricks <richard.hendricks@motorola.com>
CC: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How to get rom code to go on FADS?
References: <391B220F.9838E70F@charter.net> <391C3273.4BBF0884@motorola.com> <391C3945.9E0A439F@charter.net> <391C5416.15ADA181@motorola.com> <391D5E99.D14A02F2@charter.net> <39201DD2.2135361E@motorola.com> <39202D2C.385DD3B@charter.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Dan A. Dickey" wrote:
...
> I'll let you know more soon.

Ok, I'm down to this bit of code:
        .text
        .globl  version_string
version_string:
        .string "8xxROM 0.3.0"
        . = 0x100

        .globl  _start
Xreset:
        addis   r2,0,_start@h
        ori             r2,r2,_start@l
        mtspr   LR,r2
        bclr    20,0
        nop

nop
... intermediate code suppressed ...

        .globl  _end_of_vectors
_end_of_vectors:


        . = 0x2000

_start:
        /* the original fadsrom code by Dan Malek did a lot of setup
*/
        /* in assembler, I moved most of the code to C for readability
*/

        addis   r3, 0, _start@h
        ori             r3, r3, _start@l
        addi    r3, r3, 0x0014  /* Jumps us into the NOPs below */
        mtctr   r3
        bctr

        nop
        nop

#if 0
        /* Now we need to fix the LR since it points back to
0x0000_010x,
         * not 0x0280_010x like it needs to after we muck up the BCSR's
*/

        mflr    r3
        oris    r3, r3, 0x0280
        mtlr    r3
#endif

        addis   r0,0,0

        addi    r3, r0, MSR_    /* Set ME, RI flags */
        mtmsr   r3
        mtspr   SRR1, r3        /* Make SRR1 match MSR */

#if 0
        /* Make the LR equal the PC. */
        oris    r3,r0,sync_jump@h
        ori             r3,r3,sync_jump@l
        mtspr   LR,r3
        bclr    20,0
sync_jump:
#endif

#if
1
        /* position IMMR */

        lis     r1, IMMR_VALUE@h
        ori     r1, r1, 0
        mtspr   638, r1

bror1start:
        /* need to setup BR1/OR1 to get to the BCSR on the fads */
        lis r9,0xffff
        ori r9,r9,0x8110
        lis r10,0x0210
        ori r10,r10,0x0001
        stw r9,0x10C(r1)
        stw
r10,0x108(r1)

Ok, so I build this and put it into the flash.
While mpc8bug & the ADI are connected I power off, wait a bit, power on.
Enter "reset :ni" at the mpc8bug prompt.
Then, "br 02802038"  (bror1start: address),
followed by "go 100".

I get the following from mpc8bug:
f850SARBug> br 02802038
f850SARBug> go 100
  Use Ctrl-C to abort execution !
warning: might be in unrecoverable exception state (SRR1[RI]=0)
exception: DEVELOPMENT PORT INTERRUPT
0x00000100      3c400280 addis r2,r0,0x280
f850SARBug>

So, to me at the moment; it appears to not even be reaching bror1start.
Any suggestions?

Something here just seems plain wrong - some little thing that is
pretty innocuous but because its not set right, turns out to be
a showstopper.  As soon as I (or someone else) finds it, it'll be
a "Doh - of course we need to do that...".

Any and all suggestions will be appreciated (and quite possibly tried).
	-Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
