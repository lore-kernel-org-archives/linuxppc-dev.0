Message-ID: <XFMail.20030828152509.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <1062059514.1293.112.camel@gaston>
Date: Thu, 28 Aug 2003 15:25:09 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Random crashes
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 28-Aug-2003 Benjamin Herrenschmidt wrote:
>> > Strange. I haven't been reported such problems. Can you try an older kernel
>> > just in case ? Could also be bad ram...
>>
>> I tried 2.4.22 and I replaced the RAM. Nothing. Digging in the oops
>> collection I found this one which doesn't look very nice:
>>
>> Jul 23 21:37:55 localhost kernel: Machine check in kernel mode.
>> Jul 23 21:37:55 localhost kernel: Caused by (from SRR1=20009030): L1 Data Cache error
>>
>> I'll send the machine back for repair, altought I think they'll not even
>> notice the problem because it happens sporadically :(((
>
> Well... I'm not 100% sure the message is correct, though from what you say,
> it seems indeed there is a CPU fault...

Yes, but it happened only once. All the others were "normal" segfaults, in both
userspace and kernel space and hard lockups.


> What CPU is this exactly ? (/proc/cpuinfo)

processor       : 0
cpu             : 7455, altivec supported
clock           : 1249MHz
revision        : 3.3 (pvr 8001 0303)
bogomips        : 1248.46

processor       : 1
cpu             : 7455, altivec supported
clock           : 1249MHz
revision        : 3.3 (pvr 8001 0303)
bogomips        : 1248.46

total bogomips  : 2496.92
machine         : PowerMac3,6
motherboard     : PowerMac3,6 MacRISC3 Power Macintosh
detected as     : 129 (PowerMac G4 Windtunnel)
pmac flags      : 00000000
L2 cache        : 256K unified
memory          : 512MB
pmac-generation : NewWorld

I'm reading the latest 7455 errata
http://e-www.motorola.com/files/32bit/doc/errata/MPC7455CE.pdf
but I don't see anything that can cause L1 errors.


Unrelated thing: tlbli instruction can cause problems on 7455 (bug.20).
arch/ppc/kernel/head.S does not use the suggested workaround.


Bye.
    Giuliano.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
