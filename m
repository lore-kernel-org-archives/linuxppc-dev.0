Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <903E17B6FF22A24C96B4E28C2C0214D7012BB481@sr-bng-exc01.int.tsbu.net>
From: "Karoliya, Abhishek" <Abhishek.Karoliya@fci.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: printk  logbuf relocation
Date: Thu, 12 Feb 2004 23:33:31 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi ,

  On our MPC7447+MV64360 board running Linux {both 2.4.18_mvl30 MontaVista
PE3.0 & 2.4.20 from kernel.org} we need to carry out an experimentation.
This  is when the board does not have any serial interface and Linux may
hang at boot-up. The contents of printk that are logged in the log-buf are
adequate to provide the required information. This section of memory can be
read on next boot up. {Though this is in RAM , by turning off ECC &
Scrubbing , we could see the contents on a reboot in the firmware which has
a way to provide this memory dump over a PCI connection}. We could do up
till this but the real problem starts now.

  The log-buf lies in the region of memory where our firmware {a proprietary
one } sits , so even if scrubbing is off , this overrides the logbuf
contents. Relocating the firmware is ruled out due to other restrictions. So
possible solutions seems to be..
1. Relocate logbuf somewhere further up in the image { is this possible??}
2. Create a second buffer further up in memory and sync it with logbuf. {How
to get this new memory kmalloc??&}
and I run out of idea here...

Please suggest which is a plausible solution for such a case . Can making
kernel run of less memory {using the mem kernel parameter} and than using
this 'unseen' memory for second logbuf help.

Thanks a lot
Abhishek


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
