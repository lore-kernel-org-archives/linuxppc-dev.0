Message-Id: <v03110700b398a5992950@[209.96.179.153]>
In-Reply-To: <199906220307.NAA01278@farrago.anu.edu.au>
References: <Pine.LNX.3.95.990621201542.23566A-100000@pacific.pht.com>
 (message from Brad Midgley on Mon, 21 Jun 1999 20:37:08 -0600 (MDT))
 <Pine.LNX.3.95.990621201542.23566A-100000@pacific.pht.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 24 Jun 1999 23:37:36 -0400
To: Paul.Mackerras@cs.anu.edu.au, linuxppc-users@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
From: "Kevin B. Hendricks" <kbhend@business.wm.edu>
Subject: Machine Check in Kernel Mode with Paul's 2.2.10 on B+W G3
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Well I just received my B+W G3 yesterday and Paul's 2.2.10 kernel
annoucement seemed like fate so I tried to boot with it to no avail:

Here are some of the interesting things the error report had to say:

System: Brand new B+W G3 with 12 gig ATI drive and Adatec AIC-7850 scsi
host adapter found at PCI 2/0 with a 3 gig scsi Quantum drive with R5/YDL
on it (which will boot fine on my PowerTower 180e).

Partion check:
  sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8   (sda5 is the root partition)
  sdb: scsidisk I/O error: dev 08:10 sector 0
  unable to read partition table  (this is my zip drive without a disk in it)
  hda: hda timeout waiting for DMA

Machine check in kernel mode
Caused by (from msr): regs c01a4c18 Unknown values in msr

Here are some register values:
   NIP: C00BDE58  LR: C00BDE14  MSR: 00009030  Trap: 0200
Task= c01a2f58[0] 'swapper' mm->pgd
Last syscall: 112

Backtrace: C00BDE14 COO13C04 C001C850 C0003B68 C001F460 C00069F4 ...


>From looking at the booting log messages, everything seems fine up to the
very end (it finds the scsi drive, finds the partitions, finds the USB hub,
USB mouse, etc).  There does not seem to be anything unusual until the DMA
timeout message waiting for hda.

Any ideas here?  I used Paul's System.map to try and track down the
offending routines but none of the backtrace addresses line up exactly with
any of the map entry points (am I missing an offset here?)

Any ideas here would be greatly appreciated.  My entire JDK build tree for
glibc 2.1 is on the hard drive I am trying to boot from but my wife now has
my old machine (PT 180e) and I can't go begging to borrow that machine
back, so please any help in getting Linux to boot with this machine would
be greatly appreciated.

Thanks,

Kevin





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
