Message-ID: <20040427015358.59362.qmail@web11204.mail.yahoo.com>
Date: Mon, 26 Apr 2004 18:53:58 -0700 (PDT)
From: Frank Yang <young726@yahoo.com>
Subject: 405GP booting question
To: linuxppc-embedded@lists.linuxppc.org
Cc: young726@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

I am using 405GP custom board with 16M memory but I
got stuck when I tried to boot mvista linux.

Right now my boot loader can start the "simple" boot
loader coming with mvista linux and simple boot loader
can take over the control and make some
initialization such as serial port initialization etc.
And I did get the serial output such as
"loaded at xxxx xxxx
relocated to xxxx xxxx
zImage at xxxx xxxx
avail ram xxxx xxxx

Now booting the kernel"

But the system hangs after this output. I check the
code and found the head_4xx.S (I am using 405GP) has
been called. But somehow the program stopped at the
following part:

"
/* We now have the lower 16 Meg mapped into TLB
entries, and the
caches
 * ready to work.
 */

turn_on_mmu:
    li  r0,MSR_KERNEL
    mtspr   SRR1,r0
    lis r0,start_here@h
    ori r0,r0,start_here@l
    mtspr   SRR0,r0
    SYNC
    rfi             /* enables MMU */
"


The program stopped right after SYNC and before rfi. I
think rfi is pretty straightforward. It's just used to
start run "start_here". I don't quite understand what
make the program stop here. Also, why is the comment
of instruction rfi "enables MMU"? How is the MMU
enabled here? I put a break point in start_here and
was sure that start_here hasn't been called. Anyone
can give me some clues?

Thanks in advance!


Frank





Win a $20,000 Career Makeover at Yahoo! HotJobs
http://hotjobs.sweepstakes.yahoo.com/careermakeover

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
