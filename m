Message-Id: <v04003a04b60151e18975@[24.70.162.14]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 4 Oct 2000 16:53:01 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: 2.4 madness!
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok, so in an effort to exploit cheap-ass IDE HDs, I'm playing around with a
plain vanilla Promise ATA100 card in a Pmac 7600 (which currently runs
2.2.15 just fine).

I first tried compiling a 2.2.17 kernel with the latest ide patch, which
resulted in a machine check on startup. bummer.

Next off I tried a linus-2.4.0-test8 (cross compiled from my x86 box this
time, since the pmac hasn't the HD space - exactly the problem I'm trying
to fix), which blew up too. This was copied down by a friend (I'm trying to
do this all from across the city):

Welcome to Linux..  Yada yada.
Started at: 0x00000000
Linked at:  0xc0000000
Frame Buffer at: 0x94300210 (phys), 0x94c00210 (log)
klimit:     0x00000042
HID0:       0x8000c084

booting...
pmac_init(): exit
id mach(): done
MMU: enter
MMU: hash init
hash: enter
hash: find piece

and that's it.

Next I rsynced over top of this kernel with
rsync://ppc.samba.org/linux-pmac-devel from late-ish last night, and had my
friend hook up a serial cable, and got this:

<4>On node 0 totalpages: 20480
zone(0): 20480 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/sdb7 console=ttyS1,9600 video=ofonly
System has 32 possible interrupts
GMT Delta read from XPRAM: -300 minutes, DST: on
via_calibrate_decr: ticks per jiffy = 100001 (600009 ticks)
Console: colour dummy device 80x25
<4>Total memory = 80MB; using 512kB for hash table (at c0300000)
Linux version 2.4.0-test9 (nicoya@ubb) (gcc version 2.97 20001003
(experimental)) #5 Wed Oct 4 10:41:11 CDT 2000
PCI bus 0 controlled by bandit at f2000000
Cache coherency enabled for bandit/PSX at fdee9000
PCI bus 1 controlled by chaos at f0000000

over and over and over and over and over.

Should I be expecting 2.4 to work, or is it still not quite there yet?


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
