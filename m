Message-ID: <3946B3E0.58B82822@noos.fr>
Date: Wed, 14 Jun 2000 00:21:19 +0200
From: Guillaume Laurhs <guillaume.laures@noos.fr>
Reply-To: guillaume.laures@noos.fr
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: SMP now working - summary
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

First I'd like to thank everybody who contributed to the solution.

It turned out bootX couldn't make linux take over MacOS sucessfully on
both processors, now I'm using OF/quik and I see the twin penguins and a
cool /proc/cpuinfo on stock 2.2.16 from ftp.kernel.org.

Note that I had to delete the partition containing Darwin, I think I
will have to swap out the linux and Darwin partition if I want to
experiment both (the darwin partition is bootable, and quik can be
launched only from the first bootable partition by OF, which in my case
was the darwin partition)
BTW, quik don't launch darwin sucessfully...

A "little" summary for people wanting to troobleshoot smp later:

 - having a smp kernel (easy to compile, but if you disagree with this
try the one from
ftp://borg.mit.edu/pub/linux/linuxppc/kernels/multiprocessor/

To check if a kernel has smp enabled, run it (can be done on a non-smp
machine I think) and do a cat /proc/version ; on mine :

Linux version 2.2.16 (root@pm9500) (gcc version 2.95.2 20000313 (Debian
GNU/Linux)) #2 SMP Mon Jun 12 16:59:05 CEST 2000

you can see informations related on the machine I compiled it on, as
well as the 'SMP' tag which indicates its multiporocessor aware

 - you should see two penguins (for a bi-processor machine...) at boot,
and have a /proc/cpuinfo not far from this one :

processor       : 0
cpu             : 604e
clock           : 180MHz
revision        : 2.2
bogomips        : 358.81

processor       : 1
cpu             : 604e
clock           : 180MHz
revision        : 2.2
bogomips        : 358.81

total bogomips  : 717.62
zero pages      : total 0 (0Kb) current: 0 (0Kb) hits: 0/457 (0%)
machine         : Power Macintosh
motherboard     : AAPL,9500 MacRISC
L2 cache        : 512K unified
memory          : 64MB

ie with two "processor" tags, the first processor is numbered 0, a
second 1 and so on...

And have a dmesg sequence containing those two lines :

[...]
POSIX conformance testing by UNIFIX
Entering SMP Mode...      <-----------
Processor 1 found.            <-----------
PCI: Probing PCI hardware
adb devices: [2]: 2 5 [3]: 3 1
Linux NET4.0 for Linux 2.2
etc...

 - IF YOU DON'T GET THIS ; at the beginning I had only one penguin, a
/proc/cpuinfo missing a processor (only processor 0 present), and this
in dmesg :

Entering SMP Mode...
Processor 1 is stuck.

instead of the two lines I highlighted just before

THEN you can try the following (from the easiest to the hardest):

use the bootX extension instead of the app
use an MacOS version older than the 9.0 which I was using, for example
8.5 or 8.1
setup quik for Open Firmware
try mklinux

According to the mails I got, SMP on ppc is reported to work on the
following machines :
Power3 box (2.3.99-pre9, wow !)
UMAX S900 (without usb)
PM 7300 (2x200 Daystar nPower, 2.2.12)
and of course my PM9500 (2x180 Daystar nPower, 2.2.16)

Now I can try some fancy hardware (initio, realtek...) !!

and again, thanks to everybody who brought a solution :-)


GoM

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
