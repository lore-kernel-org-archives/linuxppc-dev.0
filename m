Content-Type: text/plain;
  charset="us-ascii"
From: Trevor Woerner <ppc339@vtnet.ca>
Reply-To: ppc339@vtnet.ca
To: linuxppc-dev@lists.linuxppc.org
Subject: PPC405 support in later 2.4.x kernels
Date: Thu, 31 Jul 2003 23:32:41 -0400
MIME-Version: 1.0
Message-Id: <200307312332.41630.ppc339@vtnet.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The following email is with respect to the code in the bitkeeper
repository at ppc.bkbits.net. I *believe* this is the correct place
from which to be getting my kernels?

I've been working with a PPC405-based device and wanted to keep
up-to-date with the 2.4.x series kernels. I interface to the device via
a serial cable console.

I had been using 2.4.21-pre7 and it was working well for me. Then I
decided to update to an official release, namely 2.4.21, and found the
405 support completely missing! Several of the ppc4xx-specific files in
arch/ppc/kernel had the bodies of functions replaced with "implement
me!". I am curious to know why.

I grabbed 2.4.22-pre8 and found the ppc4xx code back, but the strangest
thing is now happening: I've lost my user-space. The kernel boots up
perfectly fine, all the printk() messages show up fine, but the last
thing I get is kernel message about releasing memory, just before the
execve() is called from init/main.c where it's looking for the init()
to run. After that I get nothing. I've even put printk()'s in the
sys_execve and it runs fine. As soon as the kernel is done printing
printk()'s I get nothing more on my serial port.

I believe I've done all the standard things, i.e. replace /sbin/init
with a shell script, replace /sbin/init with a statically-linked "hello
world", remove /sbin/init and watch the kernel panic... It's as if the
user-space stuff is going someplace other than the serial port.

I searched through the archives and found a tip about turning on math
emulation, which I did, but it had no apparent effect.

I don't think user-space is coming up. If I ping the box I don't get my
packets back, which suggests the interface isn't being set (which is
something that would occur if user-space were coming up and running
okay). I believe the kernel is still running, I turned on debugging in
drivers/char/serial.c and sure enough I do continue to get printk()'s
to indicate interrupts.

I was thinking of hanging a small routine off of the timer interrupt and
printk()'ing something every couple of jiffies, just to see if the
kernel is still running.

I also noticed that the ppc_bd.progress() functions weren't printing
their strings like they were supposed to. This was because the option
to allow early boot messages had been removed from the build operation.

Perhaps someone more familiar with what's going on in the kernel, and
which directions it's going in, might know why I'm seeing what I'm
getting?

Best regards,
	Trevor

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
