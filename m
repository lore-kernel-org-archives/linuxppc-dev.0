Message-ID: <01a901c28c85$22aa99a0$e600a8c0@udtech.net>
From: "Shen Rong" <rshen@udtech.com.cn>
To: "Hans Feldt" <Hans.Feldt@uab.ericsson.se>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <3DD254F0.3050701@uab.ericsson.se>
Subject: Re: 8260 - Spurious interrupts again
Date: Fri, 15 Nov 2002 16:58:13 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Hans,
    Existing to see you r using the similar solution as mine: 755 with 8250 as slave.
I am not lonely:)

    I have the same problem like you, and I added a "sync" at the last line in
m8260_mask_and_ack like you, and it solves the ploblem. But it is interesting
that if I add a "sync" above the last line, it's also ok, that's

 simr[word] = ppc_cached_irq_mask[word];
__asm__ volatile("sync");
 sipnr[word] = 1 << (31 - bit);

The more, if I add an loop which does only "i++" like that:
simr[word] = ppc_cached_irq_mask[word];
{
        int i,j=0;
        for(i=0;i<150;i++)j++;
        i=j;
/*__asm__ volatile("sync");*/
}
sipnr[word] = 1 << (31 - bit);

it will also solve the problem. If I decrease the loop count, say to
100, the spurious interrupt will be much less than without the for loop,
the less the loop count, the more the spurious interrupts(my 755 is 400Mhz
and with L2 Cache enabled both for data and instruction). That's to
say it's a time problem not a sync problem. I mean the "mask" operation
need time to function properly. Note the following Motorola FAQ:

"Problem:
 For the system which consists of an external processor such as mpc750 and
PQ2 with 603e core disabled, what is the delay from the time the PQ2 interrupt
mask register is written and the time the /INT is negated?
Solution:
 It is four cycles from /TA sampled low to /INT sampled low.
Interrupt service routine should take account of this delay. "

I think it also means it needs time between the set-register operation to the IRQ
controller see it finally, right? Also note the following comments in MPC8260UM:

"If an SIMR bit is masked at the same time that the corresponding SIPNR bit causes
an interrupt request to the core, the error vector is issued (if no other interrupts
pending). Thus, the user should always include an error vector routine, even if it
contains only an rT instruction. The error vector cannot be masked."

So I think there should be a time delay when we do mask&ack(&following operation maybe).
But I don't know which solution will be the least performance degrading one.
I am still searching.

Shenrong

----- Original Message -----
From: "Hans Feldt" <Hans.Feldt@uab.ericsson.se>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, November 13, 2002 9:34 PM
Subject: 8260 - Spurious interrupts again


>
> I am running a 750 with a 8260 as slave. Since I get heaps of spurious
> interrupts I started digging into it. The old thread "8260 - Spurious
> interrupt when calling __sti()" and the latest code didn't help but this
> does:
>
> - A sync instruction last in m8260_mask_irq and m8260_mask_and_ack in
> ppc8260_pic.c.
>
> I guess you need to let the write to SIMR make it before enabling
> external interrupts in the 750 (603). This is probably due to our use of
> 8260 as a slave processor but I think it makes sense anyway.
>
> Note that this problem is not related to the fact that I am running the
> new ATM driver, this also happens as indicated in the old mail thread
> with serial and Ethernet interrupts only.
>
> Thanks,
> Hans
>
> P.S. Tack Magnus!
>
> without sync:
> ==============
> bash-2.04# cat /proc/interrupts
>             CPU0
>    4:       9777   8260 SIU   Edge      uart
>    5:          0   8260 SIU   Edge      uart
>   32: 1396813673   8260 SIU   Edge      atm
>   33:      57596   8260 SIU   Edge      fenet
>   41:          0   8260 SIU   Edge      uart
>   42:          0   8260 SIU   Edge      uart
>   60:         11   8260 SIU   Edge      ide0
> BAD: 1396813185
>
> with sync:
> ===========
> bash-2.04# cat /proc/interrupts
>             CPU0
>    4:       4709   8260 SIU   Edge      uart
>    5:          0   8260 SIU   Edge      uart
>   32:     217671   8260 SIU   Edge      atm
>   33:      10395   8260 SIU   Edge      fenet
>   41:          0   8260 SIU   Edge      uart
>   42:          0   8260 SIU   Edge      uart
>   60:         11   8260 SIU   Edge      ide0
> BAD:          0
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
