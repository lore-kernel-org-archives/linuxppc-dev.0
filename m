Message-ID: <3945518F.B3185904@noos.fr>
Date: Mon, 12 Jun 2000 23:09:35 +0200
From: Guillaume Laurhs <guillaume.laures@noos.fr>
Reply-To: guillaume.laures@noos.fr
MIME-Version: 1.0
To: Charles E Leiserson Jr <locutus@MIT.EDU>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: SMP
References: <200006121812.OAA19506@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Charles E Leiserson Jr a *crit :

> You can get a working SMP kernel at ftp://borg.mit.edu/pub/linux/linuxppc/kerne
> ls/multiprocessor/ with all of its support files.  It's a bit old (2.2.12),
> but it works.

Unfortunately, it doesn't work. BootX 1.2.2 shows up only one penguin, and I get
the same /proc/cpuinfo.
I realized that I have this oddity in dmesg :

Entering SMP Mode...
Processor 1 is stuck.

On 2.2.16 it's the same (dmesg from the begining) :

device tree used 31392 bytes
Total memory = 64MB; using 256kB for hash table (at c0240000)
Linux version 2.2.16 (root@pm9500) (gcc version 2.95.2 20000313 (Debian
GNU/Linux)) #2 SMP Mon Jun 12 16:59:05 CEST 2000
PCI bus 0 controlled by bandit at f2000000
Cache coherency enabled for bandit/PSX at f2000000
PCI bus 1 controlled by bandit at f4000000
Cache coherency enabled for bandit/PSX at f4000000
System has 32 possible interrupts
via_calibrate_decr: decrementer_count = 112500 (675003 ticks)
Console: colour dummy device 80x25
Calibrating delay loop... 358.81 BogoMIPS
Memory: 62364k available (1228k kernel code, 1848k data, 96k init) [c0000000,c40
00000]
Dentry hash table entries: 8192 (order 4, 64k)
Buffer cache hash table entries: 65536 (order 6, 256k)
Page cache hash table entries: 16384 (order 4, 64k)
POSIX conformance testing by UNIFIX
Entering SMP Mode...
Processor 1 is stuck.            <--------------------
PCI: Probing PCI hardware...

It sounds like the second processor cannot be correctly started...

I tried with an older bootX (1.1.3) it's the same. For now, I can't quik, I think
Darwin messes up quik (it's installed on a partition before linux).

The cards work well under MacOS, distributed.net client makes a full use of both
processors (which brings the 9500 a bit higher than a G3@333, but still 3,5 times
lower than a G4@450..., always accordingto dnet's client)


Any though about this ? Any way to debug ??

Thanks,

GoM


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
