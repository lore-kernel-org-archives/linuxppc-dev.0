Message-ID: <39888816.AEA4C307@mvista.com>
Date: Wed, 02 Aug 2000 13:44:06 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: lmphuc@yahoo.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: FWD: Installing PCMCIA hard disk on DVK MPC823
References: <380658298.965240776157.JavaMail.root@web621-wrb.mail.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> My name's Phuc Le. I am new on this field. I just installed
> PCMCIA HDD on the the DVK MPC823 but it failed.

What is the DVK 823? I  haven't heard of that one.


> The result was the cardmgr detects the flugged pcmcia device to be
> ATA/IDE and it tried to load the 'ide_cs.o' module. But it failed. The error
> message were displayed as below:
>
> .... ide_cs.o: unresolved symbol 'ide_register'
> .... ide_cs.o: unresolved symbol 'ide_unregister'
>
> I tried to rebuilt the kernel with turn-on some IDE features in the
> configuration phase and recompile the pcmcia based on the new kernel.
>
> The result was still failed with the kernel to be panic status.
>

As usual Dan beat me to a response, but I can give a little more
detail:-)

My next task (probably after LinuxWorld this month) is to figure out all
the details for making card services work on 8xx and document them.  In
the mean time, here is what I know:

The 8xx portion of the kernel has some code that connects the PCMCIA
controller to the IDE driver (without card services).  this code is
activated when you select the *_IDE and *_IDEDISK config options.  So it
probably is conflicting with the ide_cs modules in card services.  I
think if you pass in the ide=noprobe (check docs for exact args) at the
boot prompt it might work, maybe.

If you don't need hot swap, I suggest not using card services until I
have packaged it for HardHat.  Instead use the existing code that
connects the controller to the IDE driver.  You may need to tune some
timing parameters to your PCMCIA h/w.  I have a patch that makes it work
with a SanDisk at  ftp://ftp.mvista.com/pub/Area51/embedded-planet
To do this:

apply the patch
Enable the _IDE and _IDEDISK kernel config options
make dep; make zImage
insert PCMCIA card
load and boot linux


I will post a message when Card Services is available on Montavista's
ftp site.


Matthew Locke
Software Engineer
Montavista Software

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
