Return-Path: <hugh@blemings.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCp692cQ6zDqCm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 14:10:25 +1100 (AEDT)
From: Hugh Blemings <hugh@blemings.org>
Subject: Timekeeping oddities on MacMini G4s
To: linuxppc-dev@ozlabs.org
Cc: devel@ntpsec.org, Hal Murray <hmurray@megapathdsl.net>,
 Paul Mackerras <paulus@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <michael@ellerman.id.au>
Message-ID: <fa5edfe0-66fb-6f82-c3b3-67fdf0a09c8c@blemings.org>
Date: Wed, 1 Feb 2017 14:10:24 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I've recently been lurking on the ntpsec project mailing list.

One of the developers (Hal Murray, CCd) has been doing some tests of the 
codebase using FreeBSD and Debian on a G4 based Mac Mini - this largely 
motivated by checking all is well on a big-endian system.

Hal has identified what appears to be a systemic inaccuracy in kernel 
timekeeping of around 2500ppm on both Linux and FreeBSD and on several 
different MacMini G4s (1.42GHz and 1.5GHz variants)

That it appears on both Linux and FreeBSD kernels and some other data 
points leads us to wonder if the CPU frequency reported by Open Firmware 
being different to the actual raw clock is the root cause, but I/we 
speculate at this point.

To be clear we're not claiming "kernel bug" but something odd that 
perhaps the collective wisdom of ya'll might be able shed some light on, 
other places to dig etc.

Below is I hope sufficient salient information, copied from the various 
messages in the thread on the ntpsec mailing list.  If you'd like to 
refer to the original thread it's available in the archive starting here 
- https://lists.ntpsec.org/pipermail/devel/2017-January/003443.html

Would welcome any feedback/pointers you can provide.

Insights into how the various values from OpenFirmware interact with the 
derived figures in the kernel would be interesting too :)

Thanks,

Cheers,
Hugh


-------------------------
 From Hal's original email;

I'm reasonably confident that the system doesn't keep reasonable time 
when ntpd isn't running.

Here is my test case:
   assuming you have a working ntp setup
   add "disable ntp" to ntp.conf
   make sure you are logging loopstats:
     statsdir /var/log/ntp or ntpstats or ...
     filegen loopstats  type day link
reboot the system to start clean

You will get things like this in loopstats.
57783 14135.823 0.684044126 0.000 0.000000954 0.000000 6
57783 14137.823 0.688713522 0.000 0.000000954 0.000000 6
57783 14139.823 0.692100011 0.000 0.000000954 0.000000 6
...
57783 16640.823 6.663863776 0.000 0.000000954 0.000000 6
57783 16692.823 6.743695119 0.000 0.000000954 0.000000 6
57783 16708.823 6.823918338 0.000 0.000000954 0.000000 6
The second column is the seconds this day.
The 3rd column is the offset from the servers you are using.
It should be changing slowly.  If it is slow enough, ntpd will correct 
it by adjusting the drift.

You can calculate the drift as
    (offset2-offset1)*1000000/(time2 - time1)

$ dc
16708.823 14135.823 - p
2573.000
6.823918338 0.684044126 - p
6.139874212
1000000 * p
6139874.212000000
2573.000 / p
2386

That's 2386 ppm.  "slow enough" is under 500 ppm.  Sane numbers are 
under 100.  (either sign)

Without the "disable ntp", the 4th column will be the drift.  It should 
vary with temperature.  Ballpark change is 1 ppm per C.

-------------------------

Collated system information;

$ uname -a
Linux deb-ppc.example.com 3.16.0-4-powerpc #1 Debian 3.16.39-1 
(2016-12-30) ppc GNU/Linux

$ cat /etc/issue
Debian GNU/Linux 8

--------------

First system - one used in sample case shown above, 1.5GHz CPU.

/pro/cpuinfo says:
processor       : 0
cpu             : 7447A, altivec supported
clock           : 1499.999994MHz
revision        : 1.2 (pvr 8003 0102)
bogomips        : 83.20
timebase        : 41600571
platform        : PowerMac
model           : PowerMac10,2
machine         : PowerMac10,2
motherboard     : PowerMac10,2 MacRISC3 Power Macintosh
detected as     : 287 (Mac mini (Late 2005))
pmac flags      : 00000010
L2 cache        : 512K unified
pmac-generation : NewWorld
Memory          : 512 MB

--------------

 From a second system (labelled as a 1.42GHz machine by Apple):
Same install image as first system;

$ more /proc/cpuinfo
processor       : 0
cpu             : 7447A, altivec supported
clock           : 1416.666661MHz
revision        : 1.2 (pvr 8003 0102)
bogomips        : 83.24
timebase        : 41620907
platform        : PowerMac
model           : PowerMac10,1
machine         : PowerMac10,1
motherboard     : PowerMac10,1 MacRISC3 Power Macintosh
detected as     : 287 (Mac mini)
pmac flags      : 00000010
L2 cache        : 512K unified
pmac-generation : NewWorld
Memory          : 512 MB

 From syslog;

30 Jan 19:46:40 ntpd[3773]: frequency error 2712 PPM exceeds tolerance 
500 PPM
30 Jan 19:46:43 ntpd[3773]: ntpd exiting on signal 15 (Terminated)

-----------------

Open Firmware provides:

1.42GHz machine
    41620997 027b1605 timebase-frequency
  1416666661 54709e25 clock-frequency
  1415000000 54572fc0 rounded-clock-frequency
  1415113906 5458ecb2 recalced-clock-frequency
   166483989 09ec5815 bus-frequency
   166666666 09ef21aa config-bus-frequency
          17 00000011 processor-to-bus-ratio*2

1.5GHz machine
    41600571 027ac63b timebase-frequency
  1499999994 59682efa clock-frequency
  1498000000 5949aa80 rounded-clock-frequency
  1497620583 5943e067 recalced-clock-frequency
   166402287 09eb18ef bus-frequency
   166666666 09ef21aa config-bus-frequency
          18 00000012 processor-to-bus-ratio*2

-----------------

Reports of possibly similar issues elsewhere

"Clock Drift on Mac Mini (G4-based), ajdtimex, ntp" - undated
http://i1.dk/misc/mac_mini_clock_drift_adjtimex_ntp.html

"System clock falls behind quickly on Mac mini G4" (2014 on FreeBSD)
https://lists.freebsd.org/pipermail/freebsd-ppc/2014-April/006931.html
