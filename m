Date: Sun, 7 Apr 2002 16:33:12 +0200
From: Albrecht Dre? <albrecht.dress@arcor.de>
To: mlan@cpu.lu
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Kernel Gurus: Module insertion deadlock? [Was: SCSI system freeze w/2.4.18]
Message-ID: <20020407143312.GA927@regulus>
References: <E16tZUq-00007a-00@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
In-Reply-To: <E16tZUq-00007a-00@piglet.grunz.lu>; from mlan@cpu.lu on Fre, Apr 05, 2002 at 21:35:34 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am 05.04.02 21:35:34 schrieb(en) Michel Lanners:
>
> Hey,
>
> On   4 Apr, this message from Albrecht Dre? echoed through cyberspace:
> > I upgraded my PowerMac 7300 from 2.4.6-pre3 to (stock) 2.4.18, and since
> > then I have a nasty scsi problem: Trying to read data from the cd drive
> > without a cd loaded (e.g. "dd if=/dev/scd0 of=/dev/null bs=1 count=1")
> > freezes the machine.
>
> Hmm, I tried your dd command on my 7600 this morning, and I see weird
> things as well.
>
> In fact, the system doesn't do _any_ disk access as long as the dd
> command sits there waiting for the cdrom. dd is unkillable, and it seems
> no other disk access is possible as long as dd waits.
[snip]
> Inserting a CD makes the dd command complete, and the system unfreezes.

O.k., this was more a "user panic", as the script hung upon system shutdown,
and after a while I simply powered off...

I played a little more with this, and got the following picture:

* scsi cd support built into the kernel: the access works without a cd in
   the drive

* scsi cd support built as module
   - do a "modprobe sr_mod" (which inserts sr_mod.o and cdrom.o): access
     works like support built fixed into the kernel;
   - remove sr_mod (cdrom.o may still be loaded): access leads to the hang as
     described.

So I think there is some kind of deadlock between dd and the module
insertion (which includes a disk access to read/load the module). As I do
not see this on an iMac with a ide cd drive, it might be a problem either in
sr_mod or in the scsi stuff. However, the iMac has two separate ide busses
for the cd and the disk, so the hang might be "same bus" related. Maybe some
of the kernel gurus know more about that?

Thanks,

	Albrecht.

--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Albrecht Dreﬂ  -  Johanna-Kirchner-Straﬂe 13  -  D-53123 Bonn (Germany)
        Phone (+49) 228 6199571  -  mailto:albrecht.dress@arcor.de
_________________________________________________________________________

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
