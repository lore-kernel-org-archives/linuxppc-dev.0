Mime-Version: 1.0
Message-Id: <v04220801b664d1b729df@[10.0.0.42]>
Date: Tue, 19 Dec 2000 01:13:11 -0800
To: linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: SMP G4 interrupt oddities
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm playing around with G4 SMP using the straight kernel.org 2.2.18.
I noticed that interrupts are primarily being serviced by one of the
two CPUs, instead of load balancing as I expected:

            CPU0       CPU1
   5:          0          0   OpenPIC       SCC-txdma
   6:          0          0   OpenPIC       SCC-rxdma
   7:          0          0   OpenPIC       SCC-txdma
   8:          0          0   OpenPIC       SCC-rxdma
   9:          0          0   OpenPIC       AWACS out
  19:       1490       4709   OpenPIC       ide0
  20:          2          4   OpenPIC       ide1
  22:          0          0   OpenPIC       SCC
  24:          0          1   OpenPIC       AWACS
  25:          0          4   OpenPIC       VIA-PMU
  27:        266        959   OpenPIC       usb-ohci
  28:          1          8   OpenPIC       usb-ohci
  41:          0          6   OpenPIC       eth0
  47:          0          0   OpenPIC       GPIO1/ADB
  50:          0          0   OpenPIC       SCC
  53:       6478      25846   OpenPIC       aic7xxx, aic7xxx
  70:          0          0     IPI0
  71:          0          0     IPI1 (invalidate TLB)
  72:          0          0     IPI2 (stop CPU)
  73:       6972       6506     IPI3 (reschedule)
IPI: (recv/sent)      13478/13493
BAD:          1


Isn't the OpenPIC supposed to fairly distribute interrupts between
the two processors?

Also, as seen above, I have 1 (sometimes 2)  bad interrupts listed
after booting, but the count never increases.   Are these spurious
interrupts a side effect of starting the second CPU?

Finally, the boot log generally has one or two of the following lines
printed by some debugging in the PPC spinlock implementation:

_spin_lock(c01fb0e0) CPU#1 NIP c0036a44 holder: cpu 0 pc C00049F8

This appears to be what the spinlock code will do if it times out.
I'm pretty sure this is triggered by starting the second CPU, since
it happens only once right after the second CPU is started during
boot.  But I do wonder why the spinlock code has such a nasty
debugging printk left in it.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
