From: Michele.Pallaro@alcatel.it
Message-ID: <40FCD12D.1CD6E1B7@alcatel.it>
Date: Tue, 20 Jul 2004 10:00:46 +0200
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Problem with kernel porting (MPC8270)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is my first linux kernel porting.
Target baord : custom MPC8270
Mem: 512Mb
Kernel 2.4.20 (montavista 3.1)

The kernel and applications run without problems on my target , but an
user application can write to the kernel space if the address is between

stext (0xC0000000 virtual kernel start) and 0xC0141144 (_etext section
on my target of course).
To simplify and isolate the problem, I remove my drivers and I build a
minimal kernel (console on SMC1 and eth0-2 FCC1/3) plus a small ram
filesystem (busybox + telnetd and ftpd). I also build a test appl that
write to 0xC0001000 (InstructionTLBMiss like for an wrong pointer one of

my application did).
When I run it, the kernel insted to stop it and generate a segmentation
fault and core, it crash with oops.
I connect my emulator and I set a condictional write break at
0xc0001000, and when the appl write to 0xc0001000, it realy do it.
Stopping the appl when it tries to write and make a step the core goes
in to exception entry and tries to find the data TLBMiss, but the
problem (I think) it finds it and with the write access.
Watching in the MMU configuration, I see that the function mapin_ram
called at the startup (MMU_init) the addresses from stext to etext are
mapped with the flags _PAGE_USER. So I suppose that why the userland can

access and write to that address. I like to understand why it's done.

I solve the problem removing this flag setting on the mapin_ram(). It
wroks, but I'm new on linuxppc world, and I like to understand if the
solution I find it,  it's wrong or not.

Your help will be very appreciate.

    Michele


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
